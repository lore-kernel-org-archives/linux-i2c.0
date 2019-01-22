From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Date: Tue, 22 Jan 2019 23:50:35 +0100
Message-ID: <20190122225035.ppp7njqqwb4nz6pp@ninjato>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
 <e8c15a2a-6b59-42bb-0a1f-2ab53c01b0d6@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1617803924458684109=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e8c15a2a-6b59-42bb-0a1f-2ab53c01b0d6@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>
Cc: "eha@deif.com" <eha@deif.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org


--===============1617803924458684109==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bzf4g6etpjcm7b4b"
Content-Disposition: inline


--bzf4g6etpjcm7b4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 11:03:20AM +0000, Peter Rosin wrote:
> On 2019-01-17 04:14, YueHaibing wrote:
> > Change the call to PTR_ERR to access the value just tested by IS_ERR.
> >=20
> > Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx=
_dma_request")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 09b1245..42fed40 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struc=
t *i2c_imx,
> > =20
> >  	dma->chan_tx =3D dma_request_chan(dev, "tx");
> >  	if (IS_ERR(dma->chan_tx)) {
> > -		ret =3D PTR_ERR(dma->chan_rx);
> > +		ret =3D PTR_ERR(dma->chan_tx);
> >  		if (ret !=3D -ENODEV && ret !=3D -EPROBE_DEFER)
> >  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
> >  		goto fail_al;
> >=20
> >=20
> >=20
>=20
> You were beaten to it by Laurentiu Tudor, who sent the same patch [1] sho=
rtly
> before you.

Yes, but his Fixes: tag was wrong, so I applied this patch with Uwe's
tag moved to here.


--bzf4g6etpjcm7b4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnjoACgkQFA3kzBSg
KbaUpg//eQX7ebREIrIr4wer9VQip7SotcnGF5RgdbqTHI57lULD8NS0Pal6AqPi
aSxg6Aqr26fRosl5vR0nN15Qxjmn069hR2Kxnb2YPn+j5+D29iopEjHAUdsTqxAB
ZZr9BzYMxGlXxN4Rm8nT4q4+T1KBJ4+ZOqwNKZxELq1EM+4GolCqr3QxZkYfWJVK
kUg0QcKn5sE53OlmAtPi7n+S+bn1XP71dLe+ibvxudL2mFFY2OYuQrT0VuDsbq8Q
JPeE5f0FWZ7kEuIadrN4KYiQ4W9wbv8i2ZkbjS2IJniq2SSDuP8aztDOYiHBsot9
3ZFLhABn0fBcI7UdHXaMtN6oIISZqH8jverqHht5D5iaH+YBfPOo3f6+Fs9rx7UA
P7/lgTE7kGDZJ3YuKwKJUk8sDWIeZnsZrz+2bu7FxEOgUGMSmNtQM8Pv1lS4NYoJ
npiBzmZAEBdWxj4AiH/dbb9UVXlMWKrs5yR4OhprtRZqvUJTCqf1dOtJjG37bY5x
J0n84JHj4nZBtaIXO9DnZd/5w2sQMq25IQG9tlkICV83yHYLOJN6b/PmpFqCyxn7
rlGnTiEP/A3szglwcLqp31b/cIRNJ4Mj2Xrd0ZV6w2QVwI0oaTuwo8Nw7SKL6gp+
NVIt0HUOK0RlO7tlnejxXl+/Ih+w015L9uHam3LSROlG5cA7QDQ=
=yLqc
-----END PGP SIGNATURE-----

--bzf4g6etpjcm7b4b--


--===============1617803924458684109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1617803924458684109==--
