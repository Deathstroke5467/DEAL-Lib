pack_install() { #use case statements and $1

if [ $opt -z ] ; then
	opt=0
fi

	for pkg in $packlist; do
		if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
				echo -e "$pkg is already installed"
				#echo "checking if packages are latest versions"
				#if [ "sudo apt-get install -t stretch -s $pkg" == ]
		elif [ $opt -eq 1 ] ; then #opt 1 installs from stretch
				echo "Option: $opt installing from stretch"
				sleep 1
				if apt-get install -y -t stretch $pkg; then #use array for repo list instead of repeating
					echo "Successfully installed $pkg"
				else
					echo "Error installing $pkg"
				fi
		elif [ $opt -eq 2 ] ; then #opt 2 installs from kali
				echo "Option: $opt installing from Kali" #use exit codes and put at end to shorten?
				sleep 1
				if apt-get install -y -t kali-rolling $pkg; then
					echo "Successfully installed $pkg"
				else
					echo "Error installing $pkg"
				fi
		else #all others install from default repo
			echo "No Option or Option: $opt installing from default repos"
			sleep 1
			if apt-get -y install $pkg; then
				echo "Successfully installed $pkg"
			else
				echo "Error installing $pkg"
			fi
		fi
	done
}
