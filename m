From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH_V2 2/2] i2c: jz4780: Add i2c bus controller driver for
 Ingenic JZ4780
Date: Fri, 27 Mar 2015 21:16:53 +0100
Message-ID: <20150327201652.GA975@katana>
References: <1426084004-10364-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1426084004-10364-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426084004-10364-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

mostly looking good. checkpatch.pl --strict has some whitespaces and
continuation issues, please fix them.

And sparse rightfully says:

drivers/i2c/busses/i2c-jz4780.c:510:51: warning: cast truncates bits from c=
onstant value (100 becomes 0)

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 22da9c2..50b0c91 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -909,6 +909,15 @@ config I2C_RCAR
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-rcar.
> =20
> +config I2C_JZ4780
> +	tristate "JZ4780 I2C controller interface support"
> +	depends on MACH_JZ4780

|| COMPILE_TEST ?

> +	help
> +	 If you say yes to this option, support will be included for the
> +	 Ingenic JZ4780 I2C controller.
> +
> +	 If you don't know what to do here, say N.
> +

Sorting looks broken.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/time.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>

Please sort the includes, that prevents duplicates.

> +static inline unsigned short jz4780_i2c_readw(struct jz4780_i2c *i2c,
> +					unsigned long offset)
> +{
> +	return readw(i2c->iomem + offset);
> +}
> +
> +static inline void jz4780_i2c_writew(struct jz4780_i2c *i2c,
> +				     unsigned long offset, unsigned short val)
> +{
> +	writew(val, i2c->iomem + offset);
> +}

I don't think these functions add much compared to readw/writew, but you
can keep them if you really want.

> +			do {
> +				i2c_sta =3D jz4780_i2c_readw(i2c, JZ4780_I2C_STA);
> +				if ((i2c_sta & JZ4780_I2C_STA_TFNF)
> +					      && (i2c->wt_len > 0)) {
> +					data =3D *i2c->wbuf;
> +					data &=3D (~JZ4780_I2C_DC_READ);
> +					jz4780_i2c_writew(i2c, JZ4780_I2C_DC,
> +							  data);
> +					i2c->wbuf++;
> +					i2c->wt_len--;
> +				} else {
> +					break;
> +				}
> +			} while (1);

do/while(1) with else break;

That can be simplified with a while loop?

> +static void jz4780_i2c_txabrt(struct jz4780_i2c *i2c, int src)
> +{
> +	int i;
> +
> +	dev_err(&i2c->adap.dev, "txabrt: 0x%08x\n", src);
> +	dev_err(&i2c->adap.dev, "device addr=3D%x\n",
> +				  jz4780_i2c_readw(i2c, JZ4780_I2C_TAR));
> +	dev_err(&i2c->adap.dev, "send cmd count:%d  %d\n",
> +				  i2c->cmd, i2c->cmd_buf[i2c->cmd]);
> +	dev_err(&i2c->adap.dev, "receive data count:%d  %d\n",
> +				  i2c->cmd, i2c->data_buf[i2c->cmd]);
> +
> +	for (i =3D 0; i < 16; i++) {
> +		if (src & BIT(i))
> +			dev_info(&i2c->adap.dev, "I2C TXABRT[%d]=3D%s\n",
> +						 i, jz4780_i2c_abrt_src[i]);
> +	}

Isn't that more dev_dbg?

> +	if (!timeout) {
> +		dev_err(&i2c->adap.dev, "irq read timeout\n");
> +		dev_err(&i2c->adap.dev, "send cmd count:%d  %d\n",
> +					  i2c->cmd, i2c->cmd_buf[i2c->cmd]);
> +		dev_err(&i2c->adap.dev, "receive data count:%d  %d\n",
> +					  i2c->cmd, i2c->data_buf[i2c->cmd]);

Same here with the last two messages?

> +	if (msg->addr !=3D jz4780_i2c_readw(i2c, JZ4780_I2C_TAR)) {
> +		ret =3D jz4780_i2c_set_target(i2c, msg->addr);
> +		if (ret) {
> +			dev_err(&i2c->adap.dev, "I2C set target failed\n");
> +			goto out;
> +		}

set_target already has an error message. And set_target should return
some errno, not -1.

> +	}
> +	for (i =3D 0; i < count; i++, msg++) {
> +		if (msg->flags & I2C_M_RD)
> +			ret =3D jz4780_i2c_xfer_read(i2c, msg->buf, msg->len,
> +						   count, i);
> +		else
> +			ret =3D jz4780_i2c_xfer_write(i2c, msg->buf, msg->len,
> +						    count, i);
> +
> +		if (ret) {
> +			dev_err(&i2c->adap.dev, "I2C xfer failed\n");
> +			ret =3D -EAGAIN;

No use error codes like described in Documentation/i2c/fault-codes.
-EAGAIN has only one well defined meaning.

> +	i2c->adap.owner		=3D THIS_MODULE;
> +	i2c->adap.algo		=3D &jz4780_i2c_algorithm;
> +	i2c->adap.algo_data	=3D i2c;
> +	i2c->adap.timeout	=3D 5;

5 jiffies? That's probably not what you meant. Why not leave the
default?

Thanks,

   Wolfram


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFbq0AAoJEBQN5MwUoCm2qUYP/3lJ4dhODClVXm2oHXbDhtkb
7HjCilC+Pcz3t9hzsIWnMa8NfMQZ5beK+TfvruBvUJgpptDv2kDCHjkhIFBjmfCM
i390B91oV++S6Qm0IsptU3fA2Xs8fr7PfdJeBd0GQnyfup25EZQ+DC4RLIEBlEri
SdBrnGRGlRO+rop2f394df0l/0hHpM31jpOfYhAPlcsHuUZArlFl4zB86Is/HsHw
pKyhFjtLmfkAoWDm4iVtad4gFcdo3djqrNRi99/A9vNEZH7Yun73aLI2jnSXV+/K
f8m2kqpg6Zn0RdDPHY0rYA+bbFj9bUhjCyAL90Ja5RI1gR7X1RvQtgq5iZyo9Zwh
QtZaqfmugJijMHddq61NPFk3bXInYC87rtf5TV37k1y0bXhjT0uxqZtpGqB0P3iC
h8kRJJiHYXE7gNYqvAhDdPVfonbX4/HjzVXns3wOeqmiuLnqx+aCMwamhX7qj8K8
6POhqhZdm4yqnA0xM5W4T4c5IiLg1fs+Ca1p3+APjOzzdyPs40oVmERsA4eOdTsF
lldCVH8pV1AFPAsp3rjxFeDeQjzjIRNlf+XpzOfIHGBVxy3CLJSiMo6TVvmJ69+J
c3hSVeI9YLnEqhncF16qIBtnw52Mp0rQW4bAKPVh86/UMEglhXvM0chRvPhdpqmX
EszWACxo2nBcVsTK6AbA
=Xf8s
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
