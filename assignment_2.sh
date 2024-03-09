# Collect source and destination directories from CLA
source_dir="$1"
dest_dir="$2"

# Check that source and destination are not empty
if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
  echo "USAGE: $0 <source-directory> <destination-directory>"
  exit 98
fi

# Check that there is a source directory
if [ ! -d "$source_dir" ]; then
  echo "ERROR: Source directory '$source_dir' does not exist."
  exit 1
fi

# Create timestamp for the backup filename
timestamp=$(date +%Y-%m-%d_%H-%M-%S)

# If not exists, create destination directory
mkdir -p "$dest_dir"

# Construct the backup filename
backup_file="$dest_dir/backup_${source_dir##*/}-$timestamp.tar"

# Create the tar archive
tar -cf "$backup_file" "$source_dir"

# Print success message
echo "Tar Backup Created Successfully..."
