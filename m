From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 08:24:45 +0100
Message-ID: <20130124072445.GA8364@nekote.pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Viresh,

I think we are getting close.

On Mon, Dec 03, 2012 at 08:24:04AM +0530, Viresh Kumar wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
> protocol Rev. 03 section 3.1.16 titled "Bus clear".
> 
> http://www.nxp.com/documents/user_manual/UM10204.pdf
> 
> Sometimes during operation i2c bus hangs and we need to give dummy clocks to
> slave device to start the transfer again. Now we may have capability in the bus
> controller to generate these clocks or platform may have gpio pins which can be
> toggled to generate dummy clocks. This patch supports both.
> 
> This patch also adds in generic bus recovery routines gpio or scl line based
> which can be used by bus controller. In addition controller driver may provide
> its own version of the bus recovery routine.
> 
> This doesn't support multi-master recovery for now.

Assuming that recover_bus is not called on BUS_BUSY but on TIMEOUTs,,
this should work?

> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> V7->V8:
> - Clk rate fixed to 100KHz
> - Check SCL line to see if it is LOW due to some faults
> - removed last use of unlikely() in earlier patch
> - Enhanced comment over skip_sda_polling

I am still not sure why we need it. I prefixed comments which sketch a
way to get rid of it with an '*' at the beginning of the line.

> 
> V6->V7:
> - Lots of review comments from Wolfram incorporated
> - get[put]_gpio updated to more generic [un]prepare_recovery with return type as
>   void.
> - prototypes of generic recovery routines are exposed to controller driver and
>   they are now required to pass recover_bus()
> - gpio flags removed from recovery info
> - default clock rate is 100 KHz if not passed by controller driver
> - clk count is 9, fixed.
> 
> V5->V6:
> - Removed sda_gpio_flags
> - Make scl_gpio_flags as GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH by default
> - update bri->set_scl and bri->get_sda for gpio recovery case in i2c core
> - Guaranteed to generate 9 falling-rising edges for bus recovery
> 
> V4->V5:
> - section name corrected to 3.1.16
> - merged gpio and non-gpio recovery routines to remove code redundancy
> - Changed types of gpio and gpio-flags to unsigned and unsigned long
> - Checking return value of get_gpio() now
> - using DIV_ROUND_UP for calculating delay, to get more correct value
> 
>  drivers/i2c/i2c-core.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    |  50 +++++++++++++++++
>  2 files changed, 198 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..9b6a1a6 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -27,7 +27,9 @@
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -104,6 +106,122 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
>  
> +/* i2c bus recovery routines */
> +#define RECOVERY_CLK_CNT	9
> +#define DEFAULT_CLK_RATE	100	/* KHz */
> +/* 10^6/KHz for delay in ns */
> +unsigned long clk_delay = DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * 2);

no global variable. should go into the function needing it.

> +
> +static int get_sda_gpio_value(struct i2c_adapter *adap)
> +{
> +	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
> +}
> +
> +static int get_scl_gpio_value(struct i2c_adapter *adap)
> +{
> +	return gpio_get_value(adap->bus_recovery_info->scl_gpio);
> +}
> +
> +static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
> +{
> +	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
> +}
> +
> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> +	struct device *dev = &adap->dev;
> +	int ret = 0;
> +
> +	ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
> +			GPIOF_OUT_INIT_HIGH, "i2c-scl");
> +	if (ret) {
> +		dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		return ret;
> +	}
> +
> +	if (!bri->skip_sda_polling) {

* if (is_valid_gpio(bri->sda_gpio)) ...

> +		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
> +			/* work without sda polling */
> +			dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
> +					bri->sda_gpio);
> +			bri->skip_sda_polling = true;

* Instead of above line:
	bri->get_sda = get_sda_gpio_value;

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> +
> +	if (!bri->skip_sda_polling)

* if (is_valid_gpio(bri->sda_gpio)) ...

> +		gpio_free(bri->sda_gpio);
> +
> +	gpio_free(bri->scl_gpio);
> +}
> +
> +static int i2c_generic_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> +	int i, val = 0;
> +
> +	if (bri->prepare_recovery)
> +		bri->prepare_recovery(bri);

prepare_recovery and unprepare should be in i2c_generic_scl_recovery and
i2c_generic_gpio_recovery since they are probably needed to turn SDA/SCL
into GPIOs and back. We want that before the gpio_get/put routines.

> +
> +	/* SCL shouldn't be low here */
> +	if (!bri->get_scl(adap)) {
> +		dev_err(&adap->dev, "SCL is stuck Low, exiting recovery.\n");

returning -EBUSY?

> +		goto unprepare;
> +	}
> +
> +	/*
> +	 * By this time SCL is high, as we need to give 9 falling-rising edges
> +	 */
> +	for (i = 0; i < RECOVERY_CLK_CNT * 2; i++, val = !val) {
> +		bri->set_scl(adap, val);
> +		ndelay(clk_delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)

* if (val && bri->get_sda)

> +			/* Check SCL again to see fault condition */
> +			if (!bri->get_scl(adap)) {
> +				dev_err(&adap->dev, "SCL is stuck Low during recovery, exiting recovery.\n");

returning -EBUSY?
This scl check should not depend on skip_sda_polling, or?

> +				goto unprepare;
> +			}
> +
> +			if (bri->get_sda(adap))
> +				break;

Checking SDA should be done before setting SCL? That would

a) let us escape early if SDA got HIGH magically somehow until we enter
   the for loop for the first time
b) breaking out of the for loop after the last pulse is moot

> +	}
> +
> +unprepare:
> +	if (bri->unprepare_recovery)
> +		bri->unprepare_recovery(bri);
> +
> +	return 0;
> +}
> +
> +int i2c_generic_scl_recovery(struct i2c_adapter *adap)
> +{
> +	adap->bus_recovery_info->set_scl(adap, 1);
> +	return i2c_generic_recovery(adap);
> +}
> +
> +int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
> +{
> +	int ret;
> +
> +	ret = i2c_get_gpios_for_recovery(adap);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_generic_recovery(adap);
> +	i2c_put_gpios_for_recovery(adap);
> +
> +	return ret;
> +}
> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client = i2c_verify_client(dev);
> @@ -896,6 +1014,36 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  			 "Failed to create compatibility class link\n");
>  #endif
>  
> +	/* bus recovery specific initialization */
> +	if (adap->bus_recovery_info) {
> +		struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> +
> +		if (!bri->recover_bus) {
> +			dev_err(&adap->dev, "Invalid recover_bus(), skip recovery \n");
> +			adap->bus_recovery_info = NULL;
> +			goto exit_recovery;
> +		}
> +
> +		/* GPIO recovery */
> +		if (bri->recover_bus == i2c_generic_gpio_recovery) {
> +			bri->get_scl = get_scl_gpio_value;
> +			bri->set_scl = set_scl_gpio_value;
> +
> +			if (!bri->skip_sda_polling)
> +				bri->get_sda = get_sda_gpio_value;

* was moved upwards

> +		} else if (bri->set_scl) {
> +			if (!bri->skip_sda_polling && !bri->get_sda) {

* if (!bri->get_sda) ...

> +				dev_warn(&adap->dev,
> +						"!get_sda. skip sda polling\n");

That message needs improvement ("!get_sda").

> +				bri->skip_sda_polling = true;
> +			}
> +		} else {
> +			dev_warn(&adap->dev,
> +					"doesn't have valid recovery type\n");
> +		}
> +	}
> +
> +exit_recovery:
>  	/* create pre-declared device nodes */
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 800de22..165282f 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -368,6 +368,54 @@ struct i2c_algorithm {
>  	u32 (*functionality) (struct i2c_adapter *);
>  };
>  
> +/**
> + * struct i2c_bus_recovery_info - I2c bus recovery information

I2C

> + * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
> + *	i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
> + * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
> + *	it became high or not. Platforms/controllers which don't have
> + *	configuration registers to control sda line must set this. Only required
> + *	if recover_bus == NULL.

Last sentence is moot, because recover_bus is not allowed to be NULL.

* or can be removed

> + * @get_sda: This gets current value of sda line. For GPIO recovery
> + *	get_sda_gpio_value() is used here otherwise controller specific routine
> + *	must be passed.

* "@get_sda: This gets current value of sda line. For generic SCL recovery,
optional. For generic GPIO recovery, used internally if SDA GPIO is
set."

This block could be moved below get/set_scl.

> + * @get_scl: This gets current value of scl line. For GPIO recovery
> + *	get_scl_gpio_value() is used here otherwise controller specific routine
> + *	must be passed.

"@get_scl: This gets current value of scl line. For generic SCL
recovery, mandatory. For generic GPIO recovery, used internally."

> + * @set_scl: This sets/clears scl line. For GPIO recovery set_scl_gpio_value()
> + *	is used here otherwise controller specific routine must be passed.

Like above.

> + * @prepare_recovery: This will be called before starting recovery. Platform may
> + *	configure padmux here for sda/scl line or something else they want.
> + * @unprepare_recovery: This will be called after completing recovery. Platform
> + *	may configure padmux here for sda/scl line or something else they want.
> + * @scl_gpio: gpio number of the scl line. Only required for GPIO recovery.
> + * @sda_gpio: gpio number of the sda line. Only required for GPIO recovery.
> + */
> +struct i2c_bus_recovery_info {
> +	int (*recover_bus)(struct i2c_adapter *);
> +	bool skip_sda_polling;
> +
> +	/*
> +	 * Fn pointers for recovery, will point either to:
> +	 * - set_scl_gpio_value and get_[scl]sda_gpio_value for gpio recovery
> +	 * - Controller specific routines, otherwise
> +	 */

This comment can be dropped, I think.

> +	int (*get_sda)(struct i2c_adapter *);
> +	int (*get_scl)(struct i2c_adapter *);
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +
> +	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
> +	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
> +
> +	/* gpio recovery */
> +	unsigned scl_gpio;
> +	unsigned sda_gpio;
> +};
> +
> +/* Generic recovery routines */
> +int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
> +int i2c_generic_scl_recovery(struct i2c_adapter *adap);
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
>   * with the access algorithms necessary to access it.
> @@ -391,6 +439,8 @@ struct i2c_adapter {
>  
>  	struct mutex userspace_clients_lock;
>  	struct list_head userspace_clients;
> +
> +	struct i2c_bus_recovery_info *bus_recovery_info;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)

Thanks,

   Wolfram
