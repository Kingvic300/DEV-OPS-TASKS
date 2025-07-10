#!/bin/bash

# Variables
REPO_NAME="DEV-OPS-TASKS"
DESCRIPTION="To write DevOps scripts or add things to it"
VISIBILITY="public"
COLLABORATOR="Rofih"
BRANCH_NAME="main"

# Create GitHub repo
echo " Creating repository: $REPO_NAME"
gh repo create "$REPO_NAME" --description "$DESCRIPTION" --$VISIBILITY --confirm

# Clone the repo locally
echo " Cloning repository..."
git clone "https://github.com/Kingvic300/$REPO_NAME.git"

# Move into the cloned repo directory
cd "$REPO_NAME" || { echo " Failed to enter directory $REPO_NAME"; exit 1; }

# Create a new branch
echo " Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# Add README and commit before pushing
git add .
git commit -m "Initial commit with README"
git push -u origin "$BRANCH_NAME"

# Add collaborator
OWNER=$(gh api user --jq '.login')
echo " Adding collaborator: $COLLABORATOR"
gh api -X PUT "repos/$OWNER/$REPO_NAME/collaborators/$COLLABORATOR" -f permission=push

echo " Repo setup complete: https://github.com/$OWNER/$REPO_NAME/tree/$BRANCH_NAME"
