From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 5/5] hwmon: (lm90) Add SMBus alert support
Date: Sun, 14 Feb 2010 14:28:49 +0100
Message-ID: <20100214142849.3d2b8ae8@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
	<20100213231116.1d3ad806@hyperion.delvare>
	<Pine.LNX.4.64.1002140000220.2366@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1002140000220.2366-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Sun, 14 Feb 2010 00:33:53 -0800 (PST), Trent Piepho wrote:
> On Sat, 13 Feb 2010, Jean Delvare wrote:
> > Tested successfully with an ADM1032 chip on its evaluation board. It
> > should work fine with all other chips as well.
> >
> > At this point this is more of a proof-of-concept, we don't do anything
> > terribly useful on SMBus alert: we simply log the event. But this could
> > later evolve into libsensors signaling so that user-space applications
> > can take an appropriate action.
> 
> When I added alert support to the lm63 driver, I had it wake up any process
> that's select()ing on the the alarm* files.  I also wrote a hw monitor
> daemon that supports this system.  It worked pretty well.  Much more
> efficient than polling once per second, and also much faster to resond to
> an alert event.

Why didn't you add support to libsensors instead? This would seem the
right way if we want popular monitoring applications to take benefit of
this new feature.

> I didn't bother to use ARA, since I know what device is generating the
> interrupt.  Does your system support devices with an alert line that don't
> use SMBus ARA?

Not sure what you mean by "my system". My hardware setup is an
evaluation board connecting to the parallel port, it has an ADM1032
chip and that's all. Also, if you don't want to use the SMBus alert
mechanism, there's nothing preventing you from using raw interrupts
right now, you don't need my patches. Every driver can request an IRQ
and make use of it.

> > +static void lm90_alert(struct i2c_client *client, unsigned int flag)
> > +{
> > +	struct lm90_data *data = i2c_get_clientdata(client);
> > +	u8 config, alarms;
> > +
> > +	lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
> 
> Does lm90_read_reg() update the driver's cached copy of the alarm status
> register?

No, it doesn't.

> Because if it doesn't, then won't anything reading the alarm
> status via sysfs not see the alarms?

If the alarms have worn off meanwhile, yes indeed. But updating the
cache wouldn't really help, because it only lives for one second, so
any application polling less frequently than this would miss the
transient alarm anyway. And systems with more than one polling
application (for example sensord + a desktop applet) can easily miss
transient alarms even without my patch.

I tend to see transient alarms as an optional bonus without any
guarantee. Guaranteeing that transient alarms are always caught would
require a major redesign of all our drivers. And in practice, the
latching of alarm flags tend to confuse users more than it helps them.

> What happens if a process reads one of the sysfs attributes after the
> interrupt is generated but before the driver runs this code?

Good question. I admit that I have not necessarily thought of all the
possible race conditions. If the alarm is still present, it shouldn't
make a difference because the next conversion cycle will set the alarm
flag again. It would only make a difference if the alarm has gone away
meanwhile, and the extra read cleared the alarm bit. In that case, the
interrupt handler has no way to know what cause the problem. It will
log that everything is OK (to the user's surprise I guess) and do
nothing else. I don't see any problem here.

> In the lm63, the alarm register is clear on read.  So you get the alert,
> check alarm status, and think there are no alarms.

Yes, that's the same here. Almost all hwmon chips have alarm registers
which clear on read.

> What I did for the lm63 driver was assume that if there was an alert
> generated, there must have been an alarm bit set.  If there isn't one set
> now, then the only way it may have been cleared is if the driver read the
> alarm status.  In which case the driver's cache copy of the alarm status
> should be used to see what generated the alert.

Hmm, that's an interesting strategy, I admit. Now the problem I have at
least with the ADM1032 is that I also get an interrupt when I re-enable
the ALERT output. When this happens, the lack of alarm bit being set is
totally expected, so I certainly don't want to read the cached value to
display an alert message to the user.

I don't think this is a problem anyway. Either the alarm condition is
gone, meaning it was transient, and the user probably doesn't care. Or
the alarm condition is still there and the next cycle will trigger an
interrupt again, so the user will finally know what's up.

> 
> Another thing I found is that after getting notified of the alert, the most
> natural thing for userspace to do is check the temperature/fan/etc
> attribute that just alarmed.  "Fan Alert, fan1 speed of 2000 RPM is below
> minimum of 300 RPM" Huh?  2000 < 300?  What's going on?  The 2000 RPM is
> one second old cached data!  The current speed should cause an alarm, but
> the 1 HZ max update rate the driver makes userspace wait for it, somewhat
> defeating the purpose of the alert irq.  I have the lm63 driver invalidate
> the cached data on alert, so that if userspace reads an attribute it gets
> fresh data.

This is a good idea, I will probably do the same (even though I am a
little worried about locking... invalidating the cache requires holding
the lock, which may take long if user-space is reading the values at
that time). That being said, it is in no way bullet-proof: by the time
the user-space application reads the attributes, the faulty condition
may have gone away. So it is better to rely on the alarm flags to print
the warning, and only provide the sensor and limit values as hints.

> 
> > +		/* Re-enable ALERT# output if it was originally enabled and
> > +		 * relevant alarms are all clear */
> > +		if ((data->config_orig & 0x80) == 0
> > +		 && (data->alarms & data->alert_alarms) == 0) {
> > +			u8 config;
> > +
> > +			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
> > +			if (config & 0x80) {
> > +				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
> > +				i2c_smbus_write_byte_data(client,
> > +							  LM90_REG_W_CONFIG1,
> > +							  config & ~0x80);
> > +			}
> > +		}
> 
> I didn't like the idea of having to have userspace poll attributes to get
> alarms re-enabled.  I have the driver start a kernel timer going that
> checks the alarm status.  It also notified processes sleeping in the alarm
> attributes when the check back to 0.  The time period the kernel polling
> can be based on the driver's knowledge of the chip's update rate.  It can
> be set to poll faster when there is an alarm.

I tried to make my changes integrate into the current usage scheme of
the hwmon drivers (user-space repeatedly polling for values.) And it
was really only a way to test the rest of the SMBus alert code. As long
as it doesn't do anything useful, I do not think it is a problem to
rely on user-space. It can certainly evolve in the future, especially
if we make it possible for the kernel to take thermal management
measures by itself (e.g. processor throttling). But for this, we would
have to somehow unify the thermal zones subsystem with the hwmon one.
This is way beyond the scope of my patch.

> Of course you rejected my
> patch to let the lm63 driver set and know the update rate because that
> information could never be useful to anyone...

Trent, you rejected your patch yourself. We (I wasn't alone) asked you
to split your patch into a part which everybody agreed on and a part
where more discussion was needed. You never followed up, so your
changes never went anywhere. You did it to yourself, really.

-- 
Jean Delvare
