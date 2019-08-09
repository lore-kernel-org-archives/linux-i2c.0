From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
Date: Fri, 9 Aug 2019 04:04:45 +0000
Message-ID: <DB7PR04MB4490F2C2C4B69F0F011420C98FD60@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190808035343.34120-1-biwen.li@nxp.com>
 <20190808141814.wr4hlmbaek6p7dy2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808141814.wr4hlmbaek6p7dy2@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

>=20
> Hi,
>=20
> On Thu, Aug 08, 2019 at 11:53:43AM +0800, Biwen Li wrote:
> > The patch supports slave mode for imx I2C driver
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 199
> > ++++++++++++++++++++++++++++++++---
> >  1 file changed, 185 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index b1b8b938d7f4..f7583a9fa56f 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -202,6 +202,9 @@ struct imx_i2c_struct {
> >       struct pinctrl_state *pinctrl_pins_gpio;
> >
> >       struct imx_i2c_dma      *dma;
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +     struct i2c_client               *slave;
> > +#endif /* CONFIG_I2C_SLAVE */
>=20
> Other drivers just do a "select I2C_SLAVE" in Kconfig to get rid of these=
 #ifs. We
> should do the same.
Hi sascha, I don't know your meaning, could you let it clearer?
>=20
> >  };
> >
> >  static const struct imx_i2c_hwdata imx1_i2c_hwdata =3D { @@ -583,23
> > +586,40 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >       imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);  }
> >
> > -static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> > +/* Clear interrupt flag bit */
> > +static void i2c_imx_clr_if_bit(struct imx_i2c_struct *i2c_imx)
> >  {
> > -     struct imx_i2c_struct *i2c_imx =3D dev_id;
> > -     unsigned int temp;
> > +     unsigned int status;
> >
> > -     temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > -     if (temp & I2SR_IIF) {
> > -             /* save status register */
> > -             i2c_imx->i2csr =3D temp;
> > -             temp &=3D ~I2SR_IIF;
> > -             temp |=3D (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > -             imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> > -             wake_up(&i2c_imx->queue);
> > -             return IRQ_HANDLED;
> > -     }
> > +     status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     status &=3D ~I2SR_IIF;
> > +     status |=3D (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > +     imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> > +
> > +/* Clear arbitration lost bit */
> > +static void i2c_imx_clr_al_bit(struct imx_i2c_struct *i2c_imx) {
> > +     unsigned int status;
> > +
> > +     status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     status &=3D ~I2SR_IAL;
> > +     imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> >
> > -     return IRQ_NONE;
> > +static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx)
> > +{
> > +     unsigned int status;
> > +
> > +     dev_dbg(&i2c_imx->adapter.dev, "<%s>: master interrupt\n",
> > + __func__);
>=20
> Generally this driver has way too many dev_dbg spread around in hot pathe=
s
> already. IMO adding more doesn't make the output more useful.
Ok, got it. I will delete it in v2.
>=20
> > +
> > +     /* Save status register */
> > +     status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     i2c_imx->i2csr =3D status | I2SR_IIF;
> > +
> > +     wake_up(&i2c_imx->queue);
> > +
> > +     return IRQ_HANDLED;
> >  }
> >
> >  static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx, @@
> > -1043,11 +1063,162 @@ static u32 i2c_imx_func(struct i2c_adapter
> *adapter)
> >               | I2C_FUNC_SMBUS_READ_BLOCK_DATA;  }
> >
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx) {
> > +     unsigned int temp;
> > +
> > +     dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > +
> > +     /* Set slave addr. */
> > +     imx_i2c_write_reg((i2c_imx->slave->addr << 1), i2c_imx,
> > + IMX_I2C_IADR);
> > +
> > +     /* Disable i2c module */
> > +     temp =3D i2c_imx->hwdata->i2cr_ien_opcode
> > +                     ^ I2CR_IEN;
>=20
> unnecessary line break.
Ok, no problem. I will remove the line break in v2.
>=20
> > +     imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +     /* Reset status register */
> > +     imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> > +                       IMX_I2C_I2SR);
> > +
> > +     /* Enable module and enable interrupt from i2c module */
> > +     temp =3D i2c_imx->hwdata->i2cr_ien_opcode
> > +                     | I2CR_IIEN;
>=20
> ditto.
Ok. I will remove the line break in v2.
>=20
> > +     imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +     /* Wait controller to be stable */
> > +     usleep_range(50, 150);
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
> > +
> > +     status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +     ctl =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +     if (status & I2SR_IAL) { /* Arbitration lost */
> > +             i2c_imx_clr_al_bit(i2c_imx);
> > +     } else if (status & I2SR_IAAS) { /* Addressed as a slave */
> > +             if (status & I2SR_SRW) { /* Master wants to read from us*=
/
> > +                     dev_dbg(&i2c_imx->adapter.dev, "read requested");
> > +                     i2c_slave_event(i2c_imx->slave,
> > + I2C_SLAVE_READ_REQUESTED, &value);
> > +
> > +                     /* Slave transimt */
>=20
> s/transimt/transmit/
You are right. I will correct it in v2.
>=20
> > +                     ctl |=3D I2CR_MTX;
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
> > +                     ctl &=3D ~I2CR_MTX;
> > +                     imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +                     /* Dummy read */
> > +                     value =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR)=
;
>=20
> value is unused, no need to assign a value to it.
Ok, I will correct this in v2.
>=20
> > +             }
> > +     } else {
> > +             if (!(ctl & I2CR_MTX)) { /* Receive mode */
>=20
> Since you have an 'else' path please convert this to positive logic.
> This makes it easier to read.
Ok,got it, I will convert this to positive logic in v2.
>=20
> > +                     if (status & I2SR_IBB) { /* No STOP signal detect=
ed
> */
> > +                             ctl &=3D ~I2CR_MTX;
> > +                             imx_i2c_write_reg(ctl, i2c_imx,
> > + IMX_I2C_I2CR);
> > +
> > +                             value =3D imx_i2c_read_reg(i2c_imx,
> IMX_I2C_I2DR);
> > +                             i2c_slave_event(i2c_imx->slave,
> I2C_SLAVE_WRITE_RECEIVED, &value);
> > +                     } else { /* STOP signal is detected */
> > +                             dev_dbg(&i2c_imx->adapter.dev,
> > +                                     "STOP signal detected");
> > +                             i2c_slave_event(i2c_imx->slave,
> I2C_SLAVE_STOP, &value);
> > +                     }
> > +             } else { /* Transmit mode */
> > +                     if (!(status & I2SR_RXAK)) {    /* Received ACK *=
/
>=20
> Same here.
Ok,got it, I will convert this to positive logic in v2.
>=20
> > +                             ctl |=3D I2CR_MTX;
> > +                             imx_i2c_write_reg(ctl, i2c_imx,
> > + IMX_I2C_I2CR);
> > +
> > +                             i2c_slave_event(i2c_imx->slave,
> > + I2C_SLAVE_READ_PROCESSED, &value);
> > +
> > +                             imx_i2c_write_reg(value, i2c_imx,
> IMX_I2C_I2DR);
> > +                     } else { /* Received NAK */
> > +                             ctl &=3D ~I2CR_MTX;
> > +                             imx_i2c_write_reg(ctl, i2c_imx,
> IMX_I2C_I2CR);
> > +                             value =3D imx_i2c_read_reg(i2c_imx,
> > + IMX_I2C_I2DR);
>=20
> Also value unused.
Ok,got it, I will correct this in v2.
>=20
> > +                     }
> > +             }
> > +     }
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int i2c_imx_reg_slave(struct i2c_client *client) {
> > +     struct imx_i2c_struct *i2c_imx =3D
> > +i2c_get_adapdata(client->adapter);
> > +
> > +     if (i2c_imx->slave)
> > +             return -EINVAL;
>=20
> Better -EBUSY?
Yes, you are right, I will correct it in v2.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cbiwen.li%40nxp.com%7C6741b4f5
> b14646209b6d08d71c0b46cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C637008707067019414&amp;sdata=3Db95HQ8KRhoLS8R%2BMWyaF
> FTo%2BOr9qqVM45nTn8OoboPg%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
