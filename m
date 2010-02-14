From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Sun, 14 Feb 2010 15:40:34 +0100
Message-ID: <20100214154034.2c92a8b7@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
	<20100213230656.341ec091@hyperion.delvare>
	<201002131806.07359.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002131806.07359.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sat, 13 Feb 2010 18:06:07 -0800, David Brownell wrote:
> On Saturday 13 February 2010, Jean Delvare wrote:
>=20
> > The benefit of this approach is a zero cost for I2C bus segments wh=
ich
> > do not need SMBus alert support. Where David's implementation
> > increased the size of struct i2c_adapter by 7% (40 bytes on i386),
> > mine doesn't touch it. Where David's implementation added over 150
> > lines of code to i2c-core (+10%), mine doesn't touch it. The only
> > change that touches all the users of the i2c subsystem is a new
> > callback in struct i2c_driver (common to both implementations.) I s=
eem
> > to remember Trent was worried about the footprint of David'd
> > implementation, hopefully mine addresses the issue.
>=20
> I'm not sure I could justify making I2C and SMBus differ in *ONLY* th=
is
> particular way, since otherwise they're treated identically.

I'm not sure what you call "making I2C and SMBus differ". My
implementation simply makes it possible to exclude the extra code if
you don't need it. It doesn't prevent I2C controller drivers from
relying on that code if they want to. I named it "i2c-smbus" because I
don't think we want one separate module for every extension provided by
SMBus, and based on the assumption that people who don't want one,
won't want any of them. But if the future makes me wrong, I will be
happy to rename the module to i2c-smbus-alert.

> I certainly
> wouldn't worry about 40 bytes in a Linux kernel ... that's noise.  (I=
f
> this were inside a microcontroller that only had a few KB of SRAM, th=
en
> I'd certainly worry!)

That's 40 bytes * number of I2C segments on the system. There tends to
be more and more I2C segments on systems, and when we add support for
multiplexing (the next big thing on my list) it will only get worse.
BTW, my impression is that multiplexing and SMBus alert are almost
mutually exclusive, so not having all the data in every segment makes a
lot of sense to me.

>=20
> But that doesn't much matter.  If SMBALERT# support is now going to e=
xist,
> that's enough for me.

Honestly, I don't worry much either way myself. But I can imagine some
people would, and I didn't want to give them a reason to reject SMBus
alert support.

> > + *
> > + * Copyright (C) 2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > + *
> > + * SMBus alert support based on earlier work by David Brownell (20=
08).
> > + *
>=20
> That should be "Copyright (C) 2008 David Brownell" ... not
> just "based on", since significant chunks are the same code.

I'm sorry about this. For some reason, I decided that, just because
your code never made it upstream, you did not get to hold a copyright
on it. Silly me. It's fixed now, please accept my humble excuses.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_client=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*ara;
>=20
> Worth spelling out what "ARA" means; it shouldn't be
> just another mysterious TLA.

Good idea, added.

> > +struct alert_data {
> > +       unsigned short          addr;
> > +       u8                      flag:1;
> > +};
> > +
>=20
> Better to make "flag" be "bool" ... there's no space saving
> in the struct to have it be a one bit field, and in terms of
> code generation it *costs more* than using a "bool".

No, thanks. Your code used a bool and I voluntarily changed it to a
regular number. My reason for doing this is that bool has semantics
which are absent from the SMBus specifications. This bit of data is
really 0 or 1, it doesn't carry the meaning of "false" or "true".

> > +/* If this is the alerting device, notify its driver */
> > +static int smbus_do_alert(struct device *dev, void *addrp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_client *clien=
t =3D i2c_verify_client(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct alert_data *data =
=3D addrp;
>=20
> Surely the callback should take a "struct alert_data *" then??

smbus_do_alert() is called by device_for_each_child(), we don't get to
change its prototype.

> > +static irqreturn_t smbalert_irq(int irq, void *d)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_smbus_alert *=
data =3D d;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Disable level-trigger=
ed IRQs until we handle them */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!data->alert_edge_tr=
iggered)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0disable_irq_nosync(irq);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_work(&data->ale=
rt);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return IRQ_HANDLED;
> > +}
> > +
>=20
> Now that genirq handles threaded IRQs, should this code be updated
> to use that infrastructure instead of a work struct?  There are
> several mechanisms to kick in here.  It'd be fair to have a way for
> IRQ threads to issue i2c_handle_smbus_alert() -- or maybe some
> sibling method -- especially if i2c_setup_smbus_alert() causes
> this code to provide the hardirq handler.

Honestly, this is all beyond me. I suggest that anyone needing this
work on it on his/her own and submits an incremental patch when done. I
have already spent more time than I wanted on this, I can't afford
spending more, especially for a feature I don't need myself.

> By the way ... you probably know that the I2C/SMBus controller
> in most of Intel's Southbridge chips (like ICH8) supports
> the SMBALERT# mechanism.  Testing may be awkward, but it'd be
> good to verify this incarnation of SMBALERT# support can work
> with those controllers.  (Where "alert" is just another cause
> for an IRQ from i2c-i801.c or whatever, not a dedicated IRQ
> from a GPIO or from the parport.)

I have only one system with an ICH and an SMBus device with support for
alerts. It is not currently available for testing... when it becomes
available, I may take a look. That being said, the main obstacle I see
is that the i2c-i801 driver doesn't make use of interrupts at all at
the moment. I don't know if it is possible to enable them to get the
alerts but to not make use of them during regular transactions. The
various attempts to make the i2c-i801 driver use interrupts never made
it to mainline, there was always an least one issue remaining
preventing it. I would love if we finally managed to switch to full
interrupt support.

That being said, my code is based on yours, and I see to remember you
said yours was compatible with the ICH expectations, so I'd expect mine
to work too.

> p.s. for the record ... I'd try testing this, but the board I
>      have which needs that support doesn't have current-enough
>      Linux to do so.

Thank you! And thanks for the review as well, very much appreciated.

--=20
Jean Delvare
