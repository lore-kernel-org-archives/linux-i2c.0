From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Thu, 19 Mar 2015 11:09:44 +0100
Message-ID: <20150319100944.GA914@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana>
 <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550A05E5.3050100-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>Possible. But this change just makes i2c-mux-pinctrl honor status
> >>property at all. There is no functional change except it now allows
> >>you to disable any of the sub-busses.
> >
> >Actually, this is the feature I like. However, I wonder if we shouldn't
> >have that in the core, say in of_i2c_register_devices()?
>=20
> Hmm, looking at of_i2c_register_devices():
>=20
> 	for_each_available_child_of_node(adap->dev.of_node, node)
> 		of_i2c_register_device(adap, node);
>=20
> already honors status properties by using for_each_available_foo.
> Therefore, i2c-core will also skip i2c device nodes disabled by
> status property.

Yes, but only child nodes, not the complete bus. Here is an RFC of what
I mean:

=46rom: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [RFC] i2c: of: always check if busses are enabled

Allow all busses to have a "status" property which allows busses to not
be probed when set to "disabled". Needed for DTS overlays with i2c mux
scenarios.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fe80f85896e267..d9a3ad2149332e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1305,8 +1305,8 @@ static void of_i2c_register_devices(struct i2c_adapte=
r *adap)
 {
 	struct device_node *node;
=20
-	/* Only register child devices if the adapter has a node pointer set */
-	if (!adap->dev.of_node)
+	/* Only register childs if adapter has a node pointer with enabled status=
 */
+	if (!adap->dev.of_node || !of_device_is_available(adap->dev.of_node))
 		return;
=20
 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");

> I am not too deep into i2c-core, but AFAIKS i2c-mux-pinctrl is not an
> i2c device but an i2c mux that is dealt with differently? It is not
> probed with of_i2c_register_devices() but as a separate platform_device
> with a reference to the parent i2c bus.

Yes, but the busses have seperate nodes. Those nodes with the 'reg =3D
<0>' properties. And those are matched with of_i2c_register_devices when
the reg-property and the chan_id match.

> About the memory allocation for the maximum potential number of muxes:
> We would need some way to distinguish disabled from enabled muxes in
> i2c-mux-pinctrl's platform_data.

Do we? Can't we claim that every described bus needs a pinctrl entry.
Still, the disabled busses won't be probed? So, we could also think
about putting the above code snippet into i2c-mux when registering
busses, so not only the childs will be skipped but also the whole
bus will not be created.

> i2c_mux_pinctrl_probe() is basically DT-agnostic and it should
> definitely stay that way. Currently, each mux within pd->bus_count

I agree.

> requires a non-NULL pd->pinctrl_states[i] otherwise _probe() will bail
> out for all sub-busses.

And I think that makes sense.

> (b) allow (and skip) muxes with pinctrl_states[i] =3D=3D NULL for now and
> let the "maniac" deal with storing/re-probing the corresponding
> pinctrl_state name once it gets dynamically enabled.

Why do you need the NULL?

> I am still not too eager working on it but if you insist, I can see
> what I can do as long as Stephen sticks with testing it on Tegra. ;)

Please decide if you want to work on it. Remember, I am not short of
patches to deal with.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCqBoAAoJEBQN5MwUoCm2q24P/RpwL9xg+8jf6tqvIoLieO3C
rNSGMVa75pRpq4rkGMpxLjaejjfXN3C1lJc6KmdWy7KrI6h7v91xYkSTIQDzYtxt
BVNru1omxnSgUUGZ5ph6jJcBxUYS6SWWPVJke82m6m6IJhq/5aPnExfISlXPLnIl
hIe89UQw2bpAai3F51D27TIvzSv4DEvM7IfU3wGLxnOZeHxkcpH9UgjVMrELQLK0
tv5gQLdpK1XmKqi4UvEvW9wxXi56tArkWuV0MGOLhtltpf63jdXf62rASF+xAucX
lJV4C0fpH6wbCAWfc9/BxWeh7puIOrGaFf19o0/jfN91plg/NV2XcqxF+wzUT303
I9bTy5w0ptnhV5Gmy33AqWcg00S7XtOT992MvjX7b5XWFpWjsjkETeoA5aw8zmiO
J3eRx6pYyjkmPAjNobz3xF+xlJbda7dLfUonp8F2qoqQStnV1KaJQlgARd1QvS83
2O94f7o78ozjDxq2TbQcJ3Sd9//hISuI04Vn5ugolB455Ufd4NXF/LuhyB+YQI9e
v75yqESra+LWfP7ffDjXNMkIqhnw8bZEoZtcCXA3oPskjn0wNOy+WydtYQR1jttg
7GrrNf38nrk+gSAx62gMzinAOYyMhjD3GqxakPfhA/7HsIvPC6ZVD+oSjmkiQzZB
44X+saR6BBodpYugy4qE
=f0Jq
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
