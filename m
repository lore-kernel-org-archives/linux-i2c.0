From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/9] i2c-designware: Initial split of i2c-designware.c into
 core and bus specific parts
Date: Tue, 25 Jan 2011 10:58:23 +0900
Message-ID: <4D3E2E3F.1060506@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-3-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1295033256-30077-3-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 1/15/2011 4:27 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch splits i2c-designware.c into a core library and associated
> header file and two bus specific parts for platform bus and PCI bus.
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Makefile              |    4 +
>  drivers/i2c/busses/i2c-designware-core.c |  541 ++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h |  204 +++++++++++
>  drivers/i2c/busses/i2c-designware-pci.c  |  183 ++++++++++
>  drivers/i2c/busses/i2c-designware-plat.c |  198 +++++++++++
>  5 files changed, 1130 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-core.c
>  create mode 100644 drivers/i2c/busses/i2c-designware-core.h
>  create mode 100644 drivers/i2c/busses/i2c-designware-pci.c
>  create mode 100644 drivers/i2c/busses/i2c-designware-plat.c
> 
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 0b9aa00..e1c0774 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -34,6 +34,10 @@ obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
>  obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>  obj-$(CONFIG_I2C_DESIGNWARE)	+= i2c-designware.o
> +obj-$(CONFIG_I2C_DESIGNWARE_PCI)	+= i2c_dw_pci.o
> +i2c_dw_pci-objs := i2c-designware-pci.o i2c-designware-core.o
> +obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c_dw_plat.o
> +i2c_dw_plat-objs := i2c-designware-plat.o i2c-designware-core.o
>  obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
>  obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
>  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o

It would be nice (and consistent) we could name these new modules as
simply 'i2c-designware-pci.ko' and 'i2c-designware-plat.ko'.  Is it
possible using <modulename>-objs build machinery?

> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> new file mode 100644
> index 0000000..9dca409
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -0,0 +1,541 @@
[...]

I've checked the diff between an existing i2c-designware.c and this
-core.c, and found that some unnecessary changes were made along with
-core.c duplication, which should be avoided as this patch is not
generated using git rename dection and hence hard to review.

>--- drivers/i2c/busses/i2c-designware.c	2011-01-22 23:07:42.571983857 +0900
>+++ drivers/i2c/busses/i2c-designware-core.c	2011-01-23 10:29:34.178022264 +0900
>@@ -170,57 +64,7 @@ static char *abort_sources[] = {
> 		"lost arbitration",
> };
> 
[...]
>-
>-static u32
>+u32
> i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
> {
> 	/*
>@@ -259,7 +103,7 @@ i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL,
> 		return (ic_clk * (tSYMBOL + tf) + 5000) / 10000 - 3 + offset;
> }
> 
>-static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
>+u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
> {
> 	/*
> 	 * Conditional expression:

i2c_dw_scl_[hl]cnt() can be static.

>@@ -330,11 +175,13 @@ static void i2c_dw_init(struct dw_i2c_de
> 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> 	writel(ic_con, dev->base + DW_IC_CON);
> }
>+EXPORT_SYMBOL(i2c_dw_init);

Don't have to make it EXPORT_SYMBOL()-ed.  How about declaring it
with extern in -core.h ?  Am I missing something?

> 
> /*
>  * Waiting for bus not busy
>  */
>-static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
>+int
>+i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
> {
> 	int timeout = TIMEOUT;
> 

static.

>@@ -350,7 +197,8 @@ static int i2c_dw_wait_bus_not_busy(stru
> 	return 0;
> }
> 
>-static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>+void
>+i2c_dw_xfer_init(struct dw_i2c_dev *dev)
> {
> 	struct i2c_msg *msgs = dev->msgs;
> 	u32 ic_con;

static.

>@@ -382,7 +230,7 @@ static void i2c_dw_xfer_init(struct dw_i
>  * messages into the tx buffer.  Even if the size of i2c_msg data is
>  * longer than the size of the tx buffer, it handles everything.
>  */
>-static void
>+void
> i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
> {
> 	struct i2c_msg *msgs = dev->msgs;

static.

>@@ -456,7 +304,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
> 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
> }
> 
>-static void
>+void
> i2c_dw_read(struct dw_i2c_dev *dev)
> {
> 	struct i2c_msg *msgs = dev->msgs;

static.

>@@ -492,7 +340,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
> 	}
> }
> 
>-static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
>+int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
> {
> 	unsigned long abort_source = dev->abort_source;
> 	int i;

static.

>@@ -518,7 +366,7 @@ static int i2c_dw_handle_tx_abort(struct
> /*
>  * Prepare controller for a transaction and call i2c_dw_xfer_msg
>  */
>-static int
>+int
> i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> {
> 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
>@@ -580,8 +428,9 @@ done:
> 
> 	return ret;
> }
>+EXPORT_SYMBOL(i2c_dw_xfer);
> 
>-static u32 i2c_dw_func(struct i2c_adapter *adap)
>+u32 i2c_dw_func(struct i2c_adapter *adap)
> {
> 	return	I2C_FUNC_I2C |
> 		I2C_FUNC_10BIT_ADDR |
>@@ -590,8 +439,9 @@ static u32 i2c_dw_func(struct i2c_adapte
> 		I2C_FUNC_SMBUS_WORD_DATA |
> 		I2C_FUNC_SMBUS_I2C_BLOCK;
> }
>+EXPORT_SYMBOL(i2c_dw_func);

Two functions above, i2c_dw_xfer() and i2c_dw_func(), shouldn't be
EXPORT_SYMBOL()-ed, either.

> 
>-static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
>+u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
> {
> 	u32 stat;
> 

static.

>@@ -650,7 +500,7 @@ static u32 i2c_dw_read_clear_intrbits(st
>  * Interrupt service routine. This gets called whenever an I2C interrupt
>  * occurs.
>  */
>-static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
>+irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> {
> 	struct dw_i2c_dev *dev = dev_id;
> 	u32 stat;
[...]
>+EXPORT_SYMBOL(i2c_dw_isr);

No EXPORT_SYMBOL(). 

> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> new file mode 100644
> index 0000000..9558ef2
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -0,0 +1,204 @@
[...]
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>

We could remove most of these headers, I've not sorted out yet.


> +#define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
> +					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
> +					 DW_IC_TX_ABRT_10ADDR2_NOACK | \
> +					 DW_IC_TX_ABRT_TXDATA_NOACK | \
> +					 DW_IC_TX_ABRT_GCALL_NOACK)
> +
> +

Two blank lines.

> +
> +extern void i2c_dw_init(struct dw_i2c_dev *dev);
> +extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> +		int num);
> +extern u32 i2c_dw_func(struct i2c_adapter *adap);
> +extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);

Yeah, we have these in place.

> diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
> new file mode 100644
> index 0000000..11185b2
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-pci.c
> @@ -0,0 +1,183 @@
[...]
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include "i2c-designware-core.h"

I guess we could omit more headers.

> diff --git a/drivers/i2c/busses/i2c-designware-plat.c b/drivers/i2c/busses/i2c-designware-plat.c
> new file mode 100644
> index 0000000..b8e5aa4
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-plat.c
> @@ -0,0 +1,198 @@
[...]
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#include "i2c-designware-core.h"

Same here.

And the following is the diff between -pci.c and -plat.c.

>--- drivers/i2c/busses/i2c-designware-pci.c	2011-01-23 10:29:34.178022264 +0900
>+++ drivers/i2c/busses/i2c-designware-plat.c	2011-01-23 10:29:34.190022267 +0900
>@@ -25,11 +25,11 @@
>  * ----------------------------------------------------------------------------
>  *
>  */
>-
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/delay.h>
> #include <linux/i2c.h>
>+#include <linux/clk.h>
> #include <linux/errno.h>
> #include <linux/sched.h>
> #include <linux/err.h>
>@@ -37,6 +37,7 @@
> #include <linux/platform_device.h>
> #include <linux/io.h>
> #include <linux/slab.h>
>+
> #include "i2c-designware-core.h"
> 
> static struct i2c_algorithm i2c_dw_algo = {
>@@ -83,6 +84,12 @@ static int __devinit dw_i2c_probe(struct
> 	dev->irq = irq;
> 	platform_set_drvdata(pdev, dev);
> 
>+	dev->clk = clk_get(&pdev->dev, NULL);
>+	if (IS_ERR(dev->clk)) {
>+		r = -ENODEV;
>+		goto err_free_mem;
>+	}
>+	clk_enable(dev->clk);
> 
> 	dev->base = ioremap(mem->start, resource_size(mem));
> 	if (dev->base == NULL) {
>@@ -127,6 +134,10 @@ err_free_irq:
> 	free_irq(dev->irq, dev);
> err_iounmap:
> 	iounmap(dev->base);
>+err_unuse_clocks:
>+	clk_disable(dev->clk);
>+	clk_put(dev->clk);
>+	dev->clk = NULL;
> err_free_mem:
> 	platform_set_drvdata(pdev, NULL);
> 	put_device(&pdev->dev);
>@@ -146,6 +157,10 @@ static int __devexit dw_i2c_remove(struc
> 	i2c_del_adapter(&dev->adapter);
> 	put_device(&pdev->dev);
> 
>+	clk_disable(dev->clk);
>+	clk_put(dev->clk);
>+	dev->clk = NULL;
>+
> 	writel(0, dev->base + DW_IC_ENABLE);
> 	free_irq(dev->irq, dev);
> 	kfree(dev);

-pci.c is primary meant for the Intel Moorsetown and Medfield SoCs
as of now, and we're fine with removing clkdev API dependencies from
-pci.c file.

That said, two concerns.  First, clkdev API support isn't related to
PCI support, so it might be reasonable to disable clk_ procedures appear
in the above patch simply using #ifdef HAVE_CLK, rather than completely
removed.  The other is, how about separating such changes into another
commit, or cook it along with PATCH 3/9?

I'll follow up other patches later.
-- 
Shinya Kuribayashi
Renesas Electronics
