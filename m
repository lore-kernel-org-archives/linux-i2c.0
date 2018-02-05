From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm: don't link DP aux i2c adapter to the hardware
 device node
Date: Mon, 5 Feb 2018 19:07:17 +0100
Message-ID: <20180205180717.GB8237@ulmo>
References: <20170113173630.22138-1-l.stach@pengutronix.de>
 <20170123163347.GC2043@ulmo.ba.sec>
 <CAL_JsqKKywq3NdJO60SPWoE7+mR6CPwN3Dx62z6pyQYuEv4kSA@mail.gmail.com>
 <1491382352.2904.9.camel@pengutronix.de>
 <20170405120431.GA9162@ulmo.ba.sec> <20180205161130.GA3493@ulmo>
 <20180205173352.GA7159@ulmo>
 <1517852345.3175.17.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1987907334=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1517852345.3175.17.camel@pengutronix.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, dri-devel <dri-devel@lists.freedesktop.org>, patchwork-lst@pengutronix.de, linux-i2c@vger.kernel.org, "kernel@pengutronix.de" <kernel@pengutronix.de>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-i2c@vger.kernel.org


--===============1987907334==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 06:39:05PM +0100, Lucas Stach wrote:
> Am Montag, den 05.02.2018, 18:33 +0100 schrieb Thierry Reding:
> > On Mon, Feb 05, 2018 at 05:11:30PM +0100, Thierry Reding wrote:
> > > On Wed, Apr 05, 2017 at 02:04:31PM +0200, Thierry Reding wrote:
> > > > On Wed, Apr 05, 2017 at 10:52:32AM +0200, Lucas Stach wrote:
> > > > > Hi Rob,
> > > > >=20
> > > > > Am Mittwoch, den 29.03.2017, 08:56 -0500 schrieb Rob Herring:
> > > > > > On Mon, Jan 23, 2017 at 10:33 AM, Thierry Reding
> > > > > > > > > > > <thierry.reding@gmail.com> wrote:
> > > > > > > On Fri, Jan 13, 2017 at 06:36:30PM +0100, Lucas Stach wrote:
> > > > > > > > The i2c adapter on DP AUX is purely a software construct. L=
inking
> > > > > > > > it to the device node of the parent device is wrong, as it =
leads to
> > > > > > > > 2 devices sharing the same device node, which is bad practi=
ce, as
> > > > > > >=20
> > > > > > > Who says that two devices can't share the same device node? I=
t's done
> > > > > > > all the time.
> > > > > >=20
> > > > > > It's done *some of the time* and I would not consider it best p=
ractice.
> > > > > >=20
> > > > > > > > well as the i2c trying to populate children of the i2c adap=
ter by
> > > > > > > > looking at the child device nodes of the parent device.
> > > > > > >=20
> > > > > > > A set of patches landed in v4.9 to work around this issue in =
a better
> > > > > > > way. See:
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A098b00488459e =
dt-bindings: i2c: Add support for 'i2c-bus' subnode
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A07e4c224abfe8 =
i2c: core: Add support for 'i2c-bus' subnode
> > > > > >=20
> > > > > > What does this buy us? I don't see why this needs to be in DT e=
ither.
> > > > > > Contrary to popular belief, DT is not the only way to instantia=
te
> > > > > > devices, C code can still do it.
> > > > > >=20
> > > > > > Also, if this one line removal has no side effects, then how wa=
s it
> > > > > > even needed? We can always add it back if there's some argument=
 for
> > > > > > why it is needed.
> > > > >=20
> > > > > Okay, so I take this as you mostly agreeing with the rationale of=
 this
> > > > > patch.
> > > >=20
> > > > For some general background on this: I was originally using this fo=
r DP
> > > > support on Tegra (though that ended up never getting merged because=
 of a
> > > > particularily frustrating episode of trying to get better link trai=
ning
> > > > support into the core helpers) and use it as a means to obtain the =
I2C
> > > > controller used for DDC. On Tegra, and I suspect other devices as w=
ell,
> > > > the DP AUX controller is separate from the encoder, so the idea was=
 to
> > > > link them together using a standard ddc-i2c-bus phandle.
> > > >=20
> > > > I ended up not needing that because the encoder and DP AUX controll=
er
> > > > are so tightly linked on Tegra that I need direct access to the DP =
AUX
> > > > anyway and can therefore directly get the I2C controller from that.
> > > >=20
> > > > If there aren't any other users of this, I suppose we could simply
> > > > remove the line. Should someone turn up in the future and require t=
he
> > > > I2C controller to be looked up from a phandle we could add it again,
> > > > at which point we'd have to investigate again how to get rid of the
> > > > errors.
> > > >=20
> > > > Acked-by: Thierry Reding <treding@nvidia.com>
> > >=20
> > > I'm going to have to retract that: I just noticed that this patch bre=
aks
> > > eDP for Venice2 (and presumably all Tegra124 Nyan boards as well, tho=
ugh
> > > I don't have those to test with).
> > >=20
> > > My description above isn't quite correct. For eDP device we do use the
> > > ddc-i2c-bus property in DT to denote which I2C bus to use for probing
> > > the EDID. So the reason why eDP now breaks is because the simple-panel
> > > driver will look for the I2C adapter, not find a matching one and def=
er
> > > probe (indefinitely).
> > >=20
> > > A, perhaps nicer, alternative I found to make it work is the below
> > > patch. Would that be more reasonable? Looping in Wolfram.
> > >=20
> > > Thierry
> > > --- >8 ---
> > > diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> > > index 8d474bb1dc15..f88527a61cd1 100644
> > > --- a/drivers/i2c/i2c-core-of.c
> > > +++ b/drivers/i2c/i2c-core-of.c
> > > @@ -118,6 +118,14 @@ static int of_dev_node_match(struct device *dev,=
 void *data)
> > > > > =C2=A0	return dev->of_node =3D=3D data;
> > > =C2=A0}
> > > =C2=A0
> > > +static int of_parent_node_match(struct device *dev, void *data)
> > > +{
> > > > > +	if (dev->parent)
> > > > > +		return dev->parent->of_node =3D=3D data;
> > > +
> > > > > +	return 0;
> > > +}
> > > +
> > > =C2=A0/* must call put_device() when done with returned i2c_client de=
vice */
> > > =C2=A0struct i2c_client *of_find_i2c_device_by_node(struct device_nod=
e *node)
> > > =C2=A0{
> > > @@ -143,6 +151,9 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(s=
truct device_node *node)
> > > > > =C2=A0	struct i2c_adapter *adapter;
> > > =C2=A0
> > > > > =C2=A0	dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_dev_=
node_match);
> > > > > +	if (!dev)
> > > > > +		dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_parent_n=
ode_match);
> > > +
> > > > > =C2=A0	if (!dev)
> > > > > =C2=A0		return NULL;
> > > =C2=A0
> >=20
> > I'd like to point out that a lot of I2C bus drivers actually do the same
> > thing as the DRM AUX helpers used to do:
> >=20
> > 	$ git grep -n 'dev.of_node.*=3D' -- drivers/i2c/busses/
> > > 	drivers/i2c/busses/i2c-altera.c:467:	idev->adapter.dev.of_node =3D p=
dev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-aspeed.c:882:	bus->adap.dev.of_node =3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-at91.c:1120:	dev->adapter.dev.of_node =3D pde=
v->dev.of_node;
> > > 	drivers/i2c/busses/i2c-axxia.c:561:	idev->adapter.dev.of_node =3D pd=
ev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-bcm-iproc.c:489:	adap->dev.of_node =3D pdev->=
dev.of_node;
> > > 	drivers/i2c/busses/i2c-bcm-kona.c:858:	adap->dev.of_node =3D pdev->d=
ev.of_node;
> > > 	drivers/i2c/busses/i2c-bcm2835.c:367:	adap->dev.of_node =3D pdev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-brcmstb.c:664:	adap->dev.of_node =3D pdev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-cadence.c:912:	id->adap.dev.of_node =3D pdev-=
>dev.of_node;
> > > > 	drivers/i2c/busses/i2c-cbus-gpio.c:248:	adapter->dev.of_node	=3D p=
dev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-cpm.c:654:	cpm->adap.dev.of_node =3D of_node_=
get(ofdev->dev.of_node);
> > > 	drivers/i2c/busses/i2c-cros-ec-tunnel.c:280:	bus->adap.dev.of_node =
=3D np;
> > > 	drivers/i2c/busses/i2c-davinci.c:864:	adap->dev.of_node =3D pdev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-designware-platdrv.c:351:	adap->dev.of_node =
=3D pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-digicolor.c:337:	i2c->adap.dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-dln2.c:215:	dln2->adapter.dev.of_node =3D dev=
->of_node;
> > > 	drivers/i2c/busses/i2c-efm32.c:332:	ddata->adapter.dev.of_node =3D p=
dev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-eg20t.c:791:		pch_adap->dev.of_node =3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-emev2.c:387:	priv->adap.dev.of_node =3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-exynos5.c:743:	i2c->adap.dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-gpio.c:322:	adap->dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-hix5hd2.c:456:	priv->adap.dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-ibm_iic.c:748:	adap->dev.of_node =3D of_node_=
get(np);
> > > 	drivers/i2c/busses/i2c-img-scb.c:1383:	i2c->adap.dev.of_node =3D nod=
e;
> > > > 	drivers/i2c/busses/i2c-imx-lpi2c.c:583:	lpi2c_imx->adapter.dev.of_=
node	=3D pdev->dev.of_node;
> > > > 	drivers/i2c/busses/i2c-imx.c:1086:	i2c_imx->adapter.dev.of_node	=
=3D pdev->dev.of_node;
> > > > 	drivers/i2c/busses/i2c-jz4780.c:751:	i2c->adap.dev.of_node	=3D pde=
v->dev.of_node;
> > > 	drivers/i2c/busses/i2c-lpc2k.c:432:	i2c->adap.dev.of_node =3D pdev->=
dev.of_node;
> > > 	drivers/i2c/busses/i2c-meson.c:423:	i2c->adap.dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-mpc.c:742:	i2c->adap.dev.of_node =3D of_node_=
get(op->dev.of_node);
> > > 	drivers/i2c/busses/i2c-mt65xx.c:769:	i2c->adap.dev.of_node =3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-mv64xxx.c:935:	drv_data->adapter.dev.of_node =
=3D pd->dev.of_node;
> > > 	drivers/i2c/busses/i2c-mxs.c:867:	adap->dev.of_node =3D pdev->dev.of=
_node;
> > > 	drivers/i2c/busses/i2c-nomadik.c:1033:	adap->dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-ocores.c:493:	i2c->adap.dev.of_node =3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-octeon-platdrv.c:244:	i2c->adap.dev.of_node =
=3D node;
> > > 	drivers/i2c/busses/i2c-omap.c:1457:	adap->dev.of_node =3D pdev->dev.=
of_node;
> > > 	drivers/i2c/busses/i2c-opal.c:236:	adapter->dev.of_node =3D of_node_=
get(pdev->dev.of_node);
> > > 	drivers/i2c/busses/i2c-pca-platform.c:174:	i2c->adap.dev.of_node =3D=
 np;
> > > 	drivers/i2c/busses/i2c-pnx.c:643:	alg_data->adapter.dev.of_node =3D =
of_node_get(pdev->dev.of_node);
> > > 	drivers/i2c/busses/i2c-powermac.c:435:	adapter->dev.of_node =3D NULL;
> > > 	drivers/i2c/busses/i2c-powermac.c:447:	adapter->dev.of_node =3D dev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-pxa-pci.c:80:	pdev->dev.of_node =3D child;
> > > 	drivers/i2c/busses/i2c-pxa.c:1313:	i2c->adap.dev.of_node =3D dev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-qup.c:1608:	qup->adap.dev.of_node =3D pdev->d=
ev.of_node;
> > > 	drivers/i2c/busses/i2c-rcar.c:902:	adap->dev.of_node =3D dev->of_nod=
e;
> > > 	drivers/i2c/busses/i2c-riic.c:440:	adap->dev.of_node =3D pdev->dev.o=
f_node;
> > > 	drivers/i2c/busses/i2c-rk3x.c:1220:	i2c->adap.dev.of_node =3D np;
> > > 	drivers/i2c/busses/i2c-s3c2410.c:1210:	i2c->adap.dev.of_node =3D pde=
v->dev.of_node;
> > > 	drivers/i2c/busses/i2c-sh_mobile.c:942:	adap->dev.of_node =3D dev->d=
ev.of_node;
> > > 	drivers/i2c/busses/i2c-sirf.c:335:	adap->dev.of_node =3D pdev->dev.o=
f_node;
> > > 	drivers/i2c/busses/i2c-sprd.c:516:	i2c_dev->adap.dev.of_node =3D dev=
->of_node;
> > > 	drivers/i2c/busses/i2c-st.c:871:	adap->dev.of_node =3D pdev->dev.of_=
node;
> > > 	drivers/i2c/busses/i2c-stm32f4.c:843:	adap->dev.of_node =3D pdev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-stm32f7.c:918:	adap->dev.of_node =3D pdev->de=
v.of_node;
> > > 	drivers/i2c/busses/i2c-stu300.c:918:	adap->dev.of_node =3D pdev->dev=
=2Eof_node;
> > > 	drivers/i2c/busses/i2c-sun6i-p2wi.c:278:	p2wi->adapter.dev.of_node =
=3D pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-tegra-bpmp.c:311:	i2c->adapter.dev.of_node =
=3D pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-tegra.c:1006:	i2c_dev->adapter.dev.of_node =
=3D pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-thunderx-pcidrv.c:210:	i2c->adap.dev.of_node =
=3D pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-uniphier-f.c:538:	priv->adap.dev.of_node =3D =
dev->of_node;
> > > 	drivers/i2c/busses/i2c-uniphier.c:385:	priv->adap.dev.of_node =3D de=
v->of_node;
> > > 	drivers/i2c/busses/i2c-versatile.c:88:	i2c->adap.dev.of_node =3D dev=
->dev.of_node;
> > > 	drivers/i2c/busses/i2c-wmt.c:424:	adap->dev.of_node =3D pdev->dev.of=
_node;
> > > 	drivers/i2c/busses/i2c-xgene-slimpro.c:564:	adapter->dev.of_node =3D=
 pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-xiic.c:761:	i2c->adap.dev.of_node =3D pdev->d=
ev.of_node;
> > > 	drivers/i2c/busses/i2c-xlp9xx.c:434:	priv->adapter.dev.of_node =3D p=
dev->dev.of_node;
> > > > 	drivers/i2c/busses/i2c-xlr.c:426:	priv->adap.dev.of_node	=3D pdev-=
>dev.of_node;
> > > 	drivers/i2c/busses/i2c-zx2967.c:573:	i2c->adap.dev.of_node =3D pdev-=
>dev.of_node;
> >=20
> > This is very much standard procedure, at least in I2C land. The above
> > patch would allow us to remove all of the above and instead rely on
> > matching on the parent device's ->of_node. The more I think about it,
> > the more I'm convinced that that's actually the correct thing to do.
> > i2c_adapter.dev.of_node should only be used to override the parent's
> > device tree node.
>=20
> I agree. Thinking about it a bit more your proposed patch is actually a
> quite neat solution for the problem at hand and would allow us drop
> this standard, yet bad, practice of i2c adapters sharing the device
> node with their parent.

I'm wondering, though, if my patch wouldn't actually restore the errors
that you were seeing. Looking at of_i2c_register_devices() and
of_i2c_register_device(), you're probably seeing the "of_i2c: invalid
reg on %pOF" errors.

These happen for children of either the i2c-bus subnode or the adapter's
node itself, so it seems like the above patch wouldn't break this.
However, if we remove setting i2c_adapter->dev.of_node from all of the
controller drivers, then we wouldn't see any children get added for any
of them anymore.

The fix for that would of course be to do this:

	-		bus =3D of_node_get(adap->dev.of_node);
	+		bus =3D of_node_get(adap->dev.parent->of_node);

but then we'd be back to square one and you'd start seeing the errors
again for AUX-over-I2C controllers.

Thierry

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlp4nVQACgkQ3SOs138+
s6GBfQ/+L2VGJ2Fh0xOSE+lc2CEvl5MFLxsGBsYaRUTCD7cYJ+oqNL0sdeTIq2nu
2f2jkKjknJBmvtVxqgw5ulSK2Apy9Qa2iw/cNEUAD+EFbxt7ZzZL2d5zOLCKut39
CyW2seo0bx/VIJVFzJkC62SxlYTY1IDOkU2AhXPo7ZwwU2wZt6kJD8bj2jJ4KPpA
NRxedPQvLBfUhuKvJ/wkil3CCWRYuE/p1ZbnCPk45b8mAhUmvbwrUbMJXgmhbzDW
g6hiONLXLOeb19JbTmjaQgz0Yet0i+Q82KrZW8kmBaJAArH0Z8FqKK5+FoK7lfw5
H88qzUNw3Lpe3VsbX9M3noQyv9SLHa+6aoc7d/CUWImjyJoAYFwByF9hXDLJXITc
bESVX84uvB6krecypntbZbpCcvM+RtXDRsxtOm5nhc6DVTHq9atJVEXYrbKilXFC
kg1nrojDu8Tc8PTbZgJKCSCrsHGjigpt7cnNRpyaBZHt7tK+mpqyilVgCbTRU1ZI
L1wF+fVL7b3EDaAxL+Snmxf6TxqNseXC4LNgJ2yzqZ+6Yuy8pbluqkX2bbyih/WZ
AHvQgtPgVT2ieGsAdNLyQ9S97ltM4dAmWWQEAw81g5pQITMl+VIGLQkz7ZdIKDQx
SoCHz1ISgmGu+folkS1D4xfq/7WE7hRVgXOTHiQ0vzDTbcSZU78=
=ghP/
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============1987907334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1987907334==--
