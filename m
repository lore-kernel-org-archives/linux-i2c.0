From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: [v5] i2c: imx: support slave mode for imx I2C driver
Date: Mon, 2 Dec 2019 11:32:57 +0000
Message-ID: <DB7PR04MB4490A7B35547A7396BBDC3898F430@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20191129090513.2150-1-biwen.li@nxp.com>
 <20191202095509.ynxq2dyri36i2fwk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191202095509.ynxq2dyri36i2fwk@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Leo Li <leoyang.li@nxp.com>, "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Clark Wang <xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Jiafei Pan <jiafei.pan@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> Subject: [EXT] Re: [v5] i2c: imx: support slave mode for imx I2C driver
> 
> Caution: EXT Email
> 
> Hi,
> 
> Some more comments inline.
> 
> On Fri, Nov 29, 2019 at 05:05:13PM +0800, Biwen Li wrote:
> > The patch supports slave mode for imx I2C driver
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v5:
> >       - fix a bug that cannot determine in what mode(master mode or
> >         slave mode)
> >
> > Change in v4:
> >       - add MACRO CONFIG_I2C_SLAVE to fix compilation issue
> >
> > Change in v3:
> >       - support layerscape and i.mx platform
> >
> > Change in v2:
> >       - remove MACRO CONFIG_I2C_SLAVE
> >
> >
> >  drivers/i2c/busses/i2c-imx.c | 216
> > ++++++++++++++++++++++++++++++++---
> >  1 file changed, 198 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index a3b61336fe55..52f70de16900 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -203,6 +203,9 @@ struct imx_i2c_struct {
> >       struct pinctrl_state *pinctrl_pins_gpio;
> >
> >       struct imx_i2c_dma      *dma;
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +     struct i2c_client       *slave;
> > +#endif
> >  };
> >
> >  static const struct imx_i2c_hwdata imx1_i2c_hwdata = { @@ -279,6
> > +282,14 @@ static inline unsigned char imx_i2c_read_reg(struct
> imx_i2c_struct *i2c_imx,
> >       return readb(i2c_imx->base + (reg <<
> > i2c_imx->hwdata->regshift));  }
> >
> > +/* Set up i2c controller register and i2c status register to default
> > +value. */ static void i2c_imx_reset_regs(struct imx_i2c_struct
> > +*i2c_imx) {
> > +     imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
> > +                     i2c_imx, IMX_I2C_I2CR);
> > +     imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> > +IMX_I2C_I2SR); }
> > +
> >  /* Functions for DMA support */
> >  static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> >                                               dma_addr_t phy_addr)
> @@
> > -588,23 +599,33 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >       imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);  }
> >
> > -static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> > +/* Clear interrupt flag bit */
> > +static void i2c_imx_clr_if_bit(unsigned int status, struct
> > +imx_i2c_struct *i2c_imx)
> >  {
> > -     struct imx_i2c_struct *i2c_imx = dev_id;
> > -     unsigned int temp;
> > +     status &= ~I2SR_IIF;
> > +     status |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > +     imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> >
> > -     temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > -     if (temp & I2SR_IIF) {
> > -             /* save status register */
> > -             i2c_imx->i2csr = temp;
> > -             temp &= ~I2SR_IIF;
> > -             temp |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > -             imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> > -             wake_up(&i2c_imx->queue);
> > -             return IRQ_HANDLED;
> > -     }
> > +/* Clear arbitration lost bit */
> > +static void i2c_imx_clr_al_bit(unsigned int status, struct
> > +imx_i2c_struct *i2c_imx) {
> 
> Can you please remove some of the really obvious comments? When a function
> is named clr_al_bit, then it doesn't need a comment which says that this
> function really does this. There are more comments like this in the patch.
Got it, I will remove it in v6.
> 
> > +     status &= ~I2SR_IAL;
> > +     status |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IAL);
> > +     imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> >
> > -     return IRQ_NONE;
> > +static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx)
> > +{
> > +     unsigned int status;
> > +
> > +     /* Save status register */
> > +     status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     i2c_imx->i2csr = status | I2SR_IIF;
> 
> Instead of reading the status register again you could set i2c_imx->i2csr in the
> caller.
> 
> > +
> > +     wake_up(&i2c_imx->queue);
> > +
> > +     return IRQ_HANDLED;
> >  }
> >
> >  static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx, @@
> > -900,6 +921,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> >
> >       dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +     if (i2c_imx->slave) {
> > +             dev_err(&i2c_imx->adapter.dev, "Please not do operations of
> master mode in slave mode");
> > +             return -EBUSY;
> > +     }
> > +#endif
> > +
> >       result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> >       if (result < 0)
> >               goto out;
> > @@ -1048,11 +1076,166 @@ static u32 i2c_imx_func(struct i2c_adapter
> *adapter)
> >               | I2C_FUNC_SMBUS_READ_BLOCK_DATA;  }
> >
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +static int i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx) {
> > +     int temp;
> > +
> > +     /* Resume */
> > +     temp = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> > +     if (temp < 0) {
> > +             dev_err(&i2c_imx->adapter.dev, "failed to resume i2c
> controller");
> > +             return temp;
> > +     }
> > +
> > +     /* Set slave addr. */
> > +     imx_i2c_write_reg((i2c_imx->slave->addr << 1), i2c_imx,
> > + IMX_I2C_IADR);
> > +
> > +     i2c_imx_reset_regs(i2c_imx);
> > +
> > +     /* Enable module */
> > +     temp = i2c_imx->hwdata->i2cr_ien_opcode;
> > +     imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +     /* Enable interrupt from i2c module */
> > +     temp |= I2CR_IIEN;
> > +     imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> 
> Do these have to be two register accesses?
Yes, unless it will be not workable of interrupt.
> 
> > +
> > +     /* Wait controller to be stable */
> > +     usleep_range(50, 150);
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx)
> > +{
> > +     unsigned int status, ctl;
> > +     u8 value;
> > +
> > +     if (!i2c_imx->slave) {
> > +             dev_err(&i2c_imx->adapter.dev, "cannot deal with slave
> irq,i2c_imx->slave is null");
> > +             return IRQ_NONE;
> > +     }
> 
> This function is never called with !i2c_imx->slave.
Got it, I will remove it in v6.
> 
> > +
> > +     status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +     if (status & I2SR_IAL) { /* Arbitration lost */
> > +             i2c_imx_clr_al_bit(status, i2c_imx);
> > +     } else if (status & I2SR_IAAS) { /* Addressed as a slave */
> > +             if (status & I2SR_SRW) { /* Master wants to read from us*/
> > +                     dev_dbg(&i2c_imx->adapter.dev, "read requested");
> > +                     i2c_slave_event(i2c_imx->slave,
> > + I2C_SLAVE_READ_REQUESTED, &value);
> > +
> > +                     /* Slave transmit */
> > +                     ctl |= I2CR_MTX;
> > +                     imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +
> > +                     /* Send data */
> > +                     imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> > +             } else { /* Master wants to write to us */
> > +                     dev_dbg(&i2c_imx->adapter.dev, "write
> requested");
> > +                     i2c_slave_event(i2c_imx->slave,
> > + I2C_SLAVE_WRITE_REQUESTED, &value);
> > +
> > +                     /* Slave receive */
> > +                     ctl &= ~I2CR_MTX;
> > +                     imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +                     /* Dummy read */
> > +                     imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > +             }
> > +     } else if (!(ctl & I2CR_MTX)) { /* Receive mode */
> > +                     if (status & I2SR_IBB) { /* No STOP signal detected
> */
> > +                             ctl &= ~I2CR_MTX;
> > +                             imx_i2c_write_reg(ctl, i2c_imx,
> > + IMX_I2C_I2CR);
> > +
> > +                             value = imx_i2c_read_reg(i2c_imx,
> IMX_I2C_I2DR);
> > +                             i2c_slave_event(i2c_imx->slave,
> I2C_SLAVE_WRITE_RECEIVED, &value);
> > +                     } else { /* STOP signal is detected */
> > +                             dev_dbg(&i2c_imx->adapter.dev,
> > +                                     "STOP signal detected");
> > +                             i2c_slave_event(i2c_imx->slave,
> I2C_SLAVE_STOP, &value);
> > +                     }
> > +     } else if (!(status & I2SR_RXAK)) {     /* Transmit mode received ACK
> */
> > +             ctl |= I2CR_MTX;
> > +             imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +
> > +             i2c_slave_event(i2c_imx->slave,
> > + I2C_SLAVE_READ_PROCESSED, &value);
> > +
> > +             imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> > +     } else { /* Transmit mode received NAK */
> > +             ctl &= ~I2CR_MTX;
> > +             imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +             imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > +     }
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int i2c_imx_reg_slave(struct i2c_client *client) {
> > +     struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
> > +     int ret;
> > +     if (i2c_imx->slave)
> > +             return -EBUSY;
> > +
> > +     i2c_imx->slave = client;
> > +
> > +     ret = i2c_imx_slave_init(i2c_imx);
> > +     if (ret < 0)
> > +             dev_err(&i2c_imx->adapter.dev, "failed to switch to
> > + slave mode");
> 
> The caller already reports an error. No need to do it here again.
Okay, got it, I will remove it in v6.
> 
> > +
> > +     return ret;
> > +}
> > +
> > +static int i2c_imx_unreg_slave(struct i2c_client *client) {
> > +     struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
> > +     int ret;
> > +
> > +     if (!i2c_imx->slave)
> > +             return -EINVAL;
> > +
> > +     /* Reset slave address. */
> > +     imx_i2c_write_reg(0, i2c_imx, IMX_I2C_IADR);
> > +
> > +     i2c_imx_reset_regs(i2c_imx);
> > +
> > +     i2c_imx->slave = NULL;
> > +
> > +     /* Suspend */
> > +     ret = pm_runtime_put_sync(i2c_imx->adapter.dev.parent);
> > +     if (ret < 0)
> > +             dev_err(&i2c_imx->adapter.dev, "failed to suspend i2c
> > + controller");
> 
> I doubt this message is useful.
Got it, I will remove it in v6.
> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=02%7C01%7Cbiwen.li%40nxp.com%7C8f076a1a
> 982f408bd62808d7770dbb1f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C637108773168503613&amp;sdata=tzCXguqtJVjaAisPkUzsqwI1frtL
> 3ToGNpmyJGnLA3s%3D&amp;reserved=0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
