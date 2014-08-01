From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Drop dead code in i2c_gpio_remove
Date: Fri, 1 Aug 2014 20:02:03 +0200
Message-ID: <20140801180203.GG3277@katana>
References: <20140728143314.691999a5@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140728143314.691999a5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Violeta Menendez <violeta.menendez-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 02:33:14PM +0200, Jean Delvare wrote:
> Commit a0682a31 ("i2c: gpio: Use devm_gpio_request()") left unused
> code behind, clean it up.
>=20
> Fixes: a0682a315889 ("i2c: gpio: Use devm_gpio_request()")
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Violeta Menendez <violeta.menendez-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> Cc: Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT29YbAAoJEBQN5MwUoCm2GXwQAIiVHovJd3gB3YZmM79if5tD
xbnAU2/+CT8QfnAcviAiUE82qd6XFQYWfd4PnnUzkaO5BwMeNNOGCS9uJgJdw9gU
LvbYop8HOOfsxL25ghZdM6nFG5BHNisSybn4FG2wpjd3ra1W35TXAulPzP8iUgZT
OrAd2zrmL/44WD2UifFoGl5qQdlhh1myqryn3jBtwZZXR26LuHcMiHJIqyu01JKq
1wHUUxs+wEl4sw5X59tVVye5KMAoZyqn4IP5Q/BvPzrbHDO88sW75CxfWjbDSeoO
Ac4yuEqwOhpoXNR9s9Ltmrq0J0u4YMFGXC0urwQfRysKt6h93XgBy+F8Y+61H20W
kanznirx1TtJmkkj6RAlRVHGkTlz9j51lIIyISIvhcJfFPMTdmdlkIN2KCshuNlM
XbBXPnuY2xrMo2aduaNqlCRrRmxp2Eld2OMEPD7BJANp+1TwIDT6HgBVbHZBfRvU
PNB5rm4zS1GkEyKu/5mlDf0vvqkJ+J2i5H4tz85FqPxWVuMeT9oTKMnbG/o0+f8s
9nuAYUJ9tzc55Pgt7f1WoZ66rdfHUJQPVpIFNxfjgjbVx2tfupIJNQ1QPxas91Wc
C7MgC7cOL3OLsXtcM0Sgh1y0vckQj4diGUpEjYrH1F+sK1iXn+cKL7j7IDBNdHl7
7ehMLOPnOJNIpvZczuol
=EYpU
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
