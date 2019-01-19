# EBOWLA

VERSION Modified, this version will not work on any other set up, if you want to make a copy for your own usage look the Scripts repo and the version manager, in the script build_x64.sh and build_x86.sh i use go1.7 because new version of go dont support some old go flags like you will see in this readme. This go1.7 is a symlink of the go-1.7/bin/go. feel free to make issue but i dont promess any help since it is for my own usage.
I also change the default usage of ebowla and make the hidden parameter as default

```
USAGE: ./ebowla.py exe_dll_shellcode genetic.config

Then: Compile your code
```

### Known Issues

The current version is locked into golang version <= 1.9.5 known working on golang 1.6: https://github.com/Genetic-Malware/Ebowla/issues/23

If someone wants to update the codebase to support LDFlags for golang 1.9+ we accept pull requests!


MSF x86 EXE file output not compatible with MemoryModule (use DLL or x64 EXE/DLL)
https://github.com/Genetic-Malware/Ebowla/issues/12

Powershell output was tested on powershellv5


### Presentation Resources

Slides:

Infiltrate 2016: https://github.com/Genetic-Malware/Ebowla/raw/master/Infiltrate_2016_Morrow_Pitts_Genetic_Malware.pdf

Ekoparty 2016: https://github.com/Genetic-Malware/Ebowla/blob/master/Eko_2016_Morrow_Pitts_Master.pdf

Demos:

Demo1:
https://www.youtube.com/watch?v=rRm3O7w5GHg

Demo2:
https://youtu.be/Bu_qDrbX9Zo

Demo3:
https://youtu.be/mlh70LtwmDo

Demo4 (PowerShell):
https://youtu.be/lyedtAtATGc


### Contact:
```
  twitter:
    @wired33
    @midnite_runr
    
```

# Documentation

```
  https://github.com/Genetic-Malware/Ebowla/blob/master/documentation.md
  
  Also read genetic.config

```

# Payload Support

|Payload|Python|GO|PowerShell(tested on v5)
|:-----|:-----|:----|:----|
|Reflective DLL| x32 / x64 - None| x32 / x64 - In Memory| x32 / x64 - In Memory|
|DLL| x32 / x64 - None| x32 / x64 - In Memory| x32 / x64 - In Memory|
|EXE| x32 / x64 - On Disk| x32 / x64 - In Memory| x32 / x64 - In Memory|
|Shell Code| x32 / x64 - In Memory| x32 / x64 - In Memory|  x32 / x64 - In Memory|
|Python Code| x32 / x64 - In Memory| x32 / x64 - None| None|
|Powershell code|None|None|Yes|
|File Drop| Yes | In Progress | Yes |
### Credits

https://github.com/vyrus001/go-mimikatz

https://github.com/PowerShellMafia/PowerSploit/blob/master/CodeExecution/Invoke-ReflectivePEInjection.ps1

https://github.com/PowerShellMafia/PowerSploit/blob/master/CodeExecution/Invoke-Shellcode.ps1


### Contributing

If you have a bug report, submit an issue.  Include the OS that you tested everything on, including the server (victim).

Output of commands we like:
```
Windows:
  systeminfo
  
Linux:
  uname -a
  
```

If you want to contribute code please do so.  We ask that you actually submit something substantial, fixing spacing doesn't count, or making our code fully pep8.  

Look at our issues for ideas where you can help: https://github.com/Genetic-Malware/Ebowla/issues

secretsquirrel is on IRC #freenode as midnite_runr


### Contributors

https://github.com/wired33 (wrote most of the golang payload code)

https://github.com/secretsquirrel (wrote the python payload code and most of the encryption code)

