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
        if [ "$USER_GID" != "$(id -g "$USERNAME")" ]; then
            groupmod --gid "$USER_GID" "${GROUP_NAME}"
            usermod --gid "$USER_GID" "$USERNAME"

    fi
    if [ "$USER_UID" != "$(id -u "$USERNAME")" ]; then
        usermod --uid "$USER_UID" "$USERNAME"
    fi
else
    if [ "$PASSWORD" == "init" ]; then
        # Create user
        groupadd --gid "$USER_GID" "$USERNAME"
        useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME"
    else
        # Create user
        groupadd --gid "$USER_GID" "$USERNAME"
        useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME" -p "$PASSWORD"
fi

if [ "${USERNAME}" != "root" ] && [ "${EXISTING_NON_ROOT_USER}" != "${USERNAME}" ]; then
    echo "$USERNAME" ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/"$USERNAME"
    chmod 0440 /etc/sudoers.d/"$USERNAME"
    EXISTING_NON_ROOT_USER="${USERNAME}"
fi
