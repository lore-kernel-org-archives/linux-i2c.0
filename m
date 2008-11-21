From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 21 Nov 2008 13:54:50 -0800
Message-ID: <200811211354.51501.david-b@pacbell.net>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200811210824.55601.david-b@pacbell.net> <20081121202223.0261fb9c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081121202223.0261fb9c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 21 November 2008, Jean Delvare wrote:
> >=20
> > It's a start. =A0If this is a level-triggered IRQ and the device is
> > still raising the IRQ ... we'd need something more drastic, since
> > the IRQ itself would be stuck on; wouldn't want to re-enable it.
> > Edge triggered IRQs would be easier to cope with.
>=20
> In my case it was an edge-triggered interrupt:
>=20
> =A0 7: =A0 =A0 =A0 =A0 =A08 =A0 IO-APIC-edge =A0 =A0 =A0parport0
>=20
> For a level-triggering interrupt, I'd say it is up to the bus driver =
to
> disable it before calling smbus_alert(), as you did in smbus_irq()?

Yes, but then ... what would re-enable it?  A mechanism
seems to be missing; maybe a callback, for bus drivers
that just schedule_work(&adapter->alert), or having them
call the relevant routine in a task context instead of
letting i2c-core provide that context.


> > Do you have a handle on why the device was malfunctioning?
>=20
> The device was behaving as intended, the problem was that I had not y=
et
> implemented the alert() callback in the device driver. The device
> (ADM1032) keeps the ALERT# line low as long as the alarm condition
> exists, so smbus_alert() would receive the same address over and over
> again.

Hmm, that "keep ALERT# low" behavior is contrary to what I took away
from the SMBus spec:  "After acknowledging the slave address the device
must disengage its SMBALERT# pulldown."  This ADM1032 isn't doing that;
it only "disengages" when the alarm condition eventually goes away.
That would be particularly bad if it was raising an alert but there
was no driver for it at all!

Maybe the fault cases (no alert method, or now driver) in i2c_do_alert(=
)
should have special return codes so that the code scanning the bus for
alerting devices can be a bit smarter. =20


> I have now updated the device driver to mask out the ALERT# signal on=
ce
> it has triggered, until the alarm has worn off, at which point I unma=
sk
> the ALERT# signal again. So it works OK now (I'll post the patch in a
> minute), but this is a condition that could easily happen for other
> devices / developers out there, so I think it's better to make the
> i2c-core code robust enough to handle it.

Agreed, defend against this misbehavior.  But I can't think of a more
robust defence than leaving the IRQ disabled when it misbehaves.

- Dave
