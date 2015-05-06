From: Randy Grunwell <rgrunwell-/nwpbuHZvbfQT0dZR+AlfA@public.gmane.org>
Subject: Expanding Data Length
Date: Wed, 6 May 2015 20:31:20 +0000
Message-ID: <DM2PR05MB26987446197555F557AAAF3C4D00@DM2PR05MB269.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi-

=46irst, let me thank you for the I2C-tools! I have made a test control=
ler board for my RPi that uses them, and it has been working flawlessly=
!

=2E.. until I tried to add a display. There seems to be a 32-Byte limit=
 on sending, and for some reason, the New Haven display I am using does=
 not like having so little transferred. I have contacted New Haven (and=
 actually the actual driver IC company as well), but they apparently on=
ly communicate through the forums, and haven't seen to reply to me.=A0=20
(If you are interested, see http://www.newhavendisplay.com/NHD_forum/in=
dex.php? , then Graphics Displays, and the two messages from Tinkerer13=
59.)

So I'd like to ask you to consider expanding the length that can be tra=
nsferred if possible. This particular display would like to see a tuple=
 of at least 644 bytes at one time!

Thank you for considering this!

-Randy
