From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C: I2C controller driver for Intel Moorestown
 platform
Date: Mon, 15 Jun 2009 13:50:58 +0200
Message-ID: <20090615135058.1bf40a75@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
 <20090416111436.296cdd12@hyperion.delvare>
 <0A882F4D99BBF6449D58E61AAFD7EDD613677A65@pdsmsx502.ccr.corp.intel.com>
 <0A882F4D99BBF6449D58E61AAFD7EDD62876816C@pdsmsx502.ccr.corp.intel.com>
 <0A882F4D99BBF6449D58E61AAFD7EDD628768177@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD628768177-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wen,

Sorry for the late reply. Here comes a full review of your driver.

On Thu, 14 May 2009 15:39:03 +0800, Wang, Wen W wrote:
> From f5ace22d5aec5e62b6110e3a61f03ca04eaffafb Mon Sep 17 00:00:00 200=
1
> From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Thu, 14 May 2009 14:56:44 +0800
> Subject: [PATCH] Patch for Moorestown I2C controller driver
>  Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> ---
>  drivers/i2c/busses/Kconfig          |   10 +
>  drivers/i2c/busses/Makefile         |    1 +
>  drivers/i2c/busses/i2c-moorestown.c |  778 +++++++++++++++++++++++++=
++++++++++
>  drivers/i2c/busses/i2c-moorestown.h |  259 ++++++++++++
>  4 files changed, 1048 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-moorestown.c
>  create mode 100755 drivers/i2c/busses/i2c-moorestown.h
>=20

Your code uses spaces for indentation while the Linux kernel code
_must_ use tabs. Please fix. Please also check your code with
scripts/checkpatch.pl --file, this will help you fix most coding-style
issues.

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a48c8ae..cf84038 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -738,4 +738,14 @@ config SCx200_ACB
>           This support is also available as a module.  If so, the mod=
ule
>           will be called scx200_acb.
>=20
> +config I2C_MOORESTOWN

Insert this entry in alphabetical order please.

> +       tristate "Intel Moorestown I2C Controller"
> +       depends on PCI && GPIOLIB
> +       default y
> +       help
> +         If you say yes to this option, support will be included for=
 the Intel
> +         Moorestown chipset I2C controller.
> +         This driver can also be built as a module.  If so, the modu=
le
> +         will be called i2c-moorestown.
> +
>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index 776acb6..9d5f89c 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_I2C_SIBYTE)      +=3D i2c-sibyte.o
>  obj-$(CONFIG_I2C_STUB)         +=3D i2c-stub.o
>  obj-$(CONFIG_SCx200_ACB)       +=3D scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)       +=3D scx200_i2c.o
> +obj-$(CONFIG_I2C_MOORESTOWN)   +=3D i2c-moorestown.o

Alphabetical order here too, please.

>=20
>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS +=3D -DDEBUG
> diff --git a/drivers/i2c/busses/i2c-moorestown.c b/drivers/i2c/busses=
/i2c-moorestown.c
> new file mode 100644
> index 0000000..ab8a619
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-moorestown.c
> @@ -0,0 +1,778 @@
> +/*
> + * Support for Moorestown I2C controller
> + *
> + * Copyright (c) 2009 Intel Corporation.
> + * Copyright (c) 2009 Synopsys. Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,=
 version
> + * 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT ANY
> + * WARRANTY; without even the implied warranty of MERCHANTABILITY or=
 FITNESS
> + * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for=
 more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc., 51
> + * Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Included by <linux/module.h> so you don't need to specify it.

> +#include <linux/version.h>

Drivers should no longer include <linux/version.h>.

> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/types.h>

Included by <linux/kernel.h> so you don't need to specify it.

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +
> +#include "i2c-moorestown.h"
> +
> +#define MAX_T_POLL_COUNT       10000   /* FIXME */
> +#define DEF_BAR                0
> +#define VERSION                "Version 0.5"
> +
> +#define mrst_i2c_read(reg)             __raw_readl(reg)
> +#define mrst_i2c_write(reg, val)       __raw_writel((val), (reg))

Why macros rather than inline functions? With inline functions you
would have type checking at build time... you could also pass the i2c
controller itself as the first parameter, for slightly shorter calls.

> +
> +static int speed_mode =3D STANDARD;
> +module_param(speed_mode, int, S_IRUGO);

This parameter lacks a description (use MODULE_PARM_DESC). I also find
it odd that you expose internals to user-space that way. Wouldn't it be
cleaner to take a bus speed in kHz from user-space, and convert it to
a delay inside the driver?

> +
> +/**
> + * mrst_i2c_disable - Disable I2C controller
> + * @adap: struct pointer to i2c_adapter
> + *
> + * Return Value:
> + * 0           success
> + * -EBUSY      if device is busy
> + * -ETIMEOUT   if i2c cannot be disabled within the given time

This function actually never returns -ETIMEOUT (which additionally
doesn't exist - it's ETIMEDOUT.)

> + *
> + * I2C bus state should be checked prior to disabling the hardware. =
If bus is
> + * not in idle state, an errno is returned. Write "0" to IC_ENABLE t=
o disable
> + * I2C controller.
> + */
> +static int mrst_i2c_disable(struct i2c_adapter *adap)
> +{
> +       struct mrst_i2c_private *i2c =3D
> +           (struct mrst_i2c_private *)i2c_get_adapdata(adap);

Cast isn't needed, as i2c_get_adapdata() returns a void *. There are
other instances of this throughout the driver code, please fix them all=
=2E

> +       int count =3D 0;
> +
> +       /* Check if device is busy */
> +       dev_dbg(&adap->dev, "mrst i2c disable\n");
> +       while (mrst_i2c_read(i2c->base + IC_STATUS) & 0x1) {
> +               dev_dbg(&adap->dev, "i2c is busy, count is %d\n", cou=
nt);
> +               if (count++ > MAX_T_POLL_COUNT)
> +                       return -EBUSY;
> +       }

This is a tight loop, with a count-based exit condition. This means
you'll keep the CPU and I/O bus busy for a period of time and you can
hardly say how much this will last. This is no good. Please use a
time-based exit condition. And I suggest you sleep between retries.

> +
> +       /* Set IC_ENABLE to 0 */
> +       mrst_i2c_write(i2c->base + IC_ENABLE, 0);
> +
> +       /* Disable all interupts */
> +       mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
> +
> +       /* Clear all interrupts */
> +       mrst_i2c_read(i2c->base + IC_CLR_INTR);
> +
> +       return 0;
> +}
> +
> +/**
> + * mrst_i2c_hwinit - Initiate the I2C hardware registers. This funct=
ion will
> + * be called in mrst_i2c_probe() before device registration.
> + * @dev: pci device struct pointer
> + *
> + * Return Values:
> + * 0           success
> + * -EBUSY      i2c cannot be disabled
> + * -ETIMEDOUT  i2c cannot be disabled
> + * -EFAULT     If APB data width is not 32-bit wide
> + *
> + * I2C should be disabled prior to other register operation. If fail=
ed, an
> + * errno is returned. Mask and Clear all interrpts, this should be d=
one at
> + * first.  Set common registers which will not be modified during no=
rmal
> + * transfers, including: controll register, FIFO threshold and clock=
 freq.
> + * Check APB data width at last.
> + */
> +static int  __devinit mrst_i2c_hwinit(struct pci_dev *dev)

Coding style: doubled space.

> +{
> +       struct mrst_i2c_private *i2c =3D
> +           (struct mrst_i2c_private *)pci_get_drvdata(dev);
> +       int err =3D 0;

Useless initialization.

> +
> +       /* Disable i2c first */
> +       err =3D mrst_i2c_disable(i2c->adap);
> +       if (err)
> +               return err;
> +
> +       /* Disable all interupts */
> +       mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
> +
> +       /* Clear all interrupts */
> +       mrst_i2c_read(i2c->base + IC_CLR_INTR);

mrst_i2c_disable() already did just that, why do it again?

> +
> +       /*
> +        * Setup clock frequency and speed mode
> +        * Enable restart condition,
> +        * enable master FSM, disable slave FSM,
> +        * use target address when initiating transfer
> +        */
> +       switch (speed_mode) {
> +       case STANDARD:
> +               mrst_i2c_write(i2c->base + IC_CON,
> +                              SLV_DIS | RESTART | STANDARD_MODE | MA=
STER_EN);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT, 0x75);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT, 0x7c);
> +               break;
> +       case FAST:
> +               mrst_i2c_write(i2c->base + IC_CON,
> +                              SLV_DIS | RESTART | FAST_MODE | MASTER=
_EN);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT, 0x15);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT, 0x21);
> +               break;
> +       case HIGH:
> +               mrst_i2c_write(i2c->base + IC_CON,
> +                              SLV_DIS | RESTART | HIGH_MODE | MASTER=
_EN);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT, 0x7);
> +               mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT, 0xE);
> +               break;
> +       default:
> +               ;

You should probably do something here (return an error, or default
to STANDARD), as speed_mode may be user-provided so it could have an
unexpected value.

> +       }
> +
> +       /* Set tranmit & receive FIFO threshold to zero */
> +       mrst_i2c_write(i2c->base + IC_RX_TL, 0x3);
> +       mrst_i2c_write(i2c->base + IC_TX_TL, 0x3);
> +
> +       mrst_i2c_write(i2c->base + IC_ENABLE, 1);
> +
> +       return err;
> +}
> +
> +/**
> + * mrst_i2c_func - Return the supported three I2C operations.
> + * @adapter: i2c_adapter struct pointer
> + */
> +static u32 mrst_i2c_func(struct i2c_adapter *adapter)
> +{
> +       return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EM=
UL;
> +}

=46WIW, 10-bit addressing support is incomplete in i2c-core, so even if
your bus driver implements it, you won't be able to use it right away.

> +
> +/**
> + * mrst_i2c_invalid_address - To check if the address in i2c message=
 is
> + * correct.
> + * @p: i2c_msg struct pointer
> + *
> + * Return Values:
> + * 0   if the address is valid
> + * 1   if the address is invalid
> + */
> +static inline int mrst_i2c_invalid_address(const struct i2c_msg *p)
> +{
> +       int ret =3D ((p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN)
> +                                        && (p->addr > 0x7f)));
> +       return ret;
> +}

I don't think your driver should check this. If this check needs to be
done, that should be done in i2c-core instead of individual drivers.
But my opinion is that this check is unneeded and only slows down the
driver for no benefit, as in most cases the address value comes from
struct i2c_client, and it _is_ already checked when the client is
registered.

> +
> +/**
> + * mrst_i2c_address_neq - To check if the addresses for different i2=
c messages
> + * are equal.
> + * @p1: first i2c_msg
> + * @p2: second i2c_msg
> + *
> + * Return Values:
> + * 0    if addresse are equal

Typo: addresses.

> + * 1    if not equal
> + *
> + * Within a single transfer, I2C client may need to send its address=
 more
> + * than one time. So a check for the address equation is needed.

one time -> once. And I think you mean equality, not equation.

> + */
> +static inline int mrst_i2c_address_neq(const struct i2c_msg *p1,
> +                                      const struct i2c_msg *p2)
> +{
> +       int ret =3D ((p1->addr !=3D p2->addr) || ((p1->flags & (I2C_M=
_TEN))
> +                                             !=3D ((p2->flags) & (I2=
C_M_TEN))));
> +       return ret;
> +}
> +
> +/**
> + * mrst_i2c_abort - To handle transfer abortions and print error mes=
sages.
> + * @adap: i2c_adapter struct pointer
> + *
> + * By reading register IC_TX_ABRT_SOURCE, various transfer errors ca=
n be
> + * distingushed. At present, no circumstances have been found out th=
at
> + * multiple errors would be occured simutaneously, so we simply use =
the
> + * register value directly.

This doesn't make sense. This register is a bitfield, you have to
handle it that way no matter what. With your current code, if two
errors occur simultaneously, you don't display _any_ error message,
which is very bad practice. Handling this properly should hardly be
more code, so please do it.

> + *
> + * At last the error bits are cleared. (Note clear ABRT_SBYTE_NORSTR=
T bit need
> + * a few extra steps)
> + */
> +static void mrst_i2c_abort(struct i2c_adapter *adap)
> +{
> +       struct mrst_i2c_private *i2c =3D (struct mrst_i2c_private *)
> +           i2c_get_adapdata(adap);
> +
> +       /* Read about source register */
> +       int abort =3D mrst_i2c_read(i2c->base + IC_TX_ABRT_SOURCE);
> +
> +       dev_dbg(&adap->dev, "Abort: ");

No message fragments, please, each message must end with a newline.

> +
> +       /* Single transfer error check:
> +        * According to databook, TX/RX FIFOs would be flushed when
> +        * the abort interrupt occured.
> +        */
> +       switch (abort) {
> +       case (ABRT_MASTER_DIS):

No parentheses around constants, please.

> +               dev_err(&adap->dev,
> +                       "initiate Master operation with Master mode"
> +                       "disabled.\n");

Missing space in the middle of message.

> +

Coding style: extra blank line.

> +               break;
> +       case (ABRT_10B_RD_NORSTRT):
> +               dev_err(&adap->dev,
> +                       "RESTART disabled and master sends READ cmd i=
n 10-BIT"
> +                       "addressing.\n");

Missing space in the middle of message.

> +               break;
> +       case (ABRT_SBYTE_NORSTRT):
> +               dev_err(&adap->dev,
> +                       "RESTART disabled and user is trying to send =
START"
> +                       "byte.\n");

Same here.

> +               /* Page 141 data book */
> +               mrst_i2c_write(i2c->base + IC_TX_ABRT_SOURCE,
> +                              !(ABRT_SBYTE_NORSTRT));

Binary-not (!) makes no sense for a constant. Maybe you mean
bitwise-not (~) instead? And again parentheses aren't needed.

> +               mrst_i2c_write(i2c->base + IC_CON, RESTART);
> +               mrst_i2c_write(i2c->base + IC_TAR, !(IC_TAR_SPECIAL))=
;

Same here.

> +               break;
> +       case (ABRT_SBYTE_ACKDET):
> +               dev_err(&adap->dev,
> +                       "START byte was acknowledged.\n");
> +               break;
> +       case (ABRT_TXDATA_NOACK):
> +               dev_err(&adap->dev,
> +                       "No acknowledge received from slave.\n");
> +               break;
> +       case (ABRT_10ADDR2_NOACK):
> +               dev_err(&adap->dev,
> +                       "The 2nd address byte of 10-bit address not"
> +                       "acknowledged.\n");

This should be a debug message, not error. Missing space in the middle
of message.

> +               break;
> +       case (ABRT_10ADDR1_NOACK):
> +               dev_dbg(&adap->dev,
> +                       "The 1st address byte of 10-bit address not"
> +                       "acknowledged.\n");

Missing space in the middle of message.

> +               break;
> +       case (ABRT_7B_ADDR_NOACK):
> +               dev_err(&adap->dev,
> +                       "7-bit address not acknowledged.\n");

This should be a debug message, not error.

> +               break;
> +       default:
> +               ;;

Useless statement.

> +       }
> +
> +       /* Clear TX_ABRT bit */
> +       mrst_i2c_read(i2c->base + IC_CLR_TX_ABRT);

Is it really sufficient to _read_ from this register? If so, why is
CLR_TX_ABRT defined?

> +}
> +
> +/**
> + * xfer_read - Internal function to implement master read transfer.
> + * @adap: i2c_adapter struct pointer
> + * @buf: buffer in i2c_msg
> + * @length: number of bytes to be read
> + *
> + * Return Values:
> + * 0           if the read transfer succeeds
> + * -ETIMEDOUT  if cannot read the "raw" interrupt register
> + * -EINVAL     if transfer abort occured

Spelling: occurred. Shouldn't you return -EIO instead of -EINVAL in
case of errors?

> + *
> + * For every byte, a "READ" command will be loaded into IC_DATA_CMD =
prior to
> + * data transfer. The actual "read" operation will be performed if t=
he RX_FULL
> + * interrupt is occured.

"Is occurred" sounds incorrect, I think "occurs" would be better. And
"when" rather than "if".

> + *
> + * Note there may be two interrupt signals captured, one should read
> + * IC_RAW_INTR_STAT to seperate between errors and actual data.

Spelling: separate.

> + */
> +static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, i=
nt length)
> +{
> +       struct mrst_i2c_private *i2c =3D (struct mrst_i2c_private *)
> +           i2c_get_adapdata(adap);
> +       uint32_t reg_val;

reg_val is a poor variable name.

> +       int i =3D length;
> +       unsigned count =3D 0;
> +       uint32_t bit_get =3D 1 << 3; /* receive fifo not empty */

Isn't this STAT_RFNE? And why define a local variable for it?

> +
> +       while (i--)
> +               mrst_i2c_write(i2c->base + IC_DATA_CMD, (uint16_t)0x1=
00);

Why the cast? And why do you hardcode 0x100 instead of using IC_RD?

> +
> +       i =3D length;
> +       while (i--) {
> +               count =3D 0;
> +               reg_val =3D mrst_i2c_read(i2c->base + IC_STATUS);
> +               while ((reg_val & bit_get) =3D=3D 0) {
> +                       reg_val =3D mrst_i2c_read(i2c->base + IC_RAW_=
INTR_STAT);
> +                       if ((reg_val & 0x40) =3D=3D 0x40)
> +                               goto read_abrt;
> +                       reg_val =3D mrst_i2c_read(i2c->base + IC_STAT=
US);
> +                       if (count++ > MAX_T_POLL_COUNT)
> +                               goto read_loop;

Again, timeout should be time-based, not count-based.

> +               }
> +
> +               reg_val =3D mrst_i2c_read(i2c->base + IC_DATA_CMD);
> +               *buf++ =3D reg_val;
> +       }
> +
> +       return 0;
> +
> +read_loop:
> +       dev_err(&adap->dev, "Time out in read\n");
> +       return -ETIMEDOUT;
> +read_abrt:
> +       dev_err(&adap->dev, "Abort from read\n");
> +       mrst_i2c_abort(adap);
> +       return -EINVAL;

Not sure why you use gotos when you could handle the errors directly in
the loop.

> +}
> +
> +/**
> + * xfer_write - Internal function to implement master write transfer=
=2E
> + * @adap: i2c_adapter struct pointer
> + * @buf: buffer in i2c_msg
> + * @length: number of bytes to be read

Copy-and-paste error: to be written, not to be read.

> + *
> + * Return Values:
> + * 0   if the read transfer succeeds
> + * -ETIMEDOUT  if cannot read the "raw" interrupt register
> + * -EINVAL     if transfer abort occured

Spelling: occurred. Shouldn't you return -EIO instead of -EINVAL in
case of errors?

> + *
> + * For every byte, a "WRITE" command will be loaded into IC_DATA_CMD=
 prior to
> + * data transfer. The actual "write" operation will be performed if =
the
> + * RX_FULL interrupt siganal is occured.

Same as above: "occurs" would sound better than "is occurred". Also
"when" instead of "if", and a typo: "signal".

> + *
> + * Note there may be two interrupt signals captured, one should read
> + * IC_RAW_INTR_STAT to seperate between errors and actual data.

Spelling: separate.

> + */
> +static int xfer_write(struct i2c_adapter *adap,
> +                     unsigned char *buf, int length)
> +{
> +       struct mrst_i2c_private *i2c =3D (struct mrst_i2c_private *)
> +           i2c_get_adapdata(adap);
> +
> +       int i;
> +       uint32_t reg_val;

reg_val is a poor variable name.

> +       unsigned count =3D 0;
> +       uint32_t bit_get =3D 1 << 2; /* transmit fifo completely empt=
y */

Isn't this STAT_TFE? And why define a local variable for it?

> +
> +       for (i =3D 0; i < length; i++)
> +               mrst_i2c_write(i2c->base + IC_DATA_CMD,
> +                              (uint16_t)(*(buf + i)));
> +
> +       reg_val =3D mrst_i2c_read(i2c->base + IC_STATUS);
> +       while ((reg_val & bit_get) =3D=3D 0) {
> +               if (count++ > MAX_T_POLL_COUNT)
> +                       goto write_loop;

Again, timeout should be time-based, not count-based.

> +               reg_val =3D mrst_i2c_read(i2c->base + IC_STATUS);
> +       }
> +
> +       udelay(speed_mode);
> +       reg_val =3D mrst_i2c_read(i2c->base + IC_RAW_INTR_STAT);
> +       if ((reg_val & 0x40) =3D=3D 0x40)
> +               goto write_abrt;
> +
> +       return 0;
> +
> +write_loop:
> +       dev_err(&adap->dev, "Time out in write\n");
> +       return -ETIMEDOUT;
> +write_abrt:
> +       dev_err(&adap->dev, "Abort from write\n");
> +       mrst_i2c_abort(adap);
> +       return -EINVAL;

Again, not sure why you use gotos when you could handle the errors
directly in the loop.

> +}
> +
> +static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg =
*pmsg)
> +{
> +       struct mrst_i2c_private *i2c =3D
> +           (struct mrst_i2c_private *)i2c_get_adapdata(adap);
> +       int err;
> +       uint32_t reg_val;

reg_val is a poor variable name.

> +
> +       /* Disable device first */
> +       err =3D mrst_i2c_disable(adap);
> +       if (err) {
> +               dev_err(&adap->dev,
> +                       "Cannot disable i2c controller, timeout!\n");
> +               return -ETIMEDOUT;

You should return err instead of hard-coding a value.

> +       }
> +
> +       reg_val =3D mrst_i2c_read(i2c->base + IC_ENABLE);
> +       if (reg_val & 0x1) {
> +               dev_dbg(&adap->dev, "i2c busy, can't setup\n");
> +               return -EINVAL;
> +       }

I don't understand why you check this again, given that
mrst_i2c_disable() just did it already. If I2C is busy, it will
have returned -EBUSY and you never reach this part of the code.

> +
> +       /* Note here we have a change */

This comment is quite mysterious.

> +       switch (speed_mode) {
> +       case STANDARD:
> +               reg_val =3D SLV_DIS | RESTART | STANDARD_MODE | MASTE=
R_EN;
> +               break;
> +       case FAST:
> +               reg_val =3D SLV_DIS | RESTART | FAST_MODE | MASTER_EN=
;
> +               break;
> +       case HIGH:
> +               reg_val =3D SLV_DIS | RESTART | HIGH_MODE | MASTER_EN=
;
> +               break;
> +       default:
> +               ;

Same comment as for mrst_i2c_hwinit(): the default case is
insufficient as you have no guarantee the value of speed_mode
is one of the 3 supported ones. The best would probably be to
check the value at driver initialization time and either fail
on unsupported values, or default to STANDARD, at your option.

> +       }
> +
> +       reg_val =3D reg_val | (pmsg->flags & I2C_M_TEN ? 1 : 0) << 4;

You could use |=3D. And you should use ADDR_10BIT instead of
hard-coding the value - otherwise it was really not worth defining
all these constants in a header file.

> +       mrst_i2c_write(i2c->base + IC_CON, reg_val);
> +
> +       /* set target address to the I2C slave address */
> +       dev_dbg(&adap->dev, "set target address to the I2C slave addr=
ess,"
> +               "addr is %x\n", pmsg->addr);
> +       reg_val =3D ((pmsg->addr & 0x3ff) |
> +                  (pmsg->flags & I2C_M_TEN ? IC_TAR_10BIT_ADDR : 0))=
;
> +       mrst_i2c_write(i2c->base + IC_TAR, reg_val);
> +
> +       /* Enable I2C controller */
> +       mrst_i2c_write(i2c->base + IC_ENABLE, ENABLE);
> +
> +       return 0;
> +}
> +
> +/**
> + * mrst_i2c_xfer - Main master transfer routine.
> + * @adap: i2c_adapter struct pointer
> + * @pmsg: i2c_msg struct pointer
> + * @num: number of i2c_msg
> + *
> + * Return Values:
> + * +           number of messages transfered
> + * -ETIMEDOUT  If cannot disable I2C controller or read IC_STATUS
> + * -EINVAL     If the address in i2c_msg is invalid
> + *
> + * This function will be registered in i2c-core and exposed to exter=
nal
> + * I2C clients.
> + * 1. Disable I2C controller
> + * 2. Unmask three interrupts: RX_FULL, TX_EMPTY, TX_ABRT
> + * 3. Check if address in i2c_msg is valid
> + * 4. Enable I2C controller
> + * 5. Perform real transfer (call xfer_read or xfer_write)
> + * 6. Wait until the current transfer is finished(check bus state)

Missing space before opening parenthesis.

> + * 7. Mask and clear all interrupts
> + */
> +static int mrst_i2c_xfer(struct i2c_adapter *adap,
> +                        struct i2c_msg *pmsg,
> +                        int num)
> +{
> +       struct mrst_i2c_private *i2c =3D
> +           (struct mrst_i2c_private *)i2c_get_adapdata(adap);
> +       int i, err;
> +
> +       dev_dbg(&adap->dev, "mrst_i2c_xfer, process %d msg(s)\n", num=
);
> +       dev_dbg(&adap->dev, KERN_INFO "slave address is %x\n", pmsg->=
addr);

KERN_INFO definitely shouldn't be there, dev_dbg() already inserts
a log level code for you.

> +
> +       /* if number of messages equal 0*/
> +       if (num =3D=3D 0)
> +               return 0;
> +
> +       /* Checked the sanity of passed messages. */
> +       if (unlikely(mrst_i2c_invalid_address(&pmsg[0]))) {
> +               dev_err(&adap->dev, "Invalid address 0x%03x (%d-bit)\=
n",
> +                       pmsg[0].addr, pmsg[0].flags & I2C_M_TEN ? 10 =
: 7);
> +               return -EINVAL;
> +       }
> +       for (i =3D 0; i < num; i++) {
> +               /* Message address equal? */
> +               if (unlikely(mrst_i2c_address_neq(&pmsg[0], &pmsg[i])=
)) {

This check can't fail for i =3D 0, obviously, so you should start the
loop at i =3D 1.

> +                       dev_err(&adap->dev, "Invalid address in msg[%=
d]\n", i);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (mrst_i2c_setup(adap, pmsg))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < num; i++) {
> +               dev_dbg(&adap->dev, " #%d: %sing %d byte%s %s 0x%02x\=
n", i,
> +                       pmsg->flags & I2C_M_RD ? "read" : "writ",
> +                       pmsg->len, pmsg->len > 1 ? "s" : "",
> +                       pmsg->flags & I2C_M_RD ? "from" : "to", pmsg-=
>addr);

i2c-core already provides this type of debugging messages, so
this is redundant.

> +
> +

Coding style: doubled blank line.

> +               /* Read or Write */
> +               if (pmsg->len && pmsg->buf) {
> +                       if (pmsg->flags & I2C_M_RD) {
> +                               dev_dbg(&adap->dev, "I2C_M_RD\n");
> +                               err =3D xfer_read(adap, pmsg->buf, pm=
sg->len);
> +                       } else {
> +                               dev_dbg(&adap->dev, "I2C_M_WR\n");
> +                               err =3D xfer_write(adap, pmsg->buf, p=
msg->len);
> +                       }
> +                       if (err < 0)
> +                               goto err_1;
> +               }

What if pmsg->len =3D 0? You skip the message entirely, which
is not correct.

> +               dev_dbg(&adap->dev, "msg[%d] transfer complete\n", i)=
;
> +               pmsg++;         /* next message */
> +       }
> +       goto exit;
> +
> +err_1:
> +       i =3D err;
> +exit:
> +       /* Mask interrupts */
> +       mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
> +       /* Clear all interrupts */
> +       mrst_i2c_read(i2c->base + IC_CLR_INTR);
> +
> +       return i;
> +}
> +
> +static int mrst_gpio_init(int sda, int scl)
> +{
> +       if (gpio_request(sda, "I2C_SDA"))
> +               goto err_sda;
> +
> +       if (gpio_request(scl, "I2C_SCL"))
> +               goto err_scl;
> +
> +       /* TODO: Wait for Moorestown GPIO driver into upstream to unc=
omment */
> +       /*gpio_alt_func(sda, 1);*/
> +       /*gpio_alt_func(scl, 1);*/

Is the driver upstream by now? If not then there's little point
in merging this i2c controller driver.

> +
> +       return 0;
> +err_scl:
> +       gpio_free(sda);
> +err_sda:
> +       return -1;

You should rather return the error code from gpio_request().

> +}
> +
> +static struct pci_device_id mrst_i2c_ids[] =3D {
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0802)},
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0803)},
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0804)},
> +       {0,}
> +};
> +MODULE_DEVICE_TABLE(pci, mrst_i2c_ids);
> +
> +static struct i2c_algorithm mrst_i2c_algorithm =3D {
> +       .master_xfer    =3D mrst_i2c_xfer,
> +       .functionality  =3D mrst_i2c_func,
> +};
> +
> +static struct pci_driver mrst_i2c_driver =3D {
> +       .name           =3D "mrst_i2c",
> +       .id_table       =3D mrst_i2c_ids,
> +       .probe          =3D mrst_i2c_probe,
> +       .remove         =3D __devexit_p(mrst_i2c_remove),
> +       .suspend        =3D NULL,
> +       .resume         =3D NULL,

You don't need to define callbacks if you set them to NULL, just
omit them.

> +};
> +
> +/**
> + * mrst_i2c_probe - I2C controller initialization routine
> + * @dev: pci device
> + * @id: device id
> + *
> + * Return Values:
> + * 0           success
> + * -ENODEV     If cannot allocate pci resource
> + * -ENOMEM     If the register base remapping failed, or
> + *             if kzalloc failed
> + *
> + * Initialization steps:
> + * 1. Request for PCI resource
> + * 2. Remap the start address of PCI resource to register base
> + * 3. Request for device memory region
> + * 4. Fill in the struct members of mrst_i2c_private
> + * 5. Call mrst_i2c_hwinit() for hardware initialization
> + * 6. Register I2C adapter in i2c-core
> + */
> +static int __devinit mrst_i2c_probe(struct pci_dev *dev,
> +                                   const struct pci_device_id *id)
> +{
> +       struct mrst_i2c_private *mrst;
> +       struct i2c_adapter *adap;
> +       unsigned int start, len;
> +       int err, busnum =3D 0;
> +       void __iomem *base =3D NULL;
> +       int gpio_sda =3D 0, gpio_scl =3D 0;
> +
> +       err =3D pci_enable_device(dev);
> +       if (err) {
> +               dev_err(&dev->dev, "Failed to enable I2C PCI device (=
%d)\n",
> +                       err);
> +               goto exit;
> +       }
> +
> +       /* Determine the address of the I2C area */
> +       start =3D pci_resource_start(dev, DEF_BAR);
> +       len =3D pci_resource_len(dev, DEF_BAR);
> +       if (!start || len <=3D 0) {
> +               dev_err(&dev->dev, "Base address initialization faile=
d\n");
> +               err =3D -ENODEV;
> +               goto exit;
> +       }
> +       dev_dbg(&dev->dev, "mrst i2c resource start %x, len=3D%d\n",
> +               start, len);

Please use 0x%x, to make it clear it is an hexadecimal value.

> +       err =3D pci_request_region(dev, DEF_BAR, mrst_i2c_driver.name=
);
> +       if (err) {
> +               dev_err(&dev->dev, "Failed to request I2C region "
> +                       "0x%1x-0x%Lx\n", start,
> +                       (unsigned long long)pci_resource_end(dev, DEF=
_BAR));
> +               goto exit;
> +       }
> +
> +       base =3D ioremap_nocache(start, len);
> +       if (!base) {
> +               dev_err(&dev->dev, "I/O memory remapping failed\n");
> +               err =3D -ENOMEM;
> +               goto fail0;
> +       }
> +
> +       /* Allocate the per-device data structure, mrst_i2c_private *=
/
> +       mrst =3D kzalloc(sizeof(struct mrst_i2c_private), GFP_KERNEL)=
;
> +       if (mrst =3D=3D NULL) {
> +               dev_err(&dev->dev, "Can't allocate interface!\n");
> +               err =3D -ENOMEM;
> +               goto fail1;
> +       }
> +
> +       adap =3D kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);

Why don't you include this structure in struct mrst_i2c_private?
This would avoid memory fragmentation.

> +       if (adap =3D=3D NULL) {
> +               dev_err(&dev->dev, "Can't allocate interface!\n");
> +               err =3D -ENOMEM;
> +               goto fail2;
> +       }
> +
> +       /* Initialize struct members */
> +       snprintf(adap->name, sizeof(adap->name), "mrst_i2c");

Please come up with a nicer and unique name. Usually we include
the base address so that you can differentiate between multiple
buses on the same system. So something like:

snprintf(adap->name, sizeof(adap->name), "Moorestown I2C at %x", start)=
;

> +       adap->owner =3D THIS_MODULE;
> +       adap->algo =3D &mrst_i2c_algorithm;
> +       adap->class =3D I2C_CLASS_HWMON;
> +       adap->dev.parent =3D &dev->dev;
> +       mrst->adap =3D adap;
> +       mrst->base =3D base;
> +       mrst->speed =3D speed_mode;

You store this value but then never use it.

> +
> +       pci_set_drvdata(dev, mrst);
> +       i2c_set_adapdata(adap, mrst);
> +
> +       /* Initialize i2c controller */
> +       err =3D mrst_i2c_hwinit(dev);
> +       if (err < 0) {
> +               dev_err(&dev->dev, "I2C interface initialization fail=
ed\n");
> +               goto fail3;
> +       }
> +
> +       switch (id->device) {
> +       case 0x0802:
> +               dev_dbg(&adap->dev, KERN_INFO "I2C0\n");
> +               gpio_sda =3D GPIO_I2C_0_SDA;
> +               gpio_scl =3D GPIO_I2C_0_SCL;
> +               adap->nr =3D busnum =3D 0;

You don't use busnum anywhere, so just drop it.

> +               break;
> +       case 0x0803:
> +               dev_dbg(&adap->dev, KERN_INFO "I2C1\n");
> +               gpio_sda =3D GPIO_I2C_1_SDA;
> +               gpio_scl =3D GPIO_I2C_1_SCL;
> +               adap->nr =3D busnum =3D 1;
> +               break;
> +       case 0x0804:
> +               dev_dbg(&adap->dev, KERN_INFO "I2C2\n");
> +               gpio_sda =3D GPIO_I2C_2_SDA;
> +               gpio_scl =3D GPIO_I2C_2_SCL;
> +               adap->nr =3D busnum =3D 2;
> +               break;
> +       default:
> +               ;

Not good. If someone force-binds the driver to another device,
you go on with unconfigured GPIOs. If it doesn't make sense then
you have to return an error here.

> +       }
> +
> +       /* Config GPIO pin for I2C */
> +       err =3D mrst_gpio_init(gpio_sda, gpio_scl);
> +       if (err) {
> +               dev_err(&dev->dev, "GPIO %s registration failed\n",
> +                       adap->name);
> +               goto fail3;
> +       }
> +
> +       /* Adapter registration */
> +       err =3D i2c_add_numbered_adapter(adap);
> +       if (err) {
> +               dev_err(&dev->dev, "Adapter %s registration failed\n"=
,
> +                       adap->name);
> +               goto fail3;

If this happens, you return without releasing the GPIOs you
requested. No good.

> +       }
> +
> +       dev_dbg(&dev->dev, "MRST I2C bus %d driver bind success.\n", =
busnum);
> +       return 0;
> +
> +fail3:
> +       i2c_set_adapdata(adap, NULL);

Not terribly useful, as you're going to free the adapter 2 lines
below.

> +       pci_set_drvdata(dev, NULL);
> +       kfree(adap);
> +fail2:
> +       kfree(mrst);
> +fail1:
> +       iounmap(base);
> +fail0:
> +       pci_release_region(dev, DEF_BAR);
> +exit:
> +       return err;
> +}
> +
> +static void __devexit mrst_i2c_remove(struct pci_dev *dev)
> +{
> +       struct mrst_i2c_private *mrst =3D (struct mrst_i2c_private *)
> +                                       pci_get_drvdata(dev);

Useless cast.

> +       if (i2c_del_adapter(mrst->adap))
> +               dev_err(&dev->dev, "Failed to delete i2c adapter");
> +
> +       switch (dev->device) {
> +       case 0x0802:
> +               gpio_free(GPIO_I2C_0_SDA);
> +               gpio_free(GPIO_I2C_0_SCL);
> +               break;
> +       case 0x0803:
> +               gpio_free(GPIO_I2C_1_SDA);
> +               gpio_free(GPIO_I2C_1_SCL);
> +               break;
> +       case 0x0804:
> +               gpio_free(GPIO_I2C_2_SDA);
> +               gpio_free(GPIO_I2C_2_SCL);
> +               break;
> +       default:
> +               break;

Useless statement.

> +       }
> +
> +       pci_set_drvdata(dev, NULL);
> +       iounmap(mrst->base);

You have to free mrst->adap too, otherwise you're leaking memory.

> +       kfree(mrst);
> +       pci_release_region(dev, DEF_BAR);
> +}
> +
> +static int __init mrst_i2c_init(void)
> +{
> +       printk(KERN_NOTICE "Moorestown I2C driver %s\n", VERSION);
> +       return pci_register_driver(&mrst_i2c_driver);
> +}
> +
> +static void __exit mrst_i2c_exit(void)
> +{
> +       pci_unregister_driver(&mrst_i2c_driver);
> +}
> +
> +module_init(mrst_i2c_init);
> +module_exit(mrst_i2c_exit);
> +
> +MODULE_AUTHOR("Ba Zheng <zheng.ba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("I2C driver for Moorestown Platform");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(VERSION);
> diff --git a/drivers/i2c/busses/i2c-moorestown.h b/drivers/i2c/busses=
/i2c-moorestown.h
> new file mode 100755
> index 0000000..e2645c0
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-moorestown.h

What's the point of having a separate file for this? Please move these
definitions into the main driver file directly. And while you're at it,
please fix the horrible indentation of many constants, it's hardly
readable as is.

> @@ -0,0 +1,259 @@
> +#ifndef __I2C_MRST_H
> +#define __I2C_MRST_H
> +
> +#include <linux/i2c.h>
> +
> +struct mrst_i2c_private {
> +       struct i2c_adapter *adap;
> +       /* Register base address */
> +       void __iomem *base;
> +       /* Speed mode */
> +       int speed;
> +};
> +
> +/* Speed mode macros */
> +#define STANDARD       100
> +#define FAST           25
> +#define        HIGH            3
> +
> +/* Control register */
> +#define IC_CON                 0x00
> +#define SLV_DIS                        (1 << 6)        /* Disable sl=
ave mode */
> +#define RESTART                        (1 << 5)        /* Send a Res=
tart condition */
> +#define        ADDR_10BIT              (1 << 4)        /* 10-bit add=
ressing */
> +#define        STANDARD_MODE           (1 << 1)        /* standard m=
ode */
> +#define FAST_MODE              (2 << 1)        /* fast mode */
> +#define HIGH_MODE              (3 << 1)        /* high speed mode */
> +#define        MASTER_EN               (1 << 0)        /* Master mod=
e */
> +
> +/* Target address register */
> +#define IC_TAR                 0x04
> +#define IC_TAR_10BIT_ADDR      (1 << 12)       /* 10-bit addressing =
*/
> +#define IC_TAR_SPECIAL         (1 << 11)       /* Perform special I2=
C cmd */
> +#define IC_TAR_GC_OR_START     (1 << 10)       /* 0: Gerneral Call A=
ddress */
> +                                               /* 1: START BYTE */
> +
> +/* Slave Address Register */
> +#define IC_SAR                 0x08            /* Not used in Master=
 mode */
> +
> +/* High Speed Master Mode Code Address Register */
> +#define IC_HS_MADDR            0x0c
> +
> +/* Rx/Tx Data Buffer and Command Register */
> +#define IC_DATA_CMD            0x10
> +#define IC_RD                  (1 << 8)        /* 1: Read 0: Write *=
/
> +
> +/* Standard Speed Clock SCL High Count Register */
> +#define IC_SS_SCL_HCNT         0x14
> +
> +/* Standard Speed Clock SCL Low Count Register */
> +#define IC_SS_SCL_LCNT         0x18
> +
> +/* Fast Speed Clock SCL High Count Register */
> +#define IC_FS_SCL_HCNT         0x1c
> +
> +/* Fast Spedd Clock SCL Low Count Register */
> +#define IC_FS_SCL_LCNT         0x20
> +
> +/* High Speed Clock SCL High Count Register */
> +#define IC_HS_SCL_HCNT         0x24
> +
> +/* High Speed Clock SCL Low Count Register */
> +#define IC_HS_SCL_LCNT         0x28
> +
> +/* Interrupt Status Register */
> +#define IC_INTR_STAT           0x2c            /* Read only */
> +#define R_GEN_CALL             (1 << 11)
> +#define R_START_DET            (1 << 10)
> +#define R_STOP_DET             (1 << 9)
> +#define R_ACTIVITY             (1 << 8)
> +#define R_RX_DONE              (1 << 7)
> +#define        R_TX_ABRT               (1 << 6)
> +#define R_RD_REQ               (1 << 5)
> +#define R_TX_EMPTY             (1 << 4)
> +#define R_TX_OVER              (1 << 3)
> +#define        R_RX_FULL               (1 << 2)
> +#define        R_RX_OVER               (1 << 1)
> +#define R_RX_UNDER             (1 << 0)
> +
> +/* Interrupt Mask Register */
> +#define IC_INTR_MASK           0x30            /* Read and Write */
> +#define M_GEN_CALL             (1 << 11)
> +#define M_START_DET            (1 << 10)
> +#define M_STOP_DET             (1 << 9)
> +#define M_ACTIVITY             (1 << 8)
> +#define M_RX_DONE              (1 << 7)
> +#define        M_TX_ABRT               (1 << 6)
> +#define M_RD_REQ               (1 << 5)
> +#define M_TX_EMPTY             (1 << 4)
> +#define M_TX_OVER              (1 << 3)
> +#define        M_RX_FULL               (1 << 2)
> +#define        M_RX_OVER               (1 << 1)
> +#define M_RX_UNDER             (1 << 0)
> +
> +/* Raw Interrupt Status Register */
> +#define IC_RAW_INTR_STAT       0x34            /* Read Only */
> +#define GEN_CALL               (1 << 11)       /* General call */
> +#define START_DET              (1 << 10)       /* (RE)START occured =
*/
> +#define STOP_DET               (1 << 9)        /* STOP occured */
> +#define ACTIVITY               (1 << 8)        /* Bus busy */
> +#define RX_DONE                        (1 << 7)        /* Not used i=
n Master mode */
> +#define        TX_ABRT                 (1 << 6)        /* Transmit A=
bort */
> +#define RD_REQ                 (1 << 5)        /* Not used in Master=
 mode */
> +#define TX_EMPTY               (1 << 4)        /* TX FIFO <=3D thres=
hold */
> +#define TX_OVER                        (1 << 3)        /* TX FIFO ov=
erflow */
> +#define        RX_FULL                 (1 << 2)        /* RX FIFO >=3D=
 threshold */
> +#define        RX_OVER                 (1 << 1)        /* RX FIFO ov=
erflow */
> +#define RX_UNDER               (1 << 0)        /* RX FIFO empty */
> +
> +/* Receive FIFO Threshold Register */
> +#define IC_RX_TL               0x38
> +
> +/* Transmit FIFO Treshold Register */
> +#define IC_TX_TL               0x3c
> +
> +/* Clear Combined and Individual Interrupt Register */
> +#define IC_CLR_INTR            0x40
> +#define CLR_INTR               (1 << 0)
> +
> +/* Clear RX_UNDER Interrupt Register */
> +#define IC_CLR_RX_UNDER                0x44
> +#define CLR_RX_UNDER           (1 << 0)
> +
> +/* Clear RX_OVER Interrupt Register */
> +#define IC_CLR_RX_OVER         0x48
> +#define CLR_RX_OVER            (1 << 0)
> +
> +/* Clear TX_OVER Interrupt Register */
> +#define IC_CLR_TX_OVER         0x4c
> +#define CLR_TX_OVER            (1 << 0)
> +
> +#define IC_CLR_RD_REQ          0x50
> +
> +/* Clear TX_ABRT Interrupt Register */
> +#define IC_CLR_TX_ABRT         0x54
> +#define CLR_TX_ABRT            (1 << 0)
> +
> +#define IC_CLR_RX_DONE         0x58
> +
> +
> +/* Clear ACTIVITY Interrupt Register */
> +#define IC_CLR_ACTIVITY                0x5c
> +#define CLR_ACTIVITY           (1 << 0)
> +
> +/* Clear STOP_DET Interrupt Register */
> +#define IC_CLR_STOP_DET                0x60
> +#define CLR_STOP_DET           (1 << 0)
> +
> +/* Clear START_DET Interrupt Register */
> +#define IC_CLR_START_DET       0x64
> +#define CLR_START_DET          (1 << 0)
> +
> +/* Clear GEN_CALL Interrupt Register */
> +#define IC_CLR_GEN_CALL                0x68
> +#define CLR_GEN_CALL           (1 << 0)
> +
> +/* Enable Register */
> +#define IC_ENABLE              0x6c
> +#define ENABLE                 (1 << 0)
> +
> +/* Status Register */
> +#define IC_STATUS              0x70            /* Read Only */
> +#define STAT_SLV_ACTIVITY      (1 << 6)        /* Slave not in idle =
*/
> +#define STAT_MST_ACTIVITY      (1 << 5)        /* Master not in idle=
 */
> +#define STAT_RFF               (1 << 4)        /* RX FIFO Full */
> +#define STAT_RFNE              (1 << 3)        /* RX FIFO Not Empty =
*/
> +#define STAT_TFE               (1 << 2)        /* TX FIFO Empty */
> +#define STAT_TFNF              (1 << 1)        /* TX FIFO Not Full *=
/
> +#define STAT_ACTIVITY          (1 << 0)        /* Activity Status */
> +
> +/* Transmit FIFO Level Register */
> +#define IC_TXFLR               0x74            /* Read Only */
> +#define TXFLR                  (1 << 0)        /* TX FIFO level */
> +
> +/* Receive FIFO Level Register */
> +#define IC_RXFLR               0x78            /* Read Only */
> +#define RXFLR                  (1 << 0)        /* RX FIFO level */
> +
> +/* Transmit Abort Source Register */
> +#define IC_TX_ABRT_SOURCE      0x80
> +#define ABRT_SLVRD_INTX                (1 << 15)
> +#define ABRT_SLV_ARBLOST       (1 << 14)
> +#define ABRT_SLVFLUSH_TXFIFO   (1 << 13)
> +#define        ARB_LOST                (1 << 12)
> +#define ABRT_MASTER_DIS                (1 << 11)
> +#define ABRT_10B_RD_NORSTRT    (1 << 10)
> +#define ABRT_SBYTE_NORSTRT     (1 << 9)
> +#define ABRT_HS_NORSTRT                (1 << 8)
> +#define ABRT_SBYTE_ACKDET      (1 << 7)
> +#define ABRT_HS_ACKDET         (1 << 6)
> +#define ABRT_GCALL_READ                (1 << 5)
> +#define ABRT_GCALL_NOACK       (1 << 4)
> +#define ABRT_TXDATA_NOACK      (1 << 3)
> +#define ABRT_10ADDR2_NOACK     (1 << 2)
> +#define ABRT_10ADDR1_NOACK     (1 << 1)
> +#define ABRT_7B_ADDR_NOACK     (1 << 0)
> +
> +/* Enable Status Register */
> +#define IC_ENABLE_STATUS       0x9c
> +#define IC_EN                  (1 << 0)        /* I2C in an enabled =
state */
> +
> +/* Component Parameter Register 1*/
> +#define IC_COMP_PARAM_1                0xf4
> +#define APB_DATA_WIDTH         (0x3 << 0)
> +
> +/* GPIO_PINS */
> +#define GPIO_I2C_0_SDA         56
> +#define GPIO_I2C_0_SCL         57
> +
> +#define GPIO_I2C_1_SDA         54
> +#define GPIO_I2C_1_SCL         55
> +
> +#define GPIO_I2C_2_SDA         52
> +#define GPIO_I2C_2_SCL         53
> +
> +/* added by xiaolin --begin */

We really don't care who added this ;)

> +#define SS_MIN_SCL_HIGH         4000
> +#define SS_MIN_SCL_LOW          4700
> +#define FS_MIN_SCL_HIGH         600
> +#define FS_MIN_SCL_LOW          1300
> +#define HS_MIN_SCL_HIGH_100PF   60
> +#define HS_MIN_SCL_LOW_100PF    120
> +
> +enum mrst_i2c_irq {
> +    i2c_irq_none =3D 0x000,
> +    i2c_irq_rx_under =3D 0x001,
> +    i2c_irq_rx_over =3D 0x002,
> +    i2c_irq_rx_full =3D 0x004,
> +    i2c_irq_tx_over =3D 0x008,
> +    i2c_irq_tx_empty =3D 0x010,
> +    i2c_irq_rd_req =3D 0x020,
> +    i2c_irq_tx_abrt =3D 0x040,
> +    i2c_irq_rx_done =3D 0x080,
> +    i2c_irq_activity =3D 0x100,
> +    i2c_irq_stop_det =3D 0x200,
> +    i2c_irq_start_det =3D 0x400,
> +    i2c_irq_gen_call =3D 0x800,
> +    i2c_irq_all =3D 0xfff
> +};
> +
> +/* Function declarations */
> +static int mrst_i2c_disable(struct i2c_adapter *);
> +static int __devinit mrst_i2c_hwinit(struct pci_dev *);
> +static u32 mrst_i2c_func(struct i2c_adapter *);
> +static inline int mrst_i2c_invalid_address(const struct i2c_msg *);
> +static inline int mrst_i2c_address_neq(const struct i2c_msg *,
> +                                      const struct i2c_msg *);
> +static int mrst_i2c_xfer(struct i2c_adapter *,
> +                        struct i2c_msg *,
> +                        int);
> +static int __devinit mrst_i2c_probe(struct pci_dev *,
> +                                   const struct pci_device_id *);
> +static void __devexit mrst_i2c_remove(struct pci_dev *);
> +static int __init mrst_i2c_init(void);
> +static void __exit mrst_i2c_exit(void);
> +static int xfer_read(struct i2c_adapter *,
> +                    unsigned char *, int);
> +static int xfer_write(struct i2c_adapter *,
> +                     unsigned char *, int);
> +#endif /* __I2C_MRST_H */
> --
> 1.5.5.1
>=20
>=20
> >-----Original Message-----
> >From: Wang, Wen W
> >Sent: 2009=E5=B9=B45=E6=9C=8814=E6=97=A5 15:36
> >To: Jean Delvare
> >Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wang, Wen W
> >Subject: [PATCH 0/1] I2C: I2C controller driver for Intel Moorestown=
 platform
> >
> >Hi Jean,
> >
> >After a long discussion with other engineers, we finally got parsing=
 I2C device info
> >table code out of the I2C controller driver. Here is a description f=
or the patch:
> >
> >1. Patch for I2C controller driver for Intel low power platform "Moo=
restown".
> >2. The driver depends on a GPIO driver for Intel Moorestown platform=
=2E
> >3. Patch is based on Linux 2.6.30-rc5.
> >4. Patch 1 will:
> >       a. Add "i2c_moorestown.c" and "i2c_moorestown.h" to kernel di=
rectory
> >"drivers/i2c/busses"
> >       b. Add items into kernel files "drivers/i2c/busses/Kconfig" a=
nd
> >"drivers/i2c/Makefile".
> >
> >Code for parsing I2C device info table and register the table into I=
2C core are moved
> >into a separate platform driver under arch/ directory per your comme=
nts.
> >
> >Thanks
> >Wen

--=20
Jean Delvare
