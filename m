From: Pu Wen <puwen@hygon.cn>
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Fri, 26 Apr 2019 22:23:22 +0800
Message-ID: <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
 <20190426113751.77befab1@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190426113751.77befab1@endymion>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2019/4/26 17:38, Jean Delvare wrote:
> Sorry for the late answer.

Thanks for the reply!

>> Cc: <stable@vger.kernel.org> # v5.0+
> 
> I object to adding this to stable. It's not fixing any bug, and it's
> far from being a one-liner. I'd rather let distributions backport it as
> they see fit.

Okay, will not add this patch to stable.

>> +	     PIIX4_dev->revision >= 0x49) ||
>> +	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
>> +	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>>   	     PIIX4_dev->revision >= 0x49))
>>   		smb_en = 0x00;
> 
> Does the compatibility with the original AMD chipset include the
> revision number?

The revision number may not be needed here, although it indeed larger 
than 0x49 on Hygon platform.

>> -		if (dev->vendor == PCI_VENDOR_ID_AMD &&
>> +		if ((dev->vendor == PCI_VENDOR_ID_AMD ||
>> +		     dev->vendor == PCI_VENDOR_ID_HYGON) &&
>>   		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>>   			u8 imc;
>>   
> 
> Patch looks good. I assume you have tested it on real hardware?

Yes, I have tested it on Hygon hardware. It works well.

> I would like you to also document the new supported chipset in
> drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
> well as in the header comment of i2c-piix4.c itself. I know it seems
> redundant but it helps the user know which driver they need.

Because Hygon uses the same PCI device ID of AMD's, so is it appropriate 
to document with the name "Hygon CZ" or just "Hygon"?

-- 
Regards,
Pu Wen
