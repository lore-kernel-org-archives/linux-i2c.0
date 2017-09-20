From: "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v6 2/3] eeprom: at24: add support to fetch eeprom device
 property "size"
Date: Wed, 20 Sep 2017 03:52:35 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FC126B@FMSMSX114.amr.corp.intel.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-3-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504520928-5191-3-git-send-email-divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adding Tomasz...

> -----Original Message-----
> From: Mohandass, Divagar
> Sent: Monday, September 04, 2017 3:29 AM
> To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
> sakari.ailus-X3B1VOXEql0@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
> Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: [PATCH v6 2/3] eeprom: at24: add support to fetch eeprom device
> property "size"
> 
> Obtain the size of the EEPROM chip from DT if the "size" property is specified
> for the device.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c index
> 764ff5df..2199c42 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -570,6 +570,10 @@ static void at24_get_pdata(struct device *dev, struct
> at24_platform_data *chip)
>  	if (device_property_present(dev, "read-only"))
>  		chip->flags |= AT24_FLAG_READONLY;
> 
> +	err = device_property_read_u32(dev, "size", &val);
> +	if (!err)
> +		chip->byte_len = val;
> +
>  	err = device_property_read_u32(dev, "pagesize", &val);
>  	if (!err) {
>  		chip->page_size = val;
> --
> 1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
