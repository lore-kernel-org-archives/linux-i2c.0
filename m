From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Resend Patch 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
Date: Wed, 23 Apr 2014 13:39:51 +0800
Message-ID: <53575227.7080407@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com> <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <1398147855-9868-10-git-send-email-tianyu.lan@intel.com> <20140422114510.GM30677@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140422114510.GM30677-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B404=E6=9C=8822=E6=97=A5 19:45, Mika Westerberg wrote:
> On Tue, Apr 22, 2014 at 02:24:15PM +0800, Lan Tianyu wrote:
>> This patch is to add CONFIG_I2C_ACPI. Current there is a race betwee=
n
>> removing I2C ACPI operation region and ACPI AML code accessing.
>> So make i2c core built-in if CONFIG_I2C_ACPI is set.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/Kconfig  | 17 ++++++++++++++++-
>>  drivers/i2c/Makefile |  2 +-
>>  include/linux/i2c.h  |  2 +-
>>  3 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index 7b7ea32..c670d49 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -2,7 +2,9 @@
>>  # I2C subsystem configuration
>>  #
>> =20
>> -menuconfig I2C
>> +menu "I2C support"
>> +
>> +config I2C
>>  	tristate "I2C support"
>>  	select RT_MUTEXES
>>  	---help---
>> @@ -21,6 +23,17 @@ menuconfig I2C
>>  	  This I2C support can also be built as a module.  If so, the modu=
le
>>  	  will be called i2c-core.
>> =20
>> +config I2C_ACPI
>> +	bool "I2C ACPI support"
>> +	select I2C
>> +	depends on ACPI
>> +	default y
>> +	help
>> +	  Say Y here if you want to enable I2C ACPI function. ACPI table
>> +	  provides I2C slave devices' information to enumerate these devic=
es.
>> +	  This option also allows ACPI AML code to access I2C slave device=
s
>> +	  via I2C ACPI operation region to fulfill ACPI method.
>> +
>=20
> I'm wondering, can we provide some sort of wrapper function from ACPI=
 core
> that is guaranteed to be built in to the kernel image and use it inst=
ead of
> adding new Kconfig options?
>=20
Cc: LV

LV tried to fix the issue via wrapper solution in the ACPI code before.
https://lkml.org/lkml/2013/7/23/87

He has a plan to resolve the issue in ACPICA later.

Other choice is to increase the i2c-core module count to prevent it
being unloaded when i2c operation region handler is installed. Remove
the code When LV finish his job.

--=20
Best regards
Tianyu Lan
