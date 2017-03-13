From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c-tools: add new tool 'i2ctransfer'
Date: Mon, 13 Mar 2017 12:42:38 +0100
Message-ID: <20170313114238.jfuabrtbpjtwk6xs@ninjato>
References: <20170313114135.2327-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5kbo356u3nzyp4hz"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313114135.2327-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--5kbo356u3nzyp4hz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 12:41:35PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.
>=20
> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangerous,
> but it can also be very useful when developing.
>=20
> It has been tested with various Renesas I2C IP cores as well as Tegra,
> i.MX and AT91.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>=20
> Changes since V2:
> * reworded and added some paragraphs in the man page based on review comm=
ents
> * corrected some issues in help output
> * no code logic changes
>=20
> I'll send out a diff compared to the previous version in a reply to this =
mail.
> I think it will help given that the changes are mainly textual.

Here it is:

diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index f6fb94a..28b3388 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -28,9 +28,11 @@ and a
 here.
 A transfer may consist of multiple messages and is started with a START co=
ndition and ends with a STOP condition as described in the I2C specificatio=
n.
 Messages within the transfer are concatenated using the REPEATED START con=
dition which is described there as well.
-Some devices keep their internal states for REPEATED START but reset them =
after a STOP.
-Also, you cannot be interrupted by another I2C master during one transfer,=
 but it might happen between multiple transfers.
-This programm helps you to create proper transfers for your needs.
+There are some advantages of having multiple messages in one transfer.
+First, some devices keep their internal states for REPEATED START but rese=
t them after a STOP.
+Second, you cannot get interrupted during one transfer, but it might happe=
n between multiple transfers.
+Interruption could happen on hardware level by another I2C master on the b=
us, or at software level by another I2C user who got its transfer scheduled=
 between yours.
+This program helps you to create proper transfers for your needs.
=20
 .SH OPTIONS
 .TP
@@ -71,7 +73,10 @@ This number should correspond to one of the busses liste=
d by
 .PP
 The next parameter is one or multiple
 .I desc
-blocks which is composed like this:
+blocks.
+The number of blocks is limited by the Linux Kernel and defined in I2C_RDW=
R_IOCTL_MAX_MSGS (42 as of v4.10).
+.I desc
+blocks are composed like this:
=20
 .I {r|w}<length_of_message>[@address]
=20
@@ -81,16 +86,17 @@ specifies if the message is read or write
 .TP
 .B <length_of_message>
 specifies the number of bytes read or written in this message.
-It is parsed as an unsigned 16 bit integer, but note that the Linux might =
apply an additional upper limit (8192 as of v4.10).
+It is parsed as an unsigned 16 bit integer, but note that the Linux Kernel=
 apply an additional upper limit (8192 as of v4.10).
 .TP
 .B [@address]
-specifies the address of the chip to be accessed for this message, and is =
an integer.
+specifies the 7-bit address of the chip to be accessed for this message, a=
nd is an integer.
 If omitted, reuse the previous address.
 Normally, addresses outside the range of 0x03-0x77 and addresses with a ke=
rnel driver attached to them will be blocked.
 With
 .I -f
 (force), all addresses can be used.
 Be very careful when using that!
+10-bit addresses are currently not supported at all.
=20
 .PP
 If the I2C message is a write, then a
@@ -112,7 +118,7 @@ increase value by 1 until end of message (i.e. 0+ means=
 0, 1, 2, ...)
 decrease value by 1 until end of message (i.e. 0xff- means 0xff, 0xfe, 0xf=
d, ...)
 .TP
 p
-use value as seed for an 8 bit pseudo random sequence (i.e. 0p means 0x00,=
 0x50, 0xb0, ..)
+use value as seed for an 8 bit pseudo random sequence (i.e. 0p means 0x00,=
 0x50, 0xb0, ...)
=20
 .SH EXAMPLES
 .PP
@@ -124,7 +130,7 @@ On bus 0, from an EEPROM at address 0x50, read 8 byte f=
rom offset 0x64
 .RE
 .fi
 .PP
-For the same eeprom, at offset 0x42 write 0xff 0xfe .. 0xf0
+For the same EEPROM, at offset 0x42 write 0xff 0xfe ... 0xf0
 (one write message; first byte sets the memory pointer to 0x42, 0xff is th=
e first data byte, all following data bytes are decreased by one):
 .nf
 .RS
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index ab8d0e9..0f7ddd5 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -49,10 +49,11 @@ static void help(void)
 		"  DATA are LENGTH bytes for a write message. They can be shortened by a=
 suffix:\n"
 		"    =3D (keep value constant until LENGTH)\n"
 		"    + (increase value by 1 until LENGTH)\n"
-		"    - (decrease value by 1 until LENGTH)\n\n"
-		"Example (bus 0, read 8 byte at offset 0x64 from eeprom at 0x50):\n"
+		"    - (decrease value by 1 until LENGTH)\n"
+		"    p (use pseudo random generator until LENGTH with value as seed)\n\n"
+		"Example (bus 0, read 8 byte at offset 0x64 from EEPROM at 0x50):\n"
 		"  # i2ctransfer 0 w1@0x50 0x64 r8\n"
-		"Example (same eeprom, at offset 0x42 write 0xff 0xfe .. 0xf0):\n"
+		"Example (same EEPROM, at offset 0x42 write 0xff 0xfe ... 0xf0):\n"
 		"  # i2ctransfer 0 w17@0x50 0x42 0xff-\n");
 }
=20


--5kbo356u3nzyp4hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljGha4ACgkQFA3kzBSg
KbZt6g/7B/DD1pEPIvxGV+zmFIWx6LtmJeP6/FZcgixmT5EtuVR1KSIVbMF3xrRM
WYXmvw07rjbGdK3Xfsf9O3aMIwdalxKuxMEK0qiXtdQLK4G8BXfUqkGTsDzyFEx8
ua4cTNVhF/tDQK09qHxW66AXtC5HKQMZjtBtRr5SaTGESVU2JD3QjrIZO96qOXIy
JEEGXNMhq4h48hqzkf7+GITrXBoWk1rcMlOYGFv/HCxWaY6bDeFT7gCVAViBlosj
g6OnrYK+GcUKOwbRbdTqErazzriNPgXeKSfY6kpSlUzSAxmHpM0ebQaTLNq1Iiya
r/jz2wiebVAa1UIum7Yv6DwX36oRlZWquF6DDi/w6RdhFvanwumMHMzqCs6sLKri
ZIRRnKKyTF98qBcEIwZgidyqWg+sOBFjIu1GXq9D9mcrqigOIxbQi8kvXIxMmApo
qAMwQvXpr3k8a8rEwSKCHeI1Doqqyc0AOa78vQe0JpqfmmSpXMCSYNhkncI6ga+V
WaG6fAuRSpM/RblZ9s/y7nTpt93jpOZKCVAm9hj4N1n11WQ6u4FTvpkKMk5UKPcp
WXM3FS19ZwYHq6J88BJHOu+i9l7MOTyXAyNbqiHJ+0BaaH9w/6OQ1Gb0t/rd0Foi
LvGvv32uZpwVH5lc3KgH1ibb/hl/zTyutjuiWMx76/vNymM5A0A=
=ZDVr
-----END PGP SIGNATURE-----

--5kbo356u3nzyp4hz--
