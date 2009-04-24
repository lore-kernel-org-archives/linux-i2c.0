From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Fri, 24 Apr 2009 11:38:04 -0400
Message-ID: <9e4733910904240838k5f425d7m849cd6b7fad19f27@mail.gmail.com>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com>
	 <49ED9132.9050806@gmx.de> <20090421095112.GB3100@pengutronix.de>
	 <49EDC487.8010201@gmx.de> <20090424085256.GA26169@pengutronix.de>
	 <49F19A11.3090700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49F19A11.3090700-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 24, 2009 at 6:53 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wr=
ote:
> Wolfram Sang said the following:
> ...
>>> Allowing only clients that are mentioned in DTS?
>>
>> For now, yes. This is still the common case (=3Davoid probing). Unti=
l a
>> mainline solution comes up (which is needed, I agree on that), not s=
o
>> common cases could simply patch the driver to add a .class field.
>>
> Especially it is ugly that devices which are mentioned in DTS but are
> not present (because the component isn't plugged in or powered) get a=
n
> directory entry in /sys/bus/i2c/devices with bind, unbind, ...
> This is my 'problem': I search for a clean way to instantiate on dema=
nd
> with no zombies in case of missing H/W. I know there are problems in
> identification of devices, but to remove all possibilities to try it
> seems not a good way for me.

You might want to ask about this on the linux-ppc mailing list.

You're stuck because i2c hardware does not support hotplug. Since the
hardware doesn't support hotplug there's no software support for it in
the kernel. So you want to fall back to polled probing.

But probing is bad because it isn't standardized and coordinated, one
device's probe can cause another device to destroy things (like set a
voltage too high on a motherboard). Because of this probing can't be
turned on in general.

It's possible to get to the i2c bus from user space. You could write a
user space app that polls in your controlled environment. When you
detect the new devices you can load the appropriate modules. Now you
need to instantiate these new devices.

Jean, is it still possible to instantiate i2c devices from the module
command line?

>
>>> How should it work on systems without DTS?
>>
>> i2c_board_info? (no offence, sometimes it is hard to tell if you kno=
w
>> all details and still see a valid problem or if you are just missing
>> details. If the first one is the case, please be a bit more elaborat=
ive
>> on the problem.)
>
> I am new in the sense that I jumped in at 2.4 making some non
> i2c-drivers, rejoind at 2.6.24 for i2c-drivers and a non i2c-driver.
> Currently I try to catch up to current state to prepare management of
> all i2c-devices on our next project.
>
> Even i2c_board_info needs to be filled in and passed to subsystem via=
 a
> function call. Which part of kernel is supposed to do that without
> changing code beside board specific configuration files?
> (I do really mean this as a question.)
>
> --
> Kind regards,
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
