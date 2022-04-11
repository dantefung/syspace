#!/usr/bin/expect
 set password "yourpassword"
 spawn ssh -fgnTN -D 1080 yourusername@yourdomain
 expect "yourusername@shop.foch.tk's password:"
 send "$password"
 expect eof 
 interact
