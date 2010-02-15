From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Mon, 15 Feb 2010 18:26:20 +0000
Message-ID: <4B7991CC.3020904@cam.ac.uk>
References: <20100213230438.31fd0fd7@hyperion.delvare> <20100213230656.341ec091@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230656.341ec091-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I have a couple of parts I can test this on (connected to a pxa271)
but it may be a little while before I get to it (so don't let me
hold the patch up!)

On tiny point below.  Worth changing if you are doing another roll of the patch
as at least in my dozy Monday evening state it confused me for a few moments!

Thanks,

Jonathan

Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> SMBus alert support. The SMBus alert protocol allows several SMBus
> slave devices to share a single interrupt pin on the SMBus master,
> while still allowing the master to know which slave triggered the
> interrupt.
> 
> This is based on preliminary work by David Brownell. The key
> difference between David's implementation and mine is that his was
> part of i2c-core, while mine is split into a separate, standalone
> module named i2c-smbus. The i2c-smbus module is meant to include
> support for all SMBus extensions to the I2C protocol in the future.
> 
> The benefit of this approach is a zero cost for I2C bus segments which
> do not need SMBus alert support. Where David's implementation
> increased the size of struct i2c_adapter by 7% (40 bytes on i386),
> mine doesn't touch it. Where David's implementation added over 150
> lines of code to i2c-core (+10%), mine doesn't touch it. The only
> change that touches all the users of the i2c subsystem is a new
> callback in struct i2c_driver (common to both implementations.) I seem
> to remember Trent was worried about the footprint of David'd
> implementation, hopefully mine addresses the issue.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  Documentation/i2c/smbus-protocol |   16 ++
>  drivers/i2c/Makefile             |    2 
>  drivers/i2c/i2c-smbus.c          |  264 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-smbus.h        |   50 +++++++
>  include/linux/i2c.h              |    7 +
>  5 files changed, 338 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.33-rc7.orig/Documentation/i2c/smbus-protocol	2010-02-12 14:19:47.000000000 +0100
> +++ linux-2.6.33-rc7/Documentation/i2c/smbus-protocol	2010-02-12 14:19:51.000000000 +0100
> @@ -185,6 +185,22 @@ the protocol. All ARP communications use
>  require PEC checksums.
>  
>  
> +SMBus Alert
> +===========
> +
> +SMBus Alert was introduced in Revision 1.0 of the specification.
> +
> +The SMBus alert protocol allows several SMBus slave devices to share a
> +single interrupt pin on the SMBus master, while still allowing the master
> +to know which slave triggered the interrupt.
> +
> +This is implemented the following way in the Linux kernel:
> +* I2C bus drivers which support SMBus alert should call
> +  i2c_setup_smbus_alert() to setup SMBus alert support.
> +* I2C drivers for devices which can trigger SMBus alerts should implement
> +  the optional alert() callback.
> +
> +
>  I2C Block Transactions
>  ======================
>  
> --- linux-2.6.33-rc7.orig/drivers/i2c/Makefile	2010-02-12 14:19:47.000000000 +0100
> +++ linux-2.6.33-rc7/drivers/i2c/Makefile	2010-02-12 16:08:34.000000000 +0100
> @@ -3,7 +3,7 @@
>  #
>  
>  obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
> -obj-$(CONFIG_I2C)		+= i2c-core.o
> +obj-$(CONFIG_I2C)		+= i2c-core.o i2c-smbus.o
>  obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
>  obj-y				+= busses/ chips/ algos/
>  
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.33-rc7/drivers/i2c/i2c-smbus.c	2010-02-12 16:11:34.000000000 +0100
...
> +/*
> + * The alert IRQ handler needs to hand work off to a task which can issue
> + * SMBus calls, because those sleeping calls can't be made in IRQ context.
> + */
> +static void smbus_alert(struct work_struct *work)
> +{
> +	struct i2c_smbus_alert *data;
> +	struct i2c_client *ara;
> +	unsigned short prev_addr = 0;	/* Not a valid address */
> +
> +	data = container_of(work, struct i2c_smbus_alert, alert);
> +	ara = data->ara;
> +
> +	for (;;) {
> +		s32 status;
> +		struct alert_data data;
Can we change the name of data here.  From readability point of view it
would be better not to have this reliance on scope (as data used for 
struct i2c_smbus_alert *data above. (obviously changing it above would 
work as well!) 
> +
> +		/*
> +		 * Devices with pending alerts reply in address order, low
> +		 * to high, because of slave transmit arbitration.  After
> +		 * responding, an SMBus device stops asserting SMBALERT#.
> +		 *
> +		 * Note that SMBus 2.0 reserves 10-bit addresess for future
> +		 * use.  We neither handle them, nor try to use PEC here.
> +		 */
> +		status = i2c_smbus_read_byte(ara);
> +		if (status < 0)
> +			break;
> +
> +		data.flag = status & 1;
> +		data.addr = status >> 1;
> +
> +		if (data.addr == prev_addr) {
> +			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
> +				"0x%02x, skipping\n", data.addr);
> +			break;
> +		}
> +		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
> +			data.addr, data.flag);
> +
> +		/* Notify driver for the device which issued the alert */
> +		device_for_each_child(&ara->adapter->dev, &data,
> +				      smbus_do_alert);
> +		prev_addr = data.addr;
> +	}
> +
> +	/* We handled all alerts; re-enable level-triggered IRQs */
> +	if (!data->alert_edge_triggered)
> +		enable_irq(data->irq);
> +}
> 
