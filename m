From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm: don't link DP aux i2c adapter to the hardware
 device node
Date: Mon, 5 Feb 2018 17:11:30 +0100
Message-ID: <20180205161130.GA3493@ulmo>
References: <20170113173630.22138-1-l.stach@pengutronix.de>
 <20170123163347.GC2043@ulmo.ba.sec>
 <CAL_JsqKKywq3NdJO60SPWoE7+mR6CPwN3Dx62z6pyQYuEv4kSA@mail.gmail.com>
 <1491382352.2904.9.camel@pengutronix.de>
 <20170405120431.GA9162@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1775455586=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170405120431.GA9162@ulmo.ba.sec>
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


--===============1775455586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:04:31PM +0200, Thierry Reding wrote:
> On Wed, Apr 05, 2017 at 10:52:32AM +0200, Lucas Stach wrote:
> > Hi Rob,
> >=20
> > Am Mittwoch, den 29.03.2017, 08:56 -0500 schrieb Rob Herring:
> > > On Mon, Jan 23, 2017 at 10:33 AM, Thierry Reding
> > > <thierry.reding@gmail.com> wrote:
> > > > On Fri, Jan 13, 2017 at 06:36:30PM +0100, Lucas Stach wrote:
> > > >> The i2c adapter on DP AUX is purely a software construct. Linking
> > > >> it to the device node of the parent device is wrong, as it leads to
> > > >> 2 devices sharing the same device node, which is bad practice, as
> > > >
> > > > Who says that two devices can't share the same device node? It's do=
ne
> > > > all the time.
> > >=20
> > > It's done *some of the time* and I would not consider it best practic=
e.
> > >=20
> > > >> well as the i2c trying to populate children of the i2c adapter by
> > > >> looking at the child device nodes of the parent device.
> > > >
> > > > A set of patches landed in v4.9 to work around this issue in a bett=
er
> > > > way. See:
> > > >
> > > >         98b00488459e dt-bindings: i2c: Add support for 'i2c-bus' su=
bnode
> > > >         7e4c224abfe8 i2c: core: Add support for 'i2c-bus' subnode
> > >=20
> > > What does this buy us? I don't see why this needs to be in DT either.
> > > Contrary to popular belief, DT is not the only way to instantiate
> > > devices, C code can still do it.
> > >=20
> > > Also, if this one line removal has no side effects, then how was it
> > > even needed? We can always add it back if there's some argument for
> > > why it is needed.
> >=20
> > Okay, so I take this as you mostly agreeing with the rationale of this
> > patch.
>=20
> For some general background on this: I was originally using this for DP
> support on Tegra (though that ended up never getting merged because of a
> particularily frustrating episode of trying to get better link training
> support into the core helpers) and use it as a means to obtain the I2C
> controller used for DDC. On Tegra, and I suspect other devices as well,
> the DP AUX controller is separate from the encoder, so the idea was to
> link them together using a standard ddc-i2c-bus phandle.
>=20
> I ended up not needing that because the encoder and DP AUX controller
> are so tightly linked on Tegra that I need direct access to the DP AUX
> anyway and can therefore directly get the I2C controller from that.
>=20
> If there aren't any other users of this, I suppose we could simply
> remove the line. Should someone turn up in the future and require the
> I2C controller to be looked up from a phandle we could add it again,
> at which point we'd have to investigate again how to get rid of the
> errors.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

I'm going to have to retract that: I just noticed that this patch breaks
eDP for Venice2 (and presumably all Tegra124 Nyan boards as well, though
I don't have those to test with).

My description above isn't quite correct. For eDP device we do use the
ddc-i2c-bus property in DT to denote which I2C bus to use for probing
the EDID. So the reason why eDP now breaks is because the simple-panel
driver will look for the I2C adapter, not find a matching one and defer
probe (indefinitely).

A, perhaps nicer, alternative I found to make it work is the below
patch. Would that be more reasonable? Looping in Wolfram.

Thierry
--- >8 ---
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 8d474bb1dc15..f88527a61cd1 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -118,6 +118,14 @@ static int of_dev_node_match(struct device *dev, void =
*data)
 	return dev->of_node =3D=3D data;
 }
=20
+static int of_parent_node_match(struct device *dev, void *data)
+{
+	if (dev->parent)
+		return dev->parent->of_node =3D=3D data;
+
+	return 0;
+}
+
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
@@ -143,6 +151,9 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct =
device_node *node)
 	struct i2c_adapter *adapter;
=20
 	dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	if (!dev)
+		dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_parent_node_match);
+
 	if (!dev)
 		return NULL;
=20

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlp4gi8ACgkQ3SOs138+
s6Fi5w/9FxyDy0HBIIipOTT0t3aAzUJFs8W9ABPU7D2aPKeX793Q6xkt2lGOQcCL
PS5h0NolxrBdh6XcPsynSLi151yJ6RGskJg/tYnXw+fG6nVJacrld3hrolcvbfMt
X7cTugnNwKkoLku/qB+51XpfH06IZCY1YSrOspKyesdZopfV1acYztphIxlxagnT
UQts/3aKyRO/0KeRrkM+RpNmMnbiz5X7eQPwDSDtX/hBDFzigFyXei8wARPQh/pX
1faBgi4Y+TX60Epyi8bX5bedJGkihkXe6fw+JAU/S8xhUVpRFmCpmFiYLZxMHdid
8t76IcClrV6/YVHtRC87uXxnTUwIIzwVCDXryUKNpWUMh1232PH9Q5Nuoq9hnYxa
bJBxu7+R5ov04S7eC/vXESsd+UeL+JTSSSx62i2r7D6Hr5gWzMF1xTbPRhsTfxcK
p/jzVnxESv5GkZJC5BzH6mzSp0MU/S0j60fbmLYOHb8rD5yNqx9gYn0fuj/b/isd
o0FWdZQAMOCfKYHbPA+HZObxb6dZjtGJVb5nS0ruj1ce4z5xwUJxRLp5R2XEw4oq
EdAO/jQS2062DlsMQnxs2olZ8Ps8C6ZXO0Spn4AIpo75QmytXSZUjyzHjIUKEqIr
cyZsWaLIxSWo/D7yN5Xbo9DlOrmSrX1LlrWqzVCt/Q8gfi+evoE=
=Uuz2
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--===============1775455586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1775455586==--
