From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: add slave support
Date: Tue, 26 Jan 2016 09:36:09 +0100
Message-ID: <20160126083609.GB2190@katana>
References: <201601260255.x4ozgiHe%fengguang.wu@intel.com>
 <56A72CC0.1070207@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55751 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbcAZIgN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 03:36:13 -0500
Content-Disposition: inline
In-Reply-To: <56A72CC0.1070207@dev.rtsoft.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Syrchin <syrchin@dev.rtsoft.ru>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 11:22:24AM +0300, Dmitriy Baranov wrote:
> Thank you for testing our patch.
>=20
> Due to using the generic slave interface, It should be enabled in the con=
fig
> file.
> Please add the following in the config file:
> CONFIG_I2C_SLAVE=3Dy

For now, you need to select it to make randconfigs built.


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpy/5AAoJEBQN5MwUoCm2JFAQAJVlttrrSGGbm+AfIDpP0jRS
MwHq7ul5BaWueMjQRl3DZ4Hsu+q6XkHEGu0nzNvA5JvD5ikWZfqXR1Knv7EG5Qm1
faMQY14BGAzV4l/KzDtc8tAhvjCPt6GJYfNLyOuMfRsTxPSh8ehNBkwfVYwm+A0G
2cDZ8/oFlPXgSA/MLVV+gvPF97yWxPM9vw1bgoZesoNoe6bSmkcQgre4k7JfzEJq
CzICHkbPv8TxrmjDQ7+LSKSdno5bGib5bDJQ5UN9ioQ4yLB1Hzz/v6SwrZigu010
eVYDALqtcRw5J+Pt9f7OWGjWXpQohyfOz6n6x/mRMVoU2u0YYWmZzd8STFvMEDvl
z4C/kZqDh2hgd6zgwXp95eQBaDSGIecXkIJGoW1sVVvqKmPrMLUVlKBO8yKq/JHm
Tcwj2kKbQ2CmdyRJOClghQ2RrsrHwC5AQbLZzvfQg0Emk/pl5VfIrgWa6PFAx/Cz
xSmBvIrM3hE1FDPyh1lzsvixNl3IU8BODbQCvWnpunvQ4IB2F25UPubEH4aMfM/K
FQifXcscW38YQ8t6zfUxLuHXwBEfKItk5YcPjCe16t9kP3I3+q64Sg3rZtiJhNiY
B+v2UpnFNxAFQEe1G0sGgDPGHD0V0z0ATnj7PYWk6A70jVO2pEF/MDfRFsGe2gIJ
aVV4Xjdy0BHGi/E61AGs
=GITo
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
