#!/usr/bin/env bash
USERNAME="${1}"
USER_UID="${2}"
USER_GID="${3}"
PASSWORD="${4}"
GROUP_NAME="${5:-"default"}"

echo "${USERNAME}, ${USER_UID}, ${USER_GID}"

# Username doesnt already exist
if id -u "${USERNAME}" > /dev/null 2>&1; then
    # User exists, update if needed
    if [ "$USER_GID" != "$(id -g "$USERNAME")" ]; then
        # If password add password else, skip
        groupmod --gid "$USER_GID" "$GROUP_NAME"
        if [ "$PASSWORD" == "init" ]; then
            usermod --gid "$USER_GID" "$USERNAME"
            echo "No password added"
        else
            usermod --gid "$USER_GID" -d "$USERNAME" -p "$PASSWORD"
            echo "With password added"
        fi
    fi
    if [ "$USER_UID" != "$(id -u "$USERNAME")" ]; then
        usermod --uid "$USER_UID" "$USERNAME"
    fi
else
    # Create user
    groupadd --gid "$USER_GID" "$USERNAME"
    if [ "$PASSWORD" == "init" ]; then
        useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME"
        echo "User created without password"
    else
        useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME" -p "$PASSWORD"
        echo "User created with password"
    fi
fi

if [ "${USERNAME}" != "root" ] && [ "${EXISTING_NON_ROOT_USER}" != "${USERNAME}" ]; then
    echo "$USERNAME" ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/"$USERNAME"
    chmod 0440 /etc/sudoers.d/"$USERNAME"
    EXISTING_NON_ROOT_USER="${USERNAME}"
fi