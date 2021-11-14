The following are things I cannot automate or might not apply to your hardware:

# SSH Keys

    1. Use `sshgen` to generate keys.
    2. Use `sshkey` to copy it to the clipboard.

# Using Touch ID for `sudo`

    You will want to edit this file: `sudo vim /etc/pam.d/sudo`
    ...and change `auth sufficient`'s value to `pam_tid.so`

# Not a fan of the notch?

    The display contrast on the MacBook displays are so good you won't see
    where the notch starts and ends with a black menu bar. The TopNotch app
    does a great job of hiding the notch: https://topnotch.app/

# Google Chrome Profiles

    Best not to mix work and personal browsing. I colour my personal profile
    yellow and never log into Facebook or YouTube on my work profile. Best
    not to get into the habit of browsing to those dopamine hits when working.

    Also, set it as your default browser.

    Extensions:
    * 1Password
    * AdBlock
    * Grammarly
    * JSON Formatter
    * Simplify Gmail
    * Vue.js Devtools (beta)

    Lastly, YouTube does not have a 3x option. Adding this bookmark will let
    you set your own playback speed:

    ```
    javascript:%20r%20=%20prompt("Enter%20Rate");%20document.getElementsByClassName("video-stream")[0].playbackRate%20=%20parseFloat(r);
    ```

# Slack Groups

    * https://phpaustralia.slack.com
    * https://serverlesslaravel.slack.com
    * https://raycastcommunity.slack.com
    * Personal/family spaces are in my Notion notes
