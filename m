From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Sat, 10 Oct 2015 08:45:49 +0100
Message-ID: <20151010074547.GD1619@katana>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57285 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbbJJHqF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 10 Oct 2015 03:46:05 -0400
Content-Disposition: inline
In-Reply-To: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 01:05:01PM +0200, Christian Fetzer wrote:
> This is an attempt to upstream the patches created by Thomas Brandon and
> Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757=
=2Ehtml)
>=20
> I have mainly rebased the latest patch version and tested the driver on a
> HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor=
 data
> from a w83795adg).
>=20
> The patched driver is running stable on the machine, given that ic2_piix4=
 is
> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
> sensors triggers some errors:
>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
>=20
> While the kernel log shows:
>     i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3D03=
, DAT1=3Dc0
>     i2c i2c-1: Error: no response!
>     i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3Df=
f, DAT1=3Dff
> Unfortunately I don't know how to tackle this specific issue.
>=20
> Please review and let me know required changes in order to get this upstr=
eam
> finally.
>=20
> Eddi, Thomas, it would be great if you could verify the changes on your
> machines.
>=20
> Regards,
> Christian
>=20
> Christian Fetzer (4):
>   i2c-piix4: Optionally release smba in piix4_adap_remove
>   i2c-piix4: Convert piix4_main_adapter to array
>   i2c-piix4: Add support for multiplexed main adapter in SB800
>   i2c-piix4: Add adapter port name support for SB800 chipset
>=20
>  drivers/i2c/busses/i2c-piix4.c | 151 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 134 insertions(+), 17 deletions(-)

Jean, is that on your list?


--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGMIrAAoJEBQN5MwUoCm2sIsQAIZzMXNES99tMGgMbWbF9Z/T
yEkpX2Xzn43cJzKIYF0D0QacTBt1RF+hhaJZMHSE/t5j85KkSKHAWqG+3YJ87CdX
b5mEfIKYsWzpW6UUtPgAKfQs+gf+gsuqrgaA/NZmtL/iNOs8l1P+WW4mealsw18J
iuNYAGdrcx8rGqmYdVtov6hckWt94TgWJIwDvTIpFoR/RozpoV6rqI2d7B4+ZeY/
pR/3vV/BLq9dC0wQDuIx88okDEPf6var583U3nQV5PPH8CKzVH3c59gZW16KyW/G
tW8OPDXvn7Gzvsayndey9KxqKvfiLMslINGI0TXDsth7nvIb2Mq8Qcw6XUgXoM2D
MMVtN4pxc57ZMjdu4CFfaoz4vtSVTVShwkVoR93TakB1jg3SCiJM5Qun5p6JVl7w
06aSk4OAWz+HvwDwRKTD03yyDVrjcAnUKD7EVaCe6z91+Ct1bfwlHzJK/tGBnPme
64l25i3Dq02sS8eZe+S/HZ0Ha1twAGhw2Umyiv+PhesVnfNiwYzoo5QTYVEhkZPQ
YtZqN6jMBS9SGAI+0ircgeo3kXtH6RKjLwE60yu34UZe1ks+5GaZNQIcC5FZmLcu
Yb3bIoTtRXp91bhX6bYY9g6vAcqauR8r2uWSfv45Sk1YRkBskIEYRYeThMGJp+xv
Xpua73XzXt/FGDVHjRGX
=tgd8
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
