The following are things I cannot automate or might not apply to your hardware:

# Using Touch ID for `sudo`

    You will want to edit this file: `sudo vim /etc/pam.d/sudo`
    ...and change `auth sufficient`'s value to `pam_tid.so`

# Not a fan of the notch?

    The display contrast on the MacBook displays are so good you won't see
    where the notch starts and ends with a black menu bar. The TopNotch app
    does a great job of hiding the notch: https://topnotch.app/
