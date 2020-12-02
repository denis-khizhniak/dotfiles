## Receive options
#set folder      = imaps://imap.mail.ru:993
set folder      = imaps://imap.mail.ru
set imap_user   = d3ni5@mail.ru
set imap_pass   = `pass mail.ru/d3ni5`
set spoolfile   = +INBOX

# Specify where to save and/or look for postponed messages.
set postponed   = +[Gmail]/Drafts

set record      = +Sent


## Send options
#set smtp_url=smtps://$imap_user:$imap_pass@smtp.mail.ru:465
set smtp_url=smtps://$imap_user:$imap_pass@smtp.mail.ru
set realname="Денис Хижняк"

# Connection options
set ssl_starttls = yes
set ssl_force_tls = yes

# Set signature
set signature="./signature-rus.txt"


## Hook
account-hook $folder "set imap_user=$imap_user imap_pass=$imap_pass"

# vim:ft=muttrc
