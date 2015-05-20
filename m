From: Robert Dolca <robert.dolca@gmail.com>
Subject: Re: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Wed, 20 May 2015 12:39:22 +0300
Message-ID: <CAFPB+YfvJiL7yNidDQJqq=XbF1hA4QwdBhbVYrwB=wpLkJUOwA@mail.gmail.com>
References: <1432044209-27858-1-git-send-email-robert.dolca@intel.com> <20150520074708.GQ1490@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520074708.GQ1490@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Robert Dolca <robert.dolca@intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 10:47 AM, Mika Westerberg wrote:
> On Tue, May 19, 2015 at 05:03:29PM +0300, Robert Dolca wrote:
>> For i2c devices enumerated with ACPI you need to declare both
>> acpi_match_table and id_table. When using ACPI, the i2c_device_id structure
>> supplied to the probe function is null and you have to handle this case
>> in the driver.
>>
>> The current name for the i2c client when using ACPI is "HID:UID" where the
>> UID has 7 or 8 characters and the UID has 2 characters. The UID is not
>> relevant for identifying the chip so it does not have any practical
>> purpose.
>
> First of all, it is not "HID:UID" since the number after ":" is actually
> increasing number assigned by the ACPI core. Nothing to do with _UID.

You are right. My mistake.

> Secondly we do not list "_HID:nn" in drivers acpi_match_tables but
> instead it is either "HID" or "CID", no ":nn" there.

I didn't say that you do that :)

>
>> Modifying i2c_match_id we make the comparison by ignoring the UID from the
>> client name when the device was discovered using ACPI. The comparison is
>> case insensitive because the ACPI names are uppercase and the DT and ID
>> table names are lowercase. It would not make sense to have two different
>> chips with the same name and the only diference being the capitalized
>> letters.
>>
>> With these changes the probe function gets a valid i2c_device_id and the
>> driver doesn't have to declare acpi_match_table.
>
> No. We don't do that for DT and we definitely don't want to mix ACPI
> identifiers with arbitrary I2C device names.
>
> You are not supposed to put ACPI identifiers into i2c_device_id table.

Currently, if the name used for DT (in dts) matches one of the names
specified in the id table you will have a match. Isn't that an
intended behavior?

Robert
