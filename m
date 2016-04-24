From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-platdrv: get fast/std speed scl high/low
 count from DT
Date: Sun, 24 Apr 2016 22:39:23 +0200
Message-ID: <20160424203922.GC4317@katana>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
 <20160407175759.GO32257@rob-hp-laptop>
 <20160413201147.5621a17c@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160413201147.5621a17c@xhacker>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 08:11:47PM +0800, Jisheng Zhang wrote:
> Dear Rob,
>=20
> On Thu, 7 Apr 2016 12:57:59 -0500 Rob Herring wrote:
>=20
> > On Wed, Apr 06, 2016 at 03:28:00PM +0800, Jisheng Zhang wrote:
> > > Sometimes, it's convenient to define the scl's high/low count directl=
y,
> > > e.g HW people would do some measurement then directly give out the
> > > optimum counts. Previously, we solved the sda falling time and scl
> > > falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put them
> > > into dt, but what we really care isn't the sda/scl falling time. =20
> >=20
> > This is just so you can put specific clock count instead of converting=
=20
> > from nanoseconds with standard properties or you gain some additional=
=20
> > control of the timing. If only the former, then I prefer we stick with=
=20
> > the common properties.
>=20
> To be honest, both. Let me show how I gain additional control of the timi=
ng
> with this patch while I can't do this w/o it.
>=20
> I want the similar high percent of SCL high for both standard-mode and
> fast-mode. Before this patch, this is not achievable because the paramete=
rs
> to cal the hcnt/lcnt via i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt() are diff=
erent
> for standard-mode and fast-mode.

If there is something you can't describe currently, then we can add
additional properties to allow you to do what you want. But they should
be generic bindings and not a plain value which is custom to this driver.


--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHS76AAoJEBQN5MwUoCm2C78P/R8ahfoIxSpEMtC6XHd1LXmc
ZB/TXqtB2llMLRR0umlTwgzticDSWLWXQ3LkWLI/XnofxYhiRquakpIqEuIfsqME
DAo3Vdr1TrLHIVmZFMDQEZO3Wj/yzEQIpJf+uWkcjzIulQbHLfLybagfJX1JNNnb
sxM++07ybQ37QkXb3Yj7YxU1iUmTKa26JPWAl6uBXjLwCvlIz2o26LFyDxuclaOe
J5z3ij5m2EQeNjlZ/MzXf4fGBsdlHcs7A+qomuB1P7P8POZ8fqivhH6+gaBG1P/J
jtrpcolECKfJM8K+3RE3XFPTlhPCQRuMHLu0xe0WlpG8AZxoV+N+cobx+rQNLa4E
X86AK5poUkV7l5UI49nQ6Z18WLYoh+KT+EQdYutw5y59KiCPx+N7FBI7bGQ9sojW
v9uhuzPLaT3xpL6rvwZhPIenb2n025bFRVoabDkZQZqB1siBPrTA1wbHX/cALwG5
V4mykeBQvGJbsggW3Aio1x7bX8SUdzkG5AtBKguh2ZGM37kWWghPhjDfNDeFV+Wn
pYLw21W8IRBEvdzUczEUwTSqL+KwxxhNhwGTz99+ERvFytQrMi8wtUJ/0FoUd5XC
jW4Fvh8S1PGtgD/v9I2VAS+oz4xzt/XcJpZahJ3sumf2sxPLVsFZaY6PcWvlKkD2
+wYm1hciZn+E/lPrl97P
=z6p2
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
