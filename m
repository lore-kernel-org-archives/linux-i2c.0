From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Wed, 22 Aug 2012 11:17:51 +0200
Message-ID: <24029861.U7thTLuEmC@ws-stein>
References: <4401854.hVfHzgeqjT@ws-stein> <3514180.RWySLZuOJm@ws-stein> <20120822160439.62c619bf@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120822160439.62c619bf@feng-i7>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Am Mittwoch, 22. August 2012, 16:04:39 schrieb Feng Tang:
> > Why use a fixed one? Give the driver (and maybe every i2c bus driver) a parameter which sets the base bus number it should use.
> > E.g. i2c-eg20t.base-bus-num=2 so it will register the bus numbers starting from 2. If this parameter is unset. It would use the first free one, thus simply using i2c_add_adapter.
> 
> The reason we need a fixed number is it is easier for platform code
> which needs to register dozens of i2c devices to different controllers
> with i2c_register_board_info, and they need provide a bus number for
> each i2c device, this _binding_ info is not detectable but have to
> be fixed.

Yes, I'm aware of that. With "Why use a fixed one?" I meant why hard-code it into the driver. I should be changeable.
Because this is/was not possible in general to use i2c_register_board_info, so we used an echo to /sys/bus/i2c/devices/i2c-0/new_device or /sys/bus/i2c/devices/i2c-1/new_device.

> Yes, your module parameter "base-bus-num" sounds like a plan too,
> at the cost of some extra setting in the kernel cmdline. And I'm fine
> with all solutions as long as I can get a _fixed_ bus number so that
> I can easily write the platform config code (I guess this is same
> for device tree, and even ACPI 5.0)

i2c_add_numbered_adapter only works reliably if only using a single driver. If you are using several, especially if one uses dynamic bus numbers, you're kinda screwed.
So, not very driver can add busses starting at bus number 0.
I guess using an Intel Atom (i2c-isch) with an eg20t is not that uncommon, so you'll end up using 2 drivers where each one should have a fixed number.
Some mechanism like udev for renaming ethernet or block devices is needed here.

Regards,
Alexander
