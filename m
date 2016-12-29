From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Thu, 29 Dec 2016 09:29:36 +0100
Message-ID: <20161229082936.GA4114@ozzy.nask.waw.pl>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at i2c address 0x29. That
> i2c address is not specified in DMI or ACPI, so runtime detection without
> whitelist which is below is not possible.
> 
> Presence of that ST microelectronics accelerometer is verified by existence
> of SMO88xx ACPI device which represent that accelerometer. Unfortunately
> without i2c address.

This part of the commit message sounded a bit confusing to me at first
because there is already an ACPI driver which handles SMO88xx devices
(dell-smo8800).  My understanding is that:

  * the purpose of this patch is to expose a richer interface (as
    provided by lis3lv02d) to these devices on some machines,

  * on whitelisted machines, dell-smo8800 and lis3lv02d can work
    simultaneously (even though dell-smo8800 effectively duplicates the
    work that lis3lv02d does).

If I got something wrong, please correct me.  If I got it right, it
might make sense to rephrase the commit message a bit so that the first
bullet point above is immediately clear to the reader.

> 
> This patch registers lis3lv02d device at i2c address 0x29 if is detected.
> 
> Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
> conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
> lis3lv02d correctly initialize accelerometer.
> 
> Tested on Dell Latitude E6440.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> ---
>  drivers/i2c/busses/i2c-i801.c |   98 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index eb3627f..188cfd4 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1118,6 +1118,101 @@ static void dmi_check_onboard_devices(const struct dmi_header *dm, void *adap)
>  	}
>  }
>  
> +static acpi_status check_acpi_smo88xx_device(acpi_handle obj_handle,
> +					     u32 nesting_level,
> +					     void *context,
> +					     void **return_value)
> +{
> +	struct acpi_device_info *info;
> +	acpi_status status;
> +	char *hid;
> +
> +	status = acpi_get_object_info(obj_handle, &info);

acpi_get_object_info() allocates the returned buffer, which the caller
has to free.

> +	if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
> +		return AE_OK;
> +
> +	hid = info->hardware_id.string;
> +	if (!hid)
> +		return AE_OK;
> +
> +	if (strlen(hid) < 7)
> +		return AE_OK;
> +
> +	if (memcmp(hid, "SMO88", 5) != 0)
> +		return AE_OK;
> +
> +	*((bool *)return_value) = true;
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static bool is_dell_system_with_lis3lv02d(void)
> +{
> +	bool found;
> +	acpi_status status;
> +	const char *vendor;
> +
> +	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
> +	if (strcmp(vendor, "Dell Inc.") != 0)
> +		return false;
> +
> +	/*
> +	 * Check if ACPI device SMO88xx exists and if is enabled. That ACPI
> +	 * device represent our ST microelectronics lis3lv02d accelerometer but
> +	 * unfortunately without any other additional information.
> +	 */
> +	found = false;
> +	status = acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
> +				  (void **)&found);
> +	if (!ACPI_SUCCESS(status) || !found)
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * Dell platform team told us that these Latitude devices have
> + * ST microelectronics accelerometer at i2c address 0x29.
> + * That i2c address is not specified in DMI or ACPI, so runtime
> + * detection without whitelist which is below is not possible.
> + */
> +static const char * const dmi_dell_product_names[] = {
> +	"Latitude E5250",
> +	"Latitude E5450",
> +	"Latitude E5550",
> +	"Latitude E6440",
> +	"Latitude E6440 ATG",
> +	"Latitude E6540",
> +};
> +
> +static void register_dell_lis3lv02d_i2c_device(struct i801_priv *priv)
> +{
> +	struct i2c_board_info info;
> +	const char *product_name;
> +	bool known_i2c_address;
> +	int i;
> +
> +	known_i2c_address = false;
> +	product_name = dmi_get_system_info(DMI_PRODUCT_NAME);
> +	for (i = 0; i < ARRAY_SIZE(dmi_dell_product_names); ++i) {
> +		if (strcmp(product_name, dmi_dell_product_names[i]) == 0) {
> +			known_i2c_address = true;
> +			break;
> +		}
> +	}
> +
> +	if (!known_i2c_address) {
> +		dev_warn(&priv->pci_dev->dev,
> +			 "Accelerometer lis3lv02d i2c device is present "
> +			 "but its i2c address is unknown, skipping ...\n");

You are probably well aware of this, but checkpatch prefers keeping long
log messages in one line.  I am pointing it out just in case.

> +		return;
> +	}
> +
> +	memset(&info, 0, sizeof(struct i2c_board_info));

How about just doing "struct i2c_board_info info = { 0 };" instead?

> +	info.addr = 0x29;
> +	strlcpy(info.type, "lis3lv02d", I2C_NAME_SIZE);
> +	i2c_new_device(&priv->adapter, &info);
> +}
> +
>  /* Register optional slaves */
>  static void i801_probe_optional_slaves(struct i801_priv *priv)
>  {
> @@ -1136,6 +1231,9 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
>  
>  	if (dmi_name_in_vendors("FUJITSU"))
>  		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
> +
> +	if (is_dell_system_with_lis3lv02d())
> +		register_dell_lis3lv02d_i2c_device(priv);
>  }
>  #else
>  static void __init input_apanel_init(void) {}
> -- 
> 1.7.9.5
> 

I tested this patch on a Vostro V131, which is not on the whitelist, so
all I got was the warning message, but to this extent, it works for me.

-- 
Best regards,
Michał Kępień
