From: Po-Yu Chuang <ratbert.chuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: add Faraday FTIIC010 I2C controller support
Date: Wed, 29 Jun 2011 14:39:38 +0800
Message-ID: <BANLkTinHsg1FWRdAE2dxsJ6Shxrh7+HUeA@mail.gmail.com>
References: <1308032369-1615-1-git-send-email-ratbert.chuang@gmail.com> <20110627215955.GA23027@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110627215955.GA23027-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, Jun 28, 2011 at 5:59 AM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Tue, Jun 14, 2011 at 02:19:29PM +0800, Po-Yu Chuang wrote:
>> From: Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
>>
>> Support for Faraday FTIIC010 I2C controller. It is used on
>> Faraday A320, A369 and some other ARM SoC's.
>>
>> Signed-off-by: Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
>> ---
>> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A07 +
>> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
1 +
>> =C2=A0drivers/i2c/busses/i2c-ftiic010.c | =C2=A0434 ++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0drivers/i2c/busses/i2c-ftiic010.h | =C2=A0155 +++++++++++++
>> =C2=A04 files changed, 597 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-ftiic010.c
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-ftiic010.h
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 326652f..612c2b1 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -358,6 +358,13 @@ config I2C_DESIGNWARE
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a modul=
e. =C2=A0If so, the module
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called i2c-designware.
>>
>> +config I2C_FTIIC010
>> + =C2=A0 =C2=A0 tristate "Faraday FTIIC010 I2C controller"
>> + =C2=A0 =C2=A0 depends on HAVE_CLK
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Support for Faraday FTIIC010 I2C controller. =
It is used on
>> + =C2=A0 =C2=A0 =C2=A0 Faraday A320, A369 and some other ARM SoC's.
>> +
>
> is there a better depends line for this? is there an ARCH_xxx or some
> other way of ensuring this doesn't get shown for all systems that
> happen to support CLK?

OK, will fix this.

>
>> =C2=A0config I2C_GPIO
>> =C2=A0 =C2=A0 =C2=A0 tristate "GPIO-based bitbanging I2C"
>> =C2=A0 =C2=A0 =C2=A0 depends on GENERIC_GPIO
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index e6cf294..c49570d 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -34,6 +34,7 @@ obj-$(CONFIG_I2C_BLACKFIN_TWI) =C2=A0 =C2=A0 =C2=A0=
+=3D i2c-bfin-twi.o
>> =C2=A0obj-$(CONFIG_I2C_CPM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+=3D i2c-cpm.o
>> =C2=A0obj-$(CONFIG_I2C_DAVINCI) =C2=A0 =C2=A0+=3D i2c-davinci.o
>> =C2=A0obj-$(CONFIG_I2C_DESIGNWARE) +=3D i2c-designware.o
>> +obj-$(CONFIG_I2C_FTIIC010) =C2=A0 +=3D i2c-ftiic010.o
>> =C2=A0obj-$(CONFIG_I2C_GPIO) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D i2c-gpio.o
>> =C2=A0obj-$(CONFIG_I2C_HIGHLANDER) +=3D i2c-highlander.o
>> =C2=A0obj-$(CONFIG_I2C_IBM_IIC) =C2=A0 =C2=A0+=3D i2c-ibm_iic.o
>> diff --git a/drivers/i2c/busses/i2c-ftiic010.c b/drivers/i2c/busses/=
i2c-ftiic010.c
>> new file mode 100644
>> index 0000000..ed86f06
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-ftiic010.c
>> @@ -0,0 +1,434 @@
>> +/*
>> + * Faraday FTIIC010 I2C Controller
>> + *
>> + * (C) Copyright 2010-2011 Faraday Technology
>> + * Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See t=
he
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include "i2c-ftiic010.h"
>> +
>> +#define SCL_SPEED =C2=A0 =C2=A0(100 * 1000)
>> +#define MAX_RETRY =C2=A0 =C2=A01000
>> +
>> +#define GSR =C2=A05
>> +#define TSR =C2=A05
>> +
>> +struct ftiic010 {
>> + =C2=A0 =C2=A0 struct resource *res;
>> + =C2=A0 =C2=A0 void __iomem *base;
>> + =C2=A0 =C2=A0 int irq;
>> + =C2=A0 =C2=A0 struct clk *clk;
>> + =C2=A0 =C2=A0 struct i2c_adapter adapter;
>> +};
>> +
>> +/******************************************************************=
************
>> + * internal functions
>> + ******************************************************************=
***********/
>> +static void ftiic010_reset(struct ftiic010 *ftiic010)
>> +{
>> + =C2=A0 =C2=A0 int cr =3D FTIIC010_CR_I2C_RST;
>> +
>> + =C2=A0 =C2=A0 iowrite32(cr, ftiic010->base + FTIIC010_OFFSET_CR);
>> +
>> + =C2=A0 =C2=A0 /* wait until reset bit cleared by hw */
>> + =C2=A0 =C2=A0 while (ioread32(ftiic010->base + FTIIC010_OFFSET_CR)=
 & FTIIC010_CR_I2C_RST)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;
>
> how about calls to cpu_relax() during these loops?
> also, do we ever expect timeout?

OK, will fix this.

>
>> +}
>
> I think iowrite32/ioread32 are ok on these.

Not sure what do you mean here.

>> +
>> +static void ftiic010_set_clock_speed(struct ftiic010 *ftiic010, int=
 hz)
>> +{
>> + =C2=A0 =C2=A0 unsigned long pclk;
>> + =C2=A0 =C2=A0 int cdr;
>> +
>> + =C2=A0 =C2=A0 pclk =3D clk_get_rate(ftiic010->clk);
>> +
>> + =C2=A0 =C2=A0 cdr =3D (pclk / hz - GSR) / 2 - 2;
>> + =C2=A0 =C2=A0 cdr &=3D FTIIC010_CDR_MASK;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&ftiic010->adapter.dev, " =C2=A0[CDR] =3D %0=
8x\n", cdr);
>> + =C2=A0 =C2=A0 iowrite32(cdr, ftiic010->base + FTIIC010_OFFSET_CDR)=
;
>> +}
>> +
>> +static void ftiic010_set_tgsr(struct ftiic010 *ftiic010, int tsr, i=
nt gsr)
>> +{
>> + =C2=A0 =C2=A0 int tgsr;
>> +
>> + =C2=A0 =C2=A0 tgsr =3D FTIIC010_TGSR_TSR(tsr);
>> + =C2=A0 =C2=A0 tgsr |=3D FTIIC010_TGSR_GSR(gsr);
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&ftiic010->adapter.dev, " =C2=A0[TGSR] =3D %=
08x\n", tgsr);
>> + =C2=A0 =C2=A0 iowrite32(tgsr, ftiic010->base + FTIIC010_OFFSET_TGS=
R);
>> +}
>> +
>> +static void ftiic010_hw_init(struct ftiic010 *ftiic010)
>> +{
>> + =C2=A0 =C2=A0 ftiic010_reset(ftiic010);
>> + =C2=A0 =C2=A0 ftiic010_set_tgsr(ftiic010, TSR, GSR);
>> + =C2=A0 =C2=A0 ftiic010_set_clock_speed(ftiic010, SCL_SPEED);
>> +}
>> +
>> +static inline void ftiic010_set_cr(struct ftiic010 *ftiic010, int s=
tart,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int stop, int nak)
>> +{
>> + =C2=A0 =C2=A0 int cr;
>> +
>> + =C2=A0 =C2=A0 cr =3D FTIIC010_CR_I2C_EN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0| FTIIC010_CR_SCL_EN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0| FTIIC010_CR_TB_EN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0| FTIIC010_CR_BERRI_EN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0| FTIIC010_CR_ALI_EN;
>> +
>> + =C2=A0 =C2=A0 if (start)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cr |=3D FTIIC010_CR_STAR=
T;
>> +
>> + =C2=A0 =C2=A0 if (stop)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cr |=3D FTIIC010_CR_STOP=
;
>> +
>> + =C2=A0 =C2=A0 if (nak)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cr |=3D FTIIC010_CR_NAK;
>> +
>> + =C2=A0 =C2=A0 iowrite32(cr, ftiic010->base + FTIIC010_OFFSET_CR);
>> +}
>> +
>> +static int ftiic010_tx_byte(struct ftiic010 *ftiic010, __u8 data, i=
nt start,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int stop)
>> +{
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D &ftiic010->adapter;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 iowrite32(data, ftiic010->base + FTIIC010_OFFSET_DR)=
;
>> + =C2=A0 =C2=A0 ftiic010_set_cr(ftiic010, start, stop, 0);
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < MAX_RETRY; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int status;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ioread32(ftii=
c010->base + FTIIC010_OFFSET_SR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status & FTIIC010_SR=
_DT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 dev_err(&adapter->dev, "Failed to transmit\n");
>> + =C2=A0 =C2=A0 ftiic010_reset(ftiic010);
>> + =C2=A0 =C2=A0 return -EIO;
>> +}
>> +
>> +static int ftiic010_rx_byte(struct ftiic010 *ftiic010, int stop, in=
t nak)
>> +{
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D &ftiic010->adapter;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 ftiic010_set_cr(ftiic010, 0, stop, nak);
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < MAX_RETRY; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int status;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ioread32(ftii=
c010->base + FTIIC010_OFFSET_SR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status & FTIIC010_SR=
_DR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ioread32(ftiic010->base + FTIIC010_OFFSET_DR)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & FTIIC010_DR_MASK;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 dev_err(&adapter->dev, "Failed to receive\n");
>> + =C2=A0 =C2=A0 ftiic010_reset(ftiic010);
>> + =C2=A0 =C2=A0 return -EIO;
>> +}
>> +
>> +static int ftiic010_tx_msg(struct ftiic010 *ftiic010,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msg, int=
 last)
>> +{
>> + =C2=A0 =C2=A0 __u8 data;
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 data =3D (msg->addr & 0x7f) << 1;
>> + =C2=A0 =C2=A0 ret =3D ftiic010_tx_byte(ftiic010, data, 1, 0);
>> + =C2=A0 =C2=A0 if (ret < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < msg->len; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int stop =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (last && i + 1 =3D=3D=
 msg->len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 stop =3D 1;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ftiic010_tx_byte=
(ftiic010, msg->buf[i], 0, stop);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int ftiic010_rx_msg(struct ftiic010 *ftiic010,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msg, int=
 last)
>> +{
>> + =C2=A0 =C2=A0 __u8 data;
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 data =3D (msg->addr & 0x7f) << 1 | 1;
>> + =C2=A0 =C2=A0 ret =3D ftiic010_tx_byte(ftiic010, data, 1, 0);
>> + =C2=A0 =C2=A0 if (ret < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < msg->len; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nak =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i + 1 =3D=3D msg->le=
n)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 nak =3D 1;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ftiic010_rx_byte=
(ftiic010, last, nak);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg->buf[i] =3D ret;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int ftiic010_do_msg(struct ftiic010 *ftiic010,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msg, int=
 last)
>> +{
>> + =C2=A0 =C2=A0 if (msg->flags & I2C_M_RD)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ftiic010_rx_msg(f=
tiic010, msg, last);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ftiic010_tx_msg(f=
tiic010, msg, last);
>> +}
>
> maybe this could be merged into the parent.

Do you mean merge the content of this function into ftiic010_master_xfe=
r?
Well, I prefer the current small function.

>
> is there any way of using the interrupt handler to do the
> actual transfers, this seems to involve a lot of busy-waiting
> for the hardware.

Originally I used interrupt-driven data transfer, but some users told m=
e that
the latency of interrupt handling is too long for their application.
That's why I use polling now...

>
>> +/******************************************************************=
************
>> + * interrupt handler
>> + ******************************************************************=
***********/
>> +static irqreturn_t ftiic010_interrupt(int irq, void *dev_id)
>> +{
>> + =C2=A0 =C2=A0 struct ftiic010 *ftiic010 =3D dev_id;
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D &ftiic010->adapter;
>> + =C2=A0 =C2=A0 int sr;
>> +
>> + =C2=A0 =C2=A0 sr =3D ioread32(ftiic010->base + FTIIC010_OFFSET_SR)=
;
>> +
>> + =C2=A0 =C2=A0 if (sr & FTIIC010_SR_BERR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&adapter->dev, "=
NAK!\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ftiic010_reset(ftiic010)=
;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (sr & FTIIC010_SR_AL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&adapter->dev, "=
arbitration lost!\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ftiic010_reset(ftiic010)=
;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +/******************************************************************=
************
>> + * struct i2c_algorithm functions
>> + ******************************************************************=
***********/
>> +static int ftiic010_master_xfer(struct i2c_adapter *adapter,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msgs, in=
t num)
>> +{
>> + =C2=A0 =C2=A0 struct ftiic010 *ftiic010 =3D i2c_get_adapdata(adapt=
er);
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < num; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int last =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D num - 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 last =3D 1;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ftiic010_do_msg(=
ftiic010, &msgs[i], last);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return num;
>> +}
>> +
>> +static u32 ftiic010_functionality(struct i2c_adapter *adapter)
>> +{
>> + =C2=A0 =C2=A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static struct i2c_algorithm ftiic010_algorithm =3D {
>> + =C2=A0 =C2=A0 .master_xfer =C2=A0 =C2=A0=3D ftiic010_master_xfer,
>> + =C2=A0 =C2=A0 .functionality =C2=A0=3D ftiic010_functionality,
>> +};
>> +
>> +/******************************************************************=
************
>> + * struct platform_driver functions
>> + ******************************************************************=
***********/
>> +static int ftiic010_probe(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 struct ftiic010 *ftiic010;
>> + =C2=A0 =C2=A0 struct resource *res;
>> + =C2=A0 =C2=A0 struct clk *clk;
>> + =C2=A0 =C2=A0 int irq;
>> + =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
>> + =C2=A0 =C2=A0 if (!res)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
>
> error message, -ENXIO IIRC gets silently discarded by the bus
> layer.

OK, will add it.

>
>> +
>> + =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
>> + =C2=A0 =C2=A0 if (irq < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return irq;
>
> error print would be useful.

OK

>
>> + =C2=A0 =C2=A0 ftiic010 =3D kzalloc(sizeof(*ftiic010), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!ftiic010) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Cou=
ld not allocate private data\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_alloc;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ftiic010->res =3D request_mem_region(res->start, res=
ource_size(res),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
dev_name(&pdev->dev));
>> + =C2=A0 =C2=A0 if (!ftiic010->res) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Cou=
ld not reserve memory region\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_req_mem;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ftiic010->base =3D ioremap(res->start, resource_size=
(res));
>> + =C2=A0 =C2=A0 if (!ftiic010->base) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Fai=
led to ioremap\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ioremap;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ret =3D request_irq(irq, ftiic010_interrupt, IRQF_SH=
ARED, pdev->name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ftiic010);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Fai=
led to request irq %d\n", irq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_req_irq;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ftiic010->irq =3D irq;
>> +
>> + =C2=A0 =C2=A0 clk =3D clk_get(NULL, "pclk");
>> + =C2=A0 =C2=A0 if (!clk) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Fai=
led to get pclk\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;
>> + =C2=A0 =C2=A0 }
>
> do you really need a named clock? sounds like the clk_ usage on
> this platform needs some work to it.

Let me think about this.

[snip]

Thanks for your review.
I will fix the mentioned issues and resubmit later.

Best regards,
Po-Yu Chuang
