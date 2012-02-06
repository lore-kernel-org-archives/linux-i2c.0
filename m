From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Mon, 6 Feb 2012 10:14:57 +0800
Message-ID: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com> <20120205223757.GA10680@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120205223757.GA10680-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <ninja-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

hi Wolfram,
thanks for reviewing.

2012/2/6 Wolfram Sang <ninja-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>:
> Hi,
> On Sun, Jan 29, 2012 at 10:17:48PM +0800, Barry Song wrote:
>> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>>
>> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainlin=
e
>> 3.0.
>> There are two I2C controllers on primaII, features include:
>> * Two I2C controller modules are on chip
>> * RISC I/O bus read write register
>> * Up to 16 bytes data buffer for issuing commands and writing data
>> =C2=A0 at the same time
>> * Up to 16 commands, and receiving read data 16 bytes at a time
>> * Error INT report (ACK check)
>> * No-ACK bus protocols (SCCB bus protocols)
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>
> Thanks for your contribution! Is there a free datasheet for this cont=
roller
> available?

sorry. not available to public yet.

>
>> ---
>> =C2=A0-v5: don't disable already disabled clock as pointed out by Ru=
ssell
>>
>> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0| =C2=A0 10 +
>> =C2=A0drivers/i2c/busses/Makefile =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0drivers/i2c/busses/i2c-sirf.c | =C2=A0439 ++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0drivers/i2c/busses/i2c-sirf.h | =C2=A0 61 ++++++
>> =C2=A04 files changed, 511 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.c
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.h
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 3101dd5..a3c43fc 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -618,6 +618,16 @@ config I2C_SH_MOBILE
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a modul=
e. =C2=A0If so, the module
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called i2c-sh_mobile.
>>
>> +config I2C_SIRF
>> + =C2=A0 =C2=A0 tristate "CSR SiRFprimaII I2C interface"
>> + =C2=A0 =C2=A0 depends on ARCH_PRIMA2
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 If you say yes to this option, support will b=
e included for the
>> + =C2=A0 =C2=A0 =C2=A0 CSR SiRFprimaII I2C interface.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a module. =C2=
=A0If so, the module
>> + =C2=A0 =C2=A0 =C2=A0 will be called i2c-sirf.
>> +
>
> Sorting is broken, same with Makefile.

sorry. i don't get this. I2C_SIRF have be placed in "I2C system bus
drivers (mostly embedded / system-on-chip)" submenu and placed between
"I2C_SH_MOBILE" and "I2C_SIMTEC".
what is the problem?

>
>> =C2=A0config I2C_SIMTEC
>> =C2=A0 =C2=A0 =C2=A0 tristate "Simtec Generic I2C interface"
>> =C2=A0 =C2=A0 =C2=A0 select I2C_ALGOBIT
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index fba6da6..c30db66 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_S3C2410) =C2=A0 +=3D i2c-s3c2410.=
o
>> =C2=A0obj-$(CONFIG_I2C_S6000) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D i2c-s6000.o
>> =C2=A0obj-$(CONFIG_I2C_SH7760) =C2=A0 =C2=A0 +=3D i2c-sh7760.o
>> =C2=A0obj-$(CONFIG_I2C_SH_MOBILE) =C2=A0+=3D i2c-sh_mobile.o
>> +obj-$(CONFIG_I2C_SIRF) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +=3D i2c-sirf.o
>> =C2=A0obj-$(CONFIG_I2C_SIMTEC) =C2=A0 =C2=A0 +=3D i2c-simtec.o
>> =C2=A0obj-$(CONFIG_I2C_STU300) =C2=A0 =C2=A0 +=3D i2c-stu300.o
>> =C2=A0obj-$(CONFIG_I2C_TEGRA) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D i2c-tegra.o
>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-=
sirf.c
>> new file mode 100644
>> index 0000000..6432d35
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.c
>> @@ -0,0 +1,439 @@
>> +/*
>> + * I2C bus driver for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc gr=
oup company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +
>> +#include "i2c-sirf.h"
>> +
>> +#define SIRFSOC_I2C_DEFAULT_SPEED =C2=A0100000
>> +
>> +struct sirfsoc_i2c {
>> + =C2=A0 =C2=A0 void __iomem *base;
>> + =C2=A0 =C2=A0 struct clk *clk;
>> + =C2=A0 =C2=A0 unsigned long speed; =C2=A0 =C2=A0/* I2C SCL frequen=
cy */
>> + =C2=A0 =C2=A0 int irq;
>
> Do you really need those two?

irq can be deleted. speed is not really needed if you don't like.

>
>> + =C2=A0 =C2=A0 u32 cmd_ptr; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Current position in CMD buffer */
>> + =C2=A0 =C2=A0 u8 *buf; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Buffer passed by user */
>> + =C2=A0 =C2=A0 u32 msg_len; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Message length */
>> + =C2=A0 =C2=A0 u32 finished_len; =C2=A0 =C2=A0 =C2=A0 /* number of =
bytes read/written */
>> + =C2=A0 =C2=A0 u32 read_cmd_len; =C2=A0 =C2=A0 =C2=A0 /* number of =
read cmd sent */
>> + =C2=A0 =C2=A0 int msg_read; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
1 indicates a read message */
>> + =C2=A0 =C2=A0 int err_status; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 1 ind=
icates an error on bus */
>> +
>> + =C2=A0 =C2=A0 u32 sda_delay; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
=46or suspend/resume */
>> + =C2=A0 =C2=A0 u32 clk_div;
>> + =C2=A0 =C2=A0 int last; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Last message in transfer, STOP cmd can be sent */
>> +
>> + =C2=A0 =C2=A0 struct completion done; /* indicates completion of m=
essage transfer */
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter;
>
> Why a pointer and not the struct itself?

looks like most people use a struct directly, ok, we can move too.

>
>> +};
>> +
>> +static void i2c_sirfsoc_read_data(struct sirfsoc_i2c *siic)
>> +{
>> + =C2=A0 =C2=A0 u32 data =3D 0;
>> + =C2=A0 =C2=A0 int i =3D 0;
>
> it doesn't need to be initialized. data neither, but compilers fail o=
n that sometimes.
ok.

>
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < siic->read_cmd_len; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(i & 0x3))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 data =3D readl(siic->base + SIRFSOC_I2C_DATA_BUF + i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->buf[siic->finished=
_len++] =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned char)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SIRFSOC_I2C_DATA_SHIFT(i));
>
> buf is declared u8.

ok.
siic->buf[siic->finished_len++] =3D
                        (u8)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
                                SIRFSOC_I2C_DATA_SHIFT(i));

>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(siic->finished_le=
n > siic->msg_len);
>
> BUG? Can't we handle this more gracefully?

this should not have happened. if it happens, there is something wrong
in SW. actually, i can totally delete it.

>
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
>> +{
>> + =C2=A0 =C2=A0 u32 regval;
>> + =C2=A0 =C2=A0 int i =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (siic->msg_read) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (((siic->finished_=
len + i) < siic->msg_len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>
> Either use a different indentation for the above line or add a newlin=
e below.
> It is hard to see where the while() ends and the code block starts.

i just want to make sure what you want is:

             while (((siic->finished_len + i) < siic->msg_len)
                     &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)
                     ) {
?
or something else?

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 regval =3D SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (((siic->finished_len + i) =3D=3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (siic->msg_=
len - 1)) && siic->last)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval |=3D SIRFSOC_I2C_STOP | SIRFSOC_=
I2C_NACK;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 writel(regval,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C_CMD(siic->cmd_=
ptr++));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->read_cmd_len =3D i=
;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((siic->cmd_ptr < =
SIRFSOC_I2C_CMD_BUF_MAX - 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 && (siic->finished_len < siic->msg_len)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 regval =3D SIRFSOC_I2C_WRITE | SIRFSOC_I2C_CMD_RP(0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if ((siic->finished_len =3D=3D (siic->msg_len - 1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && siic->last)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval |=3D SIRFSOC_I2C_STOP;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 writel(regval,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C_CMD(siic->cmd_=
ptr++));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 writel(siic->buf[siic->finished_len++],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C_CMD(siic->cmd_=
ptr++));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 siic->cmd_ptr =3D 0;
>> +
>> + =C2=A0 =C2=A0 /* Trigger the transfer */
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_START_CMD, siic->base + SIRFSOC_I=
2C_CMD_START);
>> +}
>> +
>> +static irqreturn_t i2c_sirfsoc_irq(int irq, void *dev_id)
>> +{
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D (struct sirfsoc_i2c *)d=
ev_id;
>
> No need to cast.

ok.

>
>> + =C2=A0 =C2=A0 u32 i2c_stat =3D readl(siic->base + SIRFSOC_I2C_STAT=
US);
>> +
>> + =C2=A0 =C2=A0 if (i2c_stat & SIRFSOC_I2C_STAT_ERR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Error conditions */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->err_status =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_STAT_=
ERR, siic->base + SIRFSOC_I2C_STATUS);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_stat & SIRFSOC_I=
2C_STAT_NACK)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&siic->adapter->dev, "ACK not received\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&siic->adapter->dev, "I2C error\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 complete(&siic->done);
>> + =C2=A0 =C2=A0 } else if (i2c_stat & SIRFSOC_I2C_STAT_CMD_DONE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CMD buffer execution =
complete */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (siic->msg_read)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i2c_sirfsoc_read_data(siic);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (siic->finished_len =3D=
=3D siic->msg_len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 complete(&siic->done);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Fill a new CMD b=
uffer for left data */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i2c_sirfsoc_queue_cmd(siic);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_STAT_=
CMD_DONE, siic->base + SIRFSOC_I2C_STATUS);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
>> + =C2=A0 =C2=A0 struct i2c_msg *msg)
>> +{
>> + =C2=A0 =C2=A0 unsigned char addr;
>> + =C2=A0 =C2=A0 u32 regval =3D SIRFSOC_I2C_START | SIRFSOC_I2C_CMD_R=
P(0) | SIRFSOC_I2C_WRITE;
>> +
>> + =C2=A0 =C2=A0 /* no data and last message -> add STOP */
>> + =C2=A0 =C2=A0 if (siic->last && (msg->len =3D=3D 0))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval |=3D SIRFSOC_I2C_=
STOP;
>> +
>> + =C2=A0 =C2=A0 writel(regval, siic->base + SIRFSOC_I2C_CMD(siic->cm=
d_ptr++));
>> +
>> + =C2=A0 =C2=A0 addr =3D msg->addr << 1; =C2=A0/* Generate address *=
/
>> + =C2=A0 =C2=A0 if (msg->flags & I2C_M_RD)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D 1;
>> + =C2=A0 =C2=A0 if (msg->flags & I2C_M_REV_DIR_ADDR) =C2=A0 =C2=A0/*=
 Reverse direction bit */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr ^=3D 1;
>
> You don't support MANGLING according to .functionality().

ok.

>
>> +
>> + =C2=A0 =C2=A0 writel(addr, siic->base + SIRFSOC_I2C_CMD(siic->cmd_=
ptr++));
>> +}
>> +
>> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2=
c_msg *msg)
>> +{
>> + =C2=A0 =C2=A0 u32 regval =3D readl(siic->base + SIRFSOC_I2C_CTRL);
>> + =C2=A0 =C2=A0 int timeout =3D (msg->len + 1) * 50;
>
> That looks broken. What is 50 here?

just multiple of xfer bytes for defining a timeout. i might have a comm=
ent here.

>
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 i2c_sirfsoc_set_address(siic, msg);
>> +
>> + =C2=A0 =C2=A0 writel(regval | SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2=
C_ERR_INT_EN,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C=
_CTRL);
>> + =C2=A0 =C2=A0 i2c_sirfsoc_queue_cmd(siic);
>> +
>> + =C2=A0 =C2=A0 if (wait_for_completion_timeout(&siic->done, timeout=
) =3D=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->err_status =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&siic->adapter->=
dev, "Transfer timeout\n");
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 writel(regval & ~(SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_=
I2C_ERR_INT_EN),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C=
_CTRL);
>> + =C2=A0 =C2=A0 writel(0, siic->base + SIRFSOC_I2C_CMD_START);
>> +
>> + =C2=A0 =C2=A0 if (siic->err_status) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(readl(siic->base =
+ SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 siic->base + SIRFSOC_I2C_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (readl(siic->base =
+ SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cpu_relax();
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EIO;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
>> +{
>> + =C2=A0 =C2=A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static int i2c_sirfsoc_xfer(struct i2c_adapter *adap, struct i2c_ms=
g *msgs,
>> + =C2=A0 =C2=A0 int num)
>> +{
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adap->algo_data;
>> + =C2=A0 =C2=A0 int i, ret;
>> +
>> + =C2=A0 =C2=A0 clk_enable(siic->clk);
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < num; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->buf =3D msgs[i].bu=
f;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->msg_len =3D msgs[i=
].len;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msgs[i].flags & I2C_=
M_RD)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 siic->msg_read =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 siic->msg_read =3D 0;
>
> siic->msg_read =3D !!(flag & mask)?
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->err_status =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->cmd_ptr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->finished_len =3D 0=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D (num - 1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 siic->last =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 siic->last =3D 0;
>> +
>
> siic->last =3D i =3D=3D (num - 1)?

ok.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_sirfsoc_xfer=
_msg(siic, &msgs[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 return num;
>> +}
>> +
>> +/* I2C algorithms associated with this master controller driver */
>> +static const struct i2c_algorithm i2c_sirfsoc_algo =3D {
>> + =C2=A0 =C2=A0 .master_xfer =3D i2c_sirfsoc_xfer,
>> + =C2=A0 =C2=A0 .functionality =3D i2c_sirfsoc_func,
>> +};
>> +
>> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev=
)
>> +{
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic;
>> + =C2=A0 =C2=A0 struct i2c_adapter *new_adapter;
>> + =C2=A0 =C2=A0 struct resource *mem_res;
>> + =C2=A0 =C2=A0 struct clk *clk;
>> + =C2=A0 =C2=A0 int ctrl_speed;
>> +
>> + =C2=A0 =C2=A0 int err;
>> + =C2=A0 =C2=A0 u32 regval;
>> +
>> + =C2=A0 =C2=A0 clk =3D clk_get(&pdev->dev, NULL);
>> + =C2=A0 =C2=A0 if (IS_ERR(clk)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D PTR_ERR(clk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Clo=
ck get failed\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_get_clk;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 err =3D clk_prepare(clk);
>> + =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Clo=
ck prepare failed\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto =C2=A0err_clk_prep;
>
> Double space. Not only here.

ok. fix.

>
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 err =3D clk_enable(clk);
>> + =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Clo=
ck enable failed\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto =C2=A0err_clk_en;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ctrl_speed =3D clk_get_rate(clk);
>> +
>> + =C2=A0 =C2=A0 new_adapter =3D devm_kzalloc(&pdev->dev, sizeof(*new=
_adapter), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!new_adapter) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "Can't allocate new i2c adapter!\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 siic =3D devm_kzalloc(&pdev->dev, sizeof(*siic), GFP=
_KERNEL);
>> + =C2=A0 =C2=A0 if (!siic) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Can=
't allocate driver data\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 new_adapter->class =3D I2C_CLASS_HWMON | I2C_CLASS_D=
DC | I2C_CLASS_SPD;
>
> Do you really need the class?
>
>> + =C2=A0 =C2=A0 siic->adapter =3D new_adapter;
>> +
>> + =C2=A0 =C2=A0 mem_res =3D platform_get_resource(pdev, IORESOURCE_M=
EM, 0);
>> + =C2=A0 =C2=A0 if (mem_res =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Una=
ble to get MEM resource\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 siic->base =3D devm_request_and_ioremap(&pdev->dev, =
mem_res);
>> + =C2=A0 =C2=A0 if (siic->base =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "IO =
remap failed!\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 siic->irq =3D platform_get_irq(pdev, 0);
>> + =C2=A0 =C2=A0 if (siic->irq < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>
> return the error code here?

out lable will free resources and return error code.
out:
        clk_disable(clk);
err_clk_en:
        clk_unprepare(clk);
err_clk_prep:
        clk_put(clk);
err_get_clk:
        return err;

>
>> + =C2=A0 =C2=A0 err =3D devm_request_irq(&pdev->dev, siic->irq, i2c_=
sirfsoc_irq, 0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name(&pdev->dev), si=
ic);
>> + =C2=A0 =C2=A0 if (err)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> +
>> + =C2=A0 =C2=A0 new_adapter->algo =3D &i2c_sirfsoc_algo;
>> + =C2=A0 =C2=A0 new_adapter->algo_data =3D siic;
>> +
>> + =C2=A0 =C2=A0 new_adapter->dev.parent =3D &pdev->dev;
>> + =C2=A0 =C2=A0 new_adapter->nr =3D pdev->id;
>> +
>> + =C2=A0 =C2=A0 strlcpy(new_adapter->name, "sirfsoc-i2c", sizeof(new=
_adapter->name));
>> +
>> + =C2=A0 =C2=A0 platform_set_drvdata(pdev, new_adapter);
>> + =C2=A0 =C2=A0 init_completion(&siic->done);
>> +
>> + =C2=A0 =C2=A0 /* Controller Initalisation */
>> +
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_C=
TRL);
>> + =C2=A0 =C2=A0 while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSO=
C_I2C_RESET)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_relax();
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C=
_CTRL);
>> +
>> + =C2=A0 =C2=A0 siic->clk =3D clk;
>> + =C2=A0 =C2=A0 siic->speed =3D SIRFSOC_I2C_DEFAULT_SPEED;
>> + =C2=A0 =C2=A0 if (siic->speed < 100000)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (2 * ctrl_speed) / (2 * siic->speed * 11);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D ctrl_speed / =
(siic->speed * 5);
>> +
>> + =C2=A0 =C2=A0 writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + =C2=A0 =C2=A0 if (regval > 0xFF)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(0xFF, siic->base =
+ SIRFSOC_I2C_SDA_DELAY);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(regval, siic->bas=
e + SIRFSOC_I2C_SDA_DELAY);
>> +
>> + =C2=A0 =C2=A0 err =3D i2c_add_numbered_adapter(new_adapter);
>> + =C2=A0 =C2=A0 if (err < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "Can=
't add new i2c adapter\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 clk_disable(clk);
>> +
>> + =C2=A0 =C2=A0 dev_info(&pdev->dev, " I2C adapter ready to operate\=
n");
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +out:
>> + =C2=A0 =C2=A0 clk_disable(clk);
>> +err_clk_en:
>> + =C2=A0 =C2=A0 clk_unprepare(clk);
>> +err_clk_prep:
>> + =C2=A0 =C2=A0 clk_put(clk);
>> +err_get_clk:
>> + =C2=A0 =C2=A0 return err;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pde=
v)
>> +{
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_drvdata=
(pdev);
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_data;
>> +
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_C=
TRL);
>> + =C2=A0 =C2=A0 i2c_del_adapter(adapter);
>> + =C2=A0 =C2=A0 clk_unprepare(siic->clk);
>> + =C2=A0 =C2=A0 clk_put(siic->clk);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int i2c_sirfsoc_suspend(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform_device(=
dev);
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_drvdata=
(pdev);
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_data;
>> +
>> + =C2=A0 =C2=A0 clk_enable(siic->clk);
>> + =C2=A0 =C2=A0 siic->sda_delay =3D readl(siic->base + SIRFSOC_I2C_S=
DA_DELAY);
>> + =C2=A0 =C2=A0 siic->clk_div =3D readl(siic->base + SIRFSOC_I2C_CLK=
_CTRL);
>> + =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int i2c_sirfsoc_resume(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform_device(=
dev);
>> + =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_drvdata=
(pdev);
>> + =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_data;
>> +
>> + =C2=A0 =C2=A0 clk_enable(siic->clk);
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_C=
TRL);
>> + =C2=A0 =C2=A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC_I2C=
_CTRL);
>> + =C2=A0 =C2=A0 writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_C=
TRL);
>> + =C2=A0 =C2=A0 writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA=
_DELAY);
>> + =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops i2c_sirfsoc_pm_ops =3D {
>> + =C2=A0 =C2=A0 .suspend =3D i2c_sirfsoc_suspend,
>> + =C2=A0 =C2=A0 .resume =3D i2c_sirfsoc_resume,
>> +};
>> +#endif
>> +
>> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitco=
nst =3D {
>> + =C2=A0 =C2=A0 { .compatible =3D "sirf,prima2-i2c", },
>> + =C2=A0 =C2=A0 {},
>> +};
>
> Is the binding documented?

miss this. will add.

>
>> +MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
>> +
>> +static struct platform_driver i2c_sirfsoc_driver =3D {
>> + =C2=A0 =C2=A0 .driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "sirfsoc_i2c",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE,
>> +#ifdef CONFIG_PM
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =3D &i2c_sirfsoc_pm_=
ops,
>> +#endif
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D sirf=
soc_i2c_of_match,
>> + =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 .probe =3D i2c_sirfsoc_probe,
>> + =C2=A0 =C2=A0 .remove =3D __devexit_p(i2c_sirfsoc_remove),
>> +};
>> +
>> +static int __init i2c_sirfsoc_init(void)
>> +{
>> + =C2=A0 =C2=A0 return platform_driver_register(&i2c_sirfsoc_driver)=
;
>> +}
>> +arch_initcall(i2c_sirfsoc_init);
>> +
>> +static void __exit i2c_sirfsoc_exit(void)
>> +{
>> + =C2=A0 =C2=A0 platform_driver_unregister(&i2c_sirfsoc_driver);
>> +}
>> +module_exit(i2c_sirfsoc_exit);
>
> module_platform_driver()

ok.

>
>> +
>> +MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
>> +MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, "
>> + =C2=A0 =C2=A0 "Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/i2c/busses/i2c-sirf.h b/drivers/i2c/busses/i2c-=
sirf.h
>> new file mode 100644
>> index 0000000..28f4ada
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.h
>> @@ -0,0 +1,61 @@
>> +/*
>> + * I2C bus drivers for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc gr=
oup company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef _SIRFSOC_I2C_BUS_H_
>> +#define _SIRFSOC_I2C_BUS_H_
>> +
>> +#include <linux/bitops.h>
>> +
>> +#define SIRFSOC_I2C_CLK_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00
>> +#define SIRFSOC_I2C_STATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0C
>> +#define SIRFSOC_I2C_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x10
>> +#define SIRFSOC_I2C_IO_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14
>> +#define SIRFSOC_I2C_SDA_DELAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x18
>> +#define SIRFSOC_I2C_CMD_START =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x1C
>> +#define SIRFSOC_I2C_CMD_BUF =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x30
>> +#define SIRFSOC_I2C_DATA_BUF =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80
>> +
>> +#define SIRFSOC_I2C_CMD_BUF_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A016
>> +#define SIRFSOC_I2C_DATA_BUF_MAX =C2=A0 =C2=A0 16
>> +
>> +#define SIRFSOC_I2C_CMD(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (SIRF=
SOC_I2C_CMD_BUF + (x)*0x04)
>> +#define SIRFSOC_I2C_DATA_MASK(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xFF<<=
(((x)&3)*8))
>> +#define SIRFSOC_I2C_DATA_SHIFT(x) =C2=A0 =C2=A0 =C2=A0 (((x)&3)*8)
>> +
>> +#define SIRFSOC_I2C_DIV_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0xFFFF)
>> +
>> +/* I2C status flags */
>> +#define SIRFSOC_I2C_STAT_BUSY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(0)
>> +#define SIRFSOC_I2C_STAT_TIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)
>> +#define SIRFSOC_I2C_STAT_NACK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(2)
>> +#define SIRFSOC_I2C_STAT_TR_INT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(4)
>> +#define SIRFSOC_I2C_STAT_STOP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(6)
>> +#define SIRFSOC_I2C_STAT_CMD_DONE =C2=A0 =C2=A0BIT(8)
>> +#define SIRFSOC_I2C_STAT_ERR =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(9)
>> +#define SIRFSOC_I2C_CMD_INDEX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(0x1F<<16)
>> +
>> +/* I2C control flags */
>> +#define SIRFSOC_I2C_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(0)
>> +#define SIRFSOC_I2C_CORE_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(1=
)
>> +#define SIRFSOC_I2C_MASTER_MODE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(2)
>> +#define SIRFSOC_I2C_CMD_DONE_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(11)
>> +#define SIRFSOC_I2C_ERR_INT_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BIT(12)
>> +
>> +#define SIRFSOC_I2C_SDA_DELAY_MASK =C2=A0 (0xFF)
>> +#define SIRFSOC_I2C_SCLF_FILTER =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(3<<8)
>> +
>> +#define SIRFSOC_I2C_START_CMD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(0)
>> +
>> +#define SIRFSOC_I2C_CMD_RP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0((x)&0x7)
>> +#define SIRFSOC_I2C_NACK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
BIT(3)
>> +#define SIRFSOC_I2C_WRITE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(4)
>> +#define SIRFSOC_I2C_READ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
BIT(5)
>> +#define SIRFSOC_I2C_STOP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
BIT(6)
>> +#define SIRFSOC_I2C_START =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(7)
>> +
>> +#endif
>
> Regards,
>
> =C2=A0 Wolfram

-barry
