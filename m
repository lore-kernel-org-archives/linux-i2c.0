From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Sat, 13 Feb 2010 18:06:07 -0800
Message-ID: <201002131806.07359.david-b@pacbell.net>
References: <20100213230438.31fd0fd7@hyperion.delvare> <20100213230656.341ec091@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230656.341ec091-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 13 February 2010, Jean Delvare wrote:

> The benefit of this approach is a zero cost for I2C bus segments whic=
h
> do not need SMBus alert support. Where David's implementation
> increased the size of struct i2c_adapter by 7% (40 bytes on i386),
> mine doesn't touch it. Where David's implementation added over 150
> lines of code to i2c-core (+10%), mine doesn't touch it. The only
> change that touches all the users of the i2c subsystem is a new
> callback in struct i2c_driver (common to both implementations.) I see=
m
> to remember Trent was worried about the footprint of David'd
> implementation, hopefully mine addresses the issue.

I'm not sure I could justify making I2C and SMBus differ in *ONLY* this
particular way, since otherwise they're treated identically.  I certain=
ly
wouldn't worry about 40 bytes in a Linux kernel ... that's noise.  (If
this were inside a microcontroller that only had a few KB of SRAM, then
I'd certainly worry!)

But that doesn't much matter.  If SMBALERT# support is now going to exi=
st,
that's enough for me.


> + *
> + * Copyright (C) 2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> + *
> + * SMBus alert support based on earlier work by David Brownell (2008=
).
> + *

That should be "Copyright (C) 2008 David Brownell" ... not
just "based on", since significant chunks are the same code.


> +=A0=A0=A0=A0=A0=A0=A0struct i2c_client=A0=A0=A0=A0=A0=A0=A0*ara;

Worth spelling out what "ARA" means; it shouldn't be
just another mysterious TLA.


> +struct alert_data {
> +       unsigned short          addr;
> +       u8                      flag:1;
> +};
> +

Better to make "flag" be "bool" ... there's no space saving
in the struct to have it be a one bit field, and in terms of
code generation it *costs more* than using a "bool".


> +/* If this is the alerting device, notify its driver */
> +static int smbus_do_alert(struct device *dev, void *addrp)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct i2c_client *client =3D i2c_verify_client=
(dev);
> +=A0=A0=A0=A0=A0=A0=A0struct alert_data *data =3D addrp;

Surely the callback should take a "struct alert_data *" then??


> +static irqreturn_t smbalert_irq(int irq, void *d)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct i2c_smbus_alert *data =3D d;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Disable level-triggered IRQs until we handle=
 them */
> +=A0=A0=A0=A0=A0=A0=A0if (!data->alert_edge_triggered)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0disable_irq_nosync(irq)=
;
> +
> +=A0=A0=A0=A0=A0=A0=A0schedule_work(&data->alert);
> +=A0=A0=A0=A0=A0=A0=A0return IRQ_HANDLED;
> +}
> +

Now that genirq handles threaded IRQs, should this code be updated
to use that infrastructure instead of a work struct?  There are
several mechanisms to kick in here.  It'd be fair to have a way for
IRQ threads to issue i2c_handle_smbus_alert() -- or maybe some
sibling method -- especially if i2c_setup_smbus_alert() causes
this code to provide the hardirq handler.

By the way ... you probably know that the I2C/SMBus controller
in most of Intel's Southbridge chips (like ICH8) supports
the SMBALERT# mechanism.  Testing may be awkward, but it'd be
good to verify this incarnation of SMBALERT# support can work
with those controllers.  (Where "alert" is just another cause
for an IRQ from i2c-i801.c or whatever, not a dedicated IRQ
from a GPIO or from the parport.)

- Dave

p.s. for the record ... I'd try testing this, but the board I
     have which needs that support doesn't have current-enough
     Linux to do so.
