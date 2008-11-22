From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Sat, 22 Nov 2008 01:48:56 -0800
Message-ID: <200811220148.57223.david-b@pacbell.net>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200811211354.51501.david-b@pacbell.net> <20081122100344.61cf42b7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081122100344.61cf42b7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 22 November 2008, Jean Delvare wrote:
> Hi David,
>=20
> On Fri, 21 Nov 2008 13:54:50 -0800, David Brownell wrote:
> > On Friday 21 November 2008, Jean Delvare wrote:
> > > In my case it was an edge-triggered interrupt:
> > >=20
> > > =A0 7: =A0 =A0 =A0 =A0 =A08 =A0 IO-APIC-edge =A0 =A0 =A0parport0
> > >=20
> > > For a level-triggering interrupt, I'd say it is up to the bus dri=
ver to
> > > disable it before calling smbus_alert(), as you did in smbus_irq(=
)?
> >=20
> > Yes, but then ... what would re-enable it?  A mechanism
> > seems to be missing; maybe a callback, for bus drivers
> > that just schedule_work(&adapter->alert), or having them
> > call the relevant routine in a task context instead of
> > letting i2c-core provide that context.
>=20
> Well, if bus->alert_edge_triggered is set to 0 and bus->irq is proper=
ly
> set, smbus_alert() is taking care of re-enabling the IRQ, isn't it?

I was mixing up a few issues in my mind.  If it's a level-triggered
interrupt, and the device is flaking out and still asserting it even
after it responded to the ARA ... then fault isolation calls for
leaving it disabled.  Then how could it ever recover?


> OTOH I admit that I was a little surprised that I had to set
> bus->alert_edge_triggered while while my driver also sets
> bus->do_setup_alert. But as long as it is properly documented, I gues=
s
> this is OK.

I don't see a way around that, until we get to threaded IRQ handlers.
In which case lots of this could just be part of a threaded handler...
which would mask and unmask directly.

It might be worth waiting till Thomas sends the threaded IRQ stuff
for merge.  It will make the interface tradeoffs a bit different, and
one notion was to merge that stuff for 2.6.29 ...


> > > The device was behaving as intended, the problem was that I had n=
ot yet
> > > implemented the alert() callback in the device driver. The device
> > > (ADM1032) keeps the ALERT# line low as long as the alarm conditio=
n
> > > exists, so smbus_alert() would receive the same address over and =
over
> > > again.
> >=20
> > Hmm, that "keep ALERT# low" behavior is contrary to what I took awa=
y
> > from the SMBus spec:  "After acknowledging the slave address the de=
vice
> > must disengage its SMBALERT# pulldown."  This ADM1032 isn't doing t=
hat;
> > it only "disengages" when the alarm condition eventually goes away.
>=20
> Indeed, this doesn't match the specification. I'm not necessarily
> surprised, as the same ADM1032 also doesn't implement SMBus PEC
> properly. Apparently Analog Devices didn't put too much engineering
> into sticking to the SMBus specification :( At least there is a way t=
o
> mask out the ALERT# output, so this can be addressed in the driver.
> Otherwise the ADM1032 wouldn't be usable at all...

My own SMBALERT# testing involved a TI sensor, which worked like a char=
m,
and some AVR (ATtiny) firmware, ditto. =20

=20
> > That would be particularly bad if it was raising an alert but there
> > was no driver for it at all!
>=20
> True. And obviously this can happen.

Hence the "leave it disabled" thought ...


> > Maybe the fault cases (no alert method, or now driver) in i2c_do_al=
ert()
> > should have special return codes so that the code scanning the bus =
for
> > alerting devices can be a bit smarter.
>=20
> I have been thinking about this too. But OTOH, you also want to
> properly handle the case where there is a driver and it has a callbac=
k
> but this callback is misbehaving. So in the end I think it's safer to
> focus on the consequence (same slave answering to ARA several times)
> than the multiple possible causes.

That's what I concluded too.

=20
> > > I have now updated the device driver to mask out the ALERT# signa=
l once
> > > it has triggered, until the alarm has worn off, at which point I =
unmask
> > > the ALERT# signal again. So it works OK now (I'll post the patch =
in a
> > > minute), but this is a condition that could easily happen for oth=
er
> > > devices / developers out there, so I think it's better to make th=
e
> > > i2c-core code robust enough to handle it.
> >=20
> > Agreed, defend against this misbehavior.  But I can't think of a mo=
re
> > robust defence than leaving the IRQ disabled when it misbehaves.
>=20
> Except that you don't necessarily have control over the IRQ in
> question. At least in my case, the i2c-parport driver sets
> bus->alert_edge_triggered to 1 and bus->do_setup_alert to 1, which
> basically means that it is handling the IRQ on its own and i2c-core
> won't touch it. So if you want i2c-core to be more intrusive, you mus=
t
> make setting bus->irq mandatory. I have no objection, again as long a=
s
> it is properly documented.

Setting bus->irq won't work on common cases like ICH8, where the
SMBALERT# interrupt is just one more subcase.

- Dave


>=20
> --=20
> Jean Delvare
>=20
>=20
