## Receive options
set folder      = imaps://imap.gmail.com/
set imap_user   = 4denis.kh@gmail.com
set imap_pass   = `pass gmail.com/mutt`
set spoolfile   = +INBOX

# Specify where to save and/or look for postponed messages.
set postponed   = +[Gmail]/Drafts

set record      = +Sent


## Send options
set smtp_url=smtps://$imap_user:$imap_pass@smtp.gmail.com
set realname="Denis Khizhniak"

# Connection options
set ssl_force_tls = yes
unset ssl_starttls

# Set signature
set signature="./signature-en.txt"


## Hook
account-hook $folder "set imap_user=$imap_user imap_pass=$imap_pass"

# vim:ft=muttrc
