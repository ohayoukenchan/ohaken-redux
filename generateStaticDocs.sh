#!/bin/bash

# 静的ホスティング用に変換する関数
process_doccarchive() {
    local archive_path=$1
    local hosting_base_path=$2

    echo "Processing $archive_path -> ./docs/"
    xcrun docc process-archive transform-for-static-hosting \
        "$archive_path" \
        --output-path "./docs/" \
        --hosting-base-path "$hosting_base_path"
}

# Main
set -e


# docsディレクトリをクリーンアップ
echo "Cleaning up ./docs directory..."
rm -rf ./docs
mkdir -p ./docs

process_doccarchive "./build/Documentation/ohaken-redux.doccarchive" "/ohaken-redux"

echo "All documentation processed successfully!"

