From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Tue, 10 Jul 2018 14:14:40 -0500
Message-ID: <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710185042.x3slnms5wzocobqu@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 07/10/2018 01:50 PM, Wolfram Sang wrote:
>>>> +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
>>> I just noticed this and wonder: Don't you need the LSB of the address?
>>> It is not the RW flag, this is encoded in msg->flags.
>> So, the hardware interprets the LSB as the RW flag. It wouldn't be possible
>> to have a device addressed with the LSB set on this I2C master.
> But msg->addr is 7 bit and LSB aligned. If I am not horribly wrong, with
> the above code, an EEPROM at 0x50 would show up as 0x28 with your
> driver?

Sorry, what do you mean "show up as"? Yes, we could first shift all our 
addresses in user-space before passing them to the driver, so that the 
msg->addr field is exactly what the hardware expects already... This 
would be non-trivial for our users considering all our documentation 
represents the addresses as the top 7 bits of a byte :(

>
>> Indeed, real 10-bit addresses require some additional manipulation of this
>> I2C master in order to work. We don't support it right now.
> Then you should remove the associated FUNC flag.

Ah, but due to the addressing situation, tools like i2cget don't work 
with our addresses unless the 10 bit flag is specified. For example, we 
may want to access 0xA0.

>
