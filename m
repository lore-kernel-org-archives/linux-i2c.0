From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Sat, 22 Nov 2008 10:03:44 +0100
Message-ID: <20081122100344.61cf42b7@hyperion.delvare>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200811210824.55601.david-b@pacbell.net>
	<20081121202223.0261fb9c@hyperion.delvare>
	<200811211354.51501.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811211354.51501.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 21 Nov 2008 13:54:50 -0800, David Brownell wrote:
> On Friday 21 November 2008, Jean Delvare wrote:
> > In my case it was an edge-triggered interrupt:
> >=20
> > =A0 7: =A0 =A0 =A0 =A0 =A08 =A0 IO-APIC-edge =A0 =A0 =A0parport0
> >=20
> > For a level-triggering interrupt, I'd say it is up to the bus drive=
r to
> > disable it before calling smbus_alert(), as you did in smbus_irq()?
>=20
> Yes, but then ... what would re-enable it?  A mechanism
> seems to be missing; maybe a callback, for bus drivers
> that just schedule_work(&adapter->alert), or having them
> call the relevant routine in a task context instead of
> letting i2c-core provide that context.

Well, if bus->alert_edge_triggered is set to 0 and bus->irq is properly
set, smbus_alert() is taking care of re-enabling the IRQ, isn't it?
OTOH I admit that I was a little surprised that I had to set
bus->alert_edge_triggered while while my driver also sets
bus->do_setup_alert. But as long as it is properly documented, I guess
this is OK.

> > The device was behaving as intended, the problem was that I had not=
 yet
> > implemented the alert() callback in the device driver. The device
> > (ADM1032) keeps the ALERT# line low as long as the alarm condition
> > exists, so smbus_alert() would receive the same address over and ov=
er
> > again.
>=20
> Hmm, that "keep ALERT# low" behavior is contrary to what I took away
> from the SMBus spec:  "After acknowledging the slave address the devi=
ce
> must disengage its SMBALERT# pulldown."  This ADM1032 isn't doing tha=
t;
> it only "disengages" when the alarm condition eventually goes away.

Indeed, this doesn't match the specification. I'm not necessarily
surprised, as the same ADM1032 also doesn't implement SMBus PEC
properly. Apparently Analog Devices didn't put too much engineering
into sticking to the SMBus specification :( At least there is a way to
mask out the ALERT# output, so this can be addressed in the driver.
Otherwise the ADM1032 wouldn't be usable at all...

> That would be particularly bad if it was raising an alert but there
> was no driver for it at all!

True. And obviously this can happen.

> Maybe the fault cases (no alert method, or now driver) in i2c_do_aler=
t()
> should have special return codes so that the code scanning the bus fo=
r
> alerting devices can be a bit smarter.

I have been thinking about this too. But OTOH, you also want to
properly handle the case where there is a driver and it has a callback
but this callback is misbehaving. So in the end I think it's safer to
focus on the consequence (same slave answering to ARA several times)
than the multiple possible causes.

> > I have now updated the device driver to mask out the ALERT# signal =
once
> > it has triggered, until the alarm has worn off, at which point I un=
mask
> > the ALERT# signal again. So it works OK now (I'll post the patch in=
 a
> > minute), but this is a condition that could easily happen for other
> > devices / developers out there, so I think it's better to make the
> > i2c-core code robust enough to handle it.
>=20
> Agreed, defend against this misbehavior.  But I can't think of a more
> robust defence than leaving the IRQ disabled when it misbehaves.

Except that you don't necessarily have control over the IRQ in
question. At least in my case, the i2c-parport driver sets
bus->alert_edge_triggered to 1 and bus->do_setup_alert to 1, which
basically means that it is handling the IRQ on its own and i2c-core
won't touch it. So if you want i2c-core to be more intrusive, you must
make setting bus->irq mandatory. I have no objection, again as long as
it is properly documented.

--=20
Jean Delvare
