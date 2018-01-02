From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] i2c: fix ACPI_I2C_OPREGION dependency
Date: Tue, 2 Jan 2018 10:10:47 -0800
Message-ID: <48ff2e75-5ee0-5ac9-8d47-58c3c691ad6e@infradead.org>
References: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
 <ea62b24e-a77b-f52e-46f2-ed38dfebd792@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ea62b24e-a77b-f52e-46f2-ed38dfebd792@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 01/02/2018 10:07 AM, Sinan Kaya wrote:
> +linux-acpi
> 
> On 11/22/2017 12:05 PM, Eric Auger wrote:
>> If CONFIG_I2C=m we fail getting ACPI_I2C_OPREGION set. Let's
>> make ACPI_I2C_OPREGION depend on I2C.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/i2c/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index efc3354..5951e9d 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -26,7 +26,7 @@ config I2C
>>  
>>  config ACPI_I2C_OPREGION
>>  	bool "ACPI I2C Operation region support"
>> -	depends on I2C=y && ACPI
>> +	depends on I2C && ACPI
>>  	default y
>>  	help
>>  	  Say Y here if you want to enable ACPI I2C operation region support.
>>
> 
> Anybody picking this up?

Well.  It looks to me like the patch is reversed or the patch description
needs some improvement.  Or I just don't understand it.

-- 
~Randy
