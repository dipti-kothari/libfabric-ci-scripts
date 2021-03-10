#!/bin/bash

function curl_check() {
    file_name=$2
    # bash -c is used to avoid issues due to quotation within quotation
    status=$(bash -c "$1 | sed -n '/Code: / s///p'")
    if [ $status -ne 200 ]; then
        if [ -f "$file_name" ]; then
            mv $file_name error.html
            cat error.html
        fi
        exit 1
    fi
}

function wget_check() {
    file_name=$2
    # bash -c is used to avoid issues due to quotation within quotation
    bash -c "$1"
    if [ $? -ne 0 ]; then
        if [ -f "$file_name" ]; then
            mv $file_name error.html
            cat error.html
        fi
        exit 1
    fi
}

