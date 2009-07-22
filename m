From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Wed, 22 Jul 2009 21:07:53 +0200
Message-ID: <20090722210753.35802816@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
	<20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare>
	<ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare>
	<ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

On Sun, 5 Jul 2009 23:34:01 +0200, Kay Sievers wrote:
> On Sun, Jul 5, 2009 at 22:56, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Sun, 5 Jul 2009 22:19:46 +0200, Kay Sievers wrote:
> >> I think this is already removed in the current git tree, and all
> >> should use dev_pm_ops, yes.
> >
> > In which git tree? In Linus' tree, struct bus_type definitely doesn=
't
> > use dev_pm_ops yet.
>=20
> But it removed all the other stuff:
>   commit 00725787511e20dbd1fdc1fb233606120ae5c8cf
>   Author: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
>   Date:   Thu Jun 4 22:13:25 2009 +0200
>=20
>   PM: Remove device_type suspend()/resume()

This is correct but only for device_type. For bus_type, I still can see
both suspend/resume and dev_pm_ops. And right now the i2c core is using
the suspend/resume flavor. So my question is: how do I convert from
suspend/resume to dev_pm_ops? I'm fairly sure I am not the first
developer who has to do this, so my hope was that there was either a
document explaining the process, or a commit doing this for another
subsystem, which I could simply stare at and copy from.

> >> Yeah, we just need to apply the /sys/devices/virtual logic to bus
> >> devices too, it's currently limited to class devices, because ther=
e
> >> was no bus device so far who needed this, but should be an easy
> >> change.
> >
> > It will probably have do be a little different, as it is valid to
> > register a device without a parent, to have it appear at the root
> > (actually 1st level) of the device tree. So we'll need a way to
> > differentiate between this case and the virtual device case.
> >
> > I admit I am a little surprised that I am the first person asking f=
or
> > virtual bus devices, especially given how you like to repeat that i=
2c
> > was doing things differently from the rest of the world so far and =
I am
> > merely changing i2c to fit in the common model.
>=20
> Usually bus devices are a child of root device like pci or some
> platform stuff. If i2c does not have any parents like this, and is by
> itself a root for other stuff, maybe we get /sys/devices/i2c, like we
> have for pci, acpi, ccw (IBM s390), and all these device roots.

=46or physical I2C controller devices, I do expect them to have a paren=
t
(either platform or pci in most cases.) i2c-stub is different, it's a
software-only driver. So I do not expect that we have /sys/devices/i2c,
but I do expect us to have /sys/devices/virtual/i2c or some such.

> >> If you decide to do it that way, you would need the driver core to=
 be able:
> >> =A0 - to create a link from an otherwise empty "struct class" to a=
n
> >> existing bus-device
> >> =A0 - put bus devices without a parent into the /sys/devices/virtu=
al logic
> >> right? Let me know, I can look into that, if you need that.
> >
> > Yes, this is a good summary of my needs. With some room for discuss=
ion
> > on both points:
> > * Do we need an actually struct class for each fake class, or just =
a
> > =A0class name?
>=20
> We will need to create a kobject for the compat class directory, we
> will not need a "struct class" for it and can just use a simple
> pointer to the registered kobject. If we use a string, we would need
> to find the registered kobject with every call to create a link there=
,
> not necessarily bad, but an explicitely registered object might be
> easier.

Any progress on this? I have just committed the patches to
sensors-detect and libsensors, and the kernel patch is ready to go, but
without the compatibility links it doesn't make any sense to push it
upstream, not even in linux-next: lm-sensors would be broken for almost
all users.

> > * Do we want to put virtual devices in devices/virtual directly, or=
 do
> > =A0we want separate namespaces?
> > But these are details which can be solved on the way, and I have no
> > strong opinion about them anyway.
>=20
> It's basically the question if these objects usually represent real
> hardware or not. If the root i2c device just happens to have no other
> existing bus as a parent, we might just want:  /sys/devices/i2c/.

In the only case I am aware of at the moment, i2c-stub, no it doesn't
represent real hardware.

Note that I don't really care how we handle i2c-stub, BTW. It's really
only a developer tool so we don't have to care too much about backwards
compatibility etc.

--=20
Jean Delvare
