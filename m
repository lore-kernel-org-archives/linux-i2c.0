From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri, 5 Feb 2016 00:27:46 +0100
Message-ID: <20160204232746.GA2421@tetsubishi>
References: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 03:06:55PM -0800, Alexandra Yates wrote:
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
> resources have been moved to reside under the i801 SMBus host
> controller whereas previously they were under the LPC device.
>=20
> This patch adds Intel lewisburg SMBus support for iTCO device.
>=20
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>

Please state what has changed in v2 of this patch?


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs95xAAoJEBQN5MwUoCm2mp0P+gLg6+/HWl+mfvFS4XilAcO1
CpQe+xowg+XTrwo9qL1eRRiTwzZ4yVv2x994+tIGLS6Hm7GDQFuNV5fHJmHeub/0
iD8L3PJiwfCcEfHeBh2s3JWddqvbRMjLmOXSi1GTHw1H2r/cXIZ6J7+bEo6dYZAV
VqS2yqb8+iMXFahTRIR0BNaGxAyCJ2uX+fQGo7O1JZiOqHoYdaFE34qp6qOoltxe
pVCjk/6I8IXnv+TZRcXEjHTfGoF2nXTz1hJwdqYC/F0YOnhZP/kiWbotkN79mtUA
vbW50teRNKA9oZvG7C5F4ns2zW0DCwFdsw+2HvzhBClgesDGyVkk6/iF7tFKWsR3
lkKKtai44ZwkPx/bOYg/W/S7MQndo+3TAcJpInWS7l/VQppX0rOJ2Z4anFCRK2sr
BXzKBtnNYv/ewJ3z5ZuDJfsVmvDZEjs/QhdY2LGHg8WPd4ebWQlgV1wcxHUkn2+R
5/GEaXP7Glb8lAx74Km+ohBQ1x2D44k650IS1D2rjLKruVTI15QR2TOPq8TpkGhK
EC16R2loe3xlZXgWD6ZDzEgXtknPodh3t++Sv8hH5iaG3r22ab1HsAT3L6oGlqIm
AM3Tt55Scuu7UJOmJTfOrUstubwX8GSMlPOjySuhvF3cWoLagCaAbURnu964/adE
5w12/B2mR7sn09ZtiY57
=a830
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
