From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] i2c: fix ACPI_I2C_OPREGION dependency
Date: Wed, 3 Jan 2018 15:03:53 +0100
Message-ID: <3a0ee0a5-f754-e484-836b-8258d45c2108@redhat.com>
References: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
 <ea62b24e-a77b-f52e-46f2-ed38dfebd792@codeaurora.org>
 <48ff2e75-5ee0-5ac9-8d47-58c3c691ad6e@infradead.org>
 <cad432e6-1722-3080-0266-18629be56e83@codeaurora.org>
 <ccd69b15-9f3c-dbdf-f945-0323b60b4cac@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ccd69b15-9f3c-dbdf-f945-0323b60b4cac@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, eric.auger.pro@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sinan,
On 03/01/18 14:39, Sinan Kaya wrote:
> On 1/2/2018 1:19 PM, Sinan Kaya wrote:
>> On 1/2/2018 1:10 PM, Randy Dunlap wrote:
>>>>>  config ACPI_I2C_OPREGION
>>>>>  	bool "ACPI I2C Operation region support"
>>>>> -	depends on I2C=y && ACPI
>>>>> +	depends on I2C && ACPI
>>>>>  	default y
>>>>>  	help
>>>>>  	  Say Y here if you want to enable ACPI I2C operation region support.
>>>>>
>>>> Anybody picking this up?
>>> Well.  It looks to me like the patch is reversed or the patch description
>>> needs some improvement.  Or I just don't understand it.
>>
>> I'll let Eric improve the description. 
>>
>> Issue is that if you compile I2C as a module, ACPI_I2C_OPREGION doesn't get selected.
>> Therefore, any ACPI opregion calls targeting I2C fail with no opregion found.
>>
>> The goal is to select ACPI_I2C_OPREGION independent of the I2C module type selection.
>>
> 
> I hope I was able to explain it. =y above is the problem. This config option will only
> be selected if module is built-in not for m case.

Thank you for your input. I just sent a v2 with reworded commit message.
Hope this makes more sense.

Thanks

Eric
> 
