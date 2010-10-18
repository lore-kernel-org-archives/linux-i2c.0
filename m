From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [Device-drivers-devel] [PATCH] i2c: add irq_flags to board info
Date: Mon, 18 Oct 2010 15:51:49 -0400
Message-ID: <AANLkTi=fAYqxsGre9kOt9Z8nDXZ9JFjZtKUiMrE3Qn9b@mail.gmail.com>
References: <1287359019-1476-1-git-send-email-vapier@gentoo.org>
 <20101018103610.77b7e605@endymion.delvare> <544AC56F16B56944AEC3BD4E3D5917713094520EDB@LIMKCMBX1.ad.analog.com>
 <20101018140136.2b44d29e@endymion.delvare> <544AC56F16B56944AEC3BD4E3D5917713094520FA6@LIMKCMBX1.ad.analog.com>
 <20101018163357.659efe25@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101018163357.659efe25-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 18, 2010 at 10:33, Jean Delvare wrote:
> Why do we have set_irq_type() if we're not supposed to call it? I am
> not claiming to be an expert in the area, but it seems totally
> reasonable to me that the same piece of code instantiating an I2C
> device is also responsible for setting its IRQ type.

but we're back to the same issue mentioned earlier -- you cant have a
single kernel build with modules supporting multiple drivers
simultaneously.  we like to ship development boards with a single
kernel build on it with many modules.  then people can pick the addon
boards they wish to prototype with at runtime by plugging in the card
and loading the module.

if the only way to change flags on a pin is via set_irq_type(), that
kernel build is instantly tied to whatever device you've decided to
compile statically into the board's init code.  so now to prototype
multiple boards, we have to tell people to boot different kernels !?
and we have to store multiple kernels and sets of kernel modules in
the rootfs !?

>> The user decides which add-on module is plugged onto the processor board,
>> by loading the appropriate driver module.
>
> This can't work, sorry. Unless you are using I2C device auto-detection,
> which I seem to understand is NOT used in the embedded world at all,
> loading a driver module doesn't do anything if a device it supports
> hasn't been instantiated first. So the user can't just load a driver
> and see the required I2C devices magically appear for the driver to
> bind to them.

why cant user selection work ?  the user picks `modprobe foo` because
they have a 'foo' device plugged in.

i'm not sure what "I2C device auto-detection" means.  are you talking
about a userspace app/daemon that scans the I2C bus, looks up the
slave ids in the module db, and then automatically loads the modules
that it finds bindings for ?

>> There are drivers that work around this deficiency, by adding irq_flags to the bus
>> clients dev.platform_data.  See include/linux/spi/ads7846.h for one example.
>
> Interesting example, better matching the initial comment that came
> along with the patch. But it also seems to be an isolated case, as I
> can't find any other irq_flags in include/linux/{i2c,spi}/.

we've been holding off posting things because we need the core extended first
-mike
