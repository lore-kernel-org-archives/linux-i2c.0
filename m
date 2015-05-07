From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Expanding Data Length
Date: Thu, 7 May 2015 08:51:48 +0200
Message-ID: <20150507085148.36a5d765@endymion.delvare>
References: <DM2PR05MB26987446197555F557AAAF3C4D00@DM2PR05MB269.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DM2PR05MB26987446197555F557AAAF3C4D00-MaDUXw8P98D+jjRowIUrkmu6+pknBqLbXA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Grunwell <rgrunwell-/nwpbuHZvbfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Wed, 6 May 2015 20:31:20 +0000, Randy Grunwell wrote:
> First, let me thank you for the I2C-tools! I have made a test control=
ler board for my RPi that uses them, and it has been working flawlessly=
!

You're welcome :-)

> ... until I tried to add a display. There seems to be a 32-Byte limit=
 on sending, and for some reason, the New Haven display I am using does=
 not like having so little transferred. I have contacted New Haven (and=
 actually the actual driver IC company as well), but they apparently on=
ly communicate through the forums, and haven't seen to reply to me.=C2=A0=
=20
> (If you are interested, see http://www.newhavendisplay.com/NHD_forum/=
index.php? , then Graphics Displays, and the two messages from Tinkerer=
1359.)

Couldn't find the page, sorry. Why don't you provide a direct link to
the relevant posts?

> So I'd like to ask you to consider expanding the length that can be t=
ransferred if possible. This particular display would like to see a tup=
le of at least 644 bytes at one time!
>=20
> Thank you for considering this!

The 32-byte limit isn't an arbitrary software limit on our side. It
comes from the SMBus specification. SMBus is a subset of I2C commonly
used in computers. i2cdump, i2cset etc. are essentially SMBus tools
rather than I2C tools, despite their name, for maximum compatibility.
If they used the i2c interface instead of the smbus interface then they
would be useless on SMBus-only systems.

That being said, you are not the first user frustrated by this limit.
Thankfully, Wolfram recently submitted a new tool to address this
issue. The timing could hardly be better. See:

http://marc.info/?l=3Dlinux-i2c&m=3D142505384332026&w=3D2

Wolfram's tool is a true I2C tool so it won't suffer from the 32-byte
limit. I believe it should do what you need. I didn't have the time to
review the code yet, but I invite you to test it and report.

A little note though: 644+ bytes are a long message by I2C standards.
Passing all the values as text on the command line to be parsed into a
buffer then passed to the kernel will be rather inefficient. Depending
on how frequently you need to do that, it might be preferable to write
a dedicated tool in C, or to extent Wolfram's i2ctransfer to be able to
read/write binary data from/to files directly, or to write a kernel
driver for your device.

--=20
Jean Delvare
SUSE L3 Support
