From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i801: Add PCI ID for Intel Braswell
Date: Tue, 19 Aug 2014 09:49:04 -0500
Message-ID: <20140819144904.GB15371@katana>
References: <1408459048-7470-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408459048-7470-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 05:37:28PM +0300, Mika Westerberg wrote:
> From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> The SMBus host controller is the same as used in Baytrail so add the new
> PCI ID to the driver's list of supported IDs.
>=20
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 2994690b26e9..10467a327749 100644

Applied to for-current, thanks!


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT82PgAAoJEBQN5MwUoCm2bT0P+weM3WlceNvWj88EZcerCbVs
hy4WBKc3LWDYrfhYzsJJbV/nTbJ5E3COhfgAicYX6L0Hxvfc5x2rbqfT9KUDyRD3
UMLQQIm4dtgiSa+l+HXBRpOj6zzBEoCmm9ifO55OdnhEwGgMIkfQ7J+lEFCFxBD+
z3/as9agUCMvuN8zX0MK4cdaE5GDabAkwyA8vThI01RlLd23Y9nbgsEnkg3GpMOK
lVHzEDuJYshpCxQps4AbbhoIgwK3szj303s03LXGzSApN3USiuNbMzD21YPce6KB
blSTjYFZL288jTNrYQcD2csGprYipPgCN2n6hGdUEUqpytilVjmmIgBEPzGHiq0r
uHPP9z86v+sOfdk/NrLAbSYEUZ9sNsPJn96ALzXmXjtXS09erRoKDJKxLfO1+XoN
Nrq0Qj368CC8JA4fJygo1IvwIZ7joOA3uFy4vxzspZWBuIVtJJQL4jUOcFRnHytN
7aihG3iLQxZiKTeb3NGnx1qyyAkoD97SyowBk5+GIjFzdn/7j3pUuEp38L98SD41
BAcZSwm5LAVcl5SBKYsYRh3vOwAA4sd8ZlE20sJeKRAja8zZHpAuLVguTSez3cIt
frg3HsU0OqrBY0VZQD5F5B9hABV9GFEu2/ijBQn9W741rBjTXxyJhyt/kAgLSkyV
AiZLwob2UJ0X6y6mxlSK
=osk3
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
