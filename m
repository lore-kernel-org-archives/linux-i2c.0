From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 8 Jan 2014 12:29:26 +0100
Message-ID: <20140108112926.GB2669@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <20140107183853.GE4227@obsidianresearch.com>
 <20140107230610.GB2592@katana>
 <52CD2529.6090206@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CD2529.6090206-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 11:15:05AM +0100, Gregory CLEMENT wrote:
> Hi Wolfram,
>=20
> On 08/01/2014 00:06, Wolfram Sang wrote:
> > On Tue, Jan 07, 2014 at 11:38:53AM -0700, Jason Gunthorpe wrote:
> >> On Tue, Jan 07, 2014 at 05:35:03PM +0100, Gregory CLEMENT wrote:
> >>> +static struct property i2c_offload_broken =3D {
> >>> +	.name =3D "offload-broken",
> >>> +};
> >>> +
> >>> +static void __init i2c_quirk(void)
> >>> +{
> >>> +	struct device_node *np;
> >>> +	u32 dev, rev;
> >>> +
> >>> +	/*
> >>> +	 * Only revisons more recent than A0 support the offload
> >>> +	 * mechanism. We can exit only if we are sure that we can
> >>> +	 * get the SoC revision and it is more recent than A0.
> >>> +	 */
> >>> +	if (mvebu_get_soc_id(&rev, &dev) =3D=3D 0 && dev > MV78XX0_A0_REV)
> >>> +		return;
> >>> +
> >>> +	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c")
> >>> +		of_add_property(np, &i2c_offload_broken);
> >>
> >> I like this approach.
> >=20
> > Sorry, but I don't.
> >=20
> >> However, when I first read this I thought it should be a -a0 specific
> >> compatible string, not a 'offload-broken' property - any idea what the
> >> DT consensus is here? I've seen both approach in use ..
> >=20
> > I prefer the replacement of the compatible string. If it should really
> > be a seperate property, then it should be a vendor specific property. It
> > is not generic, at all.
>=20
> Something like "marvell,offload-broken" would be acceptable?

A tad more, yes. Still, since this is a feature/quirk of the IP core
revision, it should be deduced from the compatible property IMO. It
cannot be configured anywhere, so it doesn't change on board level.


--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzTaWAAoJEBQN5MwUoCm2LW0QAJsvkqdYSknF51c1kyPt0itM
phJyfNsirbZh3lY33MR8+p5xyb+DlaER8p5fuKBzZQwBHw6FWxYs9XXdMC7KJ4PW
+MhiIok7PVx7042JrOj9J9Xlr8BNDhQMZOjM7JpROzYF9yTbtT+6cAOdKvX72tOH
M+Oa6jrkZS7IOaBJ2SLnvi4SXfCGRE3hTJUJe1LKCrmwj4/6UPtvYMqrfz9b5kMb
DRnFJ0L8mzHiULgO2sv2KP2m9l3NOctOzbO4FDJzHPPQU9j9wkIdneLvNxkZgRly
64UKozveudPJ1SUqBTbBmGEDmfisu8HQ5GMjhFt5UhzAVvhpUlGY6qdprN4+266W
ipK/Osu0F1hFRbAAKcGsgvUSo2sYT/3G9iTh7W981Vxqj3218AM5eFGBKiQjL/Hv
thCV6y1FfNUw20z8vKySqk1Yv0HfCbNEQ10Qyc45l65rKiHIU/Cf6mj9S8+wOwrf
erYNXpkOicmVSJSpkE0dyNyOD20NafiRHGukFHvvf6gZVO52YBpcm+vfqsxaYOBN
94T8qtrRgddn+2cfvIdExzM6D7d48m1B3OT7TZhtUPWAgSzMi+NU2OrLDazcyvqj
kdOJTBxFWuu6TyKvBKMHhz1Cyrhn3pFqN1bcuvCXEtrQjBIbNnDR/mzKnNd3ot1d
KNGqF6o8QtGoeVLkWZcv
=jJI0
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
