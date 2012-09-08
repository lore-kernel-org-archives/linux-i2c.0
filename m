From: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Sat, 8 Sep 2012 15:18:43 +0200
Message-ID: <20120908151843.4b5a7f72@endymion.delvare>
References: <4401854.hVfHzgeqjT@ws-stein>
	<20120823162852.29243e9c@feng-i7>
	<20120829204031.648a73e1@endymion.delvare>
	<4378288.tkkLiQ5MQ7@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4378288.tkkLiQ5MQ7@ws-stein>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Feng Tang <feng.tang@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

Sorry for the late reply again.

On Thu, 30 Aug 2012 09:49:52 +0200, Alexander Stein wrote:
> On Wednesday 29 August 2012 20:40:31, Jean Delvare wrote:
> > Note that there was an assumption at the time the code was written,
> > that there was no need or reason to reserve a static I2C bus number if
> > no slave device was declared on said I2C bus. I never much liked it but
> > it never caused problems so far. This means that either:
> > * you call i2c_register_board_info() to register your slave I2C devices
> >   and all the affected I2C bus drivers call i2c_add_numbered_adapter();
> >   or
> > * you don't call i2c_register_board_info() and all I2C bus drivers call
> >   i2c_add_adapter().
> > You can't mix, i.e. if you don't register any slave device on a bus but
> > the bus driver still calls i2c_add_numbered_adapter(), it may fail.
> > 
> > If this is a problem now on some systems, it should be easy enough to
> > work around by adding a specific function to reserve an I2C bus number
> > for static allocation, even without declaring any slave device on it.
> > This function would be called at the same time
> > i2c_register_board_info() typically is.
> 
> IMO the i2c_register_board_info only works in quite static setups. Especially with I2C-Busses attached to hotplugable PCI devices this way doesn't work reliable any more.
> The device come and go dynamically so you can't assume fixed mapping.

This is correct, i2c_register_board_info() was designed with static
setups in mind and isn't suitable for dynamic setups. But there are
other ways for dynamic setup, described in
Documentation/i2c/instantiating-devices.

There is another approach which isn't fully documented yet, partly
because I am not so proud of it. Look at drivers/i2c/busses/i2c-i801.c,
it has a lot of platform-specific code instantiating slave i2c devices.
As the code is in the bus driver, we don't have to know the bus number
in advance, which is quite convenient for PC-style machines.

I'm not sure if we want to generalize this, as this is a little hard to
maintain, but short of a better idea, feel free to do the same for the
time being.

> > (...)
> > Please elaborate on "this is/was not possible in general to use
> > i2c_register_board_info." You are supposed to call it as part of your
> > platform setup, so if it is not possible for you, whatever the problem
> > is needs to be addressed.
> 
> The problem here is that AFAIK on x86 there is no platform setup to e.g. register platform devices. So you depend on the order the drivers and devices are bound.

There originally wasn't, as x86 wasn't considered an embedded platform.
But I can see arch/x86/platform is growing now, so apparently it is
well supported now.

> In 3.0.x we get a static numbering due to this order. As there is no platform setup we register our I2C devices with /sys/bus/i2c/devices/i2c-[01]/new_device as some of our sensors can't be auto-detected.

Please try dropping your platform code somewhere in arch/x86/platform
and see where you can go with that approach. You mean have to tweak the
i2c bus drivers themselves to be able to provide the bus numbers.

> > (...)
> > It should indeed be handled all in kernel space, using
> > i2c_register_board_info().
> 
> I know this mechanism for ARM, but how can this be done on x86 architecture?

Just the same, I'd say, but I admit I never tried, as I never had an
embedded x86 system to play with.

> But even with this, how does this address the random occurance of hotplugable bus masters?

For hot-plugable bus masters, obviously it doesn't work. You can go the
i2c-i801 way for now. But if you think i2c_register_board_info() should
be extended to support less static setups, I have no problem with this.
For example, i2c_register_board_info_dynamic() could be introduced,
based on i2c_register_board_info() but you'd pass a "bus match"
callback function instead of a bus number. The callback could check for
example the adapter name to tell if this is the bus on which the slave
devices should be instantiated, or it could check for a specific
platform and be inactive for others.

Whatever you need, just ask for it, or even better, code it yourself,
test it, and if it works and seems reasonable as a general solution,
send it over. This is an evolving area, this is no surprise that
changes are needed.

> > (...)
> > You can always look-up the right I2C bus number based on its name,
> > assuming your driver properly names them. There is some code doing that
> > at:
> > http://www.lm-sensors.org/browser/i2c-tools/trunk/tools/i2cbusses.c#L297
> > 
> > Ideally this code should move to libi2c and/or i2cdetect should offer
> > an interface to it, so it can easily be called from custom tools and
> > scripts.
> 
> You either need this get the current (maybe non-fixed) bus number and attach the devices by new_device or there is some in-kernel or udev related mechanism which returns the current bus number from some unique deivce path or description.

You can do a lot of things with carefully crafted udev rules, yes.

-- 
Jean Delvare
