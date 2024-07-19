#!/bin/bash

# Configuration: set your repository directory and remote repository URL
REPO_DIR="Your/DIR/URL"
REMOTE_URL="REPO/URL/ONLINE"
BRANCH_NAME="main" # Adjust if you're using a different branch

# Set your Git user email and name to match your GitHub account
GIT_USER_NAME="YOUR NAME"
GIT_USER_EMAIL="YOUR EMAIL"

# Change to the repository directory
cd "$REPO_DIR" || exit

# Ensure the working directory is clean
git status
read -p "Is the working directory clean? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Please commit or stash your changes before running this script."
    exit 1
fi

# Configure Git to handle line endings and set user info
git config core.autocrlf false
git config user.name "$GIT_USER_NAME"
git config user.email "$GIT_USER_EMAIL"

# List of realistic function names
function_names=(
    "calculateSum"
    "fetchUserData"
    "updateProfile"
    "processOrder"
    "validateInput"
    "generateReport"
    "sendEmail"
    "loginUser"
    "logoutUser"
    "registerUser"
    "deleteAccount"
    "calculateAverage"
    "generateUUID"
    "formatDate"
    "parseJSON"
    "sortArray"
    "filterData"
    "fetchAPI"
    "renderComponent"
    "logError"
    "handleRequest"
    "validateEmail"
    "sanitizeInput"
    "encryptData"
    "decryptData"
    "uploadFile"
    "downloadFile"
    "resizeImage"
    "cropImage"
    "fetchData"
    "sendNotification"
    "updateSettings"
    "retrieveRecords"
    "processPayment"
    "generateToken"
    "validatePassword"
    "authenticateUser"
    "fetchRecords"
    "sortByDate"
    "convertCurrency"
    "trackEvent"
    "createUserProfile"
    "sendReport"
    "backupData"
    "restoreBackup"
    "syncDatabase"
    "generateChart"
    "formatCurrency"
    "sendMessage"
    "parseCSV"
    "generateQRCode"
    "handleEvent"
    "createBackup"
    "updateStatus"
    "uploadImage"
    "downloadImage"
    "renderPage"
    "processOrder"
    "validateForm"
    "logActivity"
    "generateSummary"
)

# Generate random code file content
generate_random_code() {
    local function_name=${function_names[$RANDOM % ${#function_names[@]}]}
    local file_name="${function_name}_$(date +%s).js"
    cat << EOF > "$file_name"
// Function: $function_name - $(date)
function $function_name() {
    let result = 0;
    for (let i = 0; i < 10; i++) {
        result += i;
    }
    console.log("$function_name result:", result);
}
$function_name();
EOF
    git add "$file_name"
}

# Function to create a commit with a specified date
create_commit() {
    local commit_date=$1
    local commit_message="Commit on $commit_date"
    GIT_COMMITTER_DATE="$commit_date" GIT_AUTHOR_DATE="$commit_date" \
    git commit --author="$GIT_USER_NAME <$GIT_USER_EMAIL>" -m "$commit_message"
}

# Function to get a random number between 1 and 3
get_random_days() {
    echo $((1 + RANDOM % 3))
}

# Loop through the dates from January 1, 2024 to June 30, 2024 and create commits every 1 to 3 days
start_date="2024-01-01T00:00:00"
end_date="2024-12-30T23:59:59"
current_date="$start_date"

while [[ "$current_date" < "$end_date" ]]; do
    generate_random_code
    create_commit "$current_date"
    # Increment the date by a random number of days (1 to 3)
    random_days=$(get_random_days)
    current_date=$(date -Iseconds -d "$current_date + $random_days days")
done

# Check the status of the repository
git status

# Push the commits to the remote repository
git push "$REMOTE_URL" "$BRANCH_NAME"