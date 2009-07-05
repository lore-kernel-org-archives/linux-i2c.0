From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Sun, 5 Jul 2009 22:19:46 +0200
Message-ID: <ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
References: <20090426103025.4525edd3@hyperion.delvare> <20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090704191431.3d352d0b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 4, 2009 at 19:14, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Mon, 4 May 2009 14:40:36 +0200, Kay Sievers wrote:

>> (The less difference between classes and buses the better. It is wro=
ng
>> to have two types of subsystems, doing almost the same thing. One
>> could argue that it could be useful inside the kernel, which it isn'=
t,
>> I think, but exporting them to userspace was definitely the wrong
>> thing.)
>
> I finally took a stab at this. The resulting patch is below. I have
> used device_type to differentiate between I2C clients and I2C adapter=
s.
> Is this what you had in mind?

Looks fine, by just looking at the patch.

> It seems to work reasonably well, with the following issues remaining=
:
>
> * The change breaks at least sensors-detect and libsensors. I can
> =C2=A0easily modify them so that they work again, but we still have a
> =C2=A0compatibility issue. Is it possible to have a compatibility opt=
ion
> =C2=A0that would add symbolic links from class/i2c-adapter/i2c-* to
> =C2=A0bus/i2c/devices/i2c-* for a couple years?

Yeah, we can add that. I guess others will need that too, if we
convert things from class to bus. How would that look like? Like a
device_add_class_compat_link(*dev, *class)?

> * Now that i2c-core makes use of device_type, I tried to move the pow=
er
> =C2=A0management handling callbacks there from bus_type, to save a te=
st in
> =C2=A0each function, however I found that the callback set is differe=
nt
> =C2=A0between bus_type and device_type.pm. Why is it so? Is there a d=
ocument
> =C2=A0explaining the difference? Is the whole world (including bus_ty=
pe)
> =C2=A0eventually moving to dev_pm_ops?

I think this is already removed in the current git tree, and all
should use dev_pm_ops, yes.

> * When i2c-adapters were class devices, virtual ones (for example
> =C2=A0i2c-stub) appeared in sysfs as devices/virtual/i2c-adapter/i2c-=
*,
> =C2=A0which made sense and seemed safe. Now that I have turned them i=
nto
> =C2=A0bus devices, virtual ones appear in sysfs as devices/i2c-* dire=
ctly,
> =C2=A0which looks dirty and could result in collisions someday. What =
should
> =C2=A0be done about this? I wanted to use virtual_device_parent() but=
 it is
> =C2=A0internal to the driver core at the moment, and doesn't even exi=
st if
> =C2=A0CONFIG_SYSFS_DEPRECATED=3Dy.

Yeah, we just need to apply the /sys/devices/virtual logic to bus
devices too, it's currently limited to class devices, because there
was no bus device so far who needed this, but should be an easy
change.

> I would be grateful if you can advise on any of the above points.

If you decide to do it that way, you would need the driver core to be a=
ble:
  - to create a link from an otherwise empty "struct class" to an
existing bus-device
  - put bus devices without a parent into the /sys/devices/virtual logi=
c
right? Let me know, I can look into that, if you need that.

Thanks,
Kay
