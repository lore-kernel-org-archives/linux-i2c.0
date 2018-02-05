From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm: don't link DP aux i2c adapter to the hardware
 device node
Date: Mon, 5 Feb 2018 18:11:03 +0100
Message-ID: <20180205171103.GB3493@ulmo>
References: <20170113173630.22138-1-l.stach@pengutronix.de>
 <20170123163347.GC2043@ulmo.ba.sec>
 <CAL_JsqKKywq3NdJO60SPWoE7+mR6CPwN3Dx62z6pyQYuEv4kSA@mail.gmail.com>
 <1491382352.2904.9.camel@pengutronix.de>
 <20170405120431.GA9162@ulmo.ba.sec> <20180205161130.GA3493@ulmo>
 <1517848149.3175.15.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0265380749=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1517848149.3175.15.camel@pengutronix.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, dri-devel <dri-devel@lists.freedesktop.org>, patchwork-lst@pengutronix.de, linux-i2c@vger.kernel.org, "kernel@pengutronix.de" <kernel@pengutronix.de>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-i2c@vger.kernel.org


--===============0265380749==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 05:29:09PM +0100, Lucas Stach wrote:
> Am Montag, den 05.02.2018, 17:11 +0100 schrieb Thierry Reding:
> > On Wed, Apr 05, 2017 at 02:04:31PM +0200, Thierry Reding wrote:
> > > On Wed, Apr 05, 2017 at 10:52:32AM +0200, Lucas Stach wrote:
> > > > Hi Rob,
> > > >=20
> > > > Am Mittwoch, den 29.03.2017, 08:56 -0500 schrieb Rob Herring:
> > > > > On Mon, Jan 23, 2017 at 10:33 AM, Thierry Reding
> > > > > > > > > <thierry.reding@gmail.com> wrote:
> > > > > > On Fri, Jan 13, 2017 at 06:36:30PM +0100, Lucas Stach wrote:
> > > > > > > The i2c adapter on DP AUX is purely a software construct. Lin=
king
> > > > > > > it to the device node of the parent device is wrong, as it le=
ads to
> > > > > > > 2 devices sharing the same device node, which is bad practice=
, as
> > > > > >=20
> > > > > > Who says that two devices can't share the same device node? It'=
s done
> > > > > > all the time.
> > > > >=20
> > > > > It's done *some of the time* and I would not consider it best pra=
ctice.
> > > > >=20
> > > > > > > well as the i2c trying to populate children of the i2c adapte=
r by
> > > > > > > looking at the child device nodes of the parent device.
> > > > > >=20
> > > > > > A set of patches landed in v4.9 to work around this issue in a =
better
> > > > > > way. See:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A098b00488459e dt=
-bindings: i2c: Add support for 'i2c-bus' subnode
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A07e4c224abfe8 i2=
c: core: Add support for 'i2c-bus' subnode
> > > > >=20
> > > > > What does this buy us? I don't see why this needs to be in DT eit=
her.
> > > > > Contrary to popular belief, DT is not the only way to instantiate
> > > > > devices, C code can still do it.
> > > > >=20
> > > > > Also, if this one line removal has no side effects, then how was =
it
> > > > > even needed? We can always add it back if there's some argument f=
or
> > > > > why it is needed.
> > > >=20
> > > > Okay, so I take this as you mostly agreeing with the rationale of t=
his
> > > > patch.
> > >=20
> > > For some general background on this: I was originally using this for =
DP
> > > support on Tegra (though that ended up never getting merged because o=
f a
> > > particularily frustrating episode of trying to get better link traini=
ng
> > > support into the core helpers) and use it as a means to obtain the I2C
> > > controller used for DDC. On Tegra, and I suspect other devices as wel=
l,
> > > the DP AUX controller is separate from the encoder, so the idea was to
> > > link them together using a standard ddc-i2c-bus phandle.
> > >=20
> > > I ended up not needing that because the encoder and DP AUX controller
> > > are so tightly linked on Tegra that I need direct access to the DP AUX
> > > anyway and can therefore directly get the I2C controller from that.
> > >=20
> > > If there aren't any other users of this, I suppose we could simply
> > > remove the line. Should someone turn up in the future and require the
> > > I2C controller to be looked up from a phandle we could add it again,
> > > at which point we'd have to investigate again how to get rid of the
> > > errors.
> > >=20
> > > Acked-by: Thierry Reding <treding@nvidia.com>
> >=20
> > I'm going to have to retract that: I just noticed that this patch breaks
> > eDP for Venice2 (and presumably all Tegra124 Nyan boards as well, though
> > I don't have those to test with).
> >=20
> > My description above isn't quite correct. For eDP device we do use the
> > ddc-i2c-bus property in DT to denote which I2C bus to use for probing
> > the EDID. So the reason why eDP now breaks is because the simple-panel
> > driver will look for the I2C adapter, not find a matching one and defer
> > probe (indefinitely).
> >=20
> > A, perhaps nicer, alternative I found to make it work is the below
> > patch. Would that be more reasonable? Looping in Wolfram.
>=20
> Taking a step back from the immediate breakage: why do you need the
> ddc-i2c-bus phandle on the eDP panel at all? I would consider this DT
> buggy, as it tries to point to something which is purely a software
> construct. It's not like you are likely to use any other i2c adapter to
> get the eDP panel EDID than the eDP AUX adapter.
>=20
> I know this is trading different levels of breakage, but without this
> patch I'm forced to describe a (not actually existent) i2c-bus in DT on
> eDP bridges, to shut down the warnings from the i2c core when it tries
> to populate child devices of the bridge that aren't i2c devices.

So the reason why we have the ddc-i2c-bus property is because the panel
is a free-standing device tree node and therefore doesn't have any
knowledge of AUX. I guess one could argue that this is itself a problem
and I'd agree with that. But things are what they are, and we have this
device tree that used to work but this patch renders these devices more
or less useless (they don't really come with a debug UART or anything,
so display is the only thing that you can use to diagnose issues).

Perhaps the solution is that we need to make eDP panels children of the
AUX adapter that "controls" them, much like we do for DSI panels. If no
device tree maintainers has a problem with that I'm willing to break
ABI here because these boards don't have the DTB in a ROM and therefore
users can (and likely will anyway) update the DTB along with the kernel.
But I think we'd have to either find a solution to this really quickly
or revert this patch and give it another try when we do have a proper
solution.

I can somewhat agree with your assessment that the AUX-I2C adapter does
not have a place in DT. However, there could technically be any number
of devices behind that I2C bus (though practically there will likely
only ever be an EDID and maybe something like DDC/CI, SCDC or HDCP, all
of which can easily be probed in a display driver).

Still, even if we all agree that we shouldn't represent this particular
bus in device tree, we still need a replacement mechanism to allow eDP
panels to get at the AUX (and I2C-over-AUX) adapters that control them.
A parent/child relationship seems like the most straightforward approach
because we'd know exactly what struct device * to get the I2C adapter
=66rom and we could even get a hold of the AUX adapter if we want to do
something to the panel's DPCD directly.

Rob, anyone: any ideas on how to fix this? What would be the correct way
to do this in DT?

Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlp4kCUACgkQ3SOs138+
s6Gt6g//QiODv4iMTYsKh9QHA2TLhCjaRpjJLrhXpqUFrLrJIy7A0p27Jikbbkkx
nV4wJGhyAYXD/l98unhtw/PdeRZ4rSnCNSbgSDdCHz26Ucls0OWYqqli8XC91b8y
y8yoF3RwogM5WZQGAwnJ53utJIPFeysaslX5P6crxLmgKV7S1UFHLdzoycI19bHB
jF/qRm5hhDX9soSGmfaZH87nB3An7mvMmItEus+jBRynyVAHQ/iedVdF7AxlIqlH
hVtPVTAvWQ4ZkSMvvodEAQq9y6eDF4xQEnwAF8XLbmeGYrGgjUyQIQdRYvVyzOsp
Az5OQb8bysObIDvTE0JfZqHeLLS4imQovQAppnhj9Y4joMCWBYfx7AV2kziT9rFo
qxmAuBju1Dqjx2Jj5aiB9jjvf3UdO8r7ml/HcdYmCdKhEeYa+5dE+G0yPB1qQQ51
27fsGnbokFxh10gBv4DiEIR3xCzcslSVrJ0dkmy/ynGnC8Ci7MwlA7EKjN97CxjK
aN5BmQD7oRGvesTmJaIM90Le4Kr3PDkwB40v/zq+q8RabkHLoSkQ2lZPyI7DY9Eq
/oKdVUUk8yOIg2jwhiDDlD8EC+syMNJTQWqOD/FDCdNYeizmKMxIoiivYWzMwCjM
9ibsK1ncWLfApaMx+05CTu1QoSYwHO/Zpc//HIf5ucCqsWqnWEg=
=nJVx
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============0265380749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0265380749==--
