#!/usr/bin/env bash

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
if [ ! -d "${oh_my_install_dir}" ] && [ "${INSTALL_OH_MYS}" = "true" ]; then
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
