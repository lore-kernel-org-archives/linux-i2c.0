From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Don't set SCL timings and speed mode
 when in slave mode
Date: Mon, 27 Nov 2017 18:30:44 +0100
Message-ID: <20171127173044.gblciprw56uqdkx7@ninjato>
References: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlbqivej7jo5dozz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47712 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbdK0Raq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 12:30:46 -0500
Content-Disposition: inline
In-Reply-To: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>


--qlbqivej7jo5dozz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 04:46:12PM +0300, Jarkko Nikula wrote:
> According to data sheet SCL timing parameters and DW_IC_CON SPEED mode
> bits are not used when operating in slave mode.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--qlbqivej7jo5dozz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocS8QACgkQFA3kzBSg
KbZumA//S1P7/mGLF0aLO2LFEy+n8T0Tny4aDx35EU7bmTSsxB172aKgshBBrxlu
lrU1qVlKO7yK3SFldaz/UBhSm7DGreyPi7QJeR3tIoM1xF8biac91kL6T6d//FMi
1+l4Q3mL81rSL+yyNiea2r84A42vSiLk+DG4fcJkP1dfENNyOappjAb3YU/WpiF3
vyyxSf4yVB7HyqllbFxaB1/aFaC5ZIHAp18omoNIIPEjR7vnkhqpa4wlOL5gQ3yx
3l5v1PofRcAMmMl+ExUqOmkOXfcCJNvtRn6EWzkvRpUcS3uvHbbwGYhHh6cKZSVz
miboZQuNBcZhIwWG/aib53fCVXJm7ma+UDA8/YyptLRMLeuuJtzMVQ2AnnoUEhye
PH+TZAiHRAlbOwD+sjpG6zSgODR8RgHt6FIjrPCaA5rKozuEc/bSGmiInFqebGou
8o0UNTq90RbbpU+iEt64Mm6L0VTQWtLzQJw9izSxMwW+w6fYF2oGBfdcqmZkCnH2
d6mdgHuQeJj+kWLmKfJ6xvQrvuk869AsBlPirr03qM9cMsdSr7j9SfX/asDcZJUq
BDFsWf2fXNwxoHe0+f7zFxr+1DcrsdsaZXN7FuJIROo3UaRfiuimgM9R/fKUJvMC
z2fiCB30SbT1sQdG63lekac5uimhuTD3O1hd0Jx6CFuMqeCeRQ4=
=OIUA
-----END PGP SIGNATURE-----

--qlbqivej7jo5dozz--
