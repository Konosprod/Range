#!/bin/bash

# Définitions des répertoires, à adapter :
DIR=/home/kono/Bureau
AUDIO=${DIR}/Musique
VIDEO=${DIR}/Vidéos
IMG=${DIR}/Images
ARCHIVES=${DIR}/Archives
DOCS=${DIR}/Documents
MISC=${DIR}/Divers
PROG=${DIR}/Programmation
SCRIPT=${PROG}/Script
DOS=${DIR}/Windows
PYTHON=${SCRIPT}/Python
C=${PROG}/C
LUA=${SCRIPT}/Lua
BASH=${SCRIPT}/Bash


# Fichier de log :
LOG=/dev/null


# Déplacement d'un fichier et mise à jour du fichier log :
function bouge()
{
    mv "${1}" "${2}"
    heure=`date +%D-%H:%m`
    echo "[${heure}] "${1}" déplacé dans "${2}""
    return 0
}


# Créons les répertoires s'ils n'existent pas :
function createdirs()
{
    mkdir -p ${AUDIO}
    mkdir -p ${VIDEO}
    mkdir -p ${IMG}
    mkdir -p ${ARCHIVES}
    mkdir -p ${DOCS}
    mkdir -p ${MISC}
    mkdir -p ${SCRIPT}
    mkdir -p ${DOS}
    mkdir -p ${PYTHON}
    mkdir -p ${LUA}
    mkdir -p ${C}
    mkdir -p ${BASH}

    return 0
}

# Trions les fichiers :
function tri()
{
    cd ${1}
    ls > /tmp/tri
    #sed -i 's/\ / /g' /tmp/tri
    echo "Tris des fichiers du répertoire ${1}..."
    while read fichier
    do
        # Utilisons si possible le type mime :
        type=`file -bi "${fichier}"`
        
        case ${type} in
            *directory*) continue;;
        
            *application/pdf*|*application/dvi*|*application/postscript*|*application/vnd.oasis.opendocument.*) bouge "${fichier}" ${DOCS};;   
            *application/x-tar*|*application/x-rar*|*application/zip*|*application/x-iso9660-image*|*application/x-gzip*|*application/x-debian-package*|*application/x-bzip2*) bouge "${fichier}" ${ARCHIVES};;
            *application/x-dosexec*) bouge "${fichier}" ${DOS};;
            
             
            *audio/mpeg*|*audio/ogg*) bouge "${fichier}" ${AUDIO};;
            
            *video/mpeg*|*video/ogg*|*video/x-flv*|*video/x-msvideo*|*video/x-ms-wmv*) bouge "${fichier}" ${VIDEO};;  
             
            *image/bmp|image/png|image/jpeg*|*image/gif*) bouge "${fichier}" ${IMG};;

            *text/x-c*) bouge "${fichier}" ${C};;
            *text/troff*) bouge "${fichier}" ${DOCS};;
            *text/x-lua*) bouge "${fichier}" ${LUA};;
            *text/x-shellscript*) bouge "${fichier}" ${BASH};;
            *text/plain*) bouge "${fichier}" ${DOCS};;
        esac

    done < /tmp/tri

    echo "Terminé."
    cd ${OLDDIR}

    return 0
}


# Si des répertoires sont passés en argument, on les trie, sinon on trie le répertoire par défaut
OLDDIR=`pwd`
createdirs
if [ $# -eq 0 ]
then
    tri ${DIR}
else
    while [ $# -gt 0 ]
    do
        tri ${1}
        shift
    done
fi
exit 0

