From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Sun, 5 Jul 2009 22:56:16 +0200
Message-ID: <20090705225616.1d4817e7@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
	<20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare>
	<ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510907051319i414a5e78r74d623ebb0508d0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

On Sun, 5 Jul 2009 22:19:46 +0200, Kay Sievers wrote:
> On Sat, Jul 4, 2009 at 19:14, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, 4 May 2009 14:40:36 +0200, Kay Sievers wrote:
>=20
> >> (The less difference between classes and buses the better. It is w=
rong
> >> to have two types of subsystems, doing almost the same thing. One
> >> could argue that it could be useful inside the kernel, which it is=
n't,
> >> I think, but exporting them to userspace was definitely the wrong
> >> thing.)
> >
> > I finally took a stab at this. The resulting patch is below. I have
> > used device_type to differentiate between I2C clients and I2C adapt=
ers.
> > Is this what you had in mind?
>=20
> Looks fine, by just looking at the patch.
>=20
> > It seems to work reasonably well, with the following issues remaini=
ng:
> >
> > * The change breaks at least sensors-detect and libsensors. I can
> > =A0easily modify them so that they work again, but we still have a
> > =A0compatibility issue. Is it possible to have a compatibility opti=
on
> > =A0that would add symbolic links from class/i2c-adapter/i2c-* to
> > =A0bus/i2c/devices/i2c-* for a couple years?
>=20
> Yeah, we can add that. I guess others will need that too, if we
> convert things from class to bus. How would that look like? Like a
> device_add_class_compat_link(*dev, *class)?

Yes. I'm not just sure what "class" would be exactly... either a "real"
fake class, or a mere string representing the fake class name?

> > * Now that i2c-core makes use of device_type, I tried to move the p=
ower
> > =A0management handling callbacks there from bus_type, to save a tes=
t in
> > =A0each function, however I found that the callback set is differen=
t
> > =A0between bus_type and device_type.pm. Why is it so? Is there a do=
cument
> > =A0explaining the difference? Is the whole world (including bus_typ=
e)
> > =A0eventually moving to dev_pm_ops?
>=20
> I think this is already removed in the current git tree, and all
> should use dev_pm_ops, yes.

In which git tree? In Linus' tree, struct bus_type definitely doesn't
use dev_pm_ops yet.

> > * When i2c-adapters were class devices, virtual ones (for example
> > =A0i2c-stub) appeared in sysfs as devices/virtual/i2c-adapter/i2c-*=
,
> > =A0which made sense and seemed safe. Now that I have turned them in=
to
> > =A0bus devices, virtual ones appear in sysfs as devices/i2c-* direc=
tly,
> > =A0which looks dirty and could result in collisions someday. What s=
hould
> > =A0be done about this? I wanted to use virtual_device_parent() but =
it is
> > =A0internal to the driver core at the moment, and doesn't even exis=
t if
> > =A0CONFIG_SYSFS_DEPRECATED=3Dy.
>=20
> Yeah, we just need to apply the /sys/devices/virtual logic to bus
> devices too, it's currently limited to class devices, because there
> was no bus device so far who needed this, but should be an easy
> change.

It will probably have do be a little different, as it is valid to
register a device without a parent, to have it appear at the root
(actually 1st level) of the device tree. So we'll need a way to
differentiate between this case and the virtual device case.

I admit I am a little surprised that I am the first person asking for
virtual bus devices, especially given how you like to repeat that i2c
was doing things differently from the rest of the world so far and I am
merely changing i2c to fit in the common model.

> > I would be grateful if you can advise on any of the above points.
>=20
> If you decide to do it that way, you would need the driver core to be=
 able:
>   - to create a link from an otherwise empty "struct class" to an
> existing bus-device
>   - put bus devices without a parent into the /sys/devices/virtual lo=
gic
> right? Let me know, I can look into that, if you need that.

Yes, this is a good summary of my needs. With some room for discussion
on both points:
* Do we need an actually struct class for each fake class, or just a
  class name?
* Do we want to put virtual devices in devices/virtual directly, or do
  we want separate namespaces?
But these are details which can be solved on the way, and I have no
strong opinion about them anyway.

Thanks,
--=20
Jean Delvare
