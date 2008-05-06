From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH6/7] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Date: Tue, 6 May 2008 17:40:54 +0200
Message-ID: <20080506154054.GC4265@pengutronix.de>
References: <47FF71A9.4010907@scram.de> <20080506135113.GA4265@pengutronix.de> <4820770B.1010002@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764846AbYEFPlV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4820770B.1010002@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2008 at 05:19:39PM +0200, Jochen Friedrich wrote:
> setbits8() and clrbits8() use a bitmask as second argument.
Ouch! Guess my mind wanted to read in_8 and out_8 for some reason...
Sorry and thanks for clarifying!

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIIHwGD27XaX1/VRsRAgMAAKCuMHYpHITge6JsAJL5zq3rxHWDzACeLVXM
EYriBQiZ3qWFJdwjM5mfXC8=
=zDgZ
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
