From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Tue, 6 Aug 2013 18:21:51 +0200
Message-ID: <20130806162151.GB2911@lukather>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r3RYAYa9cXQlbOHD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5200E684.5080003-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--r3RYAYa9cXQlbOHD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 02:05:24PM +0200, Gregory CLEMENT wrote:
> On 16/07/2013 10:05, Maxime Ripard wrote:
> > Hi Gregory,
> >=20
> > On Mon, Jul 15, 2013 at 04:24:36PM +0200, Gregory CLEMENT wrote:
> >> The I2C Transaction Generator offloads CPU from managing I2C transfer =
step by step.
> >>=20
> >> This feature is currently only available on Armada XP, so usage of thi=
s mechanism is activated through device tree.
> >>=20
> >> Based on the work of Piotr Ziecik and rewrote to use the new way of ha=
ndling multiples i2c messages.
> >>=20
> >> Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org> Signed-off-by: Gregor=
y CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> --- drivers/i2c/busses/i2c-m=
v64xxx.c | 207
> >> ++++++++++++++++++++++++++++++++++++--- 1 file changed, 196 insertions=
(+), 11 deletions(-)
> >=20
> > [...]
> >=20
> >> +	/* +	 * For controllers embedded in new SoCs activate the +	 * Trans=
action Generator support. +	 */ +	if (of_device_is_compatible(np, "marvell,=
mv78230-i2c")) +
> >> drv_data->offload_enabled =3D true; +
> >=20
> > Do you have a reason for not adding it to the match table? I mean, you =
will introduce a new compatible here, but if that compatible is used alone,=
 won't probe the driver? That doesn't
> > seem very right to me.
>=20
> But we shouldn't use it alone: we should always use:
> compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>=20
> From my point of view using  "marvell,mv78230-i2c" alone is an error.

Why is that? If the I2C controller is a new IP with additional features,
it should have a full compatible of its own, doesn't it?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--r3RYAYa9cXQlbOHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSASKeAAoJEBx+YmzsjxAgLTYQAImvew24TcUUvc3nhNVQDB27
n/nLwKUulT5oP3blhIeugV9HgEEqDtcGsL13X0usFTz6eN5fawdXs08S830Szn03
MneK1XmJmALPtLaUGRuTJCzFEUBgVUkYvZ74ZYI2DWZUPf1t2FXj2h69Iv74i8t1
eX+4GcY52ci3dOQhs7Sle1+IDU3HtzwETBZhFWc/fAEOtP3HWBkUVBTShEIv13WB
5z7jEGLJ3+AD4FIhm1nBBi5dbQiFk+iyIdGs0nmxZ/J6YBc57yBPdU0TgcCehBPb
AoCYR4kuEObq+fbgNQINrP/wSl5FxZ+NXLbQgF9U8kYpVqeiBPPL2/tL0x7BOeWD
kjZT8urNRx0LKmy9rYXIE5YGQ1L7UG8UwuxtsnMdkAFz8bajrw1rJIt2oWSsi1VF
5RtTUGW0ZCP1S3F1vmWt+cGkAjVQmcbq9tSB/bBXFMQTY78SyRHAAPg/6iyHXcQh
LzhgW9uf/4/TO+DwymvIxLuPpqvhHLqPPJkpPgkIrWIWpvCHf5A8whGP3MvmAar5
2TNuuftYte6sJfnUlSGauZv8YEUaJto8bYudXrLRevQEmIlilN3eD7WT5QFR6dQq
FyR+wr7Z7IYHVJXFYukgOgdPboApfox1q+P4ITe7M/2CVjxOZfA38Q1Pt45VG90x
o04uozh/HbXpevbSnkZo
=px6+
-----END PGP SIGNATURE-----

--r3RYAYa9cXQlbOHD--
