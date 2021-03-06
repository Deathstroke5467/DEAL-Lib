DEAL-Lib
======
### DEAL: Debian Easy Access Library

Originally designed and tested for some of my Raspberry Pi Projects 
I have made this library public so that everyone may take advantage of it.

Currently Included functions:
* pack_install
* repo_add


## pack_install
pack_install is a script designed to first check and then install a package or a list of packages!
Often times people just apt-get and a package could already be installed wasting time, processing,
and sometimes just spamming the terminal. 

This is even more important since pack_install's principle feature is to be able to install a list of packages,
and does so using the newer Debian /etc/apt/sources.list.d and /etc/apt/preferences.d systems.

### Use

```
packlist="package1 package2 package3"
pack_install
```


## repo_add
repo_add uses the newer Debian /etc/apt/sources.list.d and /etc/apt/preferences.d systems
the /etc/apt/preferences.d file is set to a priority of -1 by default. 
This means if you apt-get, it will not source from that repo (this is useful as a security meaure.)

For instance in some cases you will add a repo for beta's or pre-releases of certain packages,
the apt-get system defaults to downloading the newest version of a package; However,
you would definitely not want to be installing beta's of everything by default. 
As such, a default priority of -1 is safest.

### Use

In order to download a package from a added repo you simply use 'apt-get install -t ${repo[name]}'
where '${repo[name]}' is what you have named the **repo**, not the **file**!

after sourcing the file, or adding it to your script it should be initialized as such:
```
declare -A repo=(["file"]="name of file" ["name"]="name of repo" ["web"]="url to repo" )
pack_install
```
*note that "file" is simply what the created files storing the repo will be called in /etc/apt/sources.list.d and /etc/apt/preferences.d
