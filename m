From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
Date: Mon, 12 Aug 2019 07:11:22 +0000
Message-ID: <DB7PR04MB44906E021E691694E30C63128FD30@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190808035343.34120-1-biwen.li@nxp.com>
 <20190808141814.wr4hlmbaek6p7dy2@pengutronix.de>
 <DB7PR04MB4490F2C2C4B69F0F011420C98FD60@DB7PR04MB4490.eurprd04.prod.outlook.com>
 <20190812063822.7odhnj5ueqjam3g6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812063822.7odhnj5ueqjam3g6@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

> Subject: Re: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
>=20
> Caution: EXT Email
>=20
> On Fri, Aug 09, 2019 at 04:04:45AM +0000, Biwen Li wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Aug 08, 2019 at 11:53:43AM +0800, Biwen Li wrote:
> > > > The patch supports slave mode for imx I2C driver
> > > >
> > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > > ---
> > > >  drivers/i2c/busses/i2c-imx.c | 199
> > > > ++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 185 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/busses/i2c-imx.c
> > > > b/drivers/i2c/busses/i2c-imx.c index b1b8b938d7f4..f7583a9fa56f
> > > > 100644
> > > > --- a/drivers/i2c/busses/i2c-imx.c
> > > > +++ b/drivers/i2c/busses/i2c-imx.c
> > > > @@ -202,6 +202,9 @@ struct imx_i2c_struct {
> > > >       struct pinctrl_state *pinctrl_pins_gpio;
> > > >
> > > >       struct imx_i2c_dma      *dma;
> > > > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > > > +     struct i2c_client               *slave;
> > > > +#endif /* CONFIG_I2C_SLAVE */
> > >
> > > Other drivers just do a "select I2C_SLAVE" in Kconfig to get rid of
> > > these #ifs. We should do the same.
> > Hi sascha, I don't know your meaning, could you let it clearer?
>=20
> Other drivers have "select I2C_SLAVE" in Kconfig, so they do not need any=
 #ifdef
> CONFIG_I2C_SLAVE as this is always true.
Okay, sascha, got it, I will remove the option in v2, thanks.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cbiwen.li%40nxp.com%7C2ad7a8ef
> 04c84f224a9808d71eefaf43%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637011887098895560&amp;sdata=3DDde7Hi6eMWcg7SM8T63eBtgY
> XsQPu3HFJaZMt6z8Vck%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
