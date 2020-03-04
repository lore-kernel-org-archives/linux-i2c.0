From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [EXT] Re: [v6] i2c: imx: support slave mode for imx I2C driver
Date: Wed, 4 Mar 2020 06:22:35 +0100
Message-ID: <20200304052235.mvpjqa2u56joew3r@pengutronix.de>
References: <20191203114809.21226-1-biwen.li@nxp.com>
 <20191204100005.r56huywxa7h3c6zr@pengutronix.de>
 <9a1a00c1-e9fa-36a1-0e79-3492d9b98d9f@pengutronix.de>
 <DB7PR04MB4490D8434B77DE285A9518448FE50@DB7PR04MB4490.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4490D8434B77DE285A9518448FE50@DB7PR04MB4490.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Biwen Li <biwen.li@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "festevam@gmail.com" <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Xiaobo Xie <xiaobo.xie@nxp.com>, Leo Li <leoyang.li@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Jiafei Pan <jiafei.pan@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hi Biwen,

On Wed, Mar 04, 2020 at 04:13:03AM +0000, Biwen Li wrote:
> Hi Wolfram,
> 
> Any comments?

Wolfram is waiting until you react to our comments. Until this is not
happened, I will not ACK this patch and Wolfram will not take it.

regards,
Oleksij

> Best Regards,
> Biwen Li
> 
> > 
> > Hi,
> > 
> > On 04.12.19 11:00, Sascha Hauer wrote:
> > > Hi,
> > >
> > > The patch looks ok to me now, but I still do not like the #ifdeffery
> > > around CONFIG_I2C_SLAVE. With the patch I just sent (You are on Cc:)
> > > we could apply the following on your patch which makes it more
> > > readable and increases compile coverage.
> > >
> > > Wolfram, Biwen, what do you think?
> > 
> > 
> > RCAR depends on slave:
> > config I2C_RCAR
> > 
> >          tristate "Renesas R-Car I2C Controller"
> > 
> >          depends on ARCH_RENESAS || COMPILE_TEST
> > 
> >          select I2C_SLAVE
> > see:
> > drivers/i2c/busses/i2c-rcar.c
> > 
> > So, I would suggest to do the same in imx.
> > 
> > So far, I tested this patch on iMX6S. It works in one board (i2c-gpio + i2c-imx)
> > and two board (i2c-imx + i2c-imx) configuration.
> > Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > 
> > >
> > > Sascha
> > >
> > > ---------------------------8<------------------------------
> > >
> > >  From 52f7c2bf59db61d4b27b59ca6404136e3ed77310 Mon Sep 17
> > 00:00:00
> > > 2001
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Date: Wed, 4 Dec 2019 10:56:34 +0100
> > > Subject: [PATCH] fixup! i2c: imx: support slave mode for imx I2C
> > > driver
> > >
> > > ---
> > >   drivers/i2c/busses/i2c-imx.c | 21 ++++++++++-----------
> > >   1 file changed, 10 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-imx.c
> > > b/drivers/i2c/busses/i2c-imx.c index 40ccfca600bf..c5d9ae8226cd 100644
> > > --- a/drivers/i2c/busses/i2c-imx.c
> > > +++ b/drivers/i2c/busses/i2c-imx.c
> > > @@ -203,9 +203,7 @@ struct imx_i2c_struct {
> > >       struct pinctrl_state *pinctrl_pins_gpio;
> > >
> > >       struct imx_i2c_dma      *dma;
> > > -#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > >       struct i2c_client       *slave;
> > > -#endif
> > >   };
> > >
> > >   static const struct imx_i2c_hwdata imx1_i2c_hwdata = { @@ -913,12
> > > +911,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> > >
> > >       dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > >
> > > -#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > >       if (i2c_imx->slave) {
> > >               dev_err(&i2c_imx->adapter.dev, "Please not do operations
> > of master mode in slave mode");
> > >               return -EBUSY;
> > >       }
> > > -#endif
> > >
> > >       result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> > >       if (result < 0)
> > > @@ -1068,7 +1064,6 @@ static u32 i2c_imx_func(struct i2c_adapter
> > *adapter)
> > >               | I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> > >   }
> > >
> > > -#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > >   static int i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
> > >   {
> > >       int temp;
> > > @@ -1159,6 +1154,10 @@ static int i2c_imx_reg_slave(struct i2c_client
> > *client)
> > >   {
> > >       struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
> > >       int ret;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_I2C_SLAVE))
> > > +             return -EINVAL;
> > > +
> > >       if (i2c_imx->slave)
> > >               return -EBUSY;
> > >
> > > @@ -1173,6 +1172,9 @@ static int i2c_imx_unreg_slave(struct i2c_client
> > *client)
> > >   {
> > >       struct imx_i2c_struct *i2c_imx =
> > > i2c_get_adapdata(client->adapter);
> > >
> > > +     if (!IS_ENABLED(CONFIG_I2C_SLAVE))
> > > +             return -EINVAL;
> > > +
> > >       if (!i2c_imx->slave)
> > >               return -EINVAL;
> > >
> > > @@ -1188,15 +1190,12 @@ static int i2c_imx_unreg_slave(struct
> > > i2c_client *client)
> > >
> > >       return 0;
> > >   }
> > > -#endif
> > >
> > >   static const struct i2c_algorithm i2c_imx_algo = {
> > >       .master_xfer    = i2c_imx_xfer,
> > >       .functionality  = i2c_imx_func,
> > > -#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > >       .reg_slave      = i2c_imx_reg_slave,
> > >       .unreg_slave    = i2c_imx_unreg_slave,
> > > -#endif
> > >   };
> > >
> > >   static irqreturn_t i2c_imx_isr(int irq, void *dev_id) @@ -1208,10
> > > +1207,10 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> > >
> > >       if (status & I2SR_IIF) {
> > >               i2c_imx_clr_if_bit(status, i2c_imx); -#if
> > > IS_ENABLED(CONFIG_I2C_SLAVE)
> > > -             if (i2c_imx->slave)
> > > +
> > > +             if (IS_ENABLED(CONFIG_I2C_SLAVE) && i2c_imx->slave)
> > >                       return i2c_imx_slave_isr(i2c_imx); -#endif
> > > +
> > >               i2c_imx->i2csr = status;
> > >               return i2c_imx_master_isr(i2c_imx);
> > >       }
> > >
> > 
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
