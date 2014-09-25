From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Thu, 25 Sep 2014 11:47:52 +0200
Message-ID: <20140925094752.GY15315@lukather>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
 <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
 <20140923190057.GN15315@lukather>
 <20140923195854.GA9921@pathfinder>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140923195854.GA9921@pathfinder>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Sep 23, 2014 at 12:58:54PM -0700, David E. Box wrote:
> Hi Maxime,
>=20
> On Tue, Sep 23, 2014 at 09:00:57PM +0200, Maxime Ripard wrote:
> > Hi David,
> >=20
> > On Tue, Sep 23, 2014 at 11:40:26AM -0700, David E. Box wrote:
> > > This patch implements an I2C bus sharing mechanism between the host a=
nd platform
> > > hardware on select Intel BayTrail SoC platforms using the X-Powers AX=
P288 PMIC.
> > >=20
> > > On these platforms access to the PMIC must be shared with platform ha=
rdware. The
> > > hardware unit assumes full control of the I2C bus and the host must r=
equest
> > > access through a special semaphore. Hardware control of the bus also =
makes it
> > > necessary to disable runtime pm to avoid interfering with hardware tr=
ansactions.
> > >=20
> > > Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >=20
> > Sorry for stepping in like this without really knowing your platform,
> > but wouldn't using the hwspinlock framework make more sense than
> > hardcoding your own internal functions here?
>=20
> I looked into this but didn't see a clear way on our platform to identify=
 the
> semaphore seperately from doing it in the designware platform driver. The=
 way
> we can find it now is through evaluating an ACPI _SEM object on every i2c=
 device
> that gets probed by the dw driver since at probe time we can get the acpi=
 handle.

And you have no way to turn it around and identify which semaphore is
associated to which i2c bus?

If so, there is probably some way to associate a given instance of the
i2c driver to one semaphore.

> Without this handle however there isn't a clear way of evaluating the _SEM
> object which would be needed to register a hwspinlock in separate code.
>=20
> Plus it would still require changes to the designware i2c core, though ad=
mittedly
> having a generic hwspinlock pointer added to the struct is cleaner.

Not only cleaner, but that could also be used by other platforms that
are using this I2C driver (and since it's a designware IP, there must
be quite a lot) together with hardware locking.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUI+TIAAoJEBx+YmzsjxAgQ10P/jdaLqFWaiyjWvAKuGmCMa4R
jrDOkSkE0k59jstPa9zO8KHysPQferECVgJrdj2/gDs1rxzGmgy9wEY1IGFjX18d
C/CxHLZcoX7WcFg6tjbPKlEDKfjslsomYJIBh6mqJtFo/JN4+V+Q6aqZT284JQ0U
Ech0QIv88u2jWseOsuiTePaQGUDOP7tvhFY8wcl7tC0OnVtIIt9MkQ8sQIxzp2sJ
3SSedYugAqicmfRQPAdQ8zpWYscyZdy+wg64s7TxJImhAfcr/GVwH81G5YR3mk74
gUOeKduZ+FxYtT15NgMghC9HnEruEVV/Cwx+jlH/FzCneOTEeN/4jQbErvZmz44j
2RiMgop5zMxpWxs4gKXUirsX7SUSncVJJPVnn6cPIOz2+MoXHeUjuZfqbir95/2Q
fQlB6As+H4f9h03oj7DZnV/zHfMrWFPIaSHuvSjkRIpd7/8hTyMwqkCDAh7ysWtm
CMhzwbwXCZ6ipdbXilv3LdeJceypwyKJvJLce6ZosPC5GX7HXjuSukpKM6dj5u3U
+9fu8OPgQ1h3ID2vbKf4jDRBdd2R6tZMtknCQ+5RofE2MgFQKdVFfatmKXSkimhO
DS+0MRXqiDs74oJQAGcq4KLqDmjf0T1MdtWd/gBFlp+VFS2BRpALKGxEvkn2zITO
psBlX5jx4f6RQ8FY+2bW
=rFUM
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--
