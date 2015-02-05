From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c/mpc: Fix ISR return value
Date: Thu, 5 Feb 2015 20:37:53 +0100
Message-ID: <20150205193753.GH15307@katana>
References: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
 <CAAVjN7fQ4RLgsk1R_DPrFm21OBWpsBdxMuDyQauiz3pxCgK+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAVjN7fQ4RLgsk1R_DPrFm21OBWpsBdxMuDyQauiz3pxCgK+Lw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 03:17:37AM -0800, Danielle Costantino wrote:
> I have been using the driver with this modification for the past 6
> months and it has been stable in an industrial environment.I had made
> a few other changes that also improve reliability (using ppc in_8 and
> out_8 and eieio barriers to ensure in-order execution. This lets you
> remove the unneeded double read of the status register. I also added a
> more robust recovery function to handle force of bus master-ship, and
> clearing the arb lost interrupt that is generated. currently this can
> cause the isr to trigger and cause superfluous interrupts. I have not
> posted this patch because of the extensive changes,
>=20
> I will ack this patch.

Thanks for the detailed explanation. If you want to assist me even
further, please use the standard form for an Ack:

Acked-by: <your email>

Then patchwork will automatically collect the ack and I don't have to do
it manually.


--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08aRAAoJEBQN5MwUoCm2fUwP/AghMy6DE3Kyh4HU4WtiS+3a
nPt6s0Sw704C+ZoYCCDZa72rRnTDw/N6r/SrhJo6FqNs5HtjOPw35T2WMaALdcCL
pNS57BsYzOdvnlIuHXSPQlqGqjJo56SesmVB2znUMd3ukbzb6I7NHiuRQbM9g6m2
ynQbDXrUfNDZnQWl9RYVHqt4Q9QRjcCuCjV7WWCyeNfFHU9LXPeJGZ9yD41+8uik
cI4uDZnrpMIlsBEhb1pl/Ido+kATd0tzNouzB3YHh0czyt3FrAL7Z7bdiq5tGxDq
oxX0KMraLXz+8MpQ2mzCqRDOL5pNl7bhm+wEy9uGcNH+yVboQq7aEbrtnrsPSliM
v7PiqFIjb8fU0mO0cW8wMtwa3I2ysOmE9V43coRpOzW18skAHShKWDK7N5kSMF1v
Ulll4GrLfVRbSN8YAsLodJx+B/a371H5+tVbAlhxLOv/w/cWAQCoW4hCBXebHsw2
470ZAxNLe3CzcufyTAhjFjB3l5LExFS2XX/iT5dicxeGyP3srbkCE2cXoU9BS/zq
OnPSc1Ns6MI240wPmi2wkJJBGVDjoYfU/38U5vQwP7+jrU9xU7+ukzVFFrhjQsl9
TM9GTz64snhbzSrQ1lSED7HUC+S05JYBELc6xXDBUOAGDS9X+sldT6C7pZbHWMaD
i3+epviScOtq3VZjZ4Id
=dWmw
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
