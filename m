From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] i2c: designware-baytrail: Add support for cherrytrail
Date: Sat, 10 Dec 2016 11:34:31 +0100
Message-ID: <6948cdba-3646-6e87-1ae6-55c2e688eb47@redhat.com>
References: <20161209110154.7157-1-hdegoede@redhat.com>
 <20161209110154.7157-2-hdegoede@redhat.com>
 <1481282952.30772.50.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbcLJKeg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 05:34:36 -0500
In-Reply-To: <1481282952.30772.50.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

Hi,

On 09-12-16 12:29, Andy Shevchenko wrote:
> On Fri, 2016-12-09 at 12:01 +0100, Hans de Goede wrote:
>> The cherrytrail punit has the pmic i2c bus access semaphore at a
>> different register address.
>
> Thanks for the patch. My comments below.
>
>> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
>> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
>> @@ -22,7 +22,8 @@
>>  #include "i2c-designware-core.h"
>>
>>  #define SEMAPHORE_TIMEOUT	100
>> -#define PUNIT_SEMAPHORE		0x7
>> +#define PUNIT_SEMAPHORE		((dev->accessor_flags &
>> ACCESS_IS_CHERRYTRAIL) \
>> +				 ? 0x10e : 0x7)
>
> Personally I don't like this.
>
> What if we do it in a helper function
>
> static u32 get_sem_addr()
> {
>  ...
>  return addr;
> }
>
> And user
>
> {
> u32 addr = get_sem_addr(...);
>
> iosf...(..., addr, ...);
> }

Ok I will change this for the next version.

>
>
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -123,6 +123,8 @@ struct dw_i2c_dev {
>>  #define ACCESS_SWAP		0x00000001
>>  #define ACCESS_16BIT		0x00000002
>>  #define ACCESS_INTR_MASK	0x00000004
>> +/* Not really an accessor_flag but also set through driver_data */
>> +#define ACCESS_IS_CHERRYTRAIL	0x00000008
>
> Don't like it either. Here two ways I see:
> Introduce another member to keep non-accessor flags, or rename existing
> one and create new flags with some other prefix.

Ok, I will introduce a new patch in the next version of the
series which renames the flags field as preparation
for the other changes.


>
>>
>>  extern int i2c_dw_init(struct dw_i2c_dev *dev);
>>  extern void i2c_dw_disable(struct dw_i2c_dev *dev);
>> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> index 96f8230..d774bab 100644
>> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> @@ -45,6 +45,7 @@ enum dw_pci_ctl_id_t {
>>  	medfield,
>>  	merrifield,
>>  	baytrail,
>> +	cherrytrail,
>>  	haswell,
>>  };
>>
>> @@ -174,6 +175,14 @@ static struct dw_pci_controller
>> dw_pci_controllers[] = {
>>  		.functionality = I2C_FUNC_10BIT_ADDR,
>>  		.scl_sda_cfg = &hsw_config,
>>  	},
>
>> +	[cherrytrail] = {
>> +		.bus_num = -1,
>> +		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>> +		.tx_fifo_depth = 32,
>> +		.rx_fifo_depth = 32,
>> +		.functionality = I2C_FUNC_10BIT_ADDR,
>> +		.scl_sda_cfg = &byt_config,
>
> Would be ugly if we actually put...
>
>> +	},
>>  };
>>
>>  #ifdef CONFIG_PM
>> @@ -241,6 +250,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>>  	dev->base = pcim_iomap_table(pdev)[0];
>>  	dev->dev = &pdev->dev;
>>  	dev->irq = pdev->irq;
>> +	if (id->driver_data == cherrytrail)
>> +		dev->accessor_flags |= ACCESS_IS_CHERRYTRAIL;
>
> ...above inside the struct dw_pci_controller?

Ack.

Note BTW that while trying to get battery readings from the axp288
pmic on my tablet now that the punit semaphore is working I repeatedly
locked up my tablet. Without any i2c client drivers loaded a simple
"i2cdump -y 14 0x34" would lookup the tablet in 1 - 3 runs guaranteed,
and that is only reading from the pmic.

I managed to find a fix for this which I will include (as a separate
patch) in the next version of my series. This will also hopefully
fix the infamous: https://bugzilla.kernel.org/show_bug.cgi?id=109051,
as I could also make things work without my fix with
"intel_idle.max_cstate=0" so they seem to be related.

Regards,

Hans





>
>>
>>  	if (controller->setup) {
>>  		r = controller->setup(pdev, controller);
>> @@ -321,13 +332,13 @@ static const struct pci_device_id
>> i2_designware_pci_ids[] = {
>>  	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
>>  	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
>>  	/* Braswell / Cherrytrail */
>> -	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C5), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C6), baytrail },
>> -	{ PCI_VDEVICE(INTEL, 0x22C7), baytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C1), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C2), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C3), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C4), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C5), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C6), cherrytrail },
>> +	{ PCI_VDEVICE(INTEL, 0x22C7), cherrytrail },
>>  	{ 0,}
>>  };
>>  MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 0b42a12..8974467 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -123,7 +123,7 @@ static const struct acpi_device_id
>> dw_i2c_acpi_match[] = {
>>  	{ "INT3432", 0 },
>>  	{ "INT3433", 0 },
>>  	{ "80860F41", 0 },
>> -	{ "808622C1", 0 },
>> +	{ "808622C1", ACCESS_IS_CHERRYTRAIL },
>>  	{ "AMD0010", ACCESS_INTR_MASK },
>>  	{ "AMDI0010", ACCESS_INTR_MASK },
>>  	{ "AMDI0510", 0 },
>
