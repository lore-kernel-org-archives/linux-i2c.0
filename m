From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ocores: Adapt for device tree
Date: Wed, 24 Nov 2010 16:42:15 +0100
Message-ID: <20101124154215.GE6812@pengutronix.de>
References: <1290607789-8996-1-git-send-email-jonas@southpole.se>
 <1290607789-8996-2-git-send-email-jonas@southpole.se>
 <20101124145843.GD6812@pengutronix.de>
 <1290612770.2959.21.camel@needafix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290612770.2959.21.camel@needafix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> While I agree that these parameters need documentation, I haven't seen
> that there is an agreed upon place to put such documentation as of yet.
> I followed your link but didn't find the corresponding document in the
> kernel tree.

Because it has not been applied yet; that was the "template" patch I
could dig up fastest.

> Should I really be putting my documentation in the
> Documentation/powerpc directory?

Not necessarily. You could post a patch moving the generic parts to a
better location, too :)

> > > +#ifdef CONFIG_OF
> > > +	i2c->adap.dev.of_node =3D pdev->dev.of_node;
> > > +#endif
> >=20
> > No need for the ifdef here.
> >=20
>=20
> Why?  of_node is protected by CONFIG_OF in linux/device.h

Ehrm, seems my mind broke :( Apologies, I probably was mixing it up with
another issue.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkztMlcACgkQD27XaX1/VRtHnQCff/DZJrOvUdPw68d3yCTscTee
2lQAn0Iwxu7lr2vmBzujE9mWXBC6FNNX
=/RmO
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
