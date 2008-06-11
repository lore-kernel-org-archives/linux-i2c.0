From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 11:31:50 -0700
Message-ID: <200806111131.50501.david-b@pacbell.net>
References: <200806091541.43899.u.luckas@road.de> <200806101355.07792.david-b@pacbell.net> <20080611101130.1a667abe@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756533AbYFKScJ@vger.kernel.org>
In-Reply-To: <20080611101130.1a667abe@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ryan Mallon <ryan@bluewatersys.com>, Uli Luckas <u.luckas@road.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 June 2008, Jean Delvare wrote:
> Hi David,
> 
> On Tue, 10 Jun 2008 13:55:07 -0700, David Brownell wrote:
> > > Why don't you simply initialize the drivers in question with
> > > subsys_initcall()? That's what i2c-pnx, i2c-omap, i2c-davinci and
> > > tps65010 are doing at the moment.
> > 
> > If they happen to sit outside the I2C tree and *before* it in
> > link order, things will misbehave.
> 
> Well, i2c system bus drivers shouldn't sit outside of the I2C tree, so
> that's not a problem. If you start accepting that drivers live at
> random places in the source tree, then there's simply no way to get
> things right.

The "drivers in question" aren't necessarily all i2c_adapter drivers,
or even *only* i2c_adapter drivers (they could expose an i2c_adapter
interface as a secondary function).

I think I introduced the term "system bus driver", but you didn't read
it the way I meant it.  To elaborate a bit:  "system bus" as in "a bus
used for system bringup and management".  On PCs, the main such bus is
PCI but there are little fragments of other stuff too.  Many smaller
embedded systems use I2C for that (and don't have PCI).  The drivers
relevant are both (a) the bus driver itself, e.g. i2c_adapter or its
PCI analogue, and (b) drivers for devices on that bus.

So while (a) having i2c and some i2c_adapter drivers at subsys_initcall
is an essential first step, the *link order* issue comes up in two other
ways:  (b1) drivers "outside the I2C tree and *before* it in link order"
that may need to be subsys_initcall too, thus depending on core I2C
stuff being available, and (b2) some other subsystems may need to rely
on I2C in their bringup, such as by enabling a specific power domain
and the chips using it.


> As for i2c chip drivers, that's the exact reason why I am urging
> developers to create function-based subsystems rather than dumping
> their drivers in drivers/i2c/chips. If we have all drivers implementing
> a given function in a dedicated directory then we can sequence this
> directory properly in the link order.

But even given that, I2C is currently sequenced *late* for systems where
it serves as a system control/management bus; see (b1) and (b2) above.


> These were only two examples. We have i2c bus drivers depending on PCI,
> parport, USB, ISA, GPIO and serio. Given the current linking order,
> this makes it impossible to move I2C up in the link order without
> moving all these too.

Not really; those particular i2c_adapter drivers don't actually get used
early in system bringup.  They aren't subsys_initcall, and neither of
the (b1) or (b2) cases apply.  Moving those adapters doesn't imply moving
those other subsystems.

Example:  USB subsystem is initialized early (subsystem_init).  From then
on, drivers can register freely -- including i2c-tiny-usb.  The usbcore
code remembers them, and then when the HCDs (analogues: i2c_adapter) start
to connect, usb devices enumerate and get bound to devices as needed.  So
it doesn't matter *when* i2c-tiny-usb does its module_init(), so long as
it's after usbcore does its subsys_initcall.

Likewise for PCI.  As I said earlier, GPIO is already covered (has to
be usable before initcalls could be run, etc).  I think i2c-parport
should behave OK too, and i2c-parport-light.


> My feeling is that we won't be able to solve this without first moving
> the different type of i2c bus drivers (and possibly chip drivers) to
> separate directories. For example, moving external I2C bus drivers
> (i2c-parport-light, i2c-parport, i2c-taos-evm and i2c-tiny-usb) to a
> separate directory that is always initialized late, would remove the
> dependencies on parport, serio and USB for the "must initialize i2c
> early" problem.

I think you're looking at this wrong.  First, as I noted already,
most of those drivers don't have this issue.  Second, if there *are*
such issues, they'd be bus-specific issues to resolve, not reasons
to avoid fixing the (b1) and (b2) problems by moving I2C earlier.

- Dave
