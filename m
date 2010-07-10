From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] hwmon: Fix autoloading of fschmd on recent Fujitsu machines
Date: Sat, 10 Jul 2010 22:47:37 +0200
Message-ID: <4C38DC69.7060402@redhat.com>
References: <20100708180743.4661c26d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100708180743.4661c26d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergey Spiridonov <sena-1VtuP/tG+VlxJOgadfisgdi2O/JbrIOy@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Thanks for the patch it looks good, and this makes sense as FUJITSU SIEMENS
no longer is a co-operation between FUJITSU and SIEMENS, so now it is
just called FUJITSU,

Acked-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Regards,

Hans


On 07/08/2010 06:07 PM, Jean Delvare wrote:
> Fujitsu slightly changed the DMI strings in their recent machines,
> (for example the D2778) and this breaks the automatic loading of the
> needed fschmd driver. Being more tolerant on string comparison fixes
> the issue.
>
> This closes bug #15634:
> https://bugzilla.kernel.org/show_bug.cgi?id=15634
>
> Signed-off-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Tested-by: Sergey Spiridonov<sena-1VtuP/tG+VlxJOgadfisgdi2O/JbrIOy@public.gmane.org>
> Cc: Hans de Goede<hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-i801.c |    8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> --- linux-2.6.35-rc4.orig/drivers/i2c/busses/i2c-i801.c	2010-07-07 15:00:17.000000000 +0200
> +++ linux-2.6.35-rc4/drivers/i2c/busses/i2c-i801.c	2010-07-08 18:00:51.000000000 +0200
> @@ -655,7 +655,7 @@ static void __devinit dmi_check_onboard_
>   		/*&  ~0x80, ignore enabled/disabled bit */
>   		if ((type&  ~0x80) != dmi_devices[i].type)
>   			continue;
> -		if (strcmp(name, dmi_devices[i].name))
> +		if (strcasecmp(name, dmi_devices[i].name))
>   			continue;
>
>   		memset(&info, 0, sizeof(struct i2c_board_info));
> @@ -704,9 +704,6 @@ static int __devinit i801_probe(struct p
>   {
>   	unsigned char temp;
>   	int err, i;
> -#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
> -	const char *vendor;
> -#endif
>
>   	I801_dev = dev;
>   	i801_features = 0;
> @@ -808,8 +805,7 @@ static int __devinit i801_probe(struct p
>   	}
>   #endif
>   #if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
> -	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> -	if (vendor&&  !strcmp(vendor, "FUJITSU SIEMENS"))
> +	if (dmi_name_in_vendors("FUJITSU"))
>   		dmi_walk(dmi_check_onboard_devices,&i801_adapter);
>   #endif
>
>
>
