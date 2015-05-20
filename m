From: Robert Dolca <robert.dolca@gmail.com>
Subject: Re: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Thu, 21 May 2015 00:32:49 +0300
Message-ID: <CAFPB+YcLSwyVTBmkHFZPM9MTgTsPHuzoxq1KN1b+Z0dvFNF5yw@mail.gmail.com>
References: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
 <20150520074708.GQ1490@lahna.fi.intel.com> <CAFPB+YfvJiL7yNidDQJqq=XbF1hA4QwdBhbVYrwB=wpLkJUOwA@mail.gmail.com>
 <20150520094829.GS1490@lahna.fi.intel.com> <CAFPB+YcggLY9vwtYREX_YVVJFrTYHTQYnBtvMcicvLgo5MX-+A@mail.gmail.com>
 <20150520105753.GT1490@lahna.fi.intel.com> <CAFPB+Ydw4Ywo4dt5NB-Aed6gtt89h2kMucXtgJa42vwommZerw@mail.gmail.com>
 <20150520135716.GW1490@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520135716.GW1490@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Robert Dolca <robert.dolca@intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 4:57 PM, Mika Westerberg wrote:
> On Wed, May 20, 2015 at 04:07:00PM +0300, Robert Dolca wrote:
>> On Wed, May 20, 2015 at 1:57 PM, Mika Westerberg wrote:
>> > On Wed, May 20, 2015 at 01:49:02PM +0300, Robert Dolca wrote:
>> >> On Wed, May 20, 2015 at 12:48 PM, Mika Westerberg wrote:
>> >> > On Wed, May 20, 2015 at 12:39:22PM +0300, Robert Dolca wrote:
>> >> >> Currently, if the name used for DT (in dts) matches one of the names
>> >> >> specified in the id table you will have a match. Isn't that an
>> >> >> intended behavior?
>> >> >
>> >> > I thought one needs to put IDs to the driver .of_match_table. This is
>> >> > also what i2c_device_match() is expecting, if I read it right.
>> >>
>> >> If you put the DT id in of_match_table it will match here:
>> >>
>> >> i2c_device_match
>> >>         /* Attempt an OF style match */
>> >>         if (of_driver_match_device(dev, drv))
>> >>                 return 1;
>> >>
>> >> If you don't specify of_match_table and you put the same ID in
>> >> i2c_device_id table it wil match here:
>> >>
>> >> i2c_device_match
>> >>         driver = to_i2c_driver(drv);
>> >>         /* match on an id table if there is one */
>> >>         if (driver->id_table)
>> >>                 return i2c_match_id(driver->id_table, client) != NULL;
>> >>
>> >> This is happening because the name from dts is used for client->name.
>> >> i2c_match_id does the matching based on the client name.
>> >
>> > OK.
>> >
>> >> > BTW, how modules are supposed to be matched if we allow putting ACPI
>> >> > identifiers to i2c_device_id table?
>> >>
>> >> My aproach was like this: if the driver specifies .acpi_match table it
>> >> will work like before.
>> >>
>> >> i2c_device_match
>> >>         /* Then ACPI style match */
>> >>         if (acpi_driver_match_device(dev, drv))
>> >>                 return 1;
>> >>
>> >> If the driver does not specify .acpi_match table the i2c core will
>> >> atempt to match against the  i2c_match_id table (the same way it does
>> >> for DT). In the ACPI case the client->name has that :nn suffix and
>> >> what the patch does is to ignore that when i2c_match_id is called.
>> >>
>> >> i2c_device_match
>> >>         driver = to_i2c_driver(drv);
>> >>         /* match on an id table if there is one */
>> >>         if (driver->id_table)
>> >>                 return i2c_match_id(driver->id_table, client) != NULL;
>> >
>> > Yeah but when you have device with modalias of "acpi:FOO:" how
>> > udev/modprobe is supposed find the correct module?
>>
>> The modalias file content exposed by the i2c device in sysfs will be the same.
>
> It won't be the same. If it has an ACPI companion it will be different.
>
> Here's one example from a machine with I2C touchscreen connected:
>
> # cat /sys/bus/i2c/devices/i2c-ATML3432\:00/modalias
> acpi:ATML3432:PNP0C50:
>
>> Currently the alias exposed by the driver is based on the i2c_match_id
>> table and it does not have any aliases based on
>> acpi_device_id table. I am new to this are so please correct me if I am wrong.
>>
>> >> The final goal is to simplify the driver and remove redundant code.
>> >
>> > IMHO mixing ACPI identifiers with I2C device identifiers does not
>> > simplify anything. And since you need to stick the ACPI ID somewhere
>> > anyway I don't get the point of removing redundant code either.
>>
>> It will make the i2c_device_id be not NULL when the device is probed.
>> Here is an example:
>>
>> static int probe(struct i2c_client *client, const struct i2c_device_id *id)
>>        /* Get device name from device table or ACPI */
>>         if (ACPI_HANDLE(dev)) {
>>                 acpi_id = acpi_match_device(silead_ts_acpi_match, dev);
>>                 if (!acpi_id)
>>                         return -ENODEV;
>>
>>                 sprintf(data->fw_name, "%s.fw", acpi_id->id);
>>
>>                 for (i = 0; i < strlen(data->fw_name); i++)
>>                         data->fw_name[i] = tolower(data->fw_name[i]);
>>         } else {
>>                 sprintf(data->fw_name, "%s.fw", id->name);
>>         }
>>
>> This will become:
>>         sprintf(data->fw_name, "%s.fw", id->name);
>
> OK, in that case it shortens the code I give you that. But the normal
> case where you only need to match against the ACPI identifier (and
> handling modules properly) this does not simplify anything.
>
>> There are allot more cases like this already in the kernel.
>
> I didn't find too many. Most of them are under drivers/iio and they all
> do something like:
>
> static const char *kmx61_match_acpi_device(struct device *dev)
> {
>         const struct acpi_device_id *id;
>
>         id = acpi_match_device(dev->driver->acpi_match_table, dev);
>         if (!id)
>                 return NULL;
>         return dev_name(dev);
> }
>
> static int kmx61_probe(struct i2c_client *client, const struct i2c_device_id *id)
> {
>         ...
>         if (id)
>                 name = id->name;
>         else if (ACPI_HANDLE(&client->dev))
>                 name = kmx61_match_acpi_device(&client->dev);
>         else
>                 return -ENODEV;
>
> which I think is not needed at all. If you end up having an ACPI handle
> for your I2C device and the I2C core has already done the matching, you
> don't need to do the match again in the driver. Instead this can be written like:
>
>         if (id)
>                 name = id->name;
>         else if (has_acpi_companion(&client->dev))
>                 name = dev_name(&client->dev);
>         else
>                 return -ENODEV;
>
> And you probably don't need that 'name' either.

I get your point. The benefits are not worth mixing the i2c_device_id
table with the ACPI ids.

Thanks for your valuable feedback.

Robert
