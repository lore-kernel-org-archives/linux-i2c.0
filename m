From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Thu, 29 Dec 2016 22:09:32 +0100
Message-ID: <20161229210932.GA1254@kmp-mobile.hq.kempniu.pl>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201612291000.58489@pali>
 <20161229134719.GA941@ozzy.nask.waw.pl>
 <201612291517.37474@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201612291517.37474@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> On Thursday 29 December 2016 14:47:19 Michał Kępień wrote:
> > > On Thursday 29 December 2016 09:29:36 Michał Kępień wrote:
> > > > > Dell platform team told us that some (DMI whitelisted) Dell
> > > > > Latitude machines have ST microelectronics accelerometer at i2c
> > > > > address 0x29. That i2c address is not specified in DMI or ACPI,
> > > > > so runtime detection without whitelist which is below is not
> > > > > possible.
> > > > > 
> > > > > Presence of that ST microelectronics accelerometer is verified
> > > > > by existence of SMO88xx ACPI device which represent that
> > > > > accelerometer. Unfortunately without i2c address.
> > > > 
> > > > This part of the commit message sounded a bit confusing to me at
> > > > first because there is already an ACPI driver which handles
> > > > SMO88xx
> > > > 
> > > > devices (dell-smo8800).  My understanding is that:
> > > >   * the purpose of this patch is to expose a richer interface (as
> > > >   
> > > >     provided by lis3lv02d) to these devices on some machines,
> > > >   
> > > >   * on whitelisted machines, dell-smo8800 and lis3lv02d can work
> > > >   
> > > >     simultaneously (even though dell-smo8800 effectively
> > > >     duplicates the work that lis3lv02d does).
> > > 
> > > No. dell-smo8800 reads from ACPI irq number and exports
> > > /dev/freefall device which notify userspace about falls. lis3lv02d
> > > is i2c driver which exports axes of accelerometer. Additionaly
> > > lis3lv02d can export also /dev/freefall if registerer of i2c
> > > device provides irq number -- which is not case of this patch.
> > > 
> > > So both drivers are doing different things and both are useful.
> > > 
> > > IIRC both dell-smo8800 and lis3lv02d represent one HW device (that
> > > ST microelectronics accelerometer) but due to complicated HW
> > > abstraction and layers on Dell laptops it is handled by two
> > > drivers, one ACPI and one i2c.
> > > 
> > > Yes, in ideal world irq number should be passed to lis3lv02d driver
> > > and that would export whole device (with /dev/freefall too), but
> > > due to HW abstraction it is too much complicated...
> > 
> > Why?  AFAICT, all that is required to pass that IRQ number all the
> > way down to lis3lv02d is to set the irq field of the struct
> > i2c_board_info you are passing to i2c_new_device().  And you can
> > extract that IRQ number e.g. in check_acpi_smo88xx_device(). 
> > However, you would then need to make sure dell-smo8800 does not
> > attempt to request the same IRQ on whitelisted machines.  This got
> > me thinking about a way to somehow incorporate your changes into
> > dell-smo8800 using Wolfram's bus_notifier suggestion, but I do not
> > have a working solution for now.  What is tempting about this
> > approach is that you would not have to scan the ACPI namespace in
> > search of SMO88xx devices, because smo8800_add() is automatically
> > called for them.  However, I fear that the resulting solution may be
> > more complicated than the one you submitted.
> 
> Then we need to deal with lot of problems. Order of loading .ko modules 
> is undefined. Binding devices to drivers registered by .ko module is 
> also in "random" order. At any time any of those .ko module can be 
> unloaded or at least device unbind (via sysfs) from driver... And there 
> can be some pathological situation (thanks to adding ACPI layer as Andy 
> pointed) that there will be more SMO88xx devices in ACPI. Plus you can 
> compile kernel with and without those modules and also you can blacklist 
> loading them (so compile time check is not enough). And still some 
> correct message notifier must be used.
> 
> I think such solution is much much more complicated, there are lot of 
> combinations of kernel configuration and available dell devices...

I tried a few more things, but ultimately failed to find a nice way to
implement this.

Another issue popped up, though.  Linus' master branch contains a recent
commit by Benjamin Tissoires (CC'ed), 4d5538f5882a ("i2c: use an IRQ to
report Host Notify events, not alert") which breaks your patch.  The
reason for that is that lis3lv02d relies on the i2c client's IRQ being 0
to detect that it should not create /dev/freefall.  Benjamin's patch
causes the Host Notify IRQ to be assigned to the i2c client your patch
creates, thus causing lis3lv02d to create /dev/freefall, which in turn
conflicts with dell-smo8800 which is trying to create /dev/freefall
itself.
        
Also, just to make sure we do not overthink this, I understand that not
every unit of the models from the whitelist has an accelerometer,
correct?  In other words, could we perhaps skip the part where we are
making sure the SMO88xx ACPI device is there?

> 
> > > > If I got something wrong, please correct me.  If I got it right,
> > > > it might make sense to rephrase the commit message a bit so that
> > > > the first bullet point above is immediately clear to the reader.
> > > > 
> > > > > This patch registers lis3lv02d device at i2c address 0x29 if is
> > > > > detected.
> > > > > 
> > > > > Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO
> > > > > OpRegion to conflict with PCI BAR") allowed to use i2c-i801
> > > > > driver on Dell machines so lis3lv02d correctly initialize
> > > > > accelerometer.
> > > > > 
> > > > > Tested on Dell Latitude E6440.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/i2c/busses/i2c-i801.c |   98
> > > > >  +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 98
> > > > >  insertions(+)
> > > > > 
> > > > > diff --git a/drivers/i2c/busses/i2c-i801.c
> > > > > b/drivers/i2c/busses/i2c-i801.c index eb3627f..188cfd4 100644
> > > > > --- a/drivers/i2c/busses/i2c-i801.c
> > > > > +++ b/drivers/i2c/busses/i2c-i801.c
> > > > > @@ -1118,6 +1118,101 @@ static void
> > > > > dmi_check_onboard_devices(const struct dmi_header *dm, void
> > > > > *adap)
> > > > > 
> > > > >  	}
> > > > >  
> > > > >  }
> > > > > 
> > > > > +static acpi_status check_acpi_smo88xx_device(acpi_handle
> > > > > obj_handle, +					     u32 nesting_level,
> > > > > +					     void *context,
> > > > > +					     void **return_value)
> > > > > +{
> > > > > +	struct acpi_device_info *info;
> > > > > +	acpi_status status;
> > > > > +	char *hid;
> > > > > +
> > > > > +	status = acpi_get_object_info(obj_handle, &info);
> > > > 
> > > > acpi_get_object_info() allocates the returned buffer, which the
> > > > caller has to free.
> > > 
> > > Ok, I will fix it in next patch iteration.
> > > 
> > > > > +	if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
> > > > > +		return AE_OK;
> > > > > +
> > > > > +	hid = info->hardware_id.string;
> > > > > +	if (!hid)
> > > > > +		return AE_OK;
> > > > > +
> > > > > +	if (strlen(hid) < 7)
> > > > > +		return AE_OK;
> > > > > +
> > > > > +	if (memcmp(hid, "SMO88", 5) != 0)
> > > > > +		return AE_OK;
> > > > > +
> > > > > +	*((bool *)return_value) = true;
> > > > > +	return AE_CTRL_TERMINATE;
> > > > > +}
> > > > > +
> > > > > +static bool is_dell_system_with_lis3lv02d(void)
> > > > > +{
> > > > > +	bool found;
> > > > > +	acpi_status status;
> > > > > +	const char *vendor;
> > > > > +
> > > > > +	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
> > > > > +	if (strcmp(vendor, "Dell Inc.") != 0)
> > > > > +		return false;
> > > > > +
> > > > > +	/*
> > > > > +	 * Check if ACPI device SMO88xx exists and if is enabled.
> > > > > That ACPI +	 * device represent our ST microelectronics
> > > > > lis3lv02d accelerometer but +	 * unfortunately without any
> > > > > other additional information. +	 */
> > > > > +	found = false;
> > > > > +	status = acpi_get_devices(NULL, check_acpi_smo88xx_device,
> > > > > NULL, +				  (void **)&found);
> > > > > +	if (!ACPI_SUCCESS(status) || !found)
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Dell platform team told us that these Latitude devices have
> > > > > + * ST microelectronics accelerometer at i2c address 0x29.
> > > > > + * That i2c address is not specified in DMI or ACPI, so
> > > > > runtime + * detection without whitelist which is below is not
> > > > > possible. + */
> > > > > +static const char * const dmi_dell_product_names[] = {
> > > > > +	"Latitude E5250",
> > > > > +	"Latitude E5450",
> > > > > +	"Latitude E5550",
> > > > > +	"Latitude E6440",
> > > > > +	"Latitude E6440 ATG",
> > > > > +	"Latitude E6540",
> > > > > +};
> > > > > +
> > > > > +static void register_dell_lis3lv02d_i2c_device(struct
> > > > > i801_priv *priv) +{
> > > > > +	struct i2c_board_info info;
> > > > > +	const char *product_name;
> > > > > +	bool known_i2c_address;
> > > > > +	int i;
> > > > > +
> > > > > +	known_i2c_address = false;
> > > > > +	product_name = dmi_get_system_info(DMI_PRODUCT_NAME);
> > > > > +	for (i = 0; i < ARRAY_SIZE(dmi_dell_product_names); ++i) {
> > > > > +		if (strcmp(product_name, dmi_dell_product_names[i]) == 0)
> > > > > {
> > > > > +			known_i2c_address = true;
> > > > > +			break;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (!known_i2c_address) {
> > > > > +		dev_warn(&priv->pci_dev->dev,
> > > > > +			 "Accelerometer lis3lv02d i2c device is present "
> > > > > +			 "but its i2c address is unknown, skipping ...\n");
> > > > 
> > > > You are probably well aware of this, but checkpatch prefers
> > > > keeping long log messages in one line.  I am pointing it out
> > > > just in case.
> > > 
> > > Yes, but I do not know how to fix it. Splitting message into two
> > > lines generates warning. Having long line generates warning too.
> > 
> > Weird, checkpatch does not protest on my machine when the log message
> > is written on a single line...
> 
> I hope that i2c maintainers decide how to format that line.
> 
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	memset(&info, 0, sizeof(struct i2c_board_info));
> > > > 
> > > > How about just doing "struct i2c_board_info info = { 0 };"
> > > > instead?
> > > 
> > > Ok.
> > > 
> > > > > +	info.addr = 0x29;
> > > > > +	strlcpy(info.type, "lis3lv02d", I2C_NAME_SIZE);
> > > > > +	i2c_new_device(&priv->adapter, &info);
> > > > > +}
> > > > > +
> > > > > 
> > > > >  /* Register optional slaves */
> > > > >  static void i801_probe_optional_slaves(struct i801_priv *priv)
> > > > >  {
> > > > > 
> > > > > @@ -1136,6 +1231,9 @@ static void
> > > > > i801_probe_optional_slaves(struct i801_priv *priv)
> > > > > 
> > > > >  	if (dmi_name_in_vendors("FUJITSU"))
> > > > >  	
> > > > >  		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
> > > > > 
> > > > > +
> > > > > +	if (is_dell_system_with_lis3lv02d())
> > > > > +		register_dell_lis3lv02d_i2c_device(priv);
> > > > > 
> > > > >  }
> > > > >  #else
> > > > >  static void __init input_apanel_init(void) {}
> > > > 
> > > > I tested this patch on a Vostro V131, which is not on the
> > > > whitelist, so all I got was the warning message, but to this
> > > > extent, it works for me.
> > > 
> > > Hm... That means your notebook has ST microelectronics
> > > accelerometer too. You could try to find it on i2c-i801 bus with
> > > userspace i2cdetect program (part of i2c-tools) and get i2c
> > > address.
> > 
> > Bingo, it is at 0x1d.  I modified your patch to set the i2c address
> > to 0x1d and at least free fall detection seems to be working
> > correctly.
> 
> lis3lv02d exports input device, you should find its number lsinput. You 
> can then test accelerometer with e.g. program input-events.
> 
> If it is working fine, I can add your machine to whitelist with i2c 
> address 0x1d.

I did some tests with evtest and it seems that axis values are
consistent with laptop's movements, so I think it is safe to whitelist
Vostro V131 with i2c address 0x1d.

-- 
Best regards,
Michał Kępień
