From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] ACPI: Add _DEP(Operation Region Dependencies) support to fix battery issue on the Asus T100TA
Date: Fri, 26 Sep 2014 15:48:51 +0200
Message-ID: <2646100.uUyj9r3K3o@vostro.rjw.lan>
References: <1411456003-29541-1-git-send-email-tianyu.lan@intel.com> <2232717.X50lT6IYgQ@vostro.rjw.lan> <5424F851.1020809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5424F851.1020809@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com, wsa@the-dreams.de, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Friday, September 26, 2014 01:23:29 PM Lan Tianyu wrote:
> On 2014=E5=B9=B409=E6=9C=8826=E6=97=A5 03:27, Rafael J. Wysocki wrote=
:
> > I'm not sure what you mean.  "Dependent" means "depending on someth=
ing", so the
> > question reads "This requires the devices with _DEP to have a list =
of devices
> > that depend on them" which is probably not what you meant.
> >=20
>=20
> Sorry, I didn't say clearly. The "dependent device" I meant is device
> pointed to by _DEP(the master you mentioned at the bottom). I thought
> master also needed a list to find its slave(device with _DEP).
>=20
> > For each device with _DEP we have dep_devices, so if you pass a poi=
nter
> > (opregion_adev) to the device that has just installed an operation =
region
> > handler to acpi_walk_dep_device_list() as an argument, then you can=
 do
> >=20
> > 	for (i =3D 0; i < adev->dep_devices.count; i++)
> > 		if (opregion_adev->handle =3D=3D adev->dep_devices.handles[i]) {
> > 			adev->dep_unmet =3D false;
> > 			acpi_bus_attach(adev);
> > 			list_del(&dep->node);
> > 			kfree(dep);
> > 		}
> >=20
> > and of course appropriate locking needs to be there in case this ra=
ces with
> > enumeration during hotplug after loading a new ACPI table on demand=
).
> >=20
>=20
> Yes, we can scan all devices on the list and match the opregion_adev
> with adev->dep_devices. This is comparatively simple solution.
>=20
> > I think you can even define
> >  =20
> > struct acpi_dep_data {
> > 	struct list_head node;
> > 	struct acpi_device *master;
> > 	struct acpi_device *slave;
> > };
> >=20
> > and create that for every valid pair of master (device pointed to b=
y _DEP)/slave
> > (device with _DEP) and create a list of these.  Then, you won't nee=
d dep_devices
> > in struct acpi_device any more and your acpi_walk_dep_device_list()=
 will only
> > need to walk the list until it finds the matching master/slave pair=
=2E
>=20
> One question is that when create struct acpi_dep_data for the depende=
ncy
> relationship between master and slave. If do this when slave's ACPI
> device is created during ACPI namespace scan, master's ACPI device ma=
ybe
> not created at that point. So acpi_handle maybe more suitable than
> struct acpi_device here.

Right.  The handle is fine too and should be sufficient.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
