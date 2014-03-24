From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Mon, 24 Mar 2014 19:41:14 +0100
Message-ID: <20140324184114.GK23076@pengutronix.de>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140324170131.GB7524@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
> > @@ -0,0 +1,34 @@
> > +* Energymicro efm32 i2c controller
> > +
> > +Required properties :
> > +
> > + - reg : Offset and length of the register set for the device
> > + - compatible : should be "efm32,i2c"
>=20
> Ehrm, come to think of it, shouldn't that actually be "energymicro, e=
fm32-i2c"
> or similar to match the "vendor,product" pattern?
yes.

>=20
> > +config I2C_EFM32
> > +	tristate "EFM32 I2C controller"
> > +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)
>=20
> Is EFM32 DT only? Do we need the dependency on OF?
yes, efm32 is DT only. Still for the COMPILE_TEST branch the OF is
needed.
=20
> > +	help
> > +	  This driver supports the i2c block found in Energy Micro's EFM3=
2
> > +	  SoCs.
> > +
>=20
> ...
>=20
> > +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> > +		struct i2c_msg *msgs, int num)
> > +{
> > +	struct efm32_i2c_ddata *ddata =3D i2c_get_adapdata(adap);
> > +	int ret;
> > +
> > +	if (ddata->msgs)
> > +		return -EBUSY;
> > +
> > +	ddata->msgs =3D msgs;
> > +	ddata->num_msgs =3D num;
> > +	ddata->current_word =3D 0;
> > +	ddata->current_msg =3D 0;
> > +	ddata->retval =3D -EIO;
> > +
> > +	reinit_completion(&ddata->done);
> > +
> > +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> > +			efm32_i2c_read32(ddata, REG_STATE),
> > +			efm32_i2c_read32(ddata, REG_STATUS));
> > +
> > +	efm32_i2c_send_next_msg(ddata);
> > +
> > +	wait_for_completion(&ddata->done);
> > +
> > +	if (ddata->current_msg >=3D ddata->num_msgs)
> > +		ret =3D ddata->num_msgs;
> > +	else
> > +		ret =3D ddata->retval;
> > +
> > +	ddata->msgs =3D NULL;
>=20
> Setting NULL should not be needed?
Right, that's a left over from the locking stuff.
=20
> > +
> > +	return ret;
> > +}
> > +
>=20
> And checkpatch said:
>=20
> WARNING: braces {} are not necessary for any arm of this statement
> #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> +		if (cur_msg->flags & I2C_M_RD) {
> ...
ok.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
