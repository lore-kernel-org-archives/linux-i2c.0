From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH]  i2c: i2c-smbus: drop useless stubs
Date: Fri, 22 Jul 2016 09:08:06 +0200
Message-ID: <20160722070806.GC1605@katana>
References: <20160719131549.3eb23323@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50773 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbcGVHIL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:08:11 -0400
Content-Disposition: inline
In-Reply-To: <20160719131549.3eb23323@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 01:15:49PM +0200, Jean Delvare wrote:
> Drivers which use the SMBus extensions select I2C_SMBUS, so the
> stubs are not needed.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcZWAAoJEBQN5MwUoCm2YsAQAIInfzwZc8UOOwojIcSc3700
UrMz75mbjDuDQLBY9fwxTA1FA97GPp+jbPSJ/XyC1BC4+vo8zd0ah4NLIweC9GAs
1mQ8CWc7w8cWpr/8DuH94LV6Hps8slMVsuA5JaFw3XX4OzH1SngokKY6D6YhLPOI
dnpIuirSZseeva6R76VcSaWiTjVknwVLz4GOo3WNcXSOO4DRE1NHQjh787BnOCgR
3vm2OSyMYfjxTGg/mYpjEgn52efyxpSvFziiWj24X+H4gIMfAjxhH3D7WDORKMzU
F6KWybVbyeAmVTrT9n2kj9JvN3KA8Gfo1ISZfxpLSg3DYfK/Yr4Ij5HVO13CA8MY
eJ3rBXwDIfZRsHrR5dwbSLV5kuJzoAgItVy24iGdCVY1VoT5z8on3D8/lNfdDvN6
GMQ/3MN1P4MSwXrbAiwQVnCJt/ca65syzap85wJWSIeP/FDSquyjy1NXM4m8c4cD
4bVVLX2BNF7CrTcM4+upiu++AHB7O7xi86Qp7+hRh+0xn/+wvt/kroAWehDz1boV
h0Ch0kTe7Mi+XZmGOEc1mB2h1/uzANoI9BfwfRp7JAaUw84sgcAefgN4WLEDH8+x
s38Sdq+z9D1K1wWPA1+RN9i0Vuo6xYTACa4oAgltLuQZijkvB6fCHcFWJfHPEtTb
oSGYH1bvawx3Am2QFbg9
=hK9J
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
