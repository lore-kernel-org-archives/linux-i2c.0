From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
Date: Mon, 12 Aug 2019 08:38:22 +0200
Message-ID: <20190812063822.7odhnj5ueqjam3g6@pengutronix.de>
References: <20190808035343.34120-1-biwen.li@nxp.com>
 <20190808141814.wr4hlmbaek6p7dy2@pengutronix.de>
 <DB7PR04MB4490F2C2C4B69F0F011420C98FD60@DB7PR04MB4490.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4490F2C2C4B69F0F011420C98FD60@DB7PR04MB4490.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 09, 2019 at 04:04:45AM +0000, Biwen Li wrote:
> > 
> > Hi,
> > 
> > On Thu, Aug 08, 2019 at 11:53:43AM +0800, Biwen Li wrote:
> > > The patch supports slave mode for imx I2C driver
> > >
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > ---
> > >  drivers/i2c/busses/i2c-imx.c | 199
> > > ++++++++++++++++++++++++++++++++---
> > >  1 file changed, 185 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-imx.c
> > > b/drivers/i2c/busses/i2c-imx.c index b1b8b938d7f4..f7583a9fa56f 100644
> > > --- a/drivers/i2c/busses/i2c-imx.c
> > > +++ b/drivers/i2c/busses/i2c-imx.c
> > > @@ -202,6 +202,9 @@ struct imx_i2c_struct {
> > >       struct pinctrl_state *pinctrl_pins_gpio;
> > >
> > >       struct imx_i2c_dma      *dma;
> > > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > > +     struct i2c_client               *slave;
> > > +#endif /* CONFIG_I2C_SLAVE */
> > 
> > Other drivers just do a "select I2C_SLAVE" in Kconfig to get rid of these #ifs. We
> > should do the same.
> Hi sascha, I don't know your meaning, could you let it clearer?

Other drivers have "select I2C_SLAVE" in Kconfig, so they do not need
any #ifdef CONFIG_I2C_SLAVE as this is always true.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
