From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Only include slave support if selected
Date: Mon, 26 Jan 2015 19:05:09 +0100
Message-ID: <20150126180508.GB25317@katana>
References: <20150126190047.7bc44f26@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126190047.7bc44f26-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 07:00:47PM +0100, Jean Delvare wrote:
> Make the slave support depend on CONFIG_I2C_SLAVE. Otherwise it gets
> included unconditionally, even when it is not needed.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
> Changes since v1:
> * Let I2C_RCAR select I2C_SLAVE
>=20
> Wolfram, you mentioned i2c-sh_mobile but that driver doesn't seem to
> implement slave support in v3.19-rc6 so I did not include it. Feel free
> to add more selects to drivers/i2c/busses/Kconfig to match the current
> state of your i2c tree.

Sorry, my bad. I meant the RCAR driver which you spotted. What about the
function pointers in the algo struct?


--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxoHUAAoJEBQN5MwUoCm2Z/gQAKvQkH2g1mPfuDCBJ8s7CPSS
CUSbWajPvlm/2kZz9fZQLbNdGzf1W4GR4JYEGRHCiUyCj8pbFF9/rTNuxdmzkq8b
a3fAM1NzhS3O6ukgJ7rKWrkHOiDCZ7ag3Xk4kx263UhKnF4KCap93z0QtlPg6wa7
GkKAuNynRrBngu7ywOOn+JODySFT98Iw8YfF9Bhp2e2GnrG1tUzglneeahbxm7Y/
ZPsEO4fN8rrPQM9GgFpnz+WoZbpMFKv8bVSML3TOEMdT02EdZ9Cia1fzgLSC8dMA
Vx4YAcorpMJIdwalydHKJJOlN454tHBvEXwKCGUuyIMGgj+hTy4GE6xzkH4/L+vG
9EDKdFE9InxEUkRThsXbEtP5we0lAvI76dIHUoQqr4pvZl5aoIYPWOZbPrmeyhxE
5FbGOlgv6W8Li2moa9crG9YsHSHhLnxTuuJHICNcreaRZTsDc9hC8CKIsoka9QBV
RTbK4diR3FEaDvGgYbnGofURNNvDlvH5Xg5wKEmP1RhHWkzyYTi3bHvPSJz2z9iz
QD9pj0Q4D/G3CmDCBhY2aPA+gbpJZlwgMCvqxDVh/LDZI/ftQUH/TKpEChZh3Vz3
CYzImScYEGNCqau11txxmlz1RXkwnNXDcMXWUwwpxdBh8xLfqmh1fTMf4AFk2n66
7ggIc4Q4PNs0bCue6ZJM
=C4hw
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
