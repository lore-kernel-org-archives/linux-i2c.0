From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] ACPI: Add _DEP(Operation Region Dependencies) support
 to fix battery issue on the Asus T100TA
Date: Fri, 26 Sep 2014 13:23:29 +0800
Message-ID: <5424F851.1020809@intel.com>
References: <1411456003-29541-1-git-send-email-tianyu.lan@intel.com> <5595235.8OhLbSk3cf@vostro.rjw.lan> <5423E40B.8010302@intel.com> <2232717.X50lT6IYgQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2232717.X50lT6IYgQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com, wsa@the-dreams.de, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B409=E6=9C=8826=E6=97=A5 03:27, Rafael J. Wysocki wrote:
> I'm not sure what you mean.  "Dependent" means "depending on somethin=
g", so the
> question reads "This requires the devices with _DEP to have a list of=
 devices
> that depend on them" which is probably not what you meant.
>=20

Sorry, I didn't say clearly. The "dependent device" I meant is device
pointed to by _DEP(the master you mentioned at the bottom). I thought
master also needed a list to find its slave(device with _DEP).

> For each device with _DEP we have dep_devices, so if you pass a point=
er
> (opregion_adev) to the device that has just installed an operation re=
gion
> handler to acpi_walk_dep_device_list() as an argument, then you can d=
o
>=20
> 	for (i =3D 0; i < adev->dep_devices.count; i++)
> 		if (opregion_adev->handle =3D=3D adev->dep_devices.handles[i]) {
> 			adev->dep_unmet =3D false;
> 			acpi_bus_attach(adev);
> 			list_del(&dep->node);
> 			kfree(dep);
> 		}
>=20
> and of course appropriate locking needs to be there in case this race=
s with
> enumeration during hotplug after loading a new ACPI table on demand).
>=20

Yes, we can scan all devices on the list and match the opregion_adev
with adev->dep_devices. This is comparatively simple solution.

> I think you can even define
>  =20
> struct acpi_dep_data {
> 	struct list_head node;
> 	struct acpi_device *master;
> 	struct acpi_device *slave;
> };
>=20
> and create that for every valid pair of master (device pointed to by =
_DEP)/slave
> (device with _DEP) and create a list of these.  Then, you won't need =
dep_devices
> in struct acpi_device any more and your acpi_walk_dep_device_list() w=
ill only
> need to walk the list until it finds the matching master/slave pair.

One question is that when create struct acpi_dep_data for the dependenc=
y
relationship between master and slave. If do this when slave's ACPI
device is created during ACPI namespace scan, master's ACPI device mayb=
e
not created at that point. So acpi_handle maybe more suitable than
struct acpi_device here.

>=20
> That will handle the case when one device depends on multiple other d=
evices too
> I think.
>=20
>>>> > >> +		dep_adev =3D acpi_bus_get_acpi_device(
>>>> > >> +				adev->dep_devices.handles[i]);
>> >=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
