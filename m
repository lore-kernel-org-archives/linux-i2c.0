From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH linux 2/6] hwmon: occ: Add sysfs interface
Date: Sat, 7 Jan 2017 09:15:57 -0800
Message-ID: <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
 <1483120568-21082-3-git-send-email-eajames.ibm@gmail.com>
 <20161230193404.GB8516@roeck-us.net>
 <OFA812992D.D19B1368-ON002580A0.007A2966-862580A0.007A72F0@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <OFA812992D.D19B1368-ON002580A0.007A2966-862580A0.007A72F0@notes.na.collabserv.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Edward James <eajames@us.ibm.com>
Cc: andrew@aj.id.au, corbet@lwn.net, devicetree@vger.kernel.org, eajames.ibm@gmail.com, jdelvare@suse.com, joel@jms.id.au, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On 01/06/2017 02:17 PM, Edward James wrote:

[ ... ]

>> > +}
>> > +
>> > +static DEVICE_ATTR(online, S_IWUSR | S_IRUGO, show_occ_online,
>> > +         store_occ_online);
>> > +
>> > +struct occ_sysfs *occ_sysfs_start(struct device *dev, struct occ *occ,
>> > +              struct occ_sysfs_config *config)
>> > +{
>> > +   struct occ_sysfs *hwmon = devm_kzalloc(dev, sizeof(struct occ_sysfs),
>> > +                      GFP_KERNEL);
>> > +   int rc;
>> > +
>> > +   if (!hwmon)
>> > +      return ERR_PTR(-ENOMEM);
>> > +
>> > +   hwmon->occ = occ;
>> > +   hwmon->num_caps_fields = config->num_caps_fields;
>> > +   hwmon->caps_names = config->caps_names;
>> > +
>> > +   dev_set_drvdata(dev, hwmon);
>> > +
>> > +   rc = device_create_file(dev, &dev_attr_online);
>> > +   if (rc)
>> > +      return ERR_PTR(rc);
>> > +
>> > +   return hwmon;
>> > +}
>> > +EXPORT_SYMBOL(occ_sysfs_start);
>> > +
>> > +int occ_sysfs_stop(struct device *dev, struct occ_sysfs *driver)
>> > +{
>> > +   if (driver->dev) {
>> > +      occ_remove_hwmon_attrs(driver);
>> > +      hwmon_device_unregister(driver->dev);
>> > +   }
>> > +
>> > +   device_remove_file(driver->dev, &dev_attr_online);
>> > +
>> > +   devm_kfree(dev, driver);
>>
>> Thw point of using devm_ functions is not to require remove/free functions.
>> Something is completely wrong here if you need that call.
>>
>> Overall, this is architectually completely wrong. One does not register
>> or instantiate drivers based on writing into sysfs attributes. Please
>> reconsider your approach.
>
> We had some trouble designing this driver because the BMC only has
> access to the OCC once the processor is powered on. This will happen
> sometime after the BMC boots (this driver runs only on the BMC). With
> no access to the OCC, we don't know what sensors are present on the
> system without a large static enumeration. Also any sysfs files created
> before we have OCC access won't be able to return any data.
>
> Instead of the "online" attribute, what do you think about using the
> "bind"/"unbind" API to probe the device from user space once the system
> is powered on? All the hwmon registration would take place in the probe
> function, it would just occur some time after boot.
>

A more common approach would be to have a platform driver. That platform
driver would need a means to detect if the OCC is up and running, and
instantiate everything else once it is.

A trigger from user space is problematic because there is no guarantee
that the OCC is really up (or that it even exists).

An alternative might be to have the hwmon driver poll for the OCC,
but that would be a bit more difficult and might require a kernel thread
or maybe asynchronous probing.

Guenter

