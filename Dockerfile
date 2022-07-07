# syntax=docker/dockerfile:1
ARG BASE_IMG_VER

FROM alpine:$BASE_IMG_VER

ARG BASE_IMG_VER

LABEL org.opencontainers.image.authors="Omae Tadashi <56265995+0xTadash1@users.noreply.github.com>"
LABEL org.opencontainers.image.url="https://github.com/0xTadash1/docker-svn"
LABEL org.opencontainers.image.documentation="https://github.com/0xTadash1/docker-svn/blob/main/README.md"
LABEL org.opencontainers.image.source="https://github.com/0xTadash1/docker-svn/blob/main/Dockerfile"
LABEL org.opencontainers.image.version="$BASE_IMG_VER"

RUN <<-eot ash
	apk add --no-cache --clean-protected subversion
	echo -e '#!/bin/ash\ncd "/mnt\$1" && shift && svn \$@' >| /entrypoint.ash
	chmod 744 entrypoint.ash 


	##
	# Clean up
	#

	apk del -r --purge --no-cache alpine-keys

	d='/bin'
	for f in \$(ls -A1 \$d); do
		p="\$d/\$f"
		if [[ -L "\$p" ]]; then
			[[ "\$p" =~ '(ash|sh|rm)\$' ]] \
				|| rm -f \$p
		fi
	done

	rm -rf /etc/apk \
		/etc/conf.d \
		/etc/crontabs \
		/etc/init.d \
		/etc/logrotate.d \
		/etc/modprobe.d \
		/etc/modules-load.d \
		/etc/opt \
		/etc/periodic \
		/etc/secfixes.d \
		/etc/sysctl.d

	rm -rf /etc/passwd- /etc/shadow- /etc/group-
	rm -rf /home
	rm -f /lib/libapk*
	rm -rf /lib/apk /lib/firmware /lib/mdev /lib/modules-load.d 
	rm -rf /media /opt
	rm -rf /run

	rm -f /sbin/apk

	rm -rf /srv
	rm -rf /usr/apk /usr/share /usr/misc
	rm -rf /var

	rm -rf /usr/sbin
	rm -rf /usr/lib/*gdb*

	d='/usr/bin'
	for f in \$(ls -A1 \$d); do
		p="\$d/\$f"
		if [[ -L "\$p" ]]; then
			[[ "\$p" =~ '(\[\[|du)\$' ]] \
				|| rm -f \$p
		fi
	done

	rm -rf /root/.ash_history
eot

ENTRYPOINT ["/entrypoint.ash"]
