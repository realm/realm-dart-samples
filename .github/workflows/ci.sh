#!/usr/bin/env bash
show_help() {
    printf "\n\nusage: $0 [--get] [--install] [--generate] [--run]

Tool for managing CI builds.
(run from root of repo)

where:
    --get
        get all dependencies
    --install
        install realm_dart package
    --generate
        generate realm models
    --run
        run dart projects
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
            printf "\ndart pub get\n"
            dart pub get
        else
            printf "\nflutter pub get\n"
            flutter pub get
        fi
    fi
    cd - > /dev/null
}

runInstall() {
    cd $1
    if [ -f "pubspec.yaml" -a grep -q 'realm_dart:' "pubspec.yaml" ]; then
        printf "\ndart run realm_dart install\n"
        dart run realm_dart install
    fi
    cd - > /dev/null
}

runGenerate() {
    cd $1
    if [ -f "pubspec.yaml" ]; then
        if grep -q 'realm_dart:' "pubspec.yaml";
        then
            printf "\ndart run realm_dart generate\n"
            dart run realm_dart generate
        else if grep -q 'realm:' "pubspec.yaml";
            then
                printf "\nflutter pub run realm generate\n"
                flutter pub run realm generate
            fi
        fi
    fi
    cd - > /dev/null
}

runDart() {
    cd $1
    if [ -f "pubspec.yaml" -a  grep -q 'realm_dart:' "pubspec.yaml"]; then
        printf "\ndart run\n"
        dart run
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
    --install)
        allDirs "runInstall"
        ;;
    --generate)
        allDirs "runGenerator"
        ;;
    --run)
        allDirs "runDart"
        ;;
    *)
esac