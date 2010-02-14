From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Sun, 14 Feb 2010 10:05:53 -0800
Message-ID: <201002141005.53934.david-b@pacbell.net>
References: <20100213230438.31fd0fd7@hyperion.delvare> <201002131806.07359.david-b@pacbell.net> <20100214154034.2c92a8b7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100214154034.2c92a8b7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 14 February 2010, Jean Delvare wrote:
> > to use that infrastructure instead of a work struct? =A0There are
> > several mechanisms to kick in here. =A0It'd be fair to have a way f=
or
> > IRQ threads to issue i2c_handle_smbus_alert() -- or maybe some
> > sibling method -- especially if i2c_setup_smbus_alert() causes
> > this code to provide the hardirq handler.
>=20
> Honestly, this is all beyond me. I suggest that anyone needing this
> work on it on his/her own and submits an incremental patch when done.=
 I
> have already spent more time than I wanted on this, I can't afford
> spending more, especially for a feature I don't need myself.

Then I'd suggest sticking in a REVISIT comment to that effect,
to help armor this patch against repeats of that feedback which
don't accompany such an incremental patch.  :)


> > By the way ... you probably know that the I2C/SMBus controller
> > in most of Intel's Southbridge chips (like ICH8) supports
> > the SMBALERT# mechanism. =A0Testing may be awkward, but it'd be
> > good to verify this incarnation of SMBALERT# support can work
> > with those controllers. =A0(Where "alert" is just another cause
> > for an IRQ from i2c-i801.c or whatever, not a dedicated IRQ
> > from a GPIO or from the parport.)
>=20
> I have only one system with an ICH and an SMBus device with support f=
or
> alerts. It is not currently available for testing... when it becomes
> available, I may take a look. That being said, the main obstacle I se=
e
> is that the i2c-i801 driver doesn't make use of interrupts at all at
> the moment. I don't know if it is possible to enable them to get the
> alerts but to not make use of them during regular transactions. The
> various attempts to make the i2c-i801 driver use interrupts never mad=
e
> it to mainline, there was always an least one issue remaining
> preventing it. I would love if we finally managed to switch to full
> interrupt support.

Ah, I recall some of that mess, now that you mention it.  Ouch!

(By the way ... glad to see you did the nice thing with parport I2C
and SMALERT#.  I've not seen much Linux code using the parport IRQ,
and if nothing else it's nice to have some verification that it has
not bit-rotted to death!)


> That being said, my code is based on yours, and I see to remember you
> said yours was compatible with the ICH expectations, so I'd expect mi=
ne
> to work too.

The compatibility was because the driver could say "I got an SMBALERT I=
RQ"
to the infrastructure from its hardirq handler.  I think the comments i=
n
your version touched on that point.

- Dave
