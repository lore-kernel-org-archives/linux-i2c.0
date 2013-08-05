From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix Kontron PLD prescaler calculation
Date: Mon, 5 Aug 2013 10:35:13 +0200
Message-ID: <20130805083513.GB2980@katana>
References: <20130726140455.40b4b86b@hyperion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130726140455.40b4b86b@hyperion>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kevin Strasser <strassek-29tvszzbzErpgkiH4x7ZXw@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Michael Brunner <Michael.Brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>, Dirk Hohndel <Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 02:04:55PM +0200, Michael Brunner wrote:
> Add some necessary braces that have been removed during driver cleanup.
> This fixes the I2C prescaler calculation.
>=20
> Signed-off-by: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>

Applied to for-current, thanks!


--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR/2PAAAoJEBQN5MwUoCm20ckQAKykhf0wV5v27MVU2fwvyK2a
tKA+Rea/h5R0t5uFJhPd2K7q/z7M8c1XVkM7i1ekiViQaaqVuWXOuHkp2I3ebcID
ptMWC/PcNAq4YZAgvyccGq1L2r4M2g1BVjaKSNu574lXd2JlvqrGE4tY2qj+qgfk
giKA+dAlx+uj1PG7OxhS4ZbTUH0w9r/qemwYCUjr9mfU7NMamvoKMADx+2Ahik1b
8pUO1CRggGx3VTq/9jJpCKPYoYrq4G+7CuFH5bDwDtSdXw8tej0kkMJhRnt6xPRb
PU+mL+j9mJiy7a5hID5+/fwktNZiGxymcwfRT9k5fovUSoHb//IhzlFOv33vcaxj
56PI2PPqZlCoKQTj4xxv5PXyJIgd4jBd0ZHkvlicqBIkPxsnj8tRnkbGsgX/P5Fz
WJxDRCMk04U4VAIhR8A3dAV2L5TG0QAgYftc5HaFpL2oksVSps8QZel8xSKV1f5h
+7mW29HtbPvZ7BJhUESsnssJhV8FpNNahuRL0H/ut+hMOTHX3g9urPHXUQF2hdg1
pVSzV9IUy7XCGnZjSwmNsU1in1lhFAuWV3fDYuyYefhIe1Dy7U8s6eilrm8P/DRL
V5InXmfW3XpznTJzOA/I9nNIT6+W2wI3jwh0CHuaXYBE/N2jtXiwslgTP+VVHRHs
/zT/hdF+AzCUQiKYEjL5
=dfMW
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
