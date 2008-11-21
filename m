From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 21 Nov 2008 20:22:23 +0100
Message-ID: <20081121202223.0261fb9c@hyperion.delvare>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200811181401.34809.david-b@pacbell.net>
	<20081121151808.324ca78c@hyperion.delvare>
	<200811210824.55601.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811210824.55601.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 21 Nov 2008 08:24:55 -0800, David Brownell wrote:
> On Friday 21 November 2008, Jean Delvare wrote:
> > --- linux-2.6.28-rc6.orig/drivers/i2c/i2c-core.c=A0=A0=A0=A0=A0=A0=A0=
=A02008-11-21 11:01:53.000000000 +0100
> > +++ linux-2.6.28-rc6/drivers/i2c/i2c-core.c=A0=A0=A0=A0=A02008-11-2=
1 14:55:29.000000000 +0100
> > @@ -446,6 +446,7 @@ static int i2c_do_alert(struct device *d
> > =A0static void smbus_alert(struct work_struct *work)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0struct i2c_adapter=A0=A0=A0=A0=A0=A0*bus;
> > +=A0=A0=A0=A0=A0=A0=A0unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0p=
rev_addr =3D 0;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0bus =3D container_of(work, struct i2c_adapt=
er, alert);
> > =A0=A0=A0=A0=A0=A0=A0=A0for (;;) {
> > @@ -465,11 +466,18 @@ static void smbus_alert(struct work_stru
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data.flag =3D (stat=
us & 1) !=3D 0;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data.addr =3D statu=
s >> 1;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (data.addr =3D=3D =
prev_addr) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0dev_warn(&bus->dev, "Duplicate SMBALERT# from dev "
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0"0x%02x, skipping\n", data.addr);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(&bus->dev, =
"SMBALERT# %s from dev 0x%02x\n",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0data.flag ? "true" : "false", data.addr);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Notify driver fo=
r the device which issued the alert. */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device_for_each_chi=
ld(&bus->dev, &data, i2c_do_alert);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0prev_addr =3D data.ad=
dr;
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0/* We handled all alerts; reenable level-tr=
iggered IRQs. */
> >=20
> > What do you think?
>=20
> It's a start.  If this is a level-triggered IRQ and the device is
> still raising the IRQ ... we'd need something more drastic, since
> the IRQ itself would be stuck on; wouldn't want to re-enable it.
> Edge triggered IRQs would be easier to cope with.

In my case it was an edge-triggered interrupt:

  7:          8   IO-APIC-edge      parport0

=46or a level-triggering interrupt, I'd say it is up to the bus driver =
to
disable it before calling smbus_alert(), as you did in smbus_irq()?

> Do you have a handle on why the device was malfunctioning?

The device was behaving as intended, the problem was that I had not yet
implemented the alert() callback in the device driver. The device
(ADM1032) keeps the ALERT# line low as long as the alarm condition
exists, so smbus_alert() would receive the same address over and over
again.

I have now updated the device driver to mask out the ALERT# signal once
it has triggered, until the alarm has worn off, at which point I unmask
the ALERT# signal again. So it works OK now (I'll post the patch in a
minute), but this is a condition that could easily happen for other
devices / developers out there, so I think it's better to make the
i2c-core code robust enough to handle it.

--=20
Jean Delvare
