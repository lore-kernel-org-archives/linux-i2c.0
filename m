From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Sun, 5 Jul 2009 23:34:01 +0200
Message-ID: <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
References: <20090426103025.4525edd3@hyperion.delvare> <20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare> <ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090705225616.1d4817e7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 5, 2009 at 22:56, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Sun, 5 Jul 2009 22:19:46 +0200, Kay Sievers wrote:

>> > * Now that i2c-core makes use of device_type, I tried to move the =
power
>> > =C2=A0management handling callbacks there from bus_type, to save a=
 test in
>> > =C2=A0each function, however I found that the callback set is diff=
erent
>> > =C2=A0between bus_type and device_type.pm. Why is it so? Is there =
a document
>> > =C2=A0explaining the difference? Is the whole world (including bus=
_type)
>> > =C2=A0eventually moving to dev_pm_ops?
>>
>> I think this is already removed in the current git tree, and all
>> should use dev_pm_ops, yes.
>
> In which git tree? In Linus' tree, struct bus_type definitely doesn't
> use dev_pm_ops yet.

But it removed all the other stuff:
  commit 00725787511e20dbd1fdc1fb233606120ae5c8cf
  Author: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
  Date:   Thu Jun 4 22:13:25 2009 +0200

  PM: Remove device_type suspend()/resume()

>> > * When i2c-adapters were class devices, virtual ones (for example
>> > =C2=A0i2c-stub) appeared in sysfs as devices/virtual/i2c-adapter/i=
2c-*,
>> > =C2=A0which made sense and seemed safe. Now that I have turned the=
m into
>> > =C2=A0bus devices, virtual ones appear in sysfs as devices/i2c-* d=
irectly,
>> > =C2=A0which looks dirty and could result in collisions someday. Wh=
at should
>> > =C2=A0be done about this? I wanted to use virtual_device_parent() =
but it is
>> > =C2=A0internal to the driver core at the moment, and doesn't even =
exist if
>> > =C2=A0CONFIG_SYSFS_DEPRECATED=3Dy.
>>
>> Yeah, we just need to apply the /sys/devices/virtual logic to bus
>> devices too, it's currently limited to class devices, because there
>> was no bus device so far who needed this, but should be an easy
>> change.
>
> It will probably have do be a little different, as it is valid to
> register a device without a parent, to have it appear at the root
> (actually 1st level) of the device tree. So we'll need a way to
> differentiate between this case and the virtual device case.
>
> I admit I am a little surprised that I am the first person asking for
> virtual bus devices, especially given how you like to repeat that i2c
> was doing things differently from the rest of the world so far and I =
am
> merely changing i2c to fit in the common model.

Usually bus devices are a child of root device like pci or some
platform stuff. If i2c does not have any parents like this, and is by
itself a root for other stuff, maybe we get /sys/devices/i2c, like we
have for pci, acpi, ccw (IBM s390), and all these device roots.

>> > I would be grateful if you can advise on any of the above points.
>>
>> If you decide to do it that way, you would need the driver core to b=
e able:
>> =C2=A0 - to create a link from an otherwise empty "struct class" to =
an
>> existing bus-device
>> =C2=A0 - put bus devices without a parent into the /sys/devices/virt=
ual logic
>> right? Let me know, I can look into that, if you need that.
>
> Yes, this is a good summary of my needs. With some room for discussio=
n
> on both points:
> * Do we need an actually struct class for each fake class, or just a
> =C2=A0class name?

We will need to create a kobject for the compat class directory, we
will not need a "struct class" for it and can just use a simple
pointer to the registered kobject. If we use a string, we would need
to find the registered kobject with every call to create a link there,
not necessarily bad, but an explicitely registered object might be
easier.

> * Do we want to put virtual devices in devices/virtual directly, or d=
o
> =C2=A0we want separate namespaces?
> But these are details which can be solved on the way, and I have no
> strong opinion about them anyway.

It's basically the question if these objects usually represent real
hardware or not. If the root i2c device just happens to have no other
existing bus as a parent, we might just want:  /sys/devices/i2c/.

Thanks,
Kay
