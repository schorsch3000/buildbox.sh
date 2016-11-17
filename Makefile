.PHONY: dist clean shellcheck

dist: clean shellcheck
	mkdir dist
	cp -rp buildbox.sh dist
	rsync -av --exclude=prepared modules di

buildbox.sh: src/*.sh
	echo '#!/usr/bin/env bash' > buildbox.sh
	echo 'cd "$$(dirname "$$0")"' >> buildbox.sh
	cat ./src/*.sh | egrep -v "^#" >> buildbox.sh
	chmod +x buildbox.sh

clean:
	rm -rf buildbox.sh dist

shellcheck: buildbox.sh
	shellcheck buildbox.sh
	find modules -name "*.sh" -exec shellcheck "{}" \;

st