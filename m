From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Date: Fri, 25 Jan 2019 09:20:51 +0000
Message-ID: <VI1PR04MB51345D0DD6A2138B3E452CEAEC9B0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
 <20190122225155.vfy37bfuikzzymao@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122225155.vfy37bfuikzzymao@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Leo Li <leoyang.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Wednesday, January 23, 2019 12:52 AM
>=20
> On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> > Use the correct error pointer when extracting the error code.
> >
> > Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma
> i2c_imx_dma_request")
>=20
> This is not the sha1 in my tree. Maybe you rebased? I applied another
> patch meanwhile fixing the same issue. Still thanks!

I don't know, perhaps I was on some transient snapshot. Anyway, good that i=
n the end it's fixed.

---
Best Regards, Laurentiu

> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
> > index 09b124547669..42fed40198a0 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struc=
t
> *i2c_imx,
> >
> >  	dma->chan_tx =3D dma_request_chan(dev, "tx");
> >  	if (IS_ERR(dma->chan_tx)) {
> > -		ret =3D PTR_ERR(dma->chan_rx);
> > +		ret =3D PTR_ERR(dma->chan_tx);
> >  		if (ret !=3D -ENODEV && ret !=3D -EPROBE_DEFER)
> >  			dev_err(dev, "can't request DMA tx channel (%d)\n",
> ret);
> >  		goto fail_al;
> > --
> > 2.17.1
> >
