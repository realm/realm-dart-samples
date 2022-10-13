#!/usr/bin/env bash
show_help() {
    printf "\n\nusage: $0 [--get] [--generate]

Tool for managing CI builds.
(run from root of repo)

where:
    --get
        get all dependencies
    --generate
        generate realm models
"
    exit 1
}

# run function in all dirs
# expects a function name
allDirs() {
    dirs=(`find . -maxdepth 2 -type d`)
    for dir in "${dirs[@]}"; do
        $1 $dir
    done
}

runGet() {
    cd $1
    if [ -f "pubspec.yaml" ]; then
        if grep -q 'realm_dart:' "pubspec.yaml"; 
        then
            dart pub get
        else
            flutter packages get
        fi
    fi
    cd - > /dev/null
}

runGenerator() {
    cd $1
    if [ -f "pubspec.yaml" ]; then
        if grep -q 'realm_dart:' "pubspec.yaml"; 
        then
            printf "\ndart pub get"
            dart pub get
            printf "\ndart run realm_dart install"
            dart run realm_dart install
            dart run realm_dart generate
            dart run
        else if grep -q 'realm:' "pubspec.yaml"; 
            then
                flutter packages get
                flutter pub run realm generate
            fi
        fi
    fi
    cd - > /dev/null
}

# if no arguments passed
if [ -z $1 ]; then show_help; fi

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --get)
        allDirs "runGet"
        ;;
    --generate)
        allDirs "runGenerator"
        ;;
    *)
esac