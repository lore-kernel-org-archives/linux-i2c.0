From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: busses: i2c-ocores: switch to
 devm_request_and_ioremap
Date: Tue, 13 Nov 2012 12:20:00 +0100
Message-ID: <20121113112000.GI23119@pengutronix.de>
References: <20120923133358.GA22861@linux-3ix0.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y6imfT/xHuCvpN0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120923133358.GA22861-ks9ITDofB9nuAK1a81qwxQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Maxin B. John" <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--1y6imfT/xHuCvpN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2012 at 09:33:58AM -0400, Maxin B. John wrote:
> This drops a few lines of code and allows common APIs to handle those for=
 us.
>=20
> Signed-off-by: Maxin B. John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks, I just applied a very similar patch by Thierry Reding which was
sent earlier.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1y6imfT/xHuCvpN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCiLOAACgkQD27XaX1/VRtqbACgvYNr1kOOLmSrF2xAURrq2EbQ
qScAoJM5dx4ERt6KsE2HDLsDCIMYE4Ca
=VvVM
-----END PGP SIGNATURE-----

--1y6imfT/xHuCvpN0--
