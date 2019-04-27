From: Pu Wen <puwen@hygon.cn>
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Sat, 27 Apr 2019 10:37:49 +0800
Message-ID: <8ec649c6-5282-6fb1-a1ee-a88dc897d644@hygon.cn>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
 <20190426113751.77befab1@endymion>
 <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
 <1556297285.22365.4.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1556297285.22365.4.camel@suse.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2019/4/27 0:48, Jean Delvare wrote:
> On Fri, 2019-04-26 at 22:23 +0800, Pu Wen wrote:
>> On 2019/4/26 17:38, Jean Delvare wrote:
>>> I would like you to also document the new supported chipset in
>>> drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
>>> well as in the header comment of i2c-piix4.c itself. I know it seems
>>> redundant but it helps the user know which driver they need.
>>
>> Because Hygon uses the same PCI device ID of AMD's, so is it appropriate
>> to document with the name "Hygon CZ" or just "Hygon"?
> 
> "Hygon CZ" please, as Hygon is the vendor not the device, and I can

Okay.

> imagine you may create more devices in the future.

Surely.

-- 
Regards,
Pu Wen
