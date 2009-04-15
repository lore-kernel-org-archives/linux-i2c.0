From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: Where to initialize class attribute of adapter
Date: Wed, 15 Apr 2009 14:53:30 +0200
Message-ID: <20090415145330.0ae9f975@hyperion.delvare>
References: <49E43E3E.1020200@gmx.de>
	<20090414102820.07b930b3@hyperion.delvare>
	<49E457C2.1010706@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E457C2.1010706-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Apr 2009 11:30:42 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > Hallo Michael,
> > 
> > On Tue, 14 Apr 2009 09:41:50 +0200, Michael Lawnick wrote:
> >> on update to kernel to 2.6.29 I've run into the issue that I2C
> >> adapter's class attribute in struct i2c_adapter wasn't set and so
> >> no client driver could be loaded. Currently I initialize .class in
> >> the struct declaration part, but this is main code for all boards
> >> that use this adapter :-( I'm now searching for a place where to do
> >> it in a board specific way like device tree. Any suggestions?
> > 
> > Which architecture is this, which bus driver?
> 
> We are based on PowerPC MPC8548, adapter code is i2c-mpc.c
> We use the adapter compiled-in.
> 
> > I think I would pass the class value as platform data to the i2c bus
> > driver, and in this driver copy the value from platform data to
> > struct i2c_adapter.
> > 
> 
> Hmm, I'm not sure whether I really understand you.
> You propose modification of C-code that is part of board unspecific
> source tree, correct?

For the infrastructure part, yes, but that would really only be a
couple lines. For the data part, of course, that would go in
board-specific code.

> IMHO, as this is a board specific parameter, there should be a way to do
> it in something like a config file. Probably in Kconfig (if this is
> possible at all) or device tree or ...? An alternative could be a
> writable sysFs-entry for dynamic reconfiguration.

I can't see how this has anything to do with Kconfig. Kconfig is about
build-time kernel configuration, to enable or disable features or
drivers. It doesn't have anything to do with board-specific device
declarations.

Device tree... this raises a question. If you have a device tree, then
you presumably know which devices are present on the system. So you
don't need i2c probing classes at all. You'd rather declare which I2C
devices are present on each I2C bus, rather than setting probing
classes on these I2C buses.

Exporting the probing classes to user-space is something I have been
thinking of at some point in the past, but it never happened, and now I
am no longer certain it would be useful. I2C probing classes tend to be
added and removed from one kernel version to the next, it's not
necessarily very stable. With the advent of new-style I2C drivers and
device instantiation, probing classes are only used for a small subset
of devices on a subset of platforms. Anyway I had not considered the
possibility to let user-space change the probing class value, I can't
really see a value in doing so, and I see a risk.

> For more understanding of my view:
> I get a preconfigured/patched kernel tree from another co-worker in our
> project. I don't know what he has done in detail to the original source
> code. I just verified that there is no modification below drivers/i2c.
> So if there is a board specific initialization file I've overseen, just
> tell me, perhaps this is the solution.

I don't know anything about MPC platforms. Just ask your co-worker?

> BTW: Why has I2C_CLASS_ALL been dropped?

Did you ask git?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e1995f65be0786ca201f466f049dad1e2e4c3421

-- 
Jean Delvare
