From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
Date: Fri, 9 Aug 2019 03:18:01 +0000
Message-ID: <VI1PR04MB4495EA1A44120654B494EB3D8FD60@VI1PR04MB4495.eurprd04.prod.outlook.com>
References: <20190808035343.34120-1-biwen.li@nxp.com>
 <20190808200202.GA6609@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808200202.GA6609@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Joshua Frkuska <joshua_frkuska@mentor.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

> > The patch supports slave mode for imx I2C driver
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
>=20
> Wow, this is much simpler than the other approach flying around:
>=20
> http://patchwork.ozlabs.org/patch/1124048/
>=20
> Can this one be master and slave on the same bus, too?
At the same time, the same bus is in master mode or slave mode.
>=20
> CCing the author of the other patch.
>=20
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
> >  	struct pinctrl_state *pinctrl_pins_gpio;
> >
> >  	struct imx_i2c_dma	*dma;
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +	struct i2c_client		*slave;
> > +#endif /* CONFIG_I2C_SLAVE */
> >  };
> >
> >  static const struct imx_i2c_hwdata imx1_i2c_hwdata =3D { @@ -583,23
> > +586,40 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);  }
> >
> > -static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> > +/* Clear interrupt flag bit */
> > +static void i2c_imx_clr_if_bit(struct imx_i2c_struct *i2c_imx)
> >  {
> > -	struct imx_i2c_struct *i2c_imx =3D dev_id;
> > -	unsigned int temp;
> > +	unsigned int status;
> >
> > -	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > -	if (temp & I2SR_IIF) {
> > -		/* save status register */
> > -		i2c_imx->i2csr =3D temp;
> > -		temp &=3D ~I2SR_IIF;
> > -		temp |=3D (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > -		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> > -		wake_up(&i2c_imx->queue);
> > -		return IRQ_HANDLED;
> > -	}
> > +	status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +	status &=3D ~I2SR_IIF;
> > +	status |=3D (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> > +	imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> > +
> > +/* Clear arbitration lost bit */
> > +static void i2c_imx_clr_al_bit(struct imx_i2c_struct *i2c_imx) {
> > +	unsigned int status;
> > +
> > +	status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +	status &=3D ~I2SR_IAL;
> > +	imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR); }
> >
> > -	return IRQ_NONE;
> > +static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx)
> > +{
> > +	unsigned int status;
> > +
> > +	dev_dbg(&i2c_imx->adapter.dev, "<%s>: master interrupt\n",
> > +__func__);
> > +
> > +	/* Save status register */
> > +	status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +	i2c_imx->i2csr =3D status | I2SR_IIF;
> > +
> > +	wake_up(&i2c_imx->queue);
> > +
> > +	return IRQ_HANDLED;
> >  }
> >
> >  static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx, @@
> > -1043,11 +1063,162 @@ static u32 i2c_imx_func(struct i2c_adapter
> *adapter)
> >  		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> >  }
> >
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx) {
> > +	unsigned int temp;
> > +
> > +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > +
> > +	/* Set slave addr. */
> > +	imx_i2c_write_reg((i2c_imx->slave->addr << 1), i2c_imx,
> > +IMX_I2C_IADR);
> > +
> > +	/* Disable i2c module */
> > +	temp =3D i2c_imx->hwdata->i2cr_ien_opcode
> > +			^ I2CR_IEN;
> > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +	/* Reset status register */
> > +	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> > +			  IMX_I2C_I2SR);
> > +
> > +	/* Enable module and enable interrupt from i2c module */
> > +	temp =3D i2c_imx->hwdata->i2cr_ien_opcode
> > +			| I2CR_IIEN;
> > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +	/* Wait controller to be stable */
> > +	usleep_range(50, 150);
> > +}
> > +
> > +static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx)
> > +{
> > +	unsigned int status, ctl;
> > +	u8 value;
> > +
> > +	if (!i2c_imx->slave) {
> > +		dev_err(&i2c_imx->adapter.dev, "cannot deal with slave
> irq,i2c_imx->slave is null");
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +	ctl =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +	if (status & I2SR_IAL) { /* Arbitration lost */
> > +		i2c_imx_clr_al_bit(i2c_imx);
> > +	} else if (status & I2SR_IAAS) { /* Addressed as a slave */
> > +		if (status & I2SR_SRW) { /* Master wants to read from us*/
> > +			dev_dbg(&i2c_imx->adapter.dev, "read requested");
> > +			i2c_slave_event(i2c_imx->slave, I2C_SLAVE_READ_REQUESTED,
> &value);
> > +
> > +			/* Slave transimt */
> > +			ctl |=3D I2CR_MTX;
> > +			imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +
> > +			/* Send data */
> > +			imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> > +		} else { /* Master wants to write to us */
> > +			dev_dbg(&i2c_imx->adapter.dev, "write requested");
> > +			i2c_slave_event(i2c_imx->slave,
> 	I2C_SLAVE_WRITE_REQUESTED, &value);
> > +
> > +			/* Slave receive */
> > +			ctl &=3D ~I2CR_MTX;
> > +			imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +			/* Dummy read */
> > +			value =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > +		}
> > +	} else {
> > +		if (!(ctl & I2CR_MTX)) { /* Receive mode */
> > +			if (status & I2SR_IBB) { /* No STOP signal detected */
> > +				ctl &=3D ~I2CR_MTX;
> > +				imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +
> > +				value =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > +				i2c_slave_event(i2c_imx->slave,
> 	I2C_SLAVE_WRITE_RECEIVED, &value);
> > +			} else { /* STOP signal is detected */
> > +				dev_dbg(&i2c_imx->adapter.dev,
> > +					"STOP signal detected");
> > +				i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &value);
> > +			}
> > +		} else { /* Transmit mode */
> > +			if (!(status & I2SR_RXAK)) {	/* Received ACK */
> > +				ctl |=3D I2CR_MTX;
> > +				imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +
> > +				i2c_slave_event(i2c_imx->slave,
> 	I2C_SLAVE_READ_PROCESSED, &value);
> > +
> > +				imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> > +			} else { /* Received NAK */
> > +				ctl &=3D ~I2CR_MTX;
> > +				imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> > +				value =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > +			}
> > +		}
> > +	}
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int i2c_imx_reg_slave(struct i2c_client *client) {
> > +	struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(client->adapter);
> > +
> > +	if (i2c_imx->slave)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > +	i2c_imx->slave =3D client;
> > +
> > +	i2c_imx_slave_init(i2c_imx);
> > +
> > +	return 0;
> > +}
> > +
> > +static int i2c_imx_unreg_slave(struct i2c_client *client) {
> > +	struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(client->adapter);
> > +
> > +	if (!i2c_imx->slave)
> > +		return -EINVAL;
> > +
> > +	i2c_imx->slave =3D NULL;
> > +
> > +	return 0;
> > +}
> > +#endif /* CONFIG_I2C_SLAVE */
> > +
> >  static const struct i2c_algorithm i2c_imx_algo =3D {
> >  	.master_xfer	=3D i2c_imx_xfer,
> >  	.functionality	=3D i2c_imx_func,
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +	.reg_slave	=3D i2c_imx_reg_slave,
> > +	.unreg_slave	=3D i2c_imx_unreg_slave,
> > +#endif /* CONFIG_I2C_SLAVE */
> >  };
> >
> > +static irqreturn_t i2c_imx_isr(int irq, void *dev_id) {
> > +	struct imx_i2c_struct *i2c_imx =3D dev_id;
> > +	unsigned int status, ctl;
> > +	irqreturn_t irq_status =3D IRQ_NONE;
> > +
> > +	status =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +	ctl =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +
> > +	if (status & I2SR_IIF) {
> > +		i2c_imx_clr_if_bit(i2c_imx);
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > +		if (ctl & I2CR_MSTA)
> > +			irq_status =3D i2c_imx_master_isr(i2c_imx);
> > +		else
> > +			irq_status =3D i2c_imx_slave_isr(i2c_imx); #else
> > +		irq_status =3D i2c_imx_master_isr(i2c_imx);
> > +
> > +#endif /* CONFIG_I2C_SLAVE */
> > +	}
> > +
> > +	return irq_status;
> > +}
> > +
> >  static int i2c_imx_probe(struct platform_device *pdev)  {
> >  	const struct of_device_id *of_id =3D of_match_device(i2c_imx_dt_ids,
> > --
> > 2.17.1
> >
