From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver i2c-core: i2c bus should support PM entries in
	struct dev_pm_ops.
Date: Tue, 15 Dec 2009 13:38:03 +0800
Message-ID: <4e5ebad50912142138he6eea0bqd790313c72b69f7@mail.gmail.com>
References: <1259744920.25505.2.camel@eight.analog.com>
	 <20091213221222.724bef54@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091213221222.724bef54-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

You changes to the patch work OK for me.


Sonic Zhang


On Mon, Dec 14, 2009 at 5:12 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Sonic,
>
> On Wed, 2 Dec 2009 17:08:40 +0800, sonic zhang wrote:
>> Struct dev_pm_ops is not configured in current i2c bus type. i2c dri=
vers
>> only depends on suspend/resume entries in struct dev_pm_ops are not
>> informed of PM suspend and resume events by i2c framework.
>
> Good point. I was wondering some times ago what was the status of
> pm_ops. I seem to understand this is the future of power management,
> and "direct" .suspend and .resume callbacks will stop being supported
> at some point in the future? If so, what is the migration plan? I don=
't
> really want to support both forever.
>
> Your patch introduces the following warnings:
>
> drivers/i2c/i2c-core.c: In function =91i2c_device_pm_suspend=92:
> drivers/i2c/i2c-core.c:167: warning: assignment discards qualifiers f=
rom pointer target type
> drivers/i2c/i2c-core.c: In function =91i2c_device_pm_resume=92:
> drivers/i2c/i2c-core.c:181: warning: assignment discards qualifiers f=
rom pointer target type
>
> You will obviously have to fix them before I can accept your patch.
> Missing const...
>
>>
>> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>> ---
>> =A0drivers/i2c/i2c-core.c | =A0 39 +++++++++++++++++++++++++++++++++=
++++++
>> =A01 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 2965043..9713c0d 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -155,6 +155,39 @@ static void i2c_device_shutdown(struct device *=
dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver->shutdown(client);
>> =A0}
>>
>> +#ifdef CONFIG_SUSPEND
>> +static int i2c_device_pm_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_driver *driver;
>> + =A0 =A0 struct dev_pm_ops *pm;
>> +
>> + =A0 =A0 if (!dev->driver)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 driver =3D to_i2c_driver(dev->driver);
>> + =A0 =A0 pm =3D driver->driver.pm;
>
> This makes little sense, sorry. Why go from device_driver to i2c_driv=
er
> and then again to device_driver? The following is equivalent and more
> efficient:
>
> =A0 =A0 =A0 =A0pm =3D dev->driver->pm;
>
>> + =A0 =A0 if (!pm || !pm->suspend)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 return pm->suspend(dev);
>> +}
>> +
>> +static int i2c_device_pm_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_driver *driver;
>> + =A0 =A0 struct dev_pm_ops *pm;
>> +
>> + =A0 =A0 if (!dev->driver)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 driver =3D to_i2c_driver(dev->driver);
>> + =A0 =A0 pm =3D driver->driver.pm;
>
> Same here.
>
>> + =A0 =A0 if (!pm || !pm->resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 return pm->resume(dev);
>> +}
>> +#else
>> +# define i2c_device_pm_suspend =A0 =A0 =A0 NULL
>> +# define i2c_device_pm_resume =A0 =A0 =A0 =A0NULL
>
> No space between "#" and "define", please.
>
>> +#endif
>> +
>> =A0static int i2c_device_suspend(struct device *dev, pm_message_t me=
sg)
>> =A0{
>> =A0 =A0 =A0 struct i2c_client *client =3D i2c_verify_client(dev);
>> @@ -219,6 +252,11 @@ static const struct attribute_group *i2c_dev_at=
tr_groups[] =3D {
>> =A0 =A0 =A0 NULL
>> =A0};
>>
>> +static struct dev_pm_ops i2c_device_pm_ops =3D {
>
> Could be const.
>
>> + =A0 =A0 .suspend =3D i2c_device_pm_suspend,
>> + =A0 =A0 .resume =3D i2c_device_pm_resume,
>> +};
>> +
>> =A0struct bus_type i2c_bus_type =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c",
>> =A0 =A0 =A0 .match =A0 =A0 =A0 =A0 =A0=3D i2c_device_match,
>> @@ -227,6 +265,7 @@ struct bus_type i2c_bus_type =3D {
>> =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D i2c_device_shutdown,
>> =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D i2c_device_suspend,
>> =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D i2c_device_resume,
>> + =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &i2c_device_pm_ops,
>> =A0};
>> =A0EXPORT_SYMBOL_GPL(i2c_bus_type);
>>
>
> I've made all the changes above myself, it build OK but I can't test.
> Modified patch is here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelv=
are-i2c/i2c-core-i2c-bus-should-support-pm-entries-in-struct-dev_pm_ops=
=2Epatch
>
> Please test and report if anything's wrong.
>
> Thanks,
> --
> Jean Delvare
>
