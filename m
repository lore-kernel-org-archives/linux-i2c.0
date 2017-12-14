From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: Re: [PATCH 2/2] i2c: fix piix4 aux port number
Date: Thu, 14 Dec 2017 13:31:19 +1000
Message-ID: <b1482844-bb96-264c-fffd-969494ee9210@opengear.com>
References: <cover.1511391626.git.andrew.cooks@opengear.com>
 <5e47610fa40bb07b214d1409ae721a5d762eb888.1511391626.git.andrew.cooks@opengear.com>
 <20171207152958.61ca5ea0@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:44104
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752243AbdLNDbk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 22:31:40 -0500
In-Reply-To: <20171207152958.61ca5ea0@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jean

On 08/12/17 00:29, Jean Delvare wrote:
> Hi Andrew,
> 
> On Thu, 23 Nov 2017 13:09:38 +1000, Andrew Cooks wrote:
>> Let the aux port use port number one (not zero), to match the AMD
>> documentation and enable mapping ACPI _ADR to port number.
>>
>> This fixes ACPI-based enumeration of I2C slave peripherals that are
>> defined for the aux SMBus port.
>>
>> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
>> ---
>>  drivers/i2c/busses/i2c-piix4.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
>> index 9260cfa..f980f0b 100644
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -975,7 +975,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  	if (retval > 0) {
>>  		/* Try to add the aux adapter if it exists,
>>  		 * piix4_add_adapter will clean up if this fails */
>> -		piix4_add_adapter(dev, retval, false, 0, false,
>> +		piix4_add_adapter(dev, retval, false, 1, false,
>>  				  is_sb800 ? piix4_aux_port_name_sb800 : "",
>>  				  &piix4_aux_adapter);
>>  	}
> 
> The port number has consequences. In piix4_adap_remove, port 0 is
> handled differently. We assume that for each controller (main or aux)
> exactly one adapter has port number 0. Your change above breaks this
> assumption.

I see the problem, thanks.

> 
> Also, if the port numbers are supposed to match the documentation, and
> the aux controller is port 1, then I wonder how are the muxed ports of
> the main controller numbered? The driver numbers them from 1 to 3, but
> I guess the documentation numbers them from 2 to 4 to avoid colliding
> with the aux controller? I have vague memories of discussion this
> before... If it is important that aux port number matches the
> documentation then I guess the same holds for the muxed ports on the
> main controller.

The documentation[1][2][3] uses labels Port 0 (00b), Port 2 (01b), Port 3 (10b), Port 4 (11b).

This led me down a rabbit hole of thinking that port 1 is intended to be the aux controller, but now I think that the labels in the documentation is unfortunate, because the labels don't match the binary values. (If 01b had been reserved for Port 1 it would've been fine, but it's not.)

Matching the adapter order of the documentation would have been nice, because ACPI developers rely on that as a reference. If the adapter ordering is different between ACPI and the driver, the peripherals will be mapped to the incorrect adapter.

In my particular case I can fix the ACPI DSDT to match the enumeration order of the driver right now, but I won't be able to change it easily. Similarly, there might be other users who need a different enumeration order and who aren't able to change their ACPI tables as easily.

> 
> If we number muxed ports from 2 to 4 then the test in piix4_adap_remove
> could be simply changed to check for adapdata->port <= 1.

I think the existing piix4_adap_remove code is correct and that using the port in the way I initially proposed is incorrect.

> 
> Please note that I just sent a fix for this specific function, so any
> patch touching the same area should go on top of it. I'll bounce it to
> you.
> 

I've sent a version 2 of the patch set, based on top of that fix.

Thanks!

Andrew

[1] http://support.amd.com/TechDocs/52740_16h_Models_30h-3Fh_BKDG.pdf
[2] http://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-7Fh_BKDG.pdf
[3] http://support.amd.com/TechDocs/50742_15h_Models_60h-6Fh_BKDG.pdf
