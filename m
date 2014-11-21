From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: introduce probe deferring
Date: Fri, 21 Nov 2014 08:02:21 +0100
Message-ID: <20141121070221.GE1480@katana>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
 <20141119091647.GB1439@katana>
 <5216790.dAh2H6iKq8@wuerfel>
 <20141119101403.GE3639@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141119101403.GE3639@ldesroches-Latitude-E6320>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2014 at 11:14:03AM +0100, Ludovic Desroches wrote:
> On Wed, Nov 19, 2014 at 10:47:15AM +0100, Arnd Bergmann wrote:
> > On Wednesday 19 November 2014 10:16:47 Wolfram Sang wrote:
> > > On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> > > > Return probe defer if requesting a dma channel without a dma contro=
ller probed.
> > > >=20
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c=
-at91.c
> > > > index 77fb647..df3f4c4 100644
> > > > --- a/drivers/i2c/busses/i2c-at91.c
> > > > +++ b/drivers/i2c/busses/i2c-at91.c
> > > > @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91=
_twi_dev *dev, u32 phy_addr)
> > > >  	dma_cap_zero(mask);
> > > >  	dma_cap_set(DMA_SLAVE, mask);
> > > > =20
> > > > -	dma->chan_tx =3D dma_request_slave_channel_compat(mask, filter, p=
data,
> > > > -							dev->dev, "tx");
> > > > -	if (!dma->chan_tx) {
> > > > +	dma->chan_tx =3D dma_request_slave_channel_reason(dev->dev, "tx");
> > >=20
> > > Will it cause regressions if you drop the compat-version of requesting
> > > a channel?
> >=20
> > I got curious about this, since the patch looks obviously wrong, but
> > actually it's ok. However the entire DMA support for non-DT platforms
> > can be dropped in this driver, see patch below
> >=20
> > > > +	if (IS_ERR(dma->chan_tx)) {
> > > > +		ret =3D PTR_ERR(dma->chan_tx);
> > > > +		if (ret =3D=3D -EPROBE_DEFER) {
> > > > +			dev_warn(dev->dev, "no DMA channel available at the moment\n");
> > >=20
> > > I'd say drop this warning. The core usually prints when deferred prob=
ing
> > > takes place.
> >=20
> > Definitely yes.
> >=20
> > 	Arnd
> > 8<---
> > [PATCH] i2c: at91: remove legacy DMA supoprt
> >=20
> > Since at91sam9g45 is now DT-only, all DMA capable users of this driver =
are
> > using the DT case, and the legacy support can be removed. While at it, =
fix
> > the deferred probe case.
> >=20
> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Thanks for this cleanup, yet I'd really appreciate a build test at
least.

> Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

=46rom you, I had even hoped for a quick runtime test. Would that be
possible for future patches?

Thanks,

   Wolfram


--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbuN9AAoJEBQN5MwUoCm2/4oQAJmxAwgr0c5a+9IWY+zpogCg
7VEIgQbqp/wgOiPbVEO18munqr67Nhoal3fVsBVRs1tAj8Rz6chCiNjT3y5H0z3c
PBu9Hs40QTk4dfZ3Ly5TT2d+SNKtp/uI5HP8jlIPj9/yzoMIMrsJjHBxNUs5EBa6
gT3skkp6H6L/MZasG/8B5RwtHksBOVcEq6C3YDNxmriIrVVtjEee2eAgBxLI7PJu
2gS2aBh0HJ8Q8vxQDhYBgB49oy6kE5mEKgHfoRFlmVhqLj3lfQNDRVrlOS2uMJBd
/nJaQjZJ9r6LRc4NpTXcAZ9Hx06eGlUwDjDHTy4pvQBU/jIOe60/njVyDv5jj7ey
pY3gRdBESblnrvUVHfGpKHO/fx/9wJoFDQULpXM/yVoT1AxHW2EUZzt/7Yw5UCQZ
CyFlg18E6Drrox53rwDDV7nilRGt0IjGGowlABb+Ha2yUVaJ/Srcz/kX3c7k9eBs
7Sqgae/cDtZBjjlL6kGulrp9dFEwsvGshKEcptGAsvMgJsHs/j7EkiZ7jdvT7J3n
qaA3jSeiVazXTnkjdBfxLEegt1ZH+oqnI2tnRSrB+r5gXyQomeEssJbuM1PaWZKe
rgOBOpq2QZjKdk/HPO1ZSEbugoNS1ituMHmPmG3EzD4fZMJH0Olx0NArsOvNVCkO
lpJNbt7AZAj5FNyf8oqV
=9sBn
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
