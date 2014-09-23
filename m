From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Tue, 23 Sep 2014 21:00:57 +0200
Message-ID: <20140923190057.GN15315@lukather>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
 <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411497626-7984-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Sep 23, 2014 at 11:40:26AM -0700, David E. Box wrote:
> This patch implements an I2C bus sharing mechanism between the host and p=
latform
> hardware on select Intel BayTrail SoC platforms using the X-Powers AXP288=
 PMIC.
>=20
> On these platforms access to the PMIC must be shared with platform hardwa=
re. The
> hardware unit assumes full control of the I2C bus and the host must reque=
st
> access through a special semaphore. Hardware control of the bus also make=
s it
> necessary to disable runtime pm to avoid interfering with hardware transa=
ctions.
>=20
> Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Sorry for stepping in like this without really knowing your platform,
but wouldn't using the hwspinlock framework make more sense than
hardcoding your own internal functions here?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIcNpAAoJEBx+YmzsjxAgmswP/37hLAseGbTf5X4Q6vIh2CmL
KxVdN52qzQ0uLGvR+DjMmT1kf1vObh+tpRWlmZ7bCr2IalimE1Miy27z0I+scr9z
+JF4N0q1hXClABPdmu98ddO9WwLXgxWSKRE/I1oW9YK8DpaiMZ0TCnUrArUZ4RlG
L1for5ITmDAXzvcEhp/4i0fz9amR6J6zwhQUkLrOLY8lJWTr3DCPyR8vhmkmO2oo
x9RVAJS7A2cPrEMXxIi3PSznXMEsqGz0PY4cizFyz07yvwcJWrB2PuoY/Mnmp/vo
SX3pWbWwRN7cK/tGubG1O7INPTg9FBMsrjJzdRyYZGxs+Gi99L32/baG5zgkwvrJ
xt+glQQrx2R6zL9VHi8EX7o7p09tPzKSLBDB5UdGv17FnIZtGOOUAZxkpOhr+OtP
OPoWrN4YDM5ayJmt0gdnFf/A0dRIvTlIU4jlxk7jVJzNZRDEV77/E/k7mIJITwvU
OHZDkMsJAXByvIAnlZvXnNtRq7m3uohHLsWBeaNnz3ScdaJu4xY0w1gWJwokSlDe
3qBMMgDFIIqLgbtRpPhNw1v1mRncAzITPqd6KoEF8lrOdzoL2n75eWBeJeI7DOm9
b0RzI266Yw1d5WNGDG67UFRvULLJLwnntVsV3Xcd7SlT91yzQZrh75YBBr72AAEx
Gbo3jDcOReBMDYyzgxAQ
=qdoH
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--
