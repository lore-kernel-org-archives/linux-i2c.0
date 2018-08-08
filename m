From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 2/4] ACPI / scan: Create platform device for fwnodes
 with multiple i2c devices
Date: Wed, 8 Aug 2018 10:07:22 +0200
Message-ID: <0e71b6ab-5a2d-a1a1-bb4b-46ef85e8a9ad@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-3-hdegoede@redhat.com>
 <00e16cb09c171b536449b61124473291f2b30d0b.camel@linux.intel.com>
 <13770931-2322-96a3-1667-83c96b25bcfb@redhat.com>
 <43d45add4c8059d44a0b228e4beffb03c094a512.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43d45add4c8059d44a0b228e4beffb03c094a512.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07-08-18 13:49, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 13:29 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 07-08-18 13:19, Andy Shevchenko wrote:
>>> On Tue, 2018-08-07 at 10:05 +0200, Hans de Goede wrote:
> 
>>>> +	/*
>>>> +	 * These devices have multiple I2cSerialBus resources and an
>>>> i2c-client
>>>> +	 * must be instantiated for each, each with its own
>>>> i2c_device_id.
>>>> +	 * Normally we only instantiate an i2c-client for the first
>>>> resource,
>>>> +	 * using the ACPI HID as id. These special cases are handled by
>>>> the
>>>> +	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which
>>>> knows
>>>> +	 * which i2c_device_id to use for each resource.
>>>> +	 */
>>>> +	static const struct acpi_device_id i2c_multi_instantiate_ids[] =
>>>> {
>>>> +		{"BSG1160", 0},
>>>> +		{"", 0},
>>>> +	};
>>>
>>> Style nits:
>>> - can we move it outside of function?
>>
>> Sure, but there are 2 existing users of an array of acpi_device_id-s
>> combined with an acpi_match_device_ids() call and both have the array
>> inside the function, so for consistency it seems better to keep it
>> where it is.
> 
> Hmm... OK.
> 
>>> - is this existing style in the file and / or files in this folder
>>> for
>>> IDs? (I mean unnecessary 0:s and empty string?
>>
>> It seems that all variants one can come up with are already used
>> inside
>> this single file.
> 
> Ah, that's sad.
> 
>> I agree that less is more, so I will change this to:
>>
>>           static const struct acpi_device_id
>> i2c_multi_instantiate_ids[] = {
> 
>>                   {"BSG1160", },
>>                   {}
>>           };
> 
> In case if it mimics already existing style, looks quite good to me
> (otherwise perhaps comma inside {} can also be removed).
> 
>>
>> For v4.
> 
> Does it make sense to test v3 on your opinion? Or better to wait for v4?

Sorry for being a bit slow to answer, I'm about to send out v4, so probably
best to wait for that now. Note the 2 will be functionally identical,
I mainly fixed / clarified commit messages and the MAINTAINERS entry +
the small style fixed discussed above.

Regards,

Hans
