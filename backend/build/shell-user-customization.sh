USERNAME={username}
USER_UID={useruid}
USER_GID={usergid}

group_name="${USERNAME}"

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