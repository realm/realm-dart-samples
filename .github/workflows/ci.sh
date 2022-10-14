#!/usr/bin/env bash
show_help() {
    printf "\n\nusage: $0 [--upgrade ] [--get] [--install] [--generate] [--run]

Tool for managing CI builds.
(run from root of repo)

where:
    --upgrade
        upgrade major versions of all dependencies
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
        cd $dir
            if [ -f "pubspec.yaml" ]; then
                $1 $dir
            fi
        cd - > /dev/null
    done
}


runUpgrade() {
    if grep -q 'realm_dart:' "pubspec.yaml";
    then
        printf "\ndart pub upgrade --major-versions\n"
        dart pub upgrade --major-versions
    else
        printf "\nflutter pub upgrade --major-versions\n"
        flutter pub upgrade --major-versions
    fi
}

runGet() {
    if grep -q 'realm_dart:' "pubspec.yaml";
    then
        printf "\ndart pub get\n"
        dart pub get
    else
        printf "\nflutter pub get\n"
        flutter pub get
    fi
}

runInstall() {
    if grep -q 'realm_dart:' "pubspec.yaml";
    then
        printf "\ndart run realm_dart install\n"
        dart run realm_dart install
    fi
}

runGenerate() {
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
}

runDart() {
    if grep -q 'realm_dart:' "pubspec.yaml";
    then
        printf "\ndart run\n"
        dart run
    fi
}

# if no arguments passed
if [ -z $1 ]; then show_help; fi

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --upgrade)
        allDirs "runUpgrade"
        ;;
    --get)
        allDirs "runGet"
        ;;
    --install)
        allDirs "runInstall"
        ;;
    --generate)
        allDirs "runGenerate"
        ;;
    --run)
        allDirs "runDart"
        ;;
    *)
esac