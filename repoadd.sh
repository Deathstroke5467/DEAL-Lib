#  repoadd.sh - a manager for adding Debian repo's using the new repo system
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

repo_add() {
	printf '%s\n' "-------------" "Adding ${repo[file]} Repos" "-------------" ""

#grep -Fiq "$repoadd" /etc/apt/sources.list
	if grep -iq "${repo[web]}" /etc/apt/sources.list.d/"${repo[file]}".list ; then #ignore this exit code if file doesnt exists
		printf '%s\n' "-------------------------------" "Repositories Already Installed!" "-------------------------------" ""
		sleep 2
	else
		#create list if repo does not exist
		if [ ! -f /etc/apt/sources.list.d/"${repo[file]}".list ]; then
			mkdir -p /etc/apt/sources.list.d/ && touch /etc/apt/sources.list.d/"${repo[file]}".list && chmod 644 /etc/apt/sources.list.d/"${repo[file]}".list
			printf '%s\n' "new ${repo[file]}.list file created in /etc/apt/sources.list.d/"
		fi

		if [ ! -f /etc/apt/preferences.d/"${repo[file]}".pref ]; then
			mkdir -p /etc/apt/preferences.d/ && touch /etc/apt/preferences.d/"${repo[file]}".pref && chmod 644 /etc/apt/preferences.d/"${repo[file]}".pref
			printf '%s\n' "new ${repo[name]}.pref file created in /etc/apt/preferences.d/"
		fi

		#add repo to file
		printf "deb ${repo[web]}\n# uncomment line below then'apt-get update' to enable 'apt-get source'\n#deb-src ${repo[web]}\n" > /etc/apt/sources.list.d/"${repo[file]}".list
		printf '%s\n' "${repo[file]} Repo will now be found in /etc/apt/sources.list.d/${repo[file]}.list"
		sleep 2
		#adds priority to preferences file
		printf "\nPackage: *\nPin: release n=${repo[name]}\nPin-Priority: -1" > /etc/apt/preferences.d/"${repo[file]}".pref
		#add link to man page
		printf '%s\n' "${repo[file]} preferences created in /etc/apt/sources.list.d/${repo[file]}.list with priority -1" "Use apt-get install -t ${repo[name]} to install packages from this repo" "sudo nano to change priority at own risk find more info at APT Preferences manpage"
		sleep 4
	fi
}
