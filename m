From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] of: i2c: Add idle-disconnect DT property to PCA954x
 mux driver
Date: Thu, 15 Jan 2015 14:19:35 +0100
Message-ID: <20150115131935.GE2549@katana>
References: <5494599A.8050803@nsn.com>
 <20150115123237.GC2549@katana>
 <54B7BBF5.4010001@nsn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B7BBF5.4010001-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 02:09:09PM +0100, Alexander Sverdlin wrote:
> Hi Wolfram!
>=20
> On 15/01/15 13:32, ext Wolfram Sang wrote:
> > On Fri, Dec 19, 2014 at 06:00:10PM +0100, Alexander Sverdlin wrote:
> >> of: i2c: Add idle-disconnect DT property to PCA954x mux driver
> >>
> >> Add idle-disconnect device tree property to PCA954x mux driver. The ne=
w property
> >> forces the multiplexer to disconnect child buses in idle state. This i=
s used, for
> >> example, when there are several multiplexers on the same bus and the d=
evices on
> >> the underlying buses might have same I2C addresses.
> >=20
> > Basically OK. Question to DT maintainers: "idle-disconnect",
> > "i2c-mux-idle-disconnect", or is there another existing binding we could
> > use?
> >=20
> >> At the same time old (and not used in the tree) platform data binding
> >> deselect_on_exit is removed to simplify the implementation. Old bindin=
g has
> >> different (per-channel) semantics and doesn't fit well in the new conc=
ept.
> >=20
> > I'd prefer to keep it. It should be only one || more. It is not really
> > in the way IMO.
>=20
> It complicates the implementation 3x times :) This is part of our discuss=
ion with Laurent:

Does it? I don't want DT and platform_data to behave equally. I just
want to keep being backwards compatible. So, I'd suggest:

(pdata && pdata->modes[num].deselect_on_exit) || idle_disconnect ? pca954x_=
deselect_mux : NULL);

> > I'm not keen to brake out-of-tree code (if any), but may be it will be
> > decided to drop this per-channel deselect_on_exit, because it's not use=
d at
> > least in the kernel tree...

I couldn't find a user of the platform_data, at all. But removing
platform_data support is a seperate patch, and deprecating platform_data
is a seperate and general issue IMO.


--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt75nAAoJEBQN5MwUoCm2yrkQAI+LPukjVgpG/uc26gv3v1TI
7QzzHkTP+/IJnL1+fkgaShhAaYnxbKSiQpwzOg9o8/c3wV+MTEx/IAwGs+Oc6Wh8
ZDiL4KUODbIVxJTY1B8fOIb7syAu3onNRbygV+ebMmD17uZtdMme6XEE7OhwNn2f
P0b93k+nxLvzdImDxCTO0DxDuhnjpOS3fM+hYHUj3F0laK5/+t2D7lCwcns4sfDl
2E0fpuM934lwtdGNAAGXuuF/S2DsEJzmigUshAABZI+YF7mWCpRoIH8hvqW3Bj0w
ZXPDPtyGsjcME/zQHcJDo81kb9IbXM4YJ6H+Uz5Hxiu+EGf7U6co2JqTpJfG3+kL
Ab/noPPJJfAWgPL8jmNwZsDJ8xJiIEAPWDBQb20VWxNqfxF5KAjLOq70WBwOSkBW
ay9sMZaFvkJcTDadPPFlNs6Opr+PBRJj8c7AFks42mzPo2blmCmOjOueKKK+gLrr
R3HZYd4Rz7/dt85m4JYATTriPbw4z1xI0ltqNFWOhgkEH6gIKPN78oL1h8n0ZKg9
ncZi0PKEeR51cQauM7HX826zf3ITsjMcu23D0Y4yeF+E30j3dUE+BCBwqV4ikaNB
FBd9AegPsJsm84s33NUDjnrQt4neagITRYCQjq5/lXavDiDmXd3Y8eZ/bJRkr74o
fe1U4q/EN1sDE+tuakjD
=XXG0
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
