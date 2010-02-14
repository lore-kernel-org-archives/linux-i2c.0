From: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 5/5] hwmon: (lm90) Add SMBus alert support
Date: Sun, 14 Feb 2010 00:33:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002140000220.2366@t2.domain.actdsltmp>
References: <20100213230438.31fd0fd7@hyperion.delvare>
 <20100213231116.1d3ad806@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213231116.1d3ad806-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 13 Feb 2010, Jean Delvare wrote:
> Tested successfully with an ADM1032 chip on its evaluation board. It
> should work fine with all other chips as well.
>
> At this point this is more of a proof-of-concept, we don't do anything
> terribly useful on SMBus alert: we simply log the event. But this could
> later evolve into libsensors signaling so that user-space applications
> can take an appropriate action.

When I added alert support to the lm63 driver, I had it wake up any process
that's select()ing on the the alarm* files.  I also wrote a hw monitor
daemon that supports this system.  It worked pretty well.  Much more
efficient than polling once per second, and also much faster to resond to
an alert event.

I didn't bother to use ARA, since I know what device is generating the
interrupt.  Does your system support devices with an alert line that don't
use SMBus ARA?

> +static void lm90_alert(struct i2c_client *client, unsigned int flag)
> +{
> +	struct lm90_data *data = i2c_get_clientdata(client);
> +	u8 config, alarms;
> +
> +	lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);

Does lm90_read_reg() update the driver's cached copy of the alarm status
register?  Because if it doesn't, then won't anything reading the alarm
status via sysfs not see the alarms?

What happens if a process reads one of the sysfs attributes after the
interrupt is generated but before the driver runs this code?

In the lm63, the alarm register is clear on read.  So you get the alert,
check alarm status, and think there are no alarms.

What I did for the lm63 driver was assume that if there was an alert
generated, there must have been an alarm bit set.  If there isn't one set
now, then the only way it may have been cleared is if the driver read the
alarm status.  In which case the driver's cache copy of the alarm status
should be used to see what generated the alert.

Another thing I found is that after getting notified of the alert, the most
natural thing for userspace to do is check the temperature/fan/etc
attribute that just alarmed.  "Fan Alert, fan1 speed of 2000 RPM is below
minimum of 300 RPM" Huh?  2000 < 300?  What's going on?  The 2000 RPM is
one second old cached data!  The current speed should cause an alarm, but
the 1 HZ max update rate the driver makes userspace wait for it, somewhat
defeating the purpose of the alert irq.  I have the lm63 driver invalidate
the cached data on alert, so that if userspace reads an attribute it gets
fresh data.

> +		/* Re-enable ALERT# output if it was originally enabled and
> +		 * relevant alarms are all clear */
> +		if ((data->config_orig & 0x80) == 0
> +		 && (data->alarms & data->alert_alarms) == 0) {
> +			u8 config;
> +
> +			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
> +			if (config & 0x80) {
> +				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
> +				i2c_smbus_write_byte_data(client,
> +							  LM90_REG_W_CONFIG1,
> +							  config & ~0x80);
> +			}
> +		}

I didn't like the idea of having to have userspace poll attributes to get
alarms re-enabled.  I have the driver start a kernel timer going that
checks the alarm status.  It also notified processes sleeping in the alarm
attributes when the check back to 0.  The time period the kernel polling
can be based on the driver's knowledge of the chip's update rate.  It can
be set to poll faster when there is an alarm.  Of course you rejected my
patch to let the lm63 driver set and know the update rate because that
information could never be useful to anyone...
