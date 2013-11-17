From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C Master with limited transmission sizes
Date: Sun, 17 Nov 2013 12:15:24 +0100
Message-ID: <20131117111524.GB3093@katana>
References: <201311160438.36636.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201311160438.36636.PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter =?iso-8859-15?Q?H=FCwe?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I'm currently writing a driver for a cheap usb-to-i2c master device, whic=
h=20
> unfortunately can only write 31 bytes (+slave addr) and read 32 bytes.

Which one?

> What is the correct behavior if a user requests larger read/writes?
> Simply set i2c_msg.len to the bytes transmitted?

No!

> Or should the master try to split up the requests?

If you have control over sending start/stop bits, you could omit the
stop condition unless you transfered all of the 32 byte chunks and issue
the stop at the end.

If you can't, don't advertise I2C_FUNC_I2C, but SMBUS functions (without
the block functions again). That will work for most devices.

Hope that helps,

   Wolfram


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSiKVMAAoJEBQN5MwUoCm2fvYQAIvhlNfERsNT8mDaY5O46fs2
oNuDPOFlqBymg/GXzV1VGG+ISS/dSe3qYXyholn9Z4RdnRsWHrw6aFwNZtDVvYWZ
mG+l9eTfCXVUDb51Jz7Wbe5YCfTa1mL2odwRY5K9tCxB1hh3isfJWmcbuR8XJokV
tPaVfEHZ3A7Ce/h2AGLikB86e+sJhVU6hP5gq4QjnJUxOt8F6XxJtsRYCX2R6QLW
YtRQoalARl9IAa4r9V44MVyb2u5EqiIe66pD92u9mT21UhnJQMAV/a9ZnIoJyq80
5J0DBXTqOUTj83DGig5vtXeehTBiggAfZ+s2nVF7D6z/20U1s2nstKpPdtlIAzht
2lwGZR8F/UOVJckp6tJSIV4yqXN+F9IZbX4mA2r10oIcMb6EsvCdUFAizEjMOIKD
vEs6m60b6abGMKTGhJ/auWf7GMKO0ZILWx4dnREYIkdmU1A/jkGn2rLC+uFpGoOn
E0n16esRkp41zPG24U/8k1SETr+dyVwnGD/H1yfvO4HRzqXhfrYwVfRSsFBuK/t0
KOmsnAqQIOX4WebBSWdPR8P4HTMXLQkJK7V37FSrvCX6ESy76YK/gWPJnqgeBnmi
XxqJg8ZoskiiJPkJbxAq94JK7Mpkfa8gLVZHMPdtOXYAPiHkEyAmlpLv4ITtclB9
FTD0eJk5/iDFD9wTD56U
=k1AW
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
