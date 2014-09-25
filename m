From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH] ACPI: Add _DEP(Operation Region Dependencies) support to fix battery issue on the Asus T100TA
Date: Thu, 25 Sep 2014 22:15:59 +0200
Message-ID: <2099115.E7zZOe2MuE@vostro.rjw.lan>
References: <1411456003-29541-1-git-send-email-tianyu.lan@intel.com> <5423E40B.8010302@intel.com> <2232717.X50lT6IYgQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2232717.X50lT6IYgQ-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday, September 25, 2014 09:27:25 PM Rafael J. Wysocki wrote:
> On Thursday, September 25, 2014 05:44:43 PM Lan Tianyu wrote:
> > On 2014=E5=B9=B409=E6=9C=8825=E6=97=A5 06:27, Rafael J. Wysocki wro=
te:
> > > On Tuesday, September 23, 2014 03:06:43 PM Lan Tianyu wrote:
> > >> ACPI 5.0 introduces _DEP to designate device objects that OSPM s=
hould
> > >> assign a higher priority in start ordering due to future operati=
on region
> > >> accesses.
> > >>
> > >> On Asus T100TA, ACPI battery info are read from a I2C slave devi=
ce via
> > >> I2C operation region. Before I2C operation region handler is ins=
talled,
> > >> battery _STA always returns 0. There is a _DEP method of designa=
ting
> > >> start order under battery device node.
> > >>
> > >> This patch is to implement _DEP feature to fix battery issue on =
the Asus T100TA.
> > >> Introducing acpi_bus_dep_device_list and adding dep_present flag=
s in the struct
> > >> acpi_device. During ACPI namespace scan, all devices with _DEP s=
upport will be put
> > >> into the new list and those devices' dep_present flag will be se=
t. Driver's probe()
> > >> should return EPROBE_DEFER when find dep_present is set. When I2=
C operation
> > >> region handler is installed, check all devices on the new list. =
Remove the one from
> > >> list if _DEP condition is met and clear its dep_present flag and=
 do acpi_bus_attch()
> > >> for the device in order to resolve battery _STA issue on the Asu=
s T100TA.
> > >>
> > >> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > >=20
> > > This is going in the right direction in my view, but isn't there =
just yet.
> > >=20
> > > Details below.
> >=20
> > Thanks for review.
> >=20
> > >=20
> > >> ---
> > >>  drivers/acpi/battery.c  |  4 +++
> > >>  drivers/acpi/scan.c     | 84 ++++++++++++++++++++++++++++++++++=
+++++++++++++++
> > >>  drivers/i2c/i2c-acpi.c  |  1 +
> > >>  include/acpi/acpi_bus.h |  2 ++
> > >>  include/linux/acpi.h    |  3 ++
> > >>  5 files changed, 94 insertions(+)
> > >>
> > >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > >> index 1c162e7..c0a68ce 100644
> > >> --- a/drivers/acpi/battery.c
> > >> +++ b/drivers/acpi/battery.c
> > >> @@ -1194,6 +1194,10 @@ static int acpi_battery_add(struct acpi_d=
evice *device)
> > >> =20
> > >>  	if (!device)
> > >>  		return -EINVAL;
> > >> +
> > >> +	if (device->dep_present)
> > >=20
> > > device->flags.dep_present would be better.  Or even call the flag=
 dep_unmet.
> >=20
> > Ok. Will update.
> >=20
> > >=20
> > >> +		return -EPROBE_DEFER;
> > >> +
> > >>  	battery =3D kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
> > >>  	if (!battery)
> > >>  		return -ENOMEM;
> > >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > >> index 3bf7764..a26dbb3 100644
> > >> --- a/drivers/acpi/scan.c
> > >> +++ b/drivers/acpi/scan.c
> > >> @@ -36,6 +36,7 @@ bool acpi_force_hot_remove;
> > >> =20
> > >>  static const char *dummy_hid =3D "device";
> > >> =20
> > >> +static LIST_HEAD(acpi_bus_dep_device_list);
> > >>  static LIST_HEAD(acpi_bus_id_list);
> > >>  static DEFINE_MUTEX(acpi_scan_lock);
> > >>  static LIST_HEAD(acpi_scan_handlers_list);
> > >> @@ -43,6 +44,11 @@ DEFINE_MUTEX(acpi_device_lock);
> > >>  LIST_HEAD(acpi_wakeup_device_list);
> > >>  static DEFINE_MUTEX(acpi_hp_context_lock);
> > >> =20
> > >> +struct acpi_dep_data {
> > >> +	struct list_head node;
> > >> +	struct acpi_device *adev;
> > >> +};
> > >> +
> > >>  struct acpi_device_bus_id{
> > >>  	char bus_id[15];
> > >>  	unsigned int instance_no;
> > >> @@ -2048,6 +2054,32 @@ static void acpi_scan_init_hotplug(struct=
 acpi_device *adev)
> > >>  	}
> > >>  }
> > >> =20
> > >> +static void acpi_device_dep_initialize(struct acpi_device * ade=
v)
> > >> +{
> > >> +	struct acpi_dep_data *dep;
> > >> +	acpi_status status;
> > >> +
> > >> +	if (!acpi_has_method(adev->handle, "_DEP"))
> > >> +		return;
> > >> +
> > >> +	status =3D acpi_evaluate_reference(adev->handle, "_DEP", NULL,
> > >> +					&adev->dep_devices);
> > >> +	if (ACPI_FAILURE(status)) {
> > >> +		dev_err(&adev->dev, "Fail to evaluate _DEP.\n");
> > >=20
> > > "Failed"
> > >=20
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	dep =3D kzalloc(sizeof(struct acpi_dep_data), GFP_KERNEL);
> > >> +	if (!dep) {
> > >> +		dev_err(&adev->dev, "Memory allocation error.\n");
> > >=20
> > > "Not enough memory for _DEP list entry\n"
> > >=20
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	dep->adev =3D adev;
> > >> +	adev->dep_present =3D true;
> > >> +	list_add_tail(&dep->node , &acpi_bus_dep_device_list);
> > >> +}
> > >> +
> > >>  static acpi_status acpi_bus_check_add(acpi_handle handle, u32 l=
vl_not_used,
> > >>  				      void *not_used, void **return_value)
> > >>  {
> > >> @@ -2074,6 +2106,7 @@ static acpi_status acpi_bus_check_add(acpi=
_handle handle, u32 lvl_not_used,
> > >>  		return AE_CTRL_DEPTH;
> > >> =20
> > >>  	acpi_scan_init_hotplug(device);
> > >> +	acpi_device_dep_initialize(device);
> > >> =20
> > >>   out:
> > >>  	if (!*return_value)
> > >> @@ -2191,6 +2224,57 @@ static void acpi_bus_attach(struct acpi_d=
evice *device)
> > >>  		acpi_bus_attach(child);
> > >>  }
> > >> =20
> > >> +static int acpi_device_dep_check(struct acpi_device *adev)
> > >> +{
> > >> +	struct acpi_device *dep_adev;
> > >> +	struct acpi_device_physical_node *pn;
> > >> +	int i;
> > >> +
> > >> +	for (i =3D 0; i < adev->dep_devices.count; i++) {
> > >> +		dep_adev =3D acpi_bus_get_acpi_device(
> > >> +				adev->dep_devices.handles[i]);
> > >> +
> > >> +		if (!dep_adev)
> > >> +			return -ENODEV;
> > >> +
> > >> +		/* Check acpi device driver probing */
> > >> +		if (dep_adev->dev.driver)
> > >> +			continue;
> > >=20
> > > This check isn't sufficient, because _DEP is supposed to be about=
 operation
> > > regions being present, not about drivers being present.  Same for=
 the driver
> > > check below.
> > >=20
> > > I wouldn't bother to check drivers in this stub implementation. -=
>
> >=20
> > Sounds like we need to check whether the dependent device node has =
been
> > attached with operation region handler and this needs ACPICA to exp=
ose
> > such function, right?
>=20
> Yes.  That's why I suggested to do the check in the function that ins=
talls
> the operation region handler.  This way we are sure that the handler =
is
> already present.
>=20
> > >=20
> > >> +
> > >> +		if (!dep_adev->physical_node_count)
> > >> +			return -ENODEV;
> > >> +
> > >> +		/* Check physcial device node driver probing */
> > >> +		mutex_lock(&dep_adev->physical_node_lock);
> > >> +		list_for_each_entry(pn, &dep_adev->physical_node_list, node) =
{
> > >> +			if (pn->dev->driver) {
> > >> +				mutex_unlock(&dep_adev->physical_node_lock);
> > >> +				continue;
> > >> +			}
> > >> +		}
> > >> +		mutex_unlock(&dep_adev->physical_node_lock);
> > >> +		return -EFAULT;
> > >> +	}
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +int acpi_walk_dep_device_list(void)
> > >=20
> > > -> I'd pass the operation region device to that (and I'd call the=
 function
> > > differently, but that's a detail).  Then, I'd just clear flags.de=
p_unmet
> > > for all devices having that operation region device in their dep_=
devices
> > > (and drop their entries from the list).  It wouldn't cover the ca=
se when
> > > one device depends on two operation regions at the same time (in =
a meaningful
> > > way), but should be sufficient to address the battery problem at =
hand.=20
> > >=20
> >=20
> > This requires the dependent devices have a list to record devices w=
hich
> > depends on them, right? Create such lists during ACPI namespace sca=
n.
>=20
> I'm not sure what you mean.  "Dependent" means "depending on somethin=
g", so the
> question reads "This requires the devices with _DEP to have a list of=
 devices
> that depend on them" which is probably not what you meant.
>=20
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
>=20
> That will handle the case when one device depends on multiple other d=
evices too
> I think.

Of course, in that case dep_unmet needs to be a counter that will be dr=
opped by 1
every time an item is dropped from the list for the given slave device.=
  In which
case it is better to keep it directly under struct acpi_device rather t=
han in the
flags.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
