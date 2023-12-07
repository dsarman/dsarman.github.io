#!/bin/bash

# Define the zip file and the locations
ZIP_FILE="publicExport.zip"
SOURCE_DIR="tmp-export"
BLOG_DEST_DIR="src/content/blog"
ASSETS_DEST_DIR="src/assets/"
ASSETS_SOURCE_DIR="$SOURCE_DIR/assets"

# Unzip the file
unzip $ZIP_FILE -d $SOURCE_DIR

# Copy the content to the locations
cp -r $SOURCE_DIR/pages/Blog/* $BLOG_DEST_DIR

if [ -d "$ASSETS_SOURCE_DIR" ]; then
  cp -r $ASSETS_SOURCE_DIR/* $ASSETS_DEST_DIR
fi

rm -rf $SOURCE_DIR