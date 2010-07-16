From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] i2c/nuc900: add i2c driver support for nuc900
Date: Fri, 16 Jul 2010 11:24:21 +0800
Message-ID: <AANLkTimwIomoGV1M-0fxpSqB5UUraCsqLJGzA5Pn8lTv@mail.gmail.com>
References: <4C2441EB.8090609@gmail.com>
	<AANLkTinlGTebx8zNc_AGni_5pkTEnNf-lrVebd3YcdGk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinlGTebx8zNc_AGni_5pkTEnNf-lrVebd3YcdGk@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
List-Id: linux-i2c@vger.kernel.org

How about this patch?
Which tree can merge it?

2010/6/28 Wan ZongShun <mcuos.com@gmail.com>:
> Hi Ben,
>
> How about this patch? Can it be applied?
>
> Thanks!
>
>> This patch is to add i2c driver support for nuc900.
>>
>> v1->v2 changes:
>> Address the comments of Ben Dooks
>>
>> (1) Document registers Macro definitions.
>> (1) Modify some documents apply to kernel doc style.
>> (2) clk_get shouldn't need the second argument, so remove it.
>> (3) clk_get_rate() should be used.
>> (5) Add irq IRQF_SHARED flag.
>> (6) change i2s_nuc900_irq_nextbyte() declaration type from 'int' to =
'void'
>> =C2=A0 =C2=A0it does not need return value.
>> (7) To enable irq easier.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
>> Reviewed-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> =C2=A0arch/arm/mach-w90x900/include/mach/i2c.h | =C2=A0 =C2=A09 +
>> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A07 +
>> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/i2c/busses/i2c-nuc900.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0709 ++++++++++++++++++++++++++++++
>> =C2=A04 files changed, 726 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 arch/arm/mach-w90x900/include/mach/i2c.h
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-nuc900.c
>>
>> diff --git a/arch/arm/mach-w90x900/include/mach/i2c.h b/arch/arm/mac=
h-w90x900/include/mach/i2c.h
>> new file mode 100644
>> index 0000000..9ffb12d
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/include/mach/i2c.h
>> @@ -0,0 +1,9 @@
>> +#ifndef __ASM_ARCH_NUC900_I2C_H
>> +#define __ASM_ARCH_NUC900_I2C_H
>> +
>> +struct nuc900_platform_i2c {
>> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 bus_num;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=A0 bus_freq;
>> +};
>> +
>> +#endif /* __ASM_ARCH_NUC900_I2C_H */
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index bceafbf..ee284d2 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -448,6 +448,13 @@ config I2C_NOMADIK
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes to this option, sup=
port will be included for the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I2C interface from ST-Ericsson's N=
omadik and Ux500 architectures.
>>
>> +config I2C_NUC900
>> + =C2=A0 =C2=A0 =C2=A0 tristate "NUC900 I2C Driver"
>> + =C2=A0 =C2=A0 =C2=A0 depends on ARCH_W90X900
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here to include support for I2C =
controller in the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Winbond/Nuvoton NUC900 based System-on=
-Chip devices.
>> +
>> =C2=A0config I2C_OCORES
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "OpenCores I2C Controller"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on EXPERIMENTAL
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index 936880b..c3ef492 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -43,6 +43,7 @@ obj-$(CONFIG_I2C_IXP2000) =C2=A0 =C2=A0 +=3D i2c-i=
xp2000.o
>> =C2=A0obj-$(CONFIG_I2C_MPC) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D i=
2c-mpc.o
>> =C2=A0obj-$(CONFIG_I2C_MV64XXX) =C2=A0 =C2=A0 =C2=A0+=3D i2c-mv64xxx=
=2Eo
>> =C2=A0obj-$(CONFIG_I2C_NOMADIK) =C2=A0 =C2=A0 =C2=A0+=3D i2c-nomadik=
=2Eo
>> +obj-$(CONFIG_I2C_NUC900) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-nuc900.o
>> =C2=A0obj-$(CONFIG_I2C_OCORES) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-ocores.=
o
>> =C2=A0obj-$(CONFIG_I2C_OMAP) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D i2c-om=
ap.o
>> =C2=A0obj-$(CONFIG_I2C_PASEMI) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-pasemi.=
o
>> diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2=
c-nuc900.c
>> new file mode 100644
>> index 0000000..7a13b28
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-nuc900.c
>> @@ -0,0 +1,709 @@
>> +/*
>> + * linux/drivers/i2c/busses/i2c-nuc900.c
>> + *
>> + * Copyright (c) 2010 Nuvoton technology corporation.
>> + *
>> + * This driver based on S3C2410 I2C driver of Ben Dooks <ben@simtec=
=2Eco.uk>.
>> + * Written by Wan ZongShun <mcuos.com@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation;version 2 of the License.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-id.h>
>> +#include <linux/init.h>
>> +#include <linux/time.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/errno.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +
>> +#include <mach/mfp.h>
>> +#include <mach/i2c.h>
>> +
>> +/* nuc900 i2c registers offset */
>> +
>> +#define CSR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00
>> +#define DIVIDER =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x04
>> +#define CMDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08
>> +#define SWR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0C
>> +#define RXR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10
>> +#define TXR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14
>> +
>> +/* nuc900 i2c CSR register bits */
>> +
>> +#define IRQEN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x003
>> +#define I2CBUSY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x400
>> +#define I2CSTART =C2=A0 =C2=A0 =C2=A0 0x018
>> +#define IRQFLAG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x004
>> +#define ARBIT_LOST =C2=A0 =C2=A0 0x200
>> +#define SLAVE_ACK =C2=A0 =C2=A0 =C2=A00x800
>> +
>> +/* nuc900 i2c CMDR register bits */
>> +
>> +#define I2C_CMD_START =C2=A00x10
>> +#define I2C_CMD_STOP =C2=A0 0x08
>> +#define I2C_CMD_READ =C2=A0 0x04
>> +#define I2C_CMD_WRITE =C2=A00x02
>> +#define I2C_CMD_NACK =C2=A0 0x01
>> +
>> +/* i2c controller state */
>> +
>> +enum nuc900_i2c_state {
>> + =C2=A0 =C2=A0 =C2=A0 STATE_IDLE,
>> + =C2=A0 =C2=A0 =C2=A0 STATE_START,
>> + =C2=A0 =C2=A0 =C2=A0 STATE_READ,
>> + =C2=A0 =C2=A0 =C2=A0 STATE_WRITE,
>> + =C2=A0 =C2=A0 =C2=A0 STATE_STOP
>> +};
>> +
>> +/* i2c controller private data */
>> +
>> +struct nuc900_i2c {
>> + =C2=A0 =C2=A0 =C2=A0 spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0lock;
>> + =C2=A0 =C2=A0 =C2=A0 wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 wait;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_msg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*msg;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msg_num;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msg_idx;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msg_ptr;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0irq;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 enum nuc900_i2c_state =C2=A0 state;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 void __iomem =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*regs;
>> + =C2=A0 =C2=A0 =C2=A0 struct clk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*clk;
>> + =C2=A0 =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *dev;
>> + =C2=A0 =C2=A0 =C2=A0 struct resource =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
ioarea;
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter =C2=A0 =C2=A0 =C2=A0adap;
>> +};
>> +
>> +/* nuc900_i2c_master_complete
>> + *
>> + * complete the message and wake up the caller, using the given ret=
urn code,
>> + * or zero to mean ok.
>> +*/
>> +
>> +static inline void nuc900_i2c_master_complete(struct nuc900_i2c *i2=
c, int ret)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "master_complete %d\n", ret=
);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_ptr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg =3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_idx++;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_num =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->msg_idx =3D =
ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 wake_up(&i2c->wait);
>> +}
>> +
>> +/* irq enable/disable functions */
>> +
>> +static inline void nuc900_i2c_disable_irq(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 tmp =3D readl(i2c->regs + CSR);
>> + =C2=A0 =C2=A0 =C2=A0 writel(tmp & ~IRQEN, i2c->regs + CSR);
>> +}
>> +
>> +static inline void nuc900_i2c_enable_irq(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 tmp =3D readl(i2c->regs + CSR);
>> + =C2=A0 =C2=A0 =C2=A0 writel(tmp | IRQEN, i2c->regs + CSR);
>> +}
>> +
>> +
>> +/* nuc900_i2c_message_start
>> + *
>> + * put the start of a message onto the bus
>> +*/
>> +
>> +static void nuc900_i2c_message_start(struct nuc900_i2c *i2c,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_=
msg *msg)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int addr =3D (msg->addr & 0x7f) << 1=
;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (msg->flags & I2C_M_RD)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D 0x1;
>> + =C2=A0 =C2=A0 =C2=A0 writel(addr & 0xff, i2c->regs + TXR);
>> + =C2=A0 =C2=A0 =C2=A0 writel(I2C_CMD_START | I2C_CMD_WRITE, i2c->re=
gs + CMDR);
>> +}
>> +
>> +static inline void nuc900_i2c_stop(struct nuc900_i2c *i2c, int ret)
>> +{
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "STOP\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* stop the transfer */
>> + =C2=A0 =C2=A0 =C2=A0 i2c->state =3D STATE_STOP;
>> + =C2=A0 =C2=A0 =C2=A0 writel(I2C_CMD_STOP, i2c->regs + CMDR);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_master_complete(i2c, ret);
>> + =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_disable_irq(i2c);
>> +}
>> +
>> +/* helper functions to determine the current state in the set of
>> + * messages we are sending
>> +*/
>> +
>> +/* is_lastmsg()
>> + *
>> + * returns TRUE if the current message is the last in the set
>> +*/
>> +
>> +static inline int is_lastmsg(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return i2c->msg_idx >=3D (i2c->msg_num - 1);
>> +}
>> +
>> +/* is_msglast
>> + *
>> + * returns TRUE if we this is the last byte in the current message
>> +*/
>> +
>> +static inline int is_msglast(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return i2c->msg_ptr =3D=3D i2c->msg->len-1;
>> +}
>> +
>> +/* is_msgend
>> + *
>> + * returns TRUE if we reached the end of the current message
>> +*/
>> +
>> +static inline int is_msgend(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return i2c->msg_ptr >=3D i2c->msg->len;
>> +}
>> +
>> +/* i2c_nuc900_irq_nextbyte
>> + *
>> + * process an interrupt and work out what to do
>> + */
>> +
>> +static void i2c_nuc900_irq_nextbyte(struct nuc900_i2c *i2c,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long iicstat=
)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned char byte;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 switch (i2c->state) {
>> +
>> + =C2=A0 =C2=A0 =C2=A0 case STATE_IDLE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(i2c->dev,=
 "%s: called in STATE_IDLE\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 case STATE_STOP:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(i2c->dev,=
 "%s: called in STATE_STOP\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_disabl=
e_irq(i2c);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 case STATE_START:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* last thing we =
did was send a start condition on the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bus, or s=
tarted a new i2c message
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iicstat & SLA=
VE_ACK &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(i=
2c->msg->flags & I2C_M_IGNORE_NAK)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* ack was not received... */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(i2c->dev, "ack was not received\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nuc900_i2c_stop(i2c, -ENXIO);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c->msg->fla=
gs & I2C_M_RD)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i2c->state =3D STATE_READ;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i2c->state =3D STATE_WRITE;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* terminate the =
transfer if there is nothing to do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* as this i=
s used by the i2c probe to find devices.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_lastmsg(i2=
c) && i2c->msg->len =3D=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nuc900_i2c_stop(i2c, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c->state =3D=
=3D STATE_READ)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto prepare_read;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through t=
o the write state, as we will need to
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* send a by=
te as well
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 case STATE_WRITE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* we are writing=
 data to the device... check for the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* end of th=
e message, and if so, work out what to do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(i2c->msg->f=
lags & I2C_M_IGNORE_NAK)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (iicstat & SLAVE_ACK) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "WRITE: No Ack=
\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_stop(i2c, -ECONNREFUS=
ED);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> +retry_write:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_msgend(i2=
c)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 byte =3D i2c->msg->buf[i2c->msg_ptr++];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 writeb(byte, i2c->regs + TXR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 writel(I2C_CMD_WRITE, i2c->regs + CMDR);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!is_la=
stmsg(i2c)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* we need to go to the next i2c message */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(i2c->dev, "WRITE: Next Message\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i2c->msg_ptr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i2c->msg_idx++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i2c->msg++;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* check to see if we need to do another message */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (i2c->msg->flags & I2C_M_NOSTART) {
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c->msg->flags & I2C_M_RD) =
{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* c=
annot do this, the controller
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* forces us to send a new START
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* when we change direction
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc9=
00_i2c_stop(i2c, -EINVAL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto retry_write;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send the new start */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_message_start(i2c, i2=
c->msg);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->state =3D STATE_START;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* send stop */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nuc900_i2c_stop(i2c, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 case STATE_READ:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* we have a byte=
 of data in the data register, do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something=
 with it, and then work out wether we are
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* going to =
do any more read/write
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 byte =3D readb(i2=
c->regs + RXR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->msg->buf[i2c=
->msg_ptr++] =3D byte;
>> +
>> +prepare_read:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_msglast(i2=
c)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* last byte of buffer */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (is_lastmsg(i2c))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(I2C_CMD_READ | I2C_CMD_NA=
CK,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->regs + CMDR);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (is_msg=
end(i2c)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* ok, we've read the entire buffer, see if there
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* is anything else we need to do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (is_lastmsg(i2c)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* last message, send stop and c=
omplete */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "READ: Send St=
op\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_stop(i2c, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* go to the next transfer */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "READ: Next Tr=
ansfer\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->msg_ptr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->msg_idx++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->msg++;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(I2C_CMD_READ, i2c->regs +=
 CMDR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 writel(I2C_CMD_READ, i2c->regs + CMDR);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +}
>> +
>> +/* nuc900_i2c_irq
>> + *
>> + * top level IRQ servicing routine
>> +*/
>> +
>> +static irqreturn_t nuc900_i2c_irq(int irqno, void *dev_id)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct nuc900_i2c *i2c =3D dev_id;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long status;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 status =3D readl(i2c->regs + CSR);
>> + =C2=A0 =C2=A0 =C2=A0 writel(status | IRQFLAG, i2c->regs + CSR);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (status & ARBIT_LOST) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* deal with arbi=
tration loss */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(i2c->dev,=
 "deal with arbitration loss\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (i2c->state =3D=3D STATE_IDLE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev,=
 "IRQ: error i2c->state =3D=3D IDLE\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* pretty much this leaves us with the fact t=
hat we've
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transmitted or received whatever byte=
 we last sent
>> + =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c_nuc900_irq_nextbyte(i2c, status);
>> +
>> + out:
>> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +
>> +/* nuc900_i2c_set_master
>> + *
>> + * get the i2c bus for a master transaction
>> +*/
>> +
>> +static int nuc900_i2c_set_master(struct nuc900_i2c *i2c)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int timeout =3D 400;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 while (timeout-- > 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((readl(i2c->=
regs + SWR) & I2CSTART) =3D=3D I2CSTART) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((readl(i2c->regs + CSR) & I2CBU=
SY) =3D=3D 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(1);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return -ETIMEDOUT;
>> +}
>> +
>> +/* nuc900_i2c_doxfer
>> + *
>> + * this starts an i2c transfer
>> +*/
>> +
>> +static int nuc900_i2c_doxfer(struct nuc900_i2c *i2c,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msgs, int num)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long iicstat, timeout;
>> + =C2=A0 =C2=A0 =C2=A0 int spins =3D 20;
>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D nuc900_i2c_set_master(i2c);
>> + =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(i2c->dev,=
 "cannot get bus (error %d)\n", ret);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EAGAIN;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&i2c->lock);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg =C2=A0 =C2=A0 =3D msgs;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_num =3D num;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_ptr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->msg_idx =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->state =C2=A0 =3D STATE_START;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_message_start(i2c, msgs);
>> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&i2c->lock);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 timeout =3D wait_event_timeout(i2c->wait, i2c=
->msg_num =3D=3D 0, HZ * 5);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c->msg_idx;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* having these next two as dev_err() makes l=
ife very
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* noisy when doing an i2cdetect
>> + =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (timeout =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev,=
 "timeout\n");
>> + =C2=A0 =C2=A0 =C2=A0 else if (ret !=3D num)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev,=
 "incomplete xfer (%d)\n", ret);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* ensure the stop has been through the bus *=
/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "waiting for bus idle\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* first, try busy waiting briefly */
>> + =C2=A0 =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iicstat =3D readl=
(i2c->regs + CSR);
>> + =C2=A0 =C2=A0 =C2=A0 } while ((iicstat & I2CBUSY) && --spins);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* if that timed out sleep */
>> + =C2=A0 =C2=A0 =C2=A0 if (!spins) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iicstat =3D readl=
(i2c->regs + CSR);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (iicstat & I2CBUSY)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(i2c->dev=
, "timeout waiting for bus idle\n");
>> +
>> + out:
>> + =C2=A0 =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +/* nuc900_i2c_xfer
>> + *
>> + * first port of call from the i2c bus code when an message needs
>> + * transferring across the i2c bus.
>> +*/
>> +
>> +static int nuc900_i2c_xfer(struct i2c_adapter *adap,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct i2c_msg *msgs, int num)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct nuc900_i2c *i2c =3D (struct nuc900_i2c=
 *)adap->algo_data;
>> + =C2=A0 =C2=A0 =C2=A0 int retry;
>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 nuc900_i2c_enable_irq(i2c);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 for (retry =3D 0; retry < adap->retries; retr=
y++) {
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D nuc900_i2=
c_doxfer(i2c, msgs, num);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D -EAG=
AIN)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev,=
 "Retrying transmission (%d)\n", retry);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(100);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return -EREMOTEIO;
>> +}
>> +
>> +/* declare our i2c functionality */
>> +static u32 nuc900_i2c_func(struct i2c_adapter *adap)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I=
2C_FUNC_PROTOCOL_MANGLING;
>> +}
>> +
>> +/* i2c bus registration info */
>> +
>> +static const struct i2c_algorithm nuc900_i2c_algorithm =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .master_xfer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D nuc900_i2c_xfer,
>> + =C2=A0 =C2=A0 =C2=A0 .functionality =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D nuc900_i2c_func,
>> +};
>> +
>> +/* nuc900_i2c_probe
>> + *
>> + * called by the bus driver when a suitable device is found
>> +*/
>> +
>> +static int __devinit nuc900_i2c_probe(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct nuc900_i2c *i2c;
>> + =C2=A0 =C2=A0 =C2=A0 struct nuc900_platform_i2c *pdata;
>> + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 pdata =3D pdev->dev.platform_data;
>> + =C2=A0 =C2=A0 =C2=A0 if (!pdata) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "no platform data\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c =3D kzalloc(sizeof(struct nuc900_i2c), GF=
P_KERNEL);
>> + =C2=A0 =C2=A0 =C2=A0 if (!i2c) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "no memory for state\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 strlcpy(i2c->adap.name, "nuc900-i2c0", sizeof=
(i2c->adap.name));
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.owner =C2=A0 =3D THIS_MODULE;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.algo =C2=A0 =C2=A0=3D &nuc900_i2c_a=
lgorithm;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.retries =3D 2;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.class =C2=A0 =3D I2C_CLASS_HWMON | =
I2C_CLASS_SPD;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&i2c->lock);
>> + =C2=A0 =C2=A0 =C2=A0 init_waitqueue_head(&i2c->wait);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* find the clock and enable it */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->dev =3D &pdev->dev;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->clk =3D clk_get(&pdev->dev, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(i2c->clk)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot get clock\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOENT;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_noclk;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "clock source %p\n", i2c-=
>clk);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_enable(i2c->clk);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* map the registers */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURC=
E_MEM, 0);
>> + =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot find IO resource\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOENT;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->ioarea =3D request_mem_region(res->start=
, resource_size(res),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
pdev->name);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (i2c->ioarea =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot request IO\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENXIO;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->regs =3D ioremap(res->start, resource_si=
ze(res));
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (i2c->regs =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot map IO\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENXIO;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ioarea;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "registers %p (%p, %p)\n"=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->regs, i2c->i=
oarea, res);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* setup info block for the i2c core */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.algo_data =3D i2c;
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.dev.parent =3D &pdev->dev;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 mfp_set_groupg(&pdev->dev);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_get_rate(i2c->clk);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D (i2c->clk.apbfreq)/(pdata->bus_freq *=
 5) - 1;
>> + =C2=A0 =C2=A0 =C2=A0 writel(ret & 0xffff, i2c->regs + DIVIDER);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* find the IRQ for this unit (note, this rel=
ies on the init call to
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* ensure no current IRQs pending
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->irq =3D ret =3D platform_get_irq(pdev, 0=
);
>> + =C2=A0 =C2=A0 =C2=A0 if (ret <=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot find IRQ\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_iomap;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D request_irq(i2c->irq, nuc900_i2c_irq,=
 IRQF_DISABLED | IRQF_SHARED,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dev_name(&pdev->dev), i2c);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "cannot claim IRQ %d\n", i2c->irq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_iomap;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* Note, previous versions of the driver used=
 i2c_add_adapter()
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to add the bus at any number. We now =
pass the bus number via
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the platform data, so if unset it wil=
l now default to always
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* being bus 0.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c->adap.nr =3D pdata->bus_num;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_add_numbered_adapter(&i2c->adap);
>> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "failed to add bus to i2c core\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_irq;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, i2c);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "%s: NUC900 I2C adapter\=
n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 dev_name(&i2c->adap.dev));
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +
>> + err_irq:
>> + =C2=A0 =C2=A0 =C2=A0 free_irq(i2c->irq, i2c);
>> +
>> + err_iomap:
>> + =C2=A0 =C2=A0 =C2=A0 iounmap(i2c->regs);
>> +
>> + err_ioarea:
>> + =C2=A0 =C2=A0 =C2=A0 release_resource(i2c->ioarea);
>> + =C2=A0 =C2=A0 =C2=A0 kfree(i2c->ioarea);
>> +
>> + err_clk:
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(i2c->clk);
>> + =C2=A0 =C2=A0 =C2=A0 clk_put(i2c->clk);
>> +
>> + err_noclk:
>> + =C2=A0 =C2=A0 =C2=A0 kfree(i2c);
>> + =C2=A0 =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +/* nuc900_i2c_remove
>> + *
>> + * called when device is removed from the bus
>> +*/
>> +
>> +static int __devexit nuc900_i2c_remove(struct platform_device *pdev=
)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct nuc900_i2c *i2c =3D platform_get_drvda=
ta(pdev);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 i2c_del_adapter(&i2c->adap);
>> + =C2=A0 =C2=A0 =C2=A0 free_irq(i2c->irq, i2c);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(i2c->clk);
>> + =C2=A0 =C2=A0 =C2=A0 clk_put(i2c->clk);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 iounmap(i2c->regs);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 release_resource(i2c->ioarea);
>> + =C2=A0 =C2=A0 =C2=A0 kfree(i2c->ioarea);
>> + =C2=A0 =C2=A0 =C2=A0 kfree(i2c);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static struct platform_driver nuc900_i2c_driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
nuc900_i2c_probe,
>> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __dev=
exit_p(nuc900_i2c_remove),
>> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D =
THIS_MODULE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D =
"nuc900-i2c0",
>> + =C2=A0 =C2=A0 =C2=A0 },
>> +};
>> +
>> +static int __init i2c_adap_nuc900_init(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&nuc900_i2c_d=
river);
>> +}
>> +
>> +static void __exit i2c_adap_nuc900_exit(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&nuc900_i2c_driver=
);
>> +}
>> +subsys_initcall(i2c_adap_nuc900_init);
>> +module_exit(i2c_adap_nuc900_exit);
>> +
>> +MODULE_DESCRIPTION("NUC900 I2C Bus driver");
>> +MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:nuc900-i2c0");
>> --
>> 1.6.3.3
>>
>
>
>
> --
> *linux-arm-kernel mailing list
> mail addr:linux-arm-kernel@lists.infradead.org
> you can subscribe by:
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> * linux-arm-NUC900 mailing list
> mail addr:NUC900@googlegroups.com
> main web: https://groups.google.com/group/NUC900
> you can subscribe it by sending me mail:
> mcuos.com@gmail.com
>



--=20
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
