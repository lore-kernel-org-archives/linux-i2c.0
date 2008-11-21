From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 21 Nov 2008 15:18:08 +0100
Message-ID: <20081121151808.324ca78c@hyperion.delvare>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<20081118091546.421d6b78@hyperion.delvare>
	<200811181401.34809.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811181401.34809.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 18 Nov 2008 14:01:34 -0800, David Brownell wrote:
> +struct alert_data {
> +	unsigned short	addr;
> +	bool		flag;
> +};
> +
> +/* If this is the alerting device, notify its driver. */
> +static int i2c_do_alert(struct device *dev, void *addrp)
> +{
> +	struct i2c_client	*client = i2c_verify_client(dev);
> +	struct alert_data	*data = addrp;
> +
> +	if (!client || client->addr != data->addr)
> +		return 0;
> +	if (client->flags & I2C_CLIENT_TEN)
> +		return 0;
> +
> +	/* Drivers should either disable alerts, or provide at least
> +	 * a minimal handler.  Lock so client->driver won't change.
> +	 */
> +	down(&dev->sem);
> +	if (client->driver) {
> +		if (client->driver->alert)
> +			client->driver->alert(client, data->flag);
> +		else
> +			dev_warn(&client->dev, "no driver alert()!\n");
> +	} else
> +		dev_dbg(&client->dev, "alert with no driver\n");
> +	up(&dev->sem);
> +
> +	/* Stop iterating after we find the device. */
> +	return -EBUSY;
> +}
> +
> +/*
> + * The alert IRQ handler needs to hand work off to a task which can issue
> + * SMBus calls, because those sleeping calls can't be made in IRQ context.
> + */
> +static void smbus_alert(struct work_struct *work)
> +{
> +	struct i2c_adapter	*bus;
> +
> +	bus = container_of(work, struct i2c_adapter, alert);
> +	for (;;) {
> +		s32			status;
> +		struct alert_data	data;
> +
> +		/* Devices with pending alerts reply in address order, low
> +		 * to high, because of slave transmit arbitration.  After
> +		 * responding, an SMBus device stops asserting SMBALERT#.
> +		 *
> +		 * NOTE that SMBus 2.0 reserves 10-bit addresess for future
> +		 * use.  We neither handle them, nor try to use PEC here.
> +		 */
> +		status = i2c_smbus_read_byte(bus->ara);
> +		if (status < 0)
> +			break;
> +
> +		data.flag = (status & 1) != 0;
> +		data.addr = status >> 1;
> +		dev_dbg(&bus->dev, "SMBALERT# %s from dev 0x%02x\n",
> +				data.flag ? "true" : "false", data.addr);
> +
> +		/* Notify driver for the device which issued the alert. */
> +		device_for_each_child(&bus->dev, &data, i2c_do_alert);
> +	}
> +
> +	/* We handled all alerts; reenable level-triggered IRQs. */
> +	if (!bus->alert_edge_triggered)
> +		enable_irq(bus->irq);
> +}

I got this function stuck in an endless loop while I was experimenting
with my parallel port evaluation board. You might argue that this is
because my code was bogus or incomplete and that would be correct, but
nevertheless, I don't think we should give driver authors the
possibility to bring their system down that way. Not to mention the
possibility of broken hardware answering to the ARA when it shouldn't.
So, I propose the following addition to make sure that we can't get
stuck in such an endless loop:

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Dismiss unhandled SMBus alerts

If a given I2C driver doesn't handle SMBus alerts properly, then there
is a risk that smbus_alert() will loop forever. We really do not want
this to happen, so add a detection mechanism which will interrupt the
loop in such a case.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.28-rc6.orig/drivers/i2c/i2c-core.c	2008-11-21 11:01:53.000000000 +0100
+++ linux-2.6.28-rc6/drivers/i2c/i2c-core.c	2008-11-21 14:55:29.000000000 +0100
@@ -446,6 +446,7 @@ static int i2c_do_alert(struct device *d
 static void smbus_alert(struct work_struct *work)
 {
 	struct i2c_adapter	*bus;
+	unsigned short		prev_addr = 0;
 
 	bus = container_of(work, struct i2c_adapter, alert);
 	for (;;) {
@@ -465,11 +466,18 @@ static void smbus_alert(struct work_stru
 
 		data.flag = (status & 1) != 0;
 		data.addr = status >> 1;
+
+		if (data.addr == prev_addr) {
+			dev_warn(&bus->dev, "Duplicate SMBALERT# from dev "
+				"0x%02x, skipping\n", data.addr);
+			break;
+		}
 		dev_dbg(&bus->dev, "SMBALERT# %s from dev 0x%02x\n",
 				data.flag ? "true" : "false", data.addr);
 
 		/* Notify driver for the device which issued the alert. */
 		device_for_each_child(&bus->dev, &data, i2c_do_alert);
+		prev_addr = data.addr;
 	}
 
 	/* We handled all alerts; reenable level-triggered IRQs. */

What do you think?

Thanks,
-- 
Jean Delvare
