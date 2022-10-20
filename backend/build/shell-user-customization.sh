#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive
USER
ZSHRC_DIR


group_name="${USERNAME}"

echo ""${USERNAME}", "${USER_UID}", "${USER_GID}""

# Username doesnt already exist
if id -u ${USERNAME} > /dev/null 2>&1; then
    # User exists, update if needed
    if [ "$USER_GID" != "$(id -g $USERNAME)" ]; then 
        group_name="$(id -gn $USERNAME)"
        groupmod --gid $USER_GID ${group_name}
        usermod --gid $USER_GID $USERNAME
    fi
    if [ "$USER_UID" != "$(id -u $USERNAME)" ]; then 
        usermod --uid $USER_UID $USERNAME
    fi
else
    # Create user
    groupadd --gid $USER_GID $USERNAME
    useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME
fi


if [ "${USERNAME}" != "root" ] && [ "${EXISTING_NON_ROOT_USER}" != "${USERNAME}" ]; then
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
    chmod 0440 /etc/sudoers.d/$USERNAME
    EXISTING_NON_ROOT_USER="${USERNAME}"
fi

# ** Shell customization section **
if [ "${USERNAME}" = "root" ]; then 
    user_rc_path="/root"
else
    user_rc_path="/home/${USERNAME}"
fi

# Restore user .bashrc defaults from skeleton file if it doesn't exist or is empty
if [ ! -f "${user_rc_path}/.bashrc" ] || [ ! -s "${user_rc_path}/.bashrc" ] ; then
    cp  /etc/skel/.bashrc "${user_rc_path}/.bashrc"
fi

# Restore user .profile defaults from skeleton file if it doesn't exist or is empty
if  [ ! -f "${user_rc_path}/.profile" ] || [ ! -s "${user_rc_path}/.profile" ] ; then
    cp  /etc/skel/.profile "${user_rc_path}/.profile"
fi

if ! type zsh > /dev/null 2>&1; then
    apt_get_update_if_needed
    apt-get install -y zsh
fi
if [ "${ZSH_ALREADY_INSTALLED}" != "true" ]; then
    echo "${rc_snippet}" >> /.docker/zsh/zshrc
    ZSH_ALREADY_INSTALLED="true"
fi


if ! type zsh > /dev/null 2>&1; then
    apt_get_update_if_needed
    apt-get install -y zsh
fi
if [ "${ZSH_ALREADY_INSTALLED}" != "true" ]; then
    echo "${rc_snippet}" >> /etc/zsh/zshrc
    ZSH_ALREADY_INSTALLED="true"
fi

# Adapted, simplified inline Oh My Zsh! install steps that adds, defaults to a codespaces theme.
# See https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh for official script.
oh_my_install_dir="${user_rc_path}/.oh-my-zsh"
if [ ! -d "${oh_my_install_dir}" ] && [ "${INSTALL_OHMYZSH}" = "true" ]; then
    template_path="${oh_my_install_dir}/templates/zshrc.zsh-template"
    user_rc_file="${user_rc_path}/.zshrc"
    umask g-w,o-w
    mkdir -p ${oh_my_install_dir}
    git clone --depth=1 \
        -c core.eol=lf \
        -c core.autocrlf=false \
        -c fsck.zeroPaddedFilemode=ignore \
        -c fetch.fsck.zeroPaddedFilemode=ignore \
        -c receive.fsck.zeroPaddedFilemode=ignore \
        "https://github.com/ohmyzsh/ohmyzsh" "${oh_my_install_dir}" 2>&1
    echo -e "$(cat "${template_path}")\nDISABLE_AUTO_UPDATE=true\nDISABLE_UPDATE_PROMPT=true" > ${user_rc_file}
    sed -i -e 's/ZSH_THEME=.*/ZSH_THEME="codespaces"/g' ${user_rc_file}

    mkdir -p ${oh_my_install_dir}/custom/themes
    echo "${codespaces_zsh}" > "${oh_my_install_dir}/custom/themes/codespaces.zsh-theme"
    # Shrink git while still enabling updates
    cd "${oh_my_install_dir}"
    git repack -a -d -f --depth=1 --window=1
    # Copy to non-root user if one is specified
    if [ "${USERNAME}" != "root" ]; then
        cp -rf "${user_rc_file}" "${oh_my_install_dir}" /root
        chown -R ${USERNAME}:${group_name} "${user_rc_path}"
    fi
fi

echo "Done!"