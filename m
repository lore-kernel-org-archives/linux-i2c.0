From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Don't probe for slaves on IDF channels
Date: Tue, 10 May 2011 17:31:28 +0200
Message-ID: <20110510173128.1499ed2c@endymion.delvare>
References: <20110510160835.37bea352@endymion.delvare>
	<1305039012.30435.85.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305039012.30435.85.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 10 May 2011 15:50:12 +0100, Woodhouse, David wrote:
> On Tue, 2011-05-10 at 15:08 +0100, Jean Delvare wrote:
> > I don't know if Fujitsu is ever going to produce Patsburg-based
> > machines, but if they do, I'd rather not probe the secondary (IDF)
> > SMBus channels. At least not until we have a good reason for doing so.
> 
> Seems reasonable in principle.

OK, I'll push this change upstream then, thanks.

Any opinion on the detection class flags for the IDF channels? Do you
have any idea what these IDF channels are supposed to be dedicated to?

> > +#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
> 
> > +#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
> 
> This kind of ifdef is horrid though, and should be avoided at all costs.
> A setting of CONFIG_xxx_MODULE should not affect the *static* kernel
> image. You should be able to enable an additional module, build it and
> use it without having to rebuild/reboot the kernel.

In general, the i2c-i801 driver will be built as a module, so that
won't affect the kernel image. While I understand your point, there was
a reason for the horrid ifdefs. The idea was that we don't want to bloat
the kernel (or the i2c-i801 module) with hardware system specific code
if the builder knows upfront that the kernel will never run on the
relevant hardware system. So, if the builder doesn't select the apanel
and fschmd drivers, we build the i2c-i801 driver without the specific
code for systems with these devices. The fact is that i2c-i801 is a very
popular driver when apanel and fschmd are only used on a few systems.

Of course this would go wrong if a user was to build the apanel or
fschmd driver out of tree, but we couldn't find any reason why anybody
would be doing so.

With x86 becoming an embedded architecture, it seemed relevant to let
people build as small an x86 kernel as possible, thus the decision to
go for the horrid ifdefs.

> I know there are *some* cases where we violate that rule, but that
> doesn't make it any nicer.

Note that my patch is merely moving this code around, it's not
introducing it.

If you really think we should change this, then maybe a good compromise
would be to use #ifdef CONFIG_X86 instead of the module-specific ones.
This would let at least non-x86 systems built the i2c-i801 driver
without the hardware specific code. But OTOH I'm not even sure if
there's any non-x86 system out there using an Intel 82801 chipset,
so maybe that would be exactly equivalent to dropping the ifdefs
altogether. Or IA64 systems maybe...?

Yet another possibility would be a dedicated Kconfig option
(CONFIG_I2C_I801_POPULATE or even CONFIG_I2C_POPULATE and make it
cross-driver) that would be hidden and enabled by default, and visible
only when CONFIG_EMBEDDED is set?

In both cases, that would be an all-or-nothing setting, but I guess
that people who care about the size of i2c-i801 have a proper way to
declare their I2C devices on the SMBus. Or at least I hope so...

I'm glad we're discussing this now, as I am on my way to add even more
such hardware-specific code to the i2c-i801 driver. All in all this
really shows how much x86 lacks proper description for the hardware
setup at the firmware or platform code level, but fixing this is out of
scope for me.

-- 
Jean Delvare
