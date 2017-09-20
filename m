From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 20 Sep 2017 17:59:18 +0900
Message-ID: <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com> <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:56450 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdITI7m (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Sep 2017 04:59:42 -0400
Received: by mail-yw0-f176.google.com with SMTP id w22so1422583ywa.13
        for <linux-i2c@vger.kernel.org>; Wed, 20 Sep 2017 01:59:42 -0700 (PDT)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com. [209.85.161.169])
        by smtp.gmail.com with ESMTPSA id n129sm543727ywe.109.2017.09.20.01.59.39
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 01:59:39 -0700 (PDT)
Received: by mail-yw0-f169.google.com with SMTP id i6so1431056ywc.9
        for <linux-i2c@vger.kernel.org>; Wed, 20 Sep 2017 01:59:39 -0700 (PDT)
In-Reply-To: <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Mohandass, Divagar" <divagar.mohandass@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mika.westerberg@linux.intel.com

On Wed, Sep 20, 2017 at 5:45 PM, sakari.ailus@iki.fi
<sakari.ailus@iki.fi> wrote:
> Hi Tomasz,
>
> On Wed, Sep 20, 2017 at 12:56:09PM +0900, Tomasz Figa wrote:
>> Thanks Raj.
>>
>> Let me post my comments inline.
>>
>> On Wed, Sep 20, 2017 at 12:52 PM, Mani, Rajmohan
>> <rajmohan.mani@intel.com> wrote:
>> > Adding Tomasz...
>> >
>> >> -----Original Message-----
>> >> From: Mohandass, Divagar
>> >> Sent: Monday, September 04, 2017 3:29 AM
>> >> To: robh+dt@kernel.org; mark.rutland@arm.com; wsa@the-dreams.de;
>> >> sakari.ailus@iki.fi
>> >> Cc: devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
>> >> kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>;
>> >> Mohandass, Divagar <divagar.mohandass@intel.com>
>> >> Subject: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
>> >>
>> >> Currently the device is kept in D0, there is an opportunity to save p=
ower by
>> >> enabling runtime pm.
>> >>
>> >> Device can be daisy chained from PMIC and we can't rely on I2C core f=
or auto
>> >> resume/suspend. Driver will decide when to resume/suspend.
>> >>
>> >> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
>> >> ---
>> >>  drivers/misc/eeprom/at24.c | 38
>> >> ++++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 38 insertions(+)
>> >>
>> >> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c =
index
>> >> 2199c42..d718a7a 100644
>> >> --- a/drivers/misc/eeprom/at24.c
>> >> +++ b/drivers/misc/eeprom/at24.c
>> >> @@ -24,6 +24,7 @@
>> >>  #include <linux/i2c.h>
>> >>  #include <linux/nvmem-provider.h>
>> >>  #include <linux/platform_data/at24.h>
>> >> +#include <linux/pm_runtime.h>
>> >>
>> >>  /*
>> >>   * I2C EEPROMs from most vendors are inexpensive and mostly
>> >> interchangeable.
>> >> @@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct
>> >> at24_data *at24, const char *buf,  static int at24_read(void *priv, u=
nsigned int
>> >> off, void *val, size_t count)  {
>> >>       struct at24_data *at24 =3D priv;
>> >> +     struct i2c_client *client;
>> >>       char *buf =3D val;
>> >> +     int ret;
>> >>
>> >>       if (unlikely(!count))
>> >>               return count;
>> >>
>> >> +     client =3D at24_translate_offset(at24, &off);
>> >> +
>> >> +     ret =3D pm_runtime_get_sync(&client->dev);
>> >> +     if (ret < 0) {
>> >> +             pm_runtime_put_noidle(&client->dev);
>> >> +             return ret;
>> >> +     }
>> >> +
>> >>       /*
>> >>        * Read data from chip, protecting against concurrent updates
>> >>        * from this host, but not from other I2C masters.
>> >> @@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned int off=
, void
>> >> *val, size_t count)
>> >>               status =3D at24->read_func(at24, buf, off, count);
>> >>               if (status < 0) {
>> >>                       mutex_unlock(&at24->lock);
>> >> +                     pm_runtime_put(&client->dev);
>> >>                       return status;
>> >>               }
>> >>               buf +=3D status;
>> >> @@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned int o=
ff, void
>> >> *val, size_t count)
>> >>
>> >>       mutex_unlock(&at24->lock);
>> >>
>> >> +     pm_runtime_put(&client->dev);
>> >> +
>> >>       return 0;
>> >>  }
>> >>
>> >>  static int at24_write(void *priv, unsigned int off, void *val, size_=
t count)  {
>> >>       struct at24_data *at24 =3D priv;
>> >> +     struct i2c_client *client;
>> >>       char *buf =3D val;
>> >> +     int ret;
>> >>
>> >>       if (unlikely(!count))
>> >>               return -EINVAL;
>> >>
>> >> +     client =3D at24_translate_offset(at24, &off);
>> >> +
>> >> +     ret =3D pm_runtime_get_sync(&client->dev);
>> >> +     if (ret < 0) {
>> >> +             pm_runtime_put_noidle(&client->dev);
>> >> +             return ret;
>> >> +     }
>> >> +
>> >>       /*
>> >>        * Write data to chip, protecting against concurrent updates
>> >>        * from this host, but not from other I2C masters.
>> >> @@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned int of=
f, void
>> >> *val, size_t count)
>> >>               status =3D at24->write_func(at24, buf, off, count);
>> >>               if (status < 0) {
>> >>                       mutex_unlock(&at24->lock);
>> >> +                     pm_runtime_put(&client->dev);
>> >>                       return status;
>> >>               }
>> >>               buf +=3D status;
>> >> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int of=
f, void
>> >> *val, size_t count)
>> >>
>> >>       mutex_unlock(&at24->lock);
>> >>
>> >> +     pm_runtime_put(&client->dev);
>> >> +
>> >>       return 0;
>> >>  }
>> >>
>> >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client *client=
, const
>> >> struct i2c_device_id *id)
>> >>
>> >>       i2c_set_clientdata(client, at24);
>> >>
>> >> +     /* enable runtime pm */
>> >> +     pm_runtime_get_noresume(&client->dev);
>> >> +     pm_runtime_set_active(&client->dev);
>> >> +     pm_runtime_enable(&client->dev);
>>
>> Do we need this get_noresume/set_active dance? I remember it was for
>> some reason needed for PCI devices, but I don't see why for I2C
>> anything else than just pm_runtime_enable() would be necessary.
>
> You specifically do not need (all) this for PCI devices, but AFAIU for I=
=E6=B6=8E
> devices you do. The runtime PM status of a device is disabled by default
> and the use count is zero, but on ACPI based systems the device is still
> powered on.

Okay, so _get_noresume() and _set_active() would do the thing for ACPI
indeed, but not sure about other platforms. Perhaps _enable(),
_get_sync() would be more general?

Bets regards,
Tomasz
