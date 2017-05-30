#  packinstall.sh - a manager for installing packages from the Debian Apt system
#  Copyright (C) 2017 Marcello Barbieri

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

pack_install() {

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
