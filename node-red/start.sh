#!/bin/sh

echo "Start script executed" >> /data/start.log

# Logging function
log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") [INFO] $1" >> /proc/1/fd/1
}

# Error logging function
log_error() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") [ERROR] $1" >> /proc/1/fd/2
}

# Log start of the script
log "Starting Node-RED container setup..."

# Set Git username and email
log "Configuring Git with username: $GIT_USERNAME and email: $GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# Log the Git configuration
log "Git configuration set."

# Clone the repository into /data/projects/<PROJECT_NAME>
if [ -n "$GIT_REPO" ]; then
  log "Cloning repository from $GIT_REPO into /data/projects/$PROJECT_NAME"
  
  # Check if the directory exists and is not empty
  if [ -d "/data/projects/$PROJECT_NAME" ] && [ "$(ls -A /data/projects/$PROJECT_NAME)" ]; then
    log "Directory /data/projects/$PROJECT_NAME already exists and is not empty. Removing it."
    rm -rf "/data/projects/$PROJECT_NAME"
  fi
  
  git clone https://$GIT_TOKEN@${GIT_REPO#https://} "/data/projects/$PROJECT_NAME"
  if [ $? -eq 0 ]; then
    log "Repository cloned successfully."
  else
    log_error "Error cloning repository."
    exit 1
  fi
else
  log "GIT_REPO is not set. Skipping repository cloning."
fi

# Create the config file /data/.config.projects.json with the project name
log "Creating /data/.config.projects.json with PROJECT_NAME: $PROJECT_NAME"
echo "{\"projects\":{\"$PROJECT_NAME\":{\"credentialSecret\":false}},\"activeProject\":\"$PROJECT_NAME\"}" > /data/.config.projects.json
if [ $? -eq 0 ]; then
  log "Config file created successfully."
else
  log_error "Error creating config file."
  exit 1
fi

# Start Node-RED
log "Starting Node-RED..."
npm start -- --userDir /data
