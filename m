From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: add High-speed mode support
Date: Fri, 09 Oct 2015 12:29:32 +0300
Message-ID: <1444382972.8361.516.camel@linux.intel.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10282 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770AbbJIJ3h (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 9 Oct 2015 05:29:37 -0400
In-Reply-To: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wangxfdu@gmail.com, xiang.a.wang@intel.com, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-10-09 at 16:47 +0800, wangxfdu@gmail.com wrote:
> From: Xiang Wang <xiang.a.wang@intel.com>
> 
> 1. Add High-speed mode support in designware core
> 2. Add function i2c_dw_acpi_setup_speed to determine
> the bus speed from ACPI table.
> 
> Signed-off-by: Xiang Wang <xiang.a.wang@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 88 
> ++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h | 11 ++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c 
> b/drivers/i2c/busses/i2c-designware-core.c
> index 6f19a33..f5c0d18 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -30,6 +30,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/acpi.h>

Shouldn't be a part of platform driver?

>  #include "i2c-designware-core.h"
>  
>  /*
> @@ -42,6 +43,8 @@
>  #define DW_IC_SS_SCL_LCNT	0x18
>  #define DW_IC_FS_SCL_HCNT	0x1c
>  #define DW_IC_FS_SCL_LCNT	0x20
> +#define DW_IC_HS_SCL_HCNT	0x24
> +#define DW_IC_HS_SCL_LCNT	0x28
>  #define DW_IC_INTR_STAT		0x2c
>  #define DW_IC_INTR_MASK		0x30
>  #define DW_IC_RAW_INTR_STAT	0x34
> @@ -358,6 +361,16 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
>  	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, 
> lcnt);
>  
> +	if (dev->hs_hcnt && dev->hs_lcnt) {
> +		hcnt = dev->hs_hcnt;
> +		lcnt = dev->hs_lcnt;
> +
> +		dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
> +		dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
> +		dev_dbg(dev->dev, "High-speed mode HCNT:LCNT = 
> %d:%d\n",
> +					hcnt, lcnt);
> +	}
> +
>  	/* Configure SDA Hold Time if required */
>  	if (dev->sda_hold_time) {
>  		reg = dw_readl(dev, DW_IC_COMP_VERSION);
> @@ -381,6 +394,81 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_init);
>  
> +#ifdef CONFIG_ACPI
> +static int i2c_dw_acpi_get_freq(struct acpi_resource *ares, void 
> *data)
> +{
> +	struct dw_i2c_dev *i2c = data;
> +	struct acpi_resource_i2c_serialbus *sb;
> +	u32 i2c_speed;
> +
> +	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> +		sb = &ares->data.i2c_serial_bus;
> +
> +		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +			i2c_speed = sb->connection_speed;
> +			if (i2c_speed == DW_STD_SPEED) {
> +				i2c->master_cfg &= 
> ~DW_IC_SPEED_MASK;
> +				i2c->master_cfg |= 
> DW_IC_CON_SPEED_STD;
> +			} else if (i2c_speed == DW_FAST_SPEED) {
> +				i2c->master_cfg &= 
> ~DW_IC_SPEED_MASK;
> +				i2c->master_cfg |= 
> DW_IC_CON_SPEED_FAST;
> +			} else if (i2c_speed == DW_HIGH_SPEED) {
> +				i2c->master_cfg &= 
> ~DW_IC_SPEED_MASK;
> +				i2c->master_cfg |= 
> DW_IC_CON_SPEED_HIGH;
> +			} else {
> +				dev_err(i2c->dev, "unsupported 
> speed: %d\n",
> +					i2c_speed);
> +			}
> +
> +			dev_dbg(i2c->dev, "i2c device speed from 
> acpi = %d\n",
> +					i2c_speed);
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static acpi_status acpi_i2c_find_device_speed(acpi_handle handle, 
> u32 level,
> +					void *data, void 
> **return_value)
> +{
> +	struct dw_i2c_dev *i2c = data;
> +	struct list_head resource_list;
> +	struct acpi_device *adev;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +	if (acpi_bus_get_status(adev) || !adev->status.present)
> +		return AE_OK;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	acpi_dev_get_resources(adev, &resource_list,
> +				i2c_dw_acpi_get_freq, i2c);
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	return AE_OK;
> +}
> +
> +void i2c_dw_acpi_setup_speed(struct device *pdev, struct dw_i2c_dev 
> *dev)
> +{
> +	acpi_handle handle = ACPI_HANDLE(pdev);
> +	acpi_status status;
> +
> +	if (handle == NULL)
> +		return;
> +
> +	/* Find I2C adapter bus frequency */
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_i2c_find_device_speed, 
> NULL,
> +				     dev, NULL);
> +	if (ACPI_FAILURE(status))
> +		dev_warn(pdev, "failed to get I2C bus freq\n");
> +}
> +
> +#else
> +void i2c_dw_acpi_setup_speed(struct device *pdev, struct dw_i2c_dev 
> *dev) {}
> +#endif
> +EXPORT_SYMBOL_GPL(i2c_dw_acpi_setup_speed);
> +
>  /*
>   * Waiting for bus not busy
>   */
> diff --git a/drivers/i2c/busses/i2c-designware-core.h 
> b/drivers/i2c/busses/i2c-designware-core.h
> index 9630222..16f53d8 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -24,12 +24,17 @@
>  
>  
>  #define DW_IC_CON_MASTER		0x1
> +#define DW_IC_SPEED_MASK		0x6
>  #define DW_IC_CON_SPEED_STD		0x2
>  #define DW_IC_CON_SPEED_FAST		0x4
> +#define DW_IC_CON_SPEED_HIGH		0x6
>  #define DW_IC_CON_10BITADDR_MASTER	0x10
>  #define DW_IC_CON_RESTART_EN		0x20
>  #define DW_IC_CON_SLAVE_DISABLE		0x40
>  
> +#define DW_STD_SPEED	100000
> +#define DW_FAST_SPEED	400000
> +#define DW_HIGH_SPEED	3400000
>  
>  /**
>   * struct dw_i2c_dev - private i2c-designware data
> @@ -61,6 +66,8 @@
>   * @ss_lcnt: standard speed LCNT value
>   * @fs_hcnt: fast speed HCNT value
>   * @fs_lcnt: fast speed LCNT value
> + * @hs_hcnt: high speed HCNT value
> + * @hs_lcnt: high speed LCNT value
>   * @acquire_lock: function to acquire a hardware lock on the bus
>   * @release_lock: function to release a hardware lock on the bus
>   * @pm_runtime_disabled: true if pm runtime is disabled
> @@ -104,6 +111,8 @@ struct dw_i2c_dev {
>  	u16			ss_lcnt;
>  	u16			fs_hcnt;
>  	u16			fs_lcnt;
> +	u16			hs_hcnt;
> +	u16			hs_lcnt;
>  	int			(*acquire_lock)(struct dw_i2c_dev 
> *dev);
>  	void			(*release_lock)(struct dw_i2c_dev 
> *dev);
>  	bool			pm_runtime_disabled;
> @@ -114,6 +123,8 @@ struct dw_i2c_dev {
>  
>  extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
>  extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
> +extern void i2c_dw_acpi_setup_speed(struct device *pdev,
> +		struct dw_i2c_dev *dev);
>  extern int i2c_dw_init(struct dw_i2c_dev *dev);
>  extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg 
> msgs[],
>  		int num);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
