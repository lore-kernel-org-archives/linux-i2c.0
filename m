From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] ACPI: Add _DEP(Operation Region Dependencies) support
 to fix battery issue on the Asus T100TA
Date: Thu, 25 Sep 2014 17:44:43 +0800
Message-ID: <5423E40B.8010302@intel.com>
References: <1411456003-29541-1-git-send-email-tianyu.lan@intel.com> <5595235.8OhLbSk3cf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5595235.8OhLbSk3cf-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B409=E6=9C=8825=E6=97=A5 06:27, Rafael J. Wysocki wrote:
> On Tuesday, September 23, 2014 03:06:43 PM Lan Tianyu wrote:
>> ACPI 5.0 introduces _DEP to designate device objects that OSPM shoul=
d
>> assign a higher priority in start ordering due to future operation r=
egion
>> accesses.
>>
>> On Asus T100TA, ACPI battery info are read from a I2C slave device v=
ia
>> I2C operation region. Before I2C operation region handler is install=
ed,
>> battery _STA always returns 0. There is a _DEP method of designating
>> start order under battery device node.
>>
>> This patch is to implement _DEP feature to fix battery issue on the =
Asus T100TA.
>> Introducing acpi_bus_dep_device_list and adding dep_present flags in=
 the struct
>> acpi_device. During ACPI namespace scan, all devices with _DEP suppo=
rt will be put
>> into the new list and those devices' dep_present flag will be set. D=
river's probe()
>> should return EPROBE_DEFER when find dep_present is set. When I2C op=
eration
>> region handler is installed, check all devices on the new list. Remo=
ve the one from
>> list if _DEP condition is met and clear its dep_present flag and do =
acpi_bus_attch()
>> for the device in order to resolve battery _STA issue on the Asus T1=
00TA.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> This is going in the right direction in my view, but isn't there just=
 yet.
>=20
> Details below.

Thanks for review.

>=20
>> ---
>>  drivers/acpi/battery.c  |  4 +++
>>  drivers/acpi/scan.c     | 84 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  drivers/i2c/i2c-acpi.c  |  1 +
>>  include/acpi/acpi_bus.h |  2 ++
>>  include/linux/acpi.h    |  3 ++
>>  5 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 1c162e7..c0a68ce 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -1194,6 +1194,10 @@ static int acpi_battery_add(struct acpi_devic=
e *device)
>> =20
>>  	if (!device)
>>  		return -EINVAL;
>> +
>> +	if (device->dep_present)
>=20
> device->flags.dep_present would be better.  Or even call the flag dep=
_unmet.

Ok. Will update.

>=20
>> +		return -EPROBE_DEFER;
>> +
>>  	battery =3D kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
>>  	if (!battery)
>>  		return -ENOMEM;
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 3bf7764..a26dbb3 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -36,6 +36,7 @@ bool acpi_force_hot_remove;
>> =20
>>  static const char *dummy_hid =3D "device";
>> =20
>> +static LIST_HEAD(acpi_bus_dep_device_list);
>>  static LIST_HEAD(acpi_bus_id_list);
>>  static DEFINE_MUTEX(acpi_scan_lock);
>>  static LIST_HEAD(acpi_scan_handlers_list);
>> @@ -43,6 +44,11 @@ DEFINE_MUTEX(acpi_device_lock);
>>  LIST_HEAD(acpi_wakeup_device_list);
>>  static DEFINE_MUTEX(acpi_hp_context_lock);
>> =20
>> +struct acpi_dep_data {
>> +	struct list_head node;
>> +	struct acpi_device *adev;
>> +};
>> +
>>  struct acpi_device_bus_id{
>>  	char bus_id[15];
>>  	unsigned int instance_no;
>> @@ -2048,6 +2054,32 @@ static void acpi_scan_init_hotplug(struct acp=
i_device *adev)
>>  	}
>>  }
>> =20
>> +static void acpi_device_dep_initialize(struct acpi_device * adev)
>> +{
>> +	struct acpi_dep_data *dep;
>> +	acpi_status status;
>> +
>> +	if (!acpi_has_method(adev->handle, "_DEP"))
>> +		return;
>> +
>> +	status =3D acpi_evaluate_reference(adev->handle, "_DEP", NULL,
>> +					&adev->dep_devices);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(&adev->dev, "Fail to evaluate _DEP.\n");
>=20
> "Failed"
>=20
>> +		return;
>> +	}
>> +
>> +	dep =3D kzalloc(sizeof(struct acpi_dep_data), GFP_KERNEL);
>> +	if (!dep) {
>> +		dev_err(&adev->dev, "Memory allocation error.\n");
>=20
> "Not enough memory for _DEP list entry\n"
>=20
>> +		return;
>> +	}
>> +
>> +	dep->adev =3D adev;
>> +	adev->dep_present =3D true;
>> +	list_add_tail(&dep->node , &acpi_bus_dep_device_list);
>> +}
>> +
>>  static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_n=
ot_used,
>>  				      void *not_used, void **return_value)
>>  {
>> @@ -2074,6 +2106,7 @@ static acpi_status acpi_bus_check_add(acpi_han=
dle handle, u32 lvl_not_used,
>>  		return AE_CTRL_DEPTH;
>> =20
>>  	acpi_scan_init_hotplug(device);
>> +	acpi_device_dep_initialize(device);
>> =20
>>   out:
>>  	if (!*return_value)
>> @@ -2191,6 +2224,57 @@ static void acpi_bus_attach(struct acpi_devic=
e *device)
>>  		acpi_bus_attach(child);
>>  }
>> =20
>> +static int acpi_device_dep_check(struct acpi_device *adev)
>> +{
>> +	struct acpi_device *dep_adev;
>> +	struct acpi_device_physical_node *pn;
>> +	int i;
>> +
>> +	for (i =3D 0; i < adev->dep_devices.count; i++) {
>> +		dep_adev =3D acpi_bus_get_acpi_device(
>> +				adev->dep_devices.handles[i]);
>> +
>> +		if (!dep_adev)
>> +			return -ENODEV;
>> +
>> +		/* Check acpi device driver probing */
>> +		if (dep_adev->dev.driver)
>> +			continue;
>=20
> This check isn't sufficient, because _DEP is supposed to be about ope=
ration
> regions being present, not about drivers being present.  Same for the=
 driver
> check below.
>=20
> I wouldn't bother to check drivers in this stub implementation. ->

Sounds like we need to check whether the dependent device node has been
attached with operation region handler and this needs ACPICA to expose
such function, right?

>=20
>> +
>> +		if (!dep_adev->physical_node_count)
>> +			return -ENODEV;
>> +
>> +		/* Check physcial device node driver probing */
>> +		mutex_lock(&dep_adev->physical_node_lock);
>> +		list_for_each_entry(pn, &dep_adev->physical_node_list, node) {
>> +			if (pn->dev->driver) {
>> +				mutex_unlock(&dep_adev->physical_node_lock);
>> +				continue;
>> +			}
>> +		}
>> +		mutex_unlock(&dep_adev->physical_node_lock);
>> +		return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int acpi_walk_dep_device_list(void)
>=20
> -> I'd pass the operation region device to that (and I'd call the fun=
ction
> differently, but that's a detail).  Then, I'd just clear flags.dep_un=
met
> for all devices having that operation region device in their dep_devi=
ces
> (and drop their entries from the list).  It wouldn't cover the case w=
hen
> one device depends on two operation regions at the same time (in a me=
aningful
> way), but should be sufficient to address the battery problem at hand=
=2E=20
>=20

This requires the dependent devices have a list to record devices which
depends on them, right? Create such lists during ACPI namespace scan.


>> +{
>> +	struct acpi_dep_data *dep, *tmp;
>> +
>> +	list_for_each_entry_safe(dep, tmp, &acpi_bus_dep_device_list, node=
) {
>> +		if (!acpi_device_dep_check(dep->adev)) {
>> +			dep->adev->dep_present =3D false;
>> +			acpi_bus_attach(dep->adev);
>> +			list_del(&dep->node);
>> +			kfree(dep);
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_walk_dep_device_list);
>> +
>>  /**
>>   * acpi_bus_scan - Add ACPI device node objects in a given namespac=
e scope.
>>   * @handle: Root of the namespace scope to scan.
>> diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
>> index 0dbc18c..fdc8dc8 100644
>> --- a/drivers/i2c/i2c-acpi.c
>> +++ b/drivers/i2c/i2c-acpi.c
>> @@ -339,6 +339,7 @@ int acpi_i2c_install_space_handler(struct i2c_ad=
apter *adapter)
>>  		return -ENOMEM;
>>  	}
>> =20
>> +	acpi_walk_dep_device_list();
>>  	return 0;
>>  }
>> =20
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index c1c9de1..c1e7055 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -357,7 +357,9 @@ struct acpi_device {
>>  	struct acpi_hotplug_context *hp;
>>  	struct acpi_driver *driver;
>>  	void *driver_data;
>> +	bool dep_present;
>>  	struct device dev;
>> +	struct acpi_handle_list dep_devices;
>>  	unsigned int physical_node_count;
>>  	struct list_head physical_node_list;
>>  	struct mutex physical_node_lock;
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 807cbc4..c9a504b 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -431,6 +431,7 @@ static inline bool acpi_driver_match_device(stru=
ct device *dev,
>> =20
>>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent=
_env *);
>>  int acpi_device_modalias(struct device *, char *, int);
>> +int acpi_walk_dep_device_list(void);
>> =20
>>  #define ACPI_PTR(_ptr)	(_ptr)
>> =20
>> @@ -449,6 +450,8 @@ static inline const char *acpi_dev_name(struct a=
cpi_device *adev)
>> =20
>>  static inline void acpi_early_init(void) { }
>> =20
>> +static inline int acpi_walk_dep_device_list(void) { }
>> +
>>  static inline int early_acpi_boot_init(void)
>>  {
>>  	return 0;
>>
>=20


--=20
Best regards
Tianyu Lan
