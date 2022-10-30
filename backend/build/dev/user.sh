#!/usr/bin/env bash

group_name="${USERNAME}"

echo "${USERNAME}, ${USER_UID}, ${USER_GID}"

# Username doesnt already exist
if id -u "${USERNAME}" > /dev/null 2>&1; then
    # User exists, update if needed
    if [ "$USER_GID" != "$(id -g "$USERNAME")" ]; then
        group_name="$(id -gn "$USERNAME")"
        groupmod --gid "$USER_GID" "${group_name}"
        usermod --gid "$USER_GID" "$USERNAME"
    fi
    if [ "$USER_UID" != "$(id -u "$USERNAME")" ]; then
        usermod --uid "$USER_UID" "$USERNAME"
    fi
else
    # Create user
    groupadd --gid "$USER_GID" "$USERNAME"
    useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME"
fi

if [ "${USERNAME}" != "root" ] && [ "${EXISTING_NON_ROOT_USER}" != "${USERNAME}" ]; then
    echo "$USERNAME" ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/"$USERNAME"
    chmod 0440 /etc/sudoers.d/"$USERNAME"
    EXISTING_NON_ROOT_USER="${USERNAME}"
fi
