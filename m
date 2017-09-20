From: "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 20 Sep 2017 12:32:22 +0300
Message-ID: <20170920093222.yzfw2ctrupep5iqx@valkosipuli.retiisi.org.uk>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
 <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
 <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:44872 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751189AbdITJcZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Sep 2017 05:32:25 -0400
Content-Disposition: inline
In-Reply-To: <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Mohandass, Divagar" <divagar.mohandass@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mika.westerberg@linux.intel.com

Hi Tomasz,

On Wed, Sep 20, 2017 at 05:59:18PM +0900, Tomasz Figa wrote:
> On Wed, Sep 20, 2017 at 5:45 PM, sakari.ailus@iki.fi
> <sakari.ailus@iki.fi> wrote:
> > Hi Tomasz,
> >
> > On Wed, Sep 20, 2017 at 12:56:09PM +0900, Tomasz Figa wrote:
> >> Thanks Raj.
> >>
> >> Let me post my comments inline.
> >>
> >> On Wed, Sep 20, 2017 at 12:52 PM, Mani, Rajmohan
> >> <rajmohan.mani@intel.com> wrote:
> >> > Adding Tomasz...
> >> >
> >> >> -----Original Message-----
> >> >> From: Mohandass, Divagar
> >> >> Sent: Monday, September 04, 2017 3:29 AM
> >> >> To: robh+dt@kernel.org; mark.rutland@arm.com; wsa@the-dreams.de;
> >> >> sakari.ailus@iki.fi
> >> >> Cc: devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
> >> >> kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>;
> >> >> Mohandass, Divagar <divagar.mohandass@intel.com>
> >> >> Subject: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
> >> >>
> >> >> Currently the device is kept in D0, there is an opportunity to save power by
> >> >> enabling runtime pm.
> >> >>
> >> >> Device can be daisy chained from PMIC and we can't rely on I2C core for auto
> >> >> resume/suspend. Driver will decide when to resume/suspend.
> >> >>
> >> >> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> >> >> ---
> >> >>  drivers/misc/eeprom/at24.c | 38
> >> >> ++++++++++++++++++++++++++++++++++++++
> >> >>  1 file changed, 38 insertions(+)
> >> >>
> >> >> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c index
> >> >> 2199c42..d718a7a 100644
> >> >> --- a/drivers/misc/eeprom/at24.c
> >> >> +++ b/drivers/misc/eeprom/at24.c
> >> >> @@ -24,6 +24,7 @@
> >> >>  #include <linux/i2c.h>
> >> >>  #include <linux/nvmem-provider.h>
> >> >>  #include <linux/platform_data/at24.h>
> >> >> +#include <linux/pm_runtime.h>
> >> >>
> >> >>  /*
> >> >>   * I2C EEPROMs from most vendors are inexpensive and mostly
> >> >> interchangeable.
> >> >> @@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct
> >> >> at24_data *at24, const char *buf,  static int at24_read(void *priv, unsigned int
> >> >> off, void *val, size_t count)  {
> >> >>       struct at24_data *at24 = priv;
> >> >> +     struct i2c_client *client;
> >> >>       char *buf = val;
> >> >> +     int ret;
> >> >>
> >> >>       if (unlikely(!count))
> >> >>               return count;
> >> >>
> >> >> +     client = at24_translate_offset(at24, &off);
> >> >> +
> >> >> +     ret = pm_runtime_get_sync(&client->dev);
> >> >> +     if (ret < 0) {
> >> >> +             pm_runtime_put_noidle(&client->dev);
> >> >> +             return ret;
> >> >> +     }
> >> >> +
> >> >>       /*
> >> >>        * Read data from chip, protecting against concurrent updates
> >> >>        * from this host, but not from other I2C masters.
> >> >> @@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned int off, void
> >> >> *val, size_t count)
> >> >>               status = at24->read_func(at24, buf, off, count);
> >> >>               if (status < 0) {
> >> >>                       mutex_unlock(&at24->lock);
> >> >> +                     pm_runtime_put(&client->dev);
> >> >>                       return status;
> >> >>               }
> >> >>               buf += status;
> >> >> @@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned int off, void
> >> >> *val, size_t count)
> >> >>
> >> >>       mutex_unlock(&at24->lock);
> >> >>
> >> >> +     pm_runtime_put(&client->dev);
> >> >> +
> >> >>       return 0;
> >> >>  }
> >> >>
> >> >>  static int at24_write(void *priv, unsigned int off, void *val, size_t count)  {
> >> >>       struct at24_data *at24 = priv;
> >> >> +     struct i2c_client *client;
> >> >>       char *buf = val;
> >> >> +     int ret;
> >> >>
> >> >>       if (unlikely(!count))
> >> >>               return -EINVAL;
> >> >>
> >> >> +     client = at24_translate_offset(at24, &off);
> >> >> +
> >> >> +     ret = pm_runtime_get_sync(&client->dev);
> >> >> +     if (ret < 0) {
> >> >> +             pm_runtime_put_noidle(&client->dev);
> >> >> +             return ret;
> >> >> +     }
> >> >> +
> >> >>       /*
> >> >>        * Write data to chip, protecting against concurrent updates
> >> >>        * from this host, but not from other I2C masters.
> >> >> @@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned int off, void
> >> >> *val, size_t count)
> >> >>               status = at24->write_func(at24, buf, off, count);
> >> >>               if (status < 0) {
> >> >>                       mutex_unlock(&at24->lock);
> >> >> +                     pm_runtime_put(&client->dev);
> >> >>                       return status;
> >> >>               }
> >> >>               buf += status;
> >> >> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int off, void
> >> >> *val, size_t count)
> >> >>
> >> >>       mutex_unlock(&at24->lock);
> >> >>
> >> >> +     pm_runtime_put(&client->dev);
> >> >> +
> >> >>       return 0;
> >> >>  }
> >> >>
> >> >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client *client, const
> >> >> struct i2c_device_id *id)
> >> >>
> >> >>       i2c_set_clientdata(client, at24);
> >> >>
> >> >> +     /* enable runtime pm */
> >> >> +     pm_runtime_get_noresume(&client->dev);
> >> >> +     pm_runtime_set_active(&client->dev);
> >> >> +     pm_runtime_enable(&client->dev);
> >>
> >> Do we need this get_noresume/set_active dance? I remember it was for
> >> some reason needed for PCI devices, but I don't see why for I2C
> >> anything else than just pm_runtime_enable() would be necessary.
> >
> > You specifically do not need (all) this for PCI devices, but AFAIU for I涎
> > devices you do. The runtime PM status of a device is disabled by default
> > and the use count is zero, but on ACPI based systems the device is still
> > powered on.
> 
> Okay, so _get_noresume() and _set_active() would do the thing for ACPI
> indeed, but not sure about other platforms. Perhaps _enable(),
> _get_sync() would be more general?

What I ended up doing in e.g. the smiapp driver was to explicitly power the
device on first and then enable runtime PM. (See
drivers/media/i2c/smiapp/smiapp-core.c .) This approach works even if
CONFIG_PM is disabled, both on DT and ACPI.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
