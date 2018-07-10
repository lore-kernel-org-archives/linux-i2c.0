From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Tue, 10 Jul 2018 15:59:23 -0500
Message-ID: <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
 <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
 <20180710193944.34phe4zafzvwjm5v@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710193944.34phe4zafzvwjm5v@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 07/10/2018 02:39 PM, Wolfram Sang wrote:
>> Sorry, what do you mean "show up as"? Yes, we could first shift all our
>> addresses in user-space before passing them to the driver, so that the
>> msg->addr field is exactly what the hardware expects already... This would
>> be non-trivial for our users considering all our documentation represents
>> the addresses as the top 7 bits of a byte :(
> Ah, now I understand the whole situation! Good that I asked. But I have
> bad news for you:
>
> msg->addr is 7 bit and LSB aligned. No way around that. This is how
> Linux I2C worked since the beginning. You have to adapt to it.
>
> I know what you mean. Most doumentation I get has the addresses in 8
> bit, i.e. 7 bit address shifted + RW bit. But sorry again, the Linux
> representation is different and all drivers have to adhere to that.
>
> An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
> addr 0xa1.

OK, I understand! Will test and resend with conforming addressing. 
Thanks for all the feedback!

Eddie

>
>>>> Indeed, real 10-bit addresses require some additional manipulation of this
>>>> I2C master in order to work. We don't support it right now.
>>> Then you should remove the associated FUNC flag.
>> Ah, but due to the addressing situation, tools like i2cget don't work with
>> our addresses unless the 10 bit flag is specified. For example, we may want
>> to access 0xA0.
> This is a kinda dirty workaround to the above problem. It is even wrong
> because 10-bit addresses look totally different on the wire.
>
> Sorry for the hazzle with the docs, but there is no way around that.
>
