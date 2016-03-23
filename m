From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: I2c client driver + ACPI on Baytrail & kernel 4.4.2 = ?
Date: Wed, 23 Mar 2016 11:30:48 +0200
Message-ID: <56F26248.3090302@linux.intel.com>
References: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
 <56E6ACBC.6010508@linux.intel.com>
 <CA+V1LzqgXpm1nERbXD2MPHFFvsv8skm=-BKLdwYU-uU=RQUaYg@mail.gmail.com>
 <CA+V1LzrtvN=HCKed8gfZSkHst0NdkvbAtb0mkV4y6AhusNSEFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29811 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbcCWJbC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 05:31:02 -0400
In-Reply-To: <CA+V1LzrtvN=HCKed8gfZSkHst0NdkvbAtb0mkV4y6AhusNSEFA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-i2c@vger.kernel.org

Hi

Sorry the delay. Answers below.

On 03/16/2016 01:12 AM, sergk sergk2mail wrote:
> Hi,
>
> regarding "80860F41:03"
> from DSDT 80860F41:
> Name (_HID, "80860F41" /* Intel Baytrail I2C Host Controller */)  //
> _HID: Hardware ID
>              Name (_CID, "80860F41" /* Intel Baytrail I2C Host
> Controller */)  // _CID: Compatible ID
>
>
> So, is this mean i2c-3?

It's third i2c-designware compatible I2C host controller but it doesn't 
necessarily map into i2c-3. For instance if there are other I2C host 
controller drivers like SMBUS or those in display controller initialized 
before it.

>> ls -l /sys/bus/acpi/devices/CHPN0001:00
>> lrwxrwxrwx 1 root root 0 Mar 15 22:08
>> /sys/bus/acpi/devices/CHPN0001:00 ->
>> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:03/CHPN0001:00
>> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/status
>> 0
>>
>> status is 0 - what does this mean? It is detected via ACPI but not present?
>> What does "LNXSYBUS:00/80860F41:03"  means?  Does it mean i2c-3, 0x41
>> ?  80860F41:03 == ?
>>
Path shows the complete device hierarchy where CHPN0001:00 is under 
80860F41:03 bus but not present. Looking at the DSDT snippet you posted 
into thread there is _STA method that forms the above status:

                 Method (_STA, 0, NotSerialized)  // _STA: Status
                 {
                     If ((OSSL & 0x80))
                     {
                         Return (Zero)
                     }

                     If ((OSYS == 0x07DD))
                     {
                         Return (0x0F)
                     }
                     Else
                     {
                         Return (0x0F)
                     }
                 }

I don't know what these OSSL and OSYS variables are. I guess OSSL 
represents either some BIOS configuration or alternative device 
manufacturer can use. Is there other similar device defined under 
80860F41:03 that could be present (status == 15)?

The _DSM method shows it indeeds is an i2c-hid device and no new driver 
is required:

                 Method (_DSM, 4, Serialized)  // _DSM: Device-Specific 
Method
                 {
                     Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                     Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                     Debug = "Method _DSM begin"
                     If ((Arg0 == ToUUID
("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))

This same UUID is matched in drivers/hid/i2c-hid/i2c-hid.c: 
i2c_hid_acpi_pdata().

>> So the question is the same - how to obtain via acpi in mentioned
>> above code i2cbus, bus addr and irq for this touch?
>>
Look up happens in acpi_i2c_add_device() and acpi_i2c_find_address() in 
drivers/i2c/i2c-core.c but device must be present.

-- 
Jarkko
