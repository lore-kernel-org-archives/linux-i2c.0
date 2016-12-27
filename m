From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on  Dell machines
Date: Tue, 27 Dec 2016 14:51:01 +0100
Message-ID: <201612271451.01505@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4513449.6tkDFjm1qK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34804 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbcL0Nv6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Dec 2016 08:51:58 -0500
In-Reply-To: <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, mario_limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, =?utf-8?q?Micha=C3=85=E2=80=9A_K=C3=84=E2=84=A2pie=C3=85=E2=80=9E?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

--nextPart4513449.6tkDFjm1qK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 27 December 2016 14:43:49 Wolfram Sang wrote:
> > Dell platform team told us that some (DMI whitelisted) Dell
> > Latitude machines have ST microelectronics accelerometer at i2c
> > address 0x29. That
> > i2c address is not specified in DMI or ACPI, so runtime detection
> > without
> > whitelist which is below is not possible.
>=20
> I'd think this should rather live somewhere in
> drivers/platform/x86/dell*.c?

i2c_new_device() with lis3lv02d for i801 i2c bus needs to be called=20
after initializing i2c-i801 bus driver.

I have no idea how to do it (properly) outside of i2c-i801.c file.

Same thing is done for Fujitsu machines, see function=20
i801_probe_optional_slaves() in i2c-i801.c file. So I did similar=20
approach for Dell machines.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4513449.6tkDFjm1qK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhiccUACgkQi/DJPQPkQ1KmEQCbB42KxcQuQOvpnxCxoNh/xaJ7
ZJkAnRSE1y4FzHIL62b7wTMjEO5beu2B
=3j+0
-----END PGP SIGNATURE-----

--nextPart4513449.6tkDFjm1qK--
