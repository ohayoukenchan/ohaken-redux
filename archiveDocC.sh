#!/bin/bash

# Constants
PROJECT_NAME="ohaken-redux"
SCHEME_NAME="ohaken-redux"
BUILD_DIR="build"
DOCC_OUTPUT_DIR="$BUILD_DIR/Documentation"

# Clean and create build directory
clean_build_directory() {
    local project_name=$1
    local build_dir=$2

    echo "Cleaning build directory..."

    if [ ! -d "$build_dir" ]; then
        echo "Creating build directory: $build_dir"
        mkdir -p "$build_dir"
    fi

    local archive_path="$build_dir/$project_name.doccarchive"
    if [ -e "$archive_path" ]; then
        echo "Removing existing archive: $archive_path"
        rm -rf "$archive_path"
    fi
}

# Generate DocC documentation
generate_doccarchive() {
    local project_name=$1
    local scheme_name=$2
    local output_dir=$3

    echo "Generating DocC documentation for $project_name..."
    xcodebuild docbuild \
        -project "$project_name/$project_name.xcodeproj" \
        -scheme "$scheme_name" \
        -destination "generic/platform=iOS" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=NO

    if [ $? -ne 0 ]; then
        echo "Error: DocC generation failed for $scheme_name."
        exit 1
    fi

    local doccarchive_path
    doccarchive_path=$(find ~/Library/Developer/Xcode/DerivedData -type d -name "$scheme_name.doccarchive" | head -n 1)
    if [ -d "$doccarchive_path" ]; then
        echo "Moving $doccarchive_path to $output_dir..."
        mv "$doccarchive_path" "$output_dir"
    else
        echo "Error: DocC archive not found for $scheme_name."
        exit 1
    fi
}

# Main script execution
clean_build_directory "$PROJECT_NAME" "$DOCC_OUTPUT_DIR"
generate_doccarchive "$PROJECT_NAME" "$SCHEME_NAME" "$DOCC_OUTPUT_DIR"

echo "✅ DocC documentation successfully generated and saved in $DOCC_OUTPUT_DIR."
