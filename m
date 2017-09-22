From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] eeprom: at24: add support to fetch eeprom device
 property "size"
Date: Fri, 22 Sep 2017 19:11:40 +0300
Message-ID: <CAHp75Ve_1oRe6w_yyQW_76NHf-boF+VqYNenTKit0PJPFj+N7A@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-3-git-send-email-divagar.mohandass@intel.com> <6F87890CF0F5204F892DEA1EF0D77A5972FC126B@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A5972FC126B-XfjTATA9Em864kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 20, 2017 at 6:52 AM, Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Adding Tomasz...

Please, don't top post.
Better to resend entire series with all stakeholders included.

>> Obtain the size of the EEPROM chip from DT if the "size" property is specified
>> for the device.
>>

I guess it lacks
Suggested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Other than that, looks good to me!

Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Wolfram, the binding is ACKed by Rob and this one is in a good shape.
Moreover, it seems like a demand for the property since some IoT stuff
would like to use the driver on ACPI enabled platforms with different
sizes.

Can you go ahead and apply first two patches? It would be really appreciated.

>> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/misc/eeprom/at24.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c index
>> 764ff5df..2199c42 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -570,6 +570,10 @@ static void at24_get_pdata(struct device *dev, struct
>> at24_platform_data *chip)
>>       if (device_property_present(dev, "read-only"))
>>               chip->flags |= AT24_FLAG_READONLY;
>>
>> +     err = device_property_read_u32(dev, "size", &val);
>> +     if (!err)
>> +             chip->byte_len = val;
>> +
>>       err = device_property_read_u32(dev, "pagesize", &val);
>>       if (!err) {
>>               chip->page_size = val;
>> --
>> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
