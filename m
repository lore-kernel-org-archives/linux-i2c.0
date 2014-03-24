From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Mon, 24 Mar 2014 18:01:31 +0100
Message-ID: <20140324170131.GB7524@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395414236-22647-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
> @@ -0,0 +1,34 @@
> +* Energymicro efm32 i2c controller
> +
> +Required properties :
> +
> + - reg : Offset and length of the register set for the device
> + - compatible : should be "efm32,i2c"

Ehrm, come to think of it, shouldn't that actually be "energymicro, efm32-i2c"
or similar to match the "vendor,product" pattern?

> +config I2C_EFM32
> +	tristate "EFM32 I2C controller"
> +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)

Is EFM32 DT only? Do we need the dependency on OF?

> +	help
> +	  This driver supports the i2c block found in Energy Micro's EFM32
> +	  SoCs.
> +

...

> +static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
> +{
> +	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];

Missing newline.

> +	if (ddata->current_word >= cur_msg->len) {
> +		/* cur_msg completely transferred */
> +		ddata->current_word = 0;
> +		ddata->current_msg += 1;
> +
> +		if (ddata->current_msg >= ddata->num_msgs) {
> +			efm32_i2c_write32(ddata, REG_CMD, REG_CMD_STOP);
> +			complete(&ddata->done);
> +		} else {
> +			efm32_i2c_send_next_msg(ddata);
> +		}
> +	} else {
> +		efm32_i2c_write32(ddata, REG_TXDATA,
> +				cur_msg->buf[ddata->current_word++]);
> +	}
> +}
> +

...


> +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> +		struct i2c_msg *msgs, int num)
> +{
> +	struct efm32_i2c_ddata *ddata = i2c_get_adapdata(adap);
> +	int ret;
> +
> +	if (ddata->msgs)
> +		return -EBUSY;
> +
> +	ddata->msgs = msgs;
> +	ddata->num_msgs = num;
> +	ddata->current_word = 0;
> +	ddata->current_msg = 0;
> +	ddata->retval = -EIO;
> +
> +	reinit_completion(&ddata->done);
> +
> +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> +			efm32_i2c_read32(ddata, REG_STATE),
> +			efm32_i2c_read32(ddata, REG_STATUS));
> +
> +	efm32_i2c_send_next_msg(ddata);
> +
> +	wait_for_completion(&ddata->done);
> +
> +	if (ddata->current_msg >= ddata->num_msgs)
> +		ret = ddata->num_msgs;
> +	else
> +		ret = ddata->retval;
> +
> +	ddata->msgs = NULL;

Setting NULL should not be needed?

> +
> +	return ret;
> +}
> +

And checkpatch said:

WARNING: braces {} are not necessary for any arm of this statement
#345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
+		if (cur_msg->flags & I2C_M_RD) {
...

Thanks,

   Wolfram


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMGTrAAoJEBQN5MwUoCm2tIUP/3dQVRr0JefR9P4uFdOn7msC
Glmr1VNGJZ98MtrsK0DuskmEW6o2eV8xhLEDUW+vWPtL6OjfiVtHkQPjMIGuzzMO
4mif+//zfanaH5RxFpN9Bicdm8XoO790rNtRT++A/K5p/ML6pjWimmcLw0M12Wux
sal8tvBo7Q7TBgK5HCiCIyG99AkG/lIe3CkKZCO3f973Wany5C/2sftThaGgYdJk
+iUYoBH+seulhMdFlHmASEmTQvEZnXgPh3KiMNKi5506QneCFZKknj7lE5tkUFvv
Io5UXghXz7a8VPd/tcHI0AYYzYYQgaMFiuzRM659w3Ll/vHJRTaeupBZ1efkJpfc
XOiqypfxSJHTNf5ruGDp7j5eCqzZJ7c84QKONlsRBrMsJuP3lQYCpMQcihLrp+l/
X7/bLy2py/yoYFK8AcnYjZyGWPIM70zESQ24afxDm6tj1+uTSkr8caYI/wCZ15pX
EkseG1xOUxi0OKcr7QFhaijXaeK3EQJtWEdE0fhaPztQ7iMKLKNPGQSYjjRbMOWU
8b63v/UFx2L1PD1q0wvu4SXiH/zgv+4Pr4idat5izSele6vm48uFZgTu9lHvc85m
BkHx8GhWoJl0RCXvqhDTrs9sH/fXyv2+Hc1sk4r3pVL0JmnJrzPtAySpQWQxf+ic
80LyqJjmEow7BGJnKqjG
=g+8r
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
