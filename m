From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Wed, 12 Jun 2013 19:09:16 +0200
Message-ID: <20130612170915.GA3018@katana>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368476301-10495-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2013 at 10:18:21PM +0200, Linus Walleij wrote:
> This tries to address an issue found when writing an MFD driver
> for the Nomadik STw481x PMICs: as the platform is using device
> tree exclusively I want to specify the driver matching like
> this:
>=20
> static const struct of_device_id stw481x_match[] =3D {
> 	{ .compatible =3D "st,stw4810", },
> 	{ .compatible =3D "st,stw4811", },
> 	{},
> };
>=20
> static struct i2c_driver stw481x_driver =3D {
> 	.driver =3D {
> 		.name	=3D "stw481x",
> 		.of_match_table =3D stw481x_match,
> 	},
> 	.probe		=3D stw481x_probe,
> 	.remove		=3D stw481x_remove,
> };
>=20
> However that turns out not to be possible: the I2C probe code
> is written so that the probe() call is always passed a match
> from i2c_match_id() using non-devicetree matches.
>=20
> This is probably why most devices using device tree for I2C
> clients currently will pass no .of_match_table *at all* but
> instead just use .id_table from struct i2c_driver to match
> the device. As you realize that means that the whole idea with
> compatible strings is discarded, and that is why we find strange
> device tree I2C device compatible strings like "product" instead
> of "vendor,product" as you could expect.
>=20
> Let's figure out how to fix this before the mess spreads. This
> patch will allow probeing devices with only an of_match_table
> as per above, and will pass NULL as the second argument to the
> probe() function. If the driver wants to deduce secondary info
> from the struct of_device_id .data field, it has to call
> of_match_device() on its own match table in the probe function
> device tree probe path.
>=20
> If drivers define both an .of_match_table *AND* a i2c_driver
> .id_table, the .of_match_table will take precedence, just
> as is done in the i2c_device_match() function in i2c-core.c.
>=20
> I2C devices probed from device tree should subsequently be
> fixed to handle the case where of_match_table() is
> used (I think none of them do that today), and platforms should
> fix their device trees to use compatible strings for I2C devices
> instead of setting the name to Linux device driver names as is
> done in multiple cases today.
>=20
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!

Thanks also to Grant for the insight.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuKs7AAoJEBQN5MwUoCm2ty8QAJ+oxf1rM+SJSwZi6bzgJ0qj
gP2EGuQFU7SszM6/RSQPHpOckSlOTVcEqqJyVk2i/y71l16XraSwoUiKeuWyAvzH
xtAl1XRBplJfEpklpe0oBCZLX5NRNpW0OFeJCFasFryAvf/QNKD/qWW6BTV0DW4F
TfSSWieyHmYTAxCbiLdST7Ym+qJFKXvatJ+58Pr7EC90ocA0a/saNJct7uPovY4w
DeGXM0B+wSlncTr6/puhUr4BE7kCR+W9t+6agKA4amK700ke4Lh+cgmolJkoh12X
SR2oVWd5EJ3+2RnxIyJA1P3sWCYWeTisqxx7P6Zz1efxPFlu7p2d2hE/OtxefeM7
IPEj0ob7Gp+PEUbomQF8SRJdUPk84xAOwufvYkKu+gmjMDdteNUa/baMHHoKYh2r
GVjMZrlulU4VFfHgdy36yssOim7wqR5cxJ2WILXKdy0g9JtXbFku6xT34CKnZhIq
ko7pNzzDVwZuPSpm68tgSAFgLxip984PuduxILxI/CbaWJB1hh8XrC6FRMzMB26H
iRgg3qeMNAt2oLbIkrWwD++A4mYYh99V4esO/7hRajgYsbmvZeHHDsn/Eqgp8Pfn
cKOWW7ZOkQMpEAENbhTy7VzNH0Bo6I/QMVbZat4Ld+/xyRX8SQcSKaYTHO/mhEqK
Io5aLbGxYzscai3AwxdA
=i50L
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
