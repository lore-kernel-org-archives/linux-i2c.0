From: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
Date: Fri, 3 Oct 2014 13:04:54 +0200
Message-ID: <CAE0=X_2mCfbmgiP955N9OesJ9Aiz1zW6wmNXE4SPZr4dNxehPw@mail.gmail.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
	<20141003103630.GB1349@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003103630.GB1349@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 3, 2014 at 12:36 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2ac87fa..8983474 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -77,6 +77,17 @@ config I2C_AMD8111
>>         This driver can also be built as a module.  If so, the module
>>         will be called i2c-amd8111.
>>
>> +config I2C_AXXIA
>> +     tristate "Axxia I2C controller"
>> +     depends on ARCH_AXXIA || COMPILE_TEST
>> +     default ARCH_AXXIA
>> +     help
>> +       Say yes if you want to support the I2C bus on Axxia platforms.
>> +
>> +       Please note that this controller is limited to transfers of maximum
>> +       255 bytes in length. Any attempt to to a larger transfer will return
>> +       an error.
>> +
>>  config I2C_I801
>>       tristate "Intel 82801 (ICH/PCH)"
>>       depends on PCI
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 49bf07e..5899edb 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_I2C_ALI15X3)   += i2c-ali15x3.o
>>  obj-$(CONFIG_I2C_AMD756)     += i2c-amd756.o
>>  obj-$(CONFIG_I2C_AMD756_S4882)       += i2c-amd756-s4882.o
>>  obj-$(CONFIG_I2C_AMD8111)    += i2c-amd8111.o
>> +obj-$(CONFIG_I2C_AXXIA)              += i2c-axxia.o
>>  obj-$(CONFIG_I2C_I801)               += i2c-i801.o
>>  obj-$(CONFIG_I2C_ISCH)               += i2c-isch.o
>>  obj-$(CONFIG_I2C_ISMT)               += i2c-ismt.o
>
> Please put it to the embedded section.
>

OK.

> ...
>
>> +     idev->adapter.class = I2C_CLASS_HWMON;
>
> Being a DT driver, you most probably don't need this.
>

Right, thanks.  I'll fix up these and submit a v3.

/Anders
