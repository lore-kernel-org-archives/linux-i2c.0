From: Robert Dolca <robert.dolca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Wed, 20 May 2015 13:49:02 +0300
Message-ID: <CAFPB+YcggLY9vwtYREX_YVVJFrTYHTQYnBtvMcicvLgo5MX-+A@mail.gmail.com>
References: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
 <20150520074708.GQ1490@lahna.fi.intel.com> <CAFPB+YfvJiL7yNidDQJqq=XbF1hA4QwdBhbVYrwB=wpLkJUOwA@mail.gmail.com>
 <20150520094829.GS1490@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520094829.GS1490-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Robert Dolca <robert.dolca-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 12:48 PM, Mika Westerberg wrote:
> On Wed, May 20, 2015 at 12:39:22PM +0300, Robert Dolca wrote:
>> Currently, if the name used for DT (in dts) matches one of the names
>> specified in the id table you will have a match. Isn't that an
>> intended behavior?
>
> I thought one needs to put IDs to the driver .of_match_table. This is
> also what i2c_device_match() is expecting, if I read it right.

If you put the DT id in of_match_table it will match here:

i2c_device_match
        /* Attempt an OF style match */
        if (of_driver_match_device(dev, drv))
                return 1;

If you don't specify of_match_table and you put the same ID in
i2c_device_id table it wil match here:

i2c_device_match
        driver = to_i2c_driver(drv);
        /* match on an id table if there is one */
        if (driver->id_table)
                return i2c_match_id(driver->id_table, client) != NULL;

This is happening because the name from dts is used for client->name.
i2c_match_id does the matching based on the client name.

> BTW, how modules are supposed to be matched if we allow putting ACPI
> identifiers to i2c_device_id table?

My aproach was like this: if the driver specifies .acpi_match table it
will work like before.

i2c_device_match
        /* Then ACPI style match */
        if (acpi_driver_match_device(dev, drv))
                return 1;

If the driver does not specify .acpi_match table the i2c core will
atempt to match against the  i2c_match_id table (the same way it does
for DT). In the ACPI case the client->name has that :nn suffix and
what the patch does is to ignore that when i2c_match_id is called.

i2c_device_match
        driver = to_i2c_driver(drv);
        /* match on an id table if there is one */
        if (driver->id_table)
                return i2c_match_id(driver->id_table, client) != NULL;

The final goal is to simplify the driver and remove redundant code.

Robert
