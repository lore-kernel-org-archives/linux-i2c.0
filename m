From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCHv2 4/5] i2c: i801: Remove pci_enable_device() call from
 i801_resume()
Date: Fri, 13 Feb 2015 13:13:18 +0200
Message-ID: <54DDDC4E.5010602@linux.intel.com>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>	<1423657928-25534-5-git-send-email-jarkko.nikula@linux.intel.com> <20150213113302.0e20b8da@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150213113302.0e20b8da-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi

On 02/13/2015 12:33 PM, Jean Delvare wrote:
> Hi Jarkko,
>
> On Wed, 11 Feb 2015 14:32:07 +0200, Jarkko Nikula wrote:
>> Since pci_disable_device() is not called from i801_suspend() and power
>> state is set already it means that subsequent pci_enable_device() calls do
>> practically nothing but monotonically increase struct pci_dev enable_cnt.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-i801.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index b1d725d758bb..5fb35464f693 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -1324,7 +1324,7 @@ static int i801_resume(struct pci_dev *dev)
>>   {
>>   	pci_set_power_state(dev, PCI_D0);
>>   	pci_restore_state(dev);
>> -	return pci_enable_device(dev);
>> +	return 0;
>>   }
>>   #else
>>   #define i801_suspend NULL
>
> This looks reasonable but have you tested this change on a range of
> actual laptops to make sure it has no unexpected side effect?
>
Unfortunately I have only limited amount of test hw which are working 
fine even if PCI device is disabled so I cannot hit those issues that 
were seen in the past.

I suppose this patch unlikely cause regression since if you look at the 
call chain pci_enable_device() -> pci_enable_device_flags() it doesn't 
go beyond taking the current power state since enable_cnt is always 
greater than 1.

drivers/pci/pci.c: pci_enable_device_flags():

if (dev->pm_cap) {
	u16 pmcsr;
	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
}

if (atomic_inc_return(&dev->enable_cnt) > 1)
	return 0;		/* already enabled */

To me it seems current power state taking is practically no-op when 
device is enabled since pci_set_power_state() calls in i801_suspend() 
and i801_resume() have already cached it.

-- 
Jarkko
