From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCHv2 5/5] i2c: i801: Use managed pcim_* PCI device initialization
 and reservation
Date: Fri, 13 Feb 2015 13:47:07 +0200
Message-ID: <54DDE43B.70902@linux.intel.com>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>	<1423657928-25534-6-git-send-email-jarkko.nikula@linux.intel.com> <20150213114756.2f0b0df9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150213114756.2f0b0df9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi

On 02/13/2015 12:47 PM, Jean Delvare wrote:
> Hi Jarkko,
>
> On Wed, 11 Feb 2015 14:32:08 +0200, Jarkko Nikula wrote:
>> Simplifies the code a bit and makes easier to disable PCI device on driver
>> detach by removing the pcim_pin_device() call in the future if needed.
>>
>> Reason why i2c-i801.c doesn't ever call pci_disable_device() was because it
>> made some systems to hang during power-off. See commit d6fcb3b9cf77
>> ("[PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled")
>> and
>> http://marc.info/?l=linux-kernel&m=115160053309535&w=2
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-i801.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> The checkpatch script complains:
>
> WARNING: line over 80 characters
> #90: FILE: drivers/i2c/busses/i2c-i801.c:1206:
> +	err = pcim_iomap_regions(dev, 1 << SMBBAR, dev_driver_string(&dev->dev));
>
Ah, I was blind to see this. Will fix.

>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index 5fb35464f693..9f7b69743233 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -1180,12 +1180,13 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   	}
>>   	priv->features &= ~disable_features;
>>
>> -	err = pci_enable_device(dev);
>> +	err = pcim_enable_device(dev);
>>   	if (err) {
>>   		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
>>   			err);
>>   		goto exit;
>>   	}
>> +	pcim_pin_device(dev);
>>
>>   	/* Determine the address of the SMBus area */
>>   	priv->smba = pci_resource_start(dev, SMBBAR);
>
> What is the benefit of this change, compared to just leaving the call
> to pci_enable_device() in place?
>
If you mean the patch itself I think easy pcim_pin_device() removal is 
the biggest benefit if we ever want to experiment does hang during 
power-off problem still exist in some machines. All PCI, ACPI and 
power-off code have evolved in 9 years so original problem may not exist 
anymore. Who knows.

Without this patch pcm_disable_device() needs to be added to error paths 
and i801_remove(). (of course trivial but it's always more nice to get 
regression from one-liner).

If you mean plain pcim_enable_device() it is required for other pcim_ 
functions since it allocates pcim_release which takes care of cleanup 
bunch of things including pci_release_region().

E.g. pcim_iomap_regions() without pcim_enable_device() causes an oops 
when doing "cat /proc/ioports" after module removal since 
pcim_iomap_release() only unmaps but does not release regions.

>> @@ -1202,7 +1203,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   		goto exit;
>>   	}
>>
>> -	err = pci_request_region(dev, SMBBAR, dev_driver_string(&dev->dev));
>> +	err = pcim_iomap_regions(dev, 1 << SMBBAR, dev_driver_string(&dev->dev));
>>   	if (err) {
>>   		dev_err(&dev->dev,
>>   			"Failed to request SMBus region 0x%lx-0x%Lx\n",
>> @@ -1276,7 +1277,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   	err = i2c_add_adapter(&priv->adapter);
>>   	if (err) {
>>   		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
>> -		goto exit_release;
>> +		goto exit;
>>   	}
>>
>>   	i801_probe_optional_slaves(priv);
>> @@ -1287,8 +1288,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>
>>   	return 0;
>>
>> -exit_release:
>> -	pci_release_region(dev, SMBBAR);
>>   exit:
>>   	return err;
>>   }
>
> Now that the exit path is empty, wouldn't it make sense to return
> directly on error? My understanding is that this is one of the benefits
> of managed device resources.
>
Yes it does. Will fix too.

-- 
Jarkko
