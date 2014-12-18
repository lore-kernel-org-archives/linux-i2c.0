From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] iio: ak8975: Added autodetect feature for ACPI
Date: Thu, 18 Dec 2014 08:52:01 -0800
Message-ID: <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1418678363-22437-4-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <549300A5.5080904@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <549300A5.5080904-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-12-18 at 17:28 +0100, Lars-Peter Clausen wrote: 
> Added I2C to Cc.
> 
> On 12/15/2014 10:19 PM, Srinivas Pandruvada wrote:
> > Using i2c auto detect feature and auto device creation feature,
> > enumerate ak8975 device, by checking their presence.
> > This is needed because when this device sits behind an i2c mux, there
> > is no way to define i2c mux in ACPI. This will enable ak8975 on
> > windows based tablets/laptops running Linux when connected via a mux.
> > Since DT model already can define an i2c mux and devices connected to
> > it, this feature is only enabled for ACPI.
> >
> 
> This is quite a bit of a hack.
Why?
Auto detect is standard feature of i2c devices. This is using standard
auto detect feature provided by the framework. 
>  Did they decide to not include the device in 
> the ACPI description at all or is there a special id for INV6050+AK8975?
This device needs has one combined id. Windows has a singe driver
processing both as a combo device. 
> 
> How does Windows decide whether there is a device or not?
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >   drivers/iio/magnetometer/ak8975.c | 35 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index 0d10a4b..c3455bd 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -820,6 +820,36 @@ static const struct i2c_device_id ak8975_id[] = {
> >
> >   MODULE_DEVICE_TABLE(i2c, ak8975_id);
> >
> > +#if defined(CONFIG_ACPI)
> > +static int ak8975_detect(struct i2c_client *temp_client,
> > +			 struct i2c_board_info *info)
> > +{
> > +	struct i2c_adapter *adapter;
> > +	int i, j;
> > +	int ret;
> > +
> > +	/* autodetect only when we are behind a mux */
> > +	adapter = i2c_parent_is_i2c_adapter(temp_client->adapter);
> > +	if (!adapter)
> > +		return -ENODEV;
> > +
> > +	for (i = 0; i < AK_MAX_TYPE; ++i) {
> > +		ret = ak8975_who_i_am(temp_client, i);
> > +		if (ret >= 0) {
> > +			for (j = 0; j < ARRAY_SIZE(ak8975_id) - 1; ++j) {
> > +				if (i == (int)ak8975_id[j].driver_data) {
> > +					strlcpy(info->type, ak8975_id[j].name,
> > +						I2C_NAME_SIZE);
> > +					return 0;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +#endif
> > +
> >   static const struct of_device_id ak8975_of_match[] = {
> >   	{ .compatible = "asahi-kasei,ak8975", },
> >   	{ .compatible = "ak8975", },
> > @@ -841,6 +871,11 @@ static struct i2c_driver ak8975_driver = {
> >   	},
> >   	.probe		= ak8975_probe,
> >   	.id_table	= ak8975_id,
> > +#if defined(CONFIG_ACPI)
> > +	.class		= I2C_CLASS_HWMON,
> > +	.address_list	= I2C_ADDRS(0x0C, 0x0D, 0x0E, 0x0F),
> > +	.detect		= ak8975_detect,
> 
> In contrast to the commit message this is always enabled if the kernel 
> contains ACPI support, not if the device is a ACPI device.
Yes. You don't enable ACPI if you don't need it. It will bring in lots
of builtin code if someone did that. 
> 
> > +#endif
> >   };
> >   module_i2c_driver(ak8975_driver);
> >
> >
> 
