#!/bin/sh
PORTS_TREES='upstream'
JAILS='FreeBSD:10:amd64 FreeBSD:11:amd64'
PYTHON_VERSION='3.6'
for PORTS_TREE in ${PORTS_TREES}; do

        # Update poudriere ports tree
        poudriere ports -u -p ${PORTS_TREE}

        for JAIL in $JAILS; do
                MAKEFILE="/usr/local/etc/poudriere.d/${JAIL}-make.conf"
                # Ensure the jail is up to date
                poudriere jail -u -j ${JAIL}

                # Build the ports
                poudriere bulk -f /usr/local/poudriere/pkg-list.txt -j ${JAIL} -p ${PORTS_TREE}

		echo "DEFAULT_VERSIONS+= python=${PYTHON_VERSION}" > ${MAKEFILE}
		poudriere bulk -f /usr/local/poudriere/pkg-list.txt -j ${JAIL} -p ${PORTS_TREE}
		rm -f ${MAKEFILE}
        done

done
