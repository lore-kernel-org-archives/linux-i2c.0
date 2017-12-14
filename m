From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 6/7] i3c: master: Add driver for Cadence IP
Date: Thu, 14 Dec 2017 11:54:16 -0800
Message-ID: <d0685c1d-a3ed-b3c1-7e3f-b69b02e8a7be@infradead.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-7-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214151610.19153-7-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Suresh Punnoose <sureshp-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vitor Soares <Vitor.Soares-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12/14/2017 07:16 AM, Boris Brezillon wrote:
> Add a driver for Cadence I3C master IP.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> Changes in v2:
> - Add basic IBI support. Note that the IP is not really reliable with
>   regards to IBI because you can't extract IBI payloads as soon as you
>   have more than one IBI waiting in the HW queue. This is something
>   that will hopefully be addressed in future revisions of this IP
> - Add a simple xfer queueing mechanism to optimize message queuing.
> - Fix a few bugs
> - Add support for Hot Join
> ---
>  drivers/i3c/master/Kconfig           |    5 +
>  drivers/i3c/master/Makefile          |    1 +
>  drivers/i3c/master/i3c-master-cdns.c | 1797 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1803 insertions(+)
>  create mode 100644 drivers/i3c/master/i3c-master-cdns.c
> 
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index e69de29bb2d1..56b9a18543b2 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -0,0 +1,5 @@
> +config CDNS_I3C_MASTER
> +	tristate "Cadence I3C master driver"
> +	depends on I3C
> +	help
> +	  Enable this driver if you want to support Cadence I3C master block.
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index e69de29bb2d1..4c4304aa9534 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> new file mode 100644
> index 000000000000..3e3ef37c01c2
> --- /dev/null
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -0,0 +1,1797 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> + */
> +

Rule #1 from submit-checklist.rst:
1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


#include <linux/bitops.h>
for BIT(x) and hweight8() and clear_bit() and find_next_bit()
and hweight32()

> +#include <linux/clk.h>

#include <linux/err.h>
for IS_ERR(), PTR_ERR()

#include <linux/errno.h>
for error codes

> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>

#include <linux/io.h>
for writel()

> +#include <linux/iopoll.h>

#include <linux/ioport.h>
for IORESOURCE_MEM

#include <linux/kernel.h>
for DIV_ROUND_UP()

#include <linux/list.h>
for list() macros and INIT_LIST_HEAD()

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

#include <linux/spinlock.h>

#include <linux/workqueue.h>
for workqueue functions and INIT_WORK()

> +
> +#define DEV_ID				0x0
> +#define DEV_ID_I3C_MASTER		0x5034

[snip]



> +#define I3C_DDR_FIRST_DATA_WORD_PREAMBLE	0x2
> +#define I3C_DDR_DATA_WORD_PREAMBLE		0x3
> +
> +#define I3C_DDR_PREAMBLE(p)			((p) << 18)
> +
> +static u32 prepare_ddr_word(u16 payload)
> +{
> +	u32 ret;
> +	u16 pb;
> +
> +	ret = (u32)payload << 2;
> +
> +	/* Calculate parity. */
> +	pb = (payload >> 15) ^ (payload >> 13) ^ (payload >> 11) ^
> +	     (payload >> 9) ^ (payload >> 7) ^ (payload >> 5) ^
> +	     (payload >> 3) ^ (payload >> 1);
> +	ret |= (pb & 1) << 1;
> +	pb = (payload >> 14) ^ (payload >> 12) ^ (payload >> 10) ^
> +	     (payload >> 8) ^ (payload >> 6) ^ (payload >> 4) ^
> +	     (payload >> 2) ^ payload ^ 1;
> +	ret |= (pb & 1);
> +
> +	return ret;
> +}
> +
> +static u32 prepare_ddr_data_word(u16 data, bool first)
> +{
> +	return prepare_ddr_word(data) | I3C_DDR_PREAMBLE(first ? 2 : 3);

Just defined macros for 2 & 3 above. Use them instead of magic numbers?

> +}
> +
> +#define I3C_DDR_READ_CMD	BIT(15)
> +
> +static u32 prepare_ddr_cmd_word(u16 cmd)
> +{
> +	return prepare_ddr_word(cmd) | I3C_DDR_PREAMBLE(1);
> +}
> +
> +static u32 prepare_ddr_crc_word(u8 crc5)
> +{
> +	return (((u32)crc5 & 0x1f) << 9) | (0xc << 14) |
> +	       I3C_DDR_PREAMBLE(1);
> +}
> +
> +static u8 update_crc5(u8 crc5, u16 word)
> +{
> +	u8 crc0;
> +	int i;
> +
> +	/*
> +	 * crc0 = next_data_bit ^ crc[4]
> +	 *                1         2            3       4
> +	 * crc[4:0] = { crc[3:2], crc[1]^crc0, crc[0], crc0 }
> +	 */
> +	for (i = 0; i < 16; ++i) {
> +		crc0 = ((word >> (15 - i)) ^ (crc5 >> 4)) & 0x1;
> +		crc5 = ((crc5 << 1) & (0x18 | 0x2)) |
> +		       (((crc5 >> 1) ^ crc0) << 2) | crc0;
> +	}
> +
> +	return crc5 & 0x1F;
> +}
> +

[snip]



> +static int cdns_i3c_master_do_daa_locked(struct cdns_i3c_master *master)
> +{
> +	unsigned long i3c_lim_period, pres_step, i3c_scl_lim;
> +	struct i3c_device_info devinfo;
> +	struct i3c_device *i3cdev;
> +	u32 prescl1, ctrl, devs;
> +	int ret, slot, ncycles;
> +
> +	ret = i3c_master_entdaa_locked(&master->base);
> +	if (ret)
> +		return ret;
> +
> +	/* Now, add discovered devices to the bus. */
> +	i3c_scl_lim = master->i3c_scl_lim;
> +	devs = readl(master->regs + DEVS_CTRL);
> +	for (slot = find_next_bit(&master->free_dev_slots, BITS_PER_LONG, 1);
> +	     slot < BITS_PER_LONG;
> +	     slot = find_next_bit(&master->free_dev_slots,
> +				  BITS_PER_LONG, slot + 1)) {
> +		struct cdns_i3c_i2c_dev_data *data;
> +		u32 rr, max_fscl = 0;
> +		u8 addr;
> +
> +		if (!(devs & DEVS_CTRL_DEV_ACTIVE(slot)))
> +			continue;
> +
> +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		data->ibi = -1;
> +		data->id = slot;
> +		rr = readl(master->regs + DEV_ID_RR0(slot));
> +		addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
> +		i3cdev = i3c_master_add_i3c_dev_locked(&master->base, addr);
> +		if (IS_ERR(i3cdev))
> +			return PTR_ERR(i3cdev);
> +
> +		i3c_device_get_info(i3cdev, &devinfo);
> +		clear_bit(data->id, &master->free_dev_slots);
> +		i3c_device_set_master_data(i3cdev, data);
> +
> +		max_fscl = max(I3C_CCC_MAX_SDR_FSCL(devinfo.max_read_ds),
> +			       I3C_CCC_MAX_SDR_FSCL(devinfo.max_write_ds));
> +		switch (max_fscl) {
> +		case I3C_SDR_DR_FSCL_8MHZ:
> +			max_fscl = 8000000;
> +			break;
> +		case I3C_SDR_DR_FSCL_6MHZ:
> +			max_fscl = 6000000;
> +			break;
> +		case I3C_SDR_DR_FSCL_4MHZ:
> +			max_fscl = 4000000;
> +			break;
> +		case I3C_SDR_DR_FSCL_2MHZ:
> +			max_fscl = 2000000;
> +			break;
> +		case I3C_SDR_DR_FSCL_MAX:
> +		default:
> +			max_fscl = 0;
> +			break;
> +		}
> +
> +		if (max_fscl && (max_fscl < i3c_scl_lim || !i3c_scl_lim))
> +			i3c_scl_lim = max_fscl;
> +	}
> +
> +	i3c_master_defslvs_locked(&master->base);
> +
> +	pres_step = 1000000000 / (master->base.bus->scl_rate.i3c * 4);

Does that build OK on 32-bit target arch?

> +
> +	/* No bus limitation to apply, bail out. */
> +	if (!i3c_scl_lim ||
> +	    (master->i3c_scl_lim && master->i3c_scl_lim <= i3c_scl_lim))
> +		return 0;
> +
> +	/* Configure PP_LOW to meet I3C slave limitations. */
> +	prescl1 = readl(master->regs + PRESCL_CTRL1) &
> +		  ~PRESCL_CTRL1_PP_LOW_MASK;
> +	ctrl = readl(master->regs + CTRL) & ~CTRL_DEV_EN;
> +
> +	i3c_lim_period = DIV_ROUND_UP(1000000000, i3c_scl_lim);
> +	ncycles = DIV_ROUND_UP(i3c_lim_period, pres_step) - 4;
> +	if (ncycles < 0)
> +		ncycles = 0;
> +	prescl1 |= PRESCL_CTRL1_PP_LOW(ncycles);
> +
> +	/* Disable I3C master before updating PRESCL_CTRL1. */
> +	ret = cdns_i3c_master_disable(master);
> +	if (!ret) {
> +		writel(prescl1, master->regs + PRESCL_CTRL1);
> +		master->i3c_scl_lim = i3c_scl_lim;
> +	}
> +	cdns_i3c_master_enable(master);
> +
> +	return ret;
> +}
> +
> +static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
> +{
> +	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
> +	unsigned long pres_step, sysclk_rate, max_i2cfreq;
> +	u32 ctrl, prescl0, prescl1, pres, low;
> +	struct i3c_device_info info = { };
> +	struct i3c_ccc_events events;
> +	struct i2c_device *i2cdev;
> +	struct i3c_device *i3cdev;
> +	int ret, slot, ncycles;
> +	u8 last_addr = 0;
> +
> +	switch (m->bus->mode) {
> +	case I3C_BUS_MODE_PURE:
> +		ctrl = CTRL_PURE_BUS_MODE;
> +		break;
> +
> +	case I3C_BUS_MODE_MIXED_FAST:
> +		ctrl = CTRL_MIXED_FAST_BUS_MODE;
> +		break;
> +
> +	case I3C_BUS_MODE_MIXED_SLOW:
> +		ctrl = CTRL_MIXED_SLOW_BUS_MODE;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	sysclk_rate = clk_get_rate(master->sysclk);
> +	if (!sysclk_rate)
> +		return -EINVAL;
> +
> +	pres = DIV_ROUND_UP(sysclk_rate, (m->bus->scl_rate.i3c * 4)) - 1;
> +	if (pres > PRESCL_CTRL0_MAX)
> +		return -ERANGE;
> +
> +	m->bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
> +
> +	prescl0 = PRESCL_CTRL0_I3C(pres);
> +
> +	low = ((I3C_BUS_TLOW_OD_MIN_NS * sysclk_rate) / (pres + 1)) - 2;
> +	prescl1 = PRESCL_CTRL1_OD_LOW(low);
> +
> +	max_i2cfreq = m->bus->scl_rate.i2c;
> +
> +	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
> +	if (pres > PRESCL_CTRL0_MAX)
> +		return -ERANGE;
> +
> +	m->bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
> +
> +	prescl0 |= PRESCL_CTRL0_I2C(pres);
> +
> +	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
> +
> +	i3c_bus_for_each_i2cdev(m->bus, i2cdev) {
> +		ret = cdns_i3c_master_attach_i2c_dev(master, i2cdev);
> +		if (ret)
> +			goto err_detach_devs;
> +	}
> +
> +	writel(prescl0, master->regs + PRESCL_CTRL0);
> +
> +	/* Calculate OD and PP low. */
> +	pres_step = 1000000000 / (m->bus->scl_rate.i3c * 4);
> +	ncycles = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, pres_step) - 2;
> +	if (ncycles < 0)
> +		ncycles = 0;
> +	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
> +	writel(prescl1, master->regs + PRESCL_CTRL1);
> +
> +	i3c_bus_for_each_i3cdev(m->bus, i3cdev) {
> +		ret = cdns_i3c_master_attach_i3c_dev(master, i3cdev);
> +		if (ret)
> +			goto err_detach_devs;
> +	}
> +
> +	/* Get an address for the master. */
> +	ret = i3c_master_get_free_addr(m, 0);
> +	if (ret < 0)
> +		goto err_detach_devs;
> +
> +	writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
> +	       master->regs + DEV_ID_RR0(0));
> +
> +	cdns_i3c_master_dev_rr_to_info(master, 0, &info);
> +	if (info.bcr & I3C_BCR_HDR_CAP)
> +		info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
> +
> +	ret = i3c_master_set_info(&master->base, &info);
> +	if (ret)
> +		goto err_detach_devs;
> +
> +	/* Prepare RR slots before lauching DAA. */

	                           launching

> +	for (slot = find_next_bit(&master->free_dev_slots, BITS_PER_LONG, 1);
> +	     slot < BITS_PER_LONG;
> +	     slot = find_next_bit(&master->free_dev_slots,
> +				  BITS_PER_LONG, slot + 1)) {
> +		ret = i3c_master_get_free_addr(m, last_addr + 1);
> +		if (ret < 0)
> +			goto err_disable_master;
> +
> +		last_addr = ret;
> +		writel(prepare_rr0_dev_address(last_addr) | DEV_ID_RR0_IS_I3C,
> +		       master->regs + DEV_ID_RR0(slot));
> +		writel(0, master->regs + DEV_ID_RR1(slot));
> +		writel(0, master->regs + DEV_ID_RR2(slot));
> +	}
> +
> +	/*
> +	 * Enable Hot-Join and when a Hot-Join request happen, disable all

	                                               happens,

> +	 * events coming from this device.
> +	 *
> +	 * We will issue ENTDAA afterwards from the threaded IRQ handler.
> +	 */
> +	ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC | CTRL_HALT_EN;
> +	writel(ctrl, master->regs + CTRL);
> +
> +	cdns_i3c_master_enable(master);
> +
> +	/*
> +	 * Reset all dynamic addresses on the bus, because we don't know what
> +	 * happened before this point (the bootloader may have assigned dynamic
> +	 * addresses that we're not aware of).
> +	 */
> +	ret = i3c_master_rstdaa_locked(m, I3C_BROADCAST_ADDR);
> +	if (ret)
> +		goto err_disable_master;
> +
> +	/* Disable all slave events (interrupts) before starting DAA. */
> +	events.events = I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> +			I3C_CCC_EVENT_HJ;
> +	ret = i3c_master_disec_locked(m, I3C_BROADCAST_ADDR, &events);
> +	if (ret)
> +		goto err_disable_master;
> +
> +	ret = cdns_i3c_master_do_daa_locked(master);
> +	if (ret < 0)
> +		goto err_disable_master;
> +
> +	/* Unmask Hot-Join and Marstership request interrupts. */

	Is that                Mastership ?

> +	events.events = I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR;
> +	ret = i3c_master_enec_locked(m, I3C_BROADCAST_ADDR, &events);
> +	if (ret)
> +		pr_info("Failed to re-enable H-J");

		Not very good info...

> +
> +	writel(MST_INT_HJ_REQ, master->regs + MST_IER);
> +	return 0;
> +
> +err_disable_master:
> +	cdns_i3c_master_disable(master);
> +
> +err_detach_devs:
> +	cdns_i3c_master_bus_cleanup(m);
> +
> +	return ret;
> +}
> +

[snip]


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
