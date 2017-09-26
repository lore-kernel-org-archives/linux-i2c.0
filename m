From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 26 Sep 2017 14:33:37 +0900
Message-ID: <CAAFQd5AQX+OuxkkXsyBXO3v-Fyv49kOK9Gdpcp1+XgZLm0KMHQ@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
 <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
 <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
 <20170920093222.yzfw2ctrupep5iqx@valkosipuli.retiisi.org.uk> <7B8CE47BD58441468D2BB13285B50E6031DF0734@BGSMSX107.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7B8CE47BD58441468D2BB13285B50E6031DF0734-yHIBzpp8AekLtBVenmexd7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

[+Rafael, Ulf]

On Tue, Sep 26, 2017 at 2:29 PM, Mohandass, Divagar
<divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Sakari & Tomas,
>
> Are you ok with the current revision, let me know if any changes are need=
ed.

Nope, my concerns have not been addressed, but we need someone from
the PM world to clarify how we should do this to work on all
platforms.

Best regards,
Tomasz

P.S. Please avoid top-posting on mailing lists, it is considered bad manner=
.

>
> ---
> ^Divagar
>
>>-----Original Message-----
>>From: sakari.ailus-X3B1VOXEql0@public.gmane.org [mailto:sakari.ailus-X3B1VOXEql0@public.gmane.org]
>>Sent: Wednesday, September 20, 2017 3:02 PM
>>To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>Cc: Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Mohandass, Divagar
>><divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
>>mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>>Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
>>
>>Hi Tomasz,
>>
>>On Wed, Sep 20, 2017 at 05:59:18PM +0900, Tomasz Figa wrote:
>>> On Wed, Sep 20, 2017 at 5:45 PM, sakari.ailus-X3B1VOXEql0@public.gmane.org
>>> <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
>>> > Hi Tomasz,
>>> >
>>> > On Wed, Sep 20, 2017 at 12:56:09PM +0900, Tomasz Figa wrote:
>>> >> Thanks Raj.
>>> >>
>>> >> Let me post my comments inline.
>>> >>
>>> >> On Wed, Sep 20, 2017 at 12:52 PM, Mani, Rajmohan
>>> >> <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>> >> > Adding Tomasz...
>>> >> >
>>> >> >> -----Original Message-----
>>> >> >> From: Mohandass, Divagar
>>> >> >> Sent: Monday, September 04, 2017 3:29 AM
>>> >> >> To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa@the-
>>dreams.de;
>>> >> >> sakari.ailus-X3B1VOXEql0@public.gmane.org
>>> >> >> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>> >> >> linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan
>>> >> >> <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Mohandass, Divagar
>>> >> >> <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> >> >> Subject: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
>>> >> >>
>>> >> >> Currently the device is kept in D0, there is an opportunity to
>>> >> >> save power by enabling runtime pm.
>>> >> >>
>>> >> >> Device can be daisy chained from PMIC and we can't rely on I2C
>>> >> >> core for auto resume/suspend. Driver will decide when to
>>resume/suspend.
>>> >> >>
>>> >> >> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> >> >> ---
>>> >> >>  drivers/misc/eeprom/at24.c | 38
>>> >> >> ++++++++++++++++++++++++++++++++++++++
>>> >> >>  1 file changed, 38 insertions(+)
>>> >> >>
>>> >> >> diff --git a/drivers/misc/eeprom/at24.c
>>> >> >> b/drivers/misc/eeprom/at24.c index 2199c42..d718a7a 100644
>>> >> >> --- a/drivers/misc/eeprom/at24.c
>>> >> >> +++ b/drivers/misc/eeprom/at24.c
>>> >> >> @@ -24,6 +24,7 @@
>>> >> >>  #include <linux/i2c.h>
>>> >> >>  #include <linux/nvmem-provider.h>  #include
>>> >> >> <linux/platform_data/at24.h>
>>> >> >> +#include <linux/pm_runtime.h>
>>> >> >>
>>> >> >>  /*
>>> >> >>   * I2C EEPROMs from most vendors are inexpensive and mostly
>>> >> >> interchangeable.
>>> >> >> @@ -501,11 +502,21 @@ static ssize_t
>>> >> >> at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
>>> >> >> static int at24_read(void *priv, unsigned int off, void *val, siz=
e_t
>>count)  {
>>> >> >>       struct at24_data *at24 =3D priv;
>>> >> >> +     struct i2c_client *client;
>>> >> >>       char *buf =3D val;
>>> >> >> +     int ret;
>>> >> >>
>>> >> >>       if (unlikely(!count))
>>> >> >>               return count;
>>> >> >>
>>> >> >> +     client =3D at24_translate_offset(at24, &off);
>>> >> >> +
>>> >> >> +     ret =3D pm_runtime_get_sync(&client->dev);
>>> >> >> +     if (ret < 0) {
>>> >> >> +             pm_runtime_put_noidle(&client->dev);
>>> >> >> +             return ret;
>>> >> >> +     }
>>> >> >> +
>>> >> >>       /*
>>> >> >>        * Read data from chip, protecting against concurrent updat=
es
>>> >> >>        * from this host, but not from other I2C masters.
>>> >> >> @@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned
>>> >> >> int off, void *val, size_t count)
>>> >> >>               status =3D at24->read_func(at24, buf, off, count);
>>> >> >>               if (status < 0) {
>>> >> >>                       mutex_unlock(&at24->lock);
>>> >> >> +                     pm_runtime_put(&client->dev);
>>> >> >>                       return status;
>>> >> >>               }
>>> >> >>               buf +=3D status;
>>> >> >> @@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned
>>> >> >> int off, void *val, size_t count)
>>> >> >>
>>> >> >>       mutex_unlock(&at24->lock);
>>> >> >>
>>> >> >> +     pm_runtime_put(&client->dev);
>>> >> >> +
>>> >> >>       return 0;
>>> >> >>  }
>>> >> >>
>>> >> >>  static int at24_write(void *priv, unsigned int off, void *val, s=
ize_t
>>count)  {
>>> >> >>       struct at24_data *at24 =3D priv;
>>> >> >> +     struct i2c_client *client;
>>> >> >>       char *buf =3D val;
>>> >> >> +     int ret;
>>> >> >>
>>> >> >>       if (unlikely(!count))
>>> >> >>               return -EINVAL;
>>> >> >>
>>> >> >> +     client =3D at24_translate_offset(at24, &off);
>>> >> >> +
>>> >> >> +     ret =3D pm_runtime_get_sync(&client->dev);
>>> >> >> +     if (ret < 0) {
>>> >> >> +             pm_runtime_put_noidle(&client->dev);
>>> >> >> +             return ret;
>>> >> >> +     }
>>> >> >> +
>>> >> >>       /*
>>> >> >>        * Write data to chip, protecting against concurrent update=
s
>>> >> >>        * from this host, but not from other I2C masters.
>>> >> >> @@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned
>>> >> >> int off, void *val, size_t count)
>>> >> >>               status =3D at24->write_func(at24, buf, off, count);
>>> >> >>               if (status < 0) {
>>> >> >>                       mutex_unlock(&at24->lock);
>>> >> >> +                     pm_runtime_put(&client->dev);
>>> >> >>                       return status;
>>> >> >>               }
>>> >> >>               buf +=3D status;
>>> >> >> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned
>>> >> >> int off, void *val, size_t count)
>>> >> >>
>>> >> >>       mutex_unlock(&at24->lock);
>>> >> >>
>>> >> >> +     pm_runtime_put(&client->dev);
>>> >> >> +
>>> >> >>       return 0;
>>> >> >>  }
>>> >> >>
>>> >> >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client
>>> >> >> *client, const struct i2c_device_id *id)
>>> >> >>
>>> >> >>       i2c_set_clientdata(client, at24);
>>> >> >>
>>> >> >> +     /* enable runtime pm */
>>> >> >> +     pm_runtime_get_noresume(&client->dev);
>>> >> >> +     pm_runtime_set_active(&client->dev);
>>> >> >> +     pm_runtime_enable(&client->dev);
>>> >>
>>> >> Do we need this get_noresume/set_active dance? I remember it was
>>> >> for some reason needed for PCI devices, but I don't see why for I2C
>>> >> anything else than just pm_runtime_enable() would be necessary.
>>> >
>>> > You specifically do not need (all) this for PCI devices, but AFAIU
>>> > for I=E6=B6=8E
>>> > devices you do. The runtime PM status of a device is disabled by
>>> > default and the use count is zero, but on ACPI based systems the
>>> > device is still powered on.
>>>
>>> Okay, so _get_noresume() and _set_active() would do the thing for ACPI
>>> indeed, but not sure about other platforms. Perhaps _enable(),
>>> _get_sync() would be more general?
>>
>>What I ended up doing in e.g. the smiapp driver was to explicitly power t=
he
>>device on first and then enable runtime PM. (See
>>drivers/media/i2c/smiapp/smiapp-core.c .) This approach works even if
>>CONFIG_PM is disabled, both on DT and ACPI.
>>
>>--
>>Regards,
>>
>>Sakari Ailus
>>e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
