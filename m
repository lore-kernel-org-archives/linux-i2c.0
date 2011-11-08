From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 8 Nov 2011 16:41:16 +0200
Message-ID: <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> new file mode 100644
> index 0000000..e35479b
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -0,0 +1,442 @@
> +/*
> +
> +    i2c Support for Atmel's AT91 Two-Wire Interface (TWI)
> +
> +    Copyright (C) 2011 Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
> +
> +    Evolved from original work by:
> +    Copyright (C) 2004 Rick Bronson
> +    Converted to 2.6 by Andrew Victor <andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org>
> +
> +    Borrowed heavily from original work by:
> +    Copyright (C) 2000 Philip Edelbrock <phil-LT64U7CwzWEZMC/lefXSXFaTQe2KTcn/@public.gmane.org>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/at91_twi.h>
> +#include <mach/board.h>
> +#include <mach/cpu.h>

avoid including <mach/*> on drivers.

> +static void at91_set_twi_clock(struct at91_twi_dev *dev)
> +{
> +	unsigned long cdiv, ckdiv;
> +
> +	/* Calcuate clock dividers */
> +	cdiv =3D (clk_get_rate(dev->clk) / (2 * TWI_CLOCK)) - 3;
> +	cdiv =3D cdiv + 1;	/* round up */
> +	ckdiv =3D 0;
> +	while (cdiv > 255) {
> +		ckdiv++;
> +		cdiv =3D cdiv >> 1;
> +	}
> +
> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */

I don't think you should be using cpu_is_* on drivers.

> +static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> +{
> +	struct at91_twi_dev *dev =3D dev_id;
> +	const unsigned status =3D at91_twi_read(dev, AT91_TWI_SR);
> +	const unsigned irqstatus =3D status & at91_twi_read(dev, AT91_TWI_IMR);
> +
> +	if (irqstatus & AT91_TWI_TXCOMP) {
> +		at91_disable_twi_interrupts(dev);
> +		dev->transfer_status =3D status;
> +		complete(&dev->cmd_complete);
> +	}
> +	else if (irqstatus & AT91_TWI_RXRDY) {
> +		at91_twi_read_next_byte(dev);
> +	}
> +	else if (irqstatus & AT91_TWI_TXRDY) {
> +		at91_twi_write_next_byte(dev);
> +	}
> +	else {
> +		return IRQ_NONE;

coding style is wrong. Also, are those IRQ events really mutually
exclusive ??

> +static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, =
int num)
> +{
> +	struct at91_twi_dev *dev =3D i2c_get_adapdata(adap);
> +	int ret;
> +	unsigned int_addr_flag =3D 0;
> +	struct i2c_msg *m_start =3D msg;
> +
> +	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
> +
> +	/* the hardware can handle at most two messages concatenated by a
> +	 * repeated start via it's internal address feature.
> +	 */

wrong comment style.

--=20
balbi

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOuT+LAAoJEIaOsuA1yqREHO4QAJfspmosq655yzFLCI5keZpO
ZgugLNKOPz+Z4efxB9oYf6Arir5e39LrLyI7Id/j9JS8H56At5Aln0SGdW1C5Omm
tqHg6lGmXR3KB13ckdDQhZCiEgoTR3eXoAoCyxVrWNTklX7JgqBOH0uYkzUjZsui
vbbZXtvBZBmownee3ninb6w6tPH+RNThJYueLsrHGYLt3O+zxjtDjKoSJCGcb9kK
09sZ43zVafVqMP0YPVPuZsf9ovNfrsfrRtQMw5L1DCpFpgPfXrA7EuldkPAbYpIT
p6uHL25flGAGtlTriYGpZ5Ite2lucmKyggAJ1VMRBXthxcQFh6JKieNXdjC3Th0U
1crK9UfApO4mjRd0VnNvGL94vZkKDIPpbUBQKPGyg8RZkiSm9vcvffn9uYR3vjSb
xhHmjeu0MIbVubjKCSOE9drFGBKtMJ3jxxSw8+6+iiHfLR1++65ronZWzdK04R7X
vylsQtpHlRE+EjIa4xsFtaqNBWCUwp5pmNV1vNa7UULNEXnb/IpciA67fLpBFfsz
+YlqXj5vBHKlOgXUMi3a3keSTI15CW6OOk4Fpp8rbolZSpwbWIGS8aBHu9mb8Reh
tJI6/O9+xFrziqdA2qEmuqK00Md6SrA02NKF87yxDCB0muZFVGV5MXOmGwlvWp7p
tro5Xd0vbgkrHg+2oZI0
=ZHBt
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
