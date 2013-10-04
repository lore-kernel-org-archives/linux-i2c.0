From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3 V3] i2c: mxs: Rework the PIO mode operation
Date: Fri, 4 Oct 2013 07:20:52 +0200
Message-ID: <20131004052052.GA3194@katana>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
 <1380497035-7457-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380497035-7457-2-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 01:23:54AM +0200, Marek Vasut wrote:
> Analyze and rework the PIO mode operation. The PIO mode operation
> was unreliable on MX28, by analyzing the bus with LA, the checks
> for when data were available or were to be sent were wrong.
>=20
> The PIO WRITE has to be completely reworked as it multiple problems.
> The MX23 datasheet helped here, see comments in the code for details.
> The problems boil down to:
> - RUN bit in CTRL0 must be set after DATA register was written
> - The PIO transfer must be 4 bytes long tops, otherwise use
>   clock stretching.
> Both of these fixes are implemented.
>=20
> The PIO READ operation can only be done for up to four bytes as
> we are unable to read out the data from the DATA register fast
> enough.
>=20
> This patch also tries to document the investigation within the
> code.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Please fix the checkpatch errors and build warning.


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTlA0AAoJEBQN5MwUoCm2k0oP/AmVjJ0Uk2rAkGd/s5smyEu8
G1eoXg0La9IvRQeqxYVtzo7ncKx5StA6MZm2s3nSbJzN8KhuloL8YhCj4F1QUYYs
R3mZksRxdbb/HHmh2sb25H0hj5iAgX1RpLaNfdrGR2XnMtLVMYB4nktS5MAXvKfJ
Qd3c1T6N5td+hZ00z+zS07PFUql/h/avkD008tOwTuc0vCiN5Mx/h5p9gtYUTDqS
MYgdMc8AqwtZmP0FcAW/AioRtAQTAJRl01gNXxAptDSET4UJ/LZF0tqkMkKxsvik
P0CoR0jlOxQPcMg0yXCS6t1ENK13okOSgjqqtvvSLMTE3TkcxAmdU1t/cpYIi3Uk
9XrpgrJDspAmQYKIlPd09NcrUdqhbDp8xQraXd3MueUlhtwf6p2u7Nnnupa8PnMe
ZypD9bIwhOKrvodX/cvmHEyjYrfKqkny9Z8iDTehdHOzc6ElQ3/3kbG8j85CidhF
fS66qSgfJfWpuPD77owZE1pUDmq67uoddgEZ/y8jhwh8m1yR9AULmlmDHos6ZPya
v+H/I3g7lxm9Km74KJ3hr9KlcfLdb3/9YJuL1+NruAdYZ10s1KfKQsp46MoZpU7g
gL6+GUQv0zFWXwOqrWaxBURLEsAwyiUaRwJFfL+gH7pQ7uWcBSL6xV6t6dlMiuGv
oI4Ul6+yEJX+M3M2nS5e
=IqXu
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
