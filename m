From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c
 binding
Date: Tue, 28 Mar 2017 21:22:58 +0200
Message-ID: <20170328192258.GA4525@katana>
References: <1489029185-21447-1-git-send-email-jun.gao@mediatek.com>
 <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
 <20170322090543.sxacnddn2o7stjnq@ninjato>
 <1490694612.18582.11.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490694612.18582.11.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 05:50:12PM +0800, Jun Gao wrote:
> On Wed, 2017-03-22 at 10:05 +0100, Wolfram Sang wrote:
> > On Thu, Mar 09, 2017 at 11:13:04AM +0800, Jun Gao wrote:
> > > From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >=20
> > > Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
> > > modify i2c driver.
> > >=20
> > > Signed-off-by: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >=20
> > There is still the issue which Matthias Brugger pointed out on January,
> > 24th: you need to describe the fallback compatibles.
> >=20
>=20
> IMHO the value under compatible are just inputs which can be accepted.
> It's little strange to add fallback information in binding. Some other
> bindings do not describe so detailedly.
> Is it OK to make binding as minimum standard?
> If we describe it very detailedly, we will have to modify binding if
> there are some changes for mt2701.

My reading of the below is that I could simply use "mediatek,mt2701-i2c"
as compatible and things will work. But it won't, we don't have that in
the driver IIRC. So, we need a fallback for that to work.

> Rob, could you give some suggestions?  Thanks!

Would be welcome, yes. I lost track what the preferred solution is.

>=20
> > > ---
> > >  .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/D=
ocumentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > > index 0ce6fa3..27dbbf9 100644
> > > --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > > @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface =
with I2C devices.
> > > =20
> > >  Required properties:
> > >    - compatible: value should be either of the following.
> > > -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> > > -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> > > -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> > > -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> > > -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
> > > +	"mediatek,mt2701-i2c"
> > > +	"mediatek,mt6577-i2c"
> > > +	"mediatek,mt6589-i2c"
> > > +	"mediatek,mt8127-i2c"
> > > +	"mediatek,mt8135-i2c"
> > > +	"mediatek,mt8173-i2c"
> > >    - reg: physical base address of the controller and dma base, lengt=
h of memory
> > >      mapped region.
> > >    - interrupts: interrupt number to the cpu.
> > > --=20
> > > 1.7.9.5
> > >=20
>=20
>=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY2rgRAAoJEBQN5MwUoCm2QPUP/RKSUMu/CfirGXi+l3xVQZDN
dMrIEX+y79HfavvLgG6juaSqVREn6s27LmmO5pSqr/JyfzuhStx2H0c9/wmIjRqA
s+jq8BKnWmL7+QnxG49ksqM+t/yp9hE3LIEHWMdfZkMGLgpK4R1SGiHxAa71ppnb
B3B7gNunzH6bc/3OnkXHT3TVN8YfqukkV4OJCsdIU4/kZiO8dV6X1rx5OjlvqFNY
16ksH12rIfQ6QAqs0Fzsp5uOUsxEltO1msFpXyXic34eprR16duiSyXteYz8fVSR
ZUjuFe/A4cpPT5jw0sjO9qvVzHqdeJtzqVVvLNiwNZfFj8WplSAoIbc0hWZ0B/Rt
KwobM7eGrPC45eMmLIHde1AL90mCIKobBzAjx9vaRQrzg13R5G/7h9v/Yo6tVRkR
jOMTTc9PNK0TXOAagQYJ2XoH6SspJpcRZLXDjeMBmUmfl6x6YRTj8u/aeJ6jG/bi
sJ/3H1wqabX/l9AelNkEZO3IHuKcbtYn53LPSb2Xj16BrSBe/oLcSOGY9rA2xfMZ
c/n3GCGBEENSuE6Ievifj2PMdWktD2qAFh+yTiwhb62pXaOPqh9bRnWKN9BZoO7K
7+IppUh3fFzmZjy8hlCCqG5k2qlQS0NtWcWfrjUXpG2n/KzKmyecQ/FCVPQ3gFg6
mu+esTsYSByGlfUrcvfw
=yz7H
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
