pack_install() {

if [[ ! -z $1 ]] ; then
	printf '%s\n' "Installing from $1"
	opt="$1"
	sleep 1
fi

for pkg in $packlist; do
	if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
			echo -e "$pkg is already installed"
	else
		if apt-get install -y "$opt" "$pkg" ; then
			echo "Successfully installed $pkg"
		else
			echo "Error installing $pkg"
		fi
	fi
done
}
