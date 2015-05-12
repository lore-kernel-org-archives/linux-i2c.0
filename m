From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: hix5hd2: Fix modalias to make module auto-loading
 work
Date: Tue, 12 May 2015 18:10:29 +0200
Message-ID: <20150512161029.GC6805@schokonusskuchen.bad>
References: <1431046211.31122.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431046211.31122.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Cc: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 08:50:11AM +0800, Axel Lin wrote:
> Make the modalias match driver name, this is required to make module
> auto-loading work.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Applied to for-current, thanks!
Added stable, too.


--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUiX1AAoJEBQN5MwUoCm2gBcP/jftsgHigjPjudV+fsCXO3hx
JaWp9/9A7hZ17gYI0eIa1E/BlJ9PpeNGF1O2A0FPTjpVingOZrSrQvRCno8uUvpb
lQF0scqdLI1qh3dqQZc7YMSjMvIX12T0vuRSdf1W+mE0udStldZC1J0P8KkZIOEh
3NavRZY0QNN4e60YI8qpWIfJQZrFSJcFZUw9MFgGDcR4CZPXLoSWjBqdEqnhiBNi
AnYgsAsTQgH5TaShER0TUdLEhGicQCv/j/P5s8OHkuIyE9QF1eaGVtm+iStENe1R
YjnemuXbbGmOimDV3H4b4e7DYXYH2LzdXB6hymhC9F4Ghb7D7LZf13c26c+Z0WtP
Hr8bt8eId6+c2D4187UWle/YNfSmVuHNg+VoDxRdJvitKYr0mfZ+LRTJHWKYT/D6
RYSoJa0kGxEbtbqMblBxSsj2VIKSLkJRnqjHOM0y4DD5UNqUOL+s+L3VdmubxiI3
f1vjsvLpaE4EqIJG0pDInFnkAhytrv+/53OiNatlu7OUVYHUeI9G18e391HB+BxK
JfRGkNV4J8bkf07wuf0rmWH8nZR3vLUsMe1NuEoE476mojeEZncD2jfRDDVVSRZL
CkqWsh45kuieit+jov/T6su67wdqskBSgmvx/7xRD/YWLN9HF1LR/CQGrmjsrdE6
ouQT3XIfTAYdqN8KdUJf
=h7mm
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
