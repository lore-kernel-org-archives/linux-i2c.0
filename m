From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Wed, 11 Jul 2018 14:29:03 +1000
Message-ID: <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato> <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato> <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
 <20180710193944.34phe4zafzvwjm5v@ninjato> <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

On 11 July 2018 at 06:59, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>
>
> On 07/10/2018 02:39 PM, Wolfram Sang wrote:
>>>
>>> Sorry, what do you mean "show up as"? Yes, we could first shift all our
>>> addresses in user-space before passing them to the driver, so that the
>>> msg->addr field is exactly what the hardware expects already... This
>>> would
>>> be non-trivial for our users considering all our documentation represents
>>> the addresses as the top 7 bits of a byte :(
>>
>> Ah, now I understand the whole situation! Good that I asked. But I have
>> bad news for you:
>>
>> msg->addr is 7 bit and LSB aligned. No way around that. This is how
>> Linux I2C worked since the beginning. You have to adapt to it.
>>
>> I know what you mean. Most doumentation I get has the addresses in 8
>> bit, i.e. 7 bit address shifted + RW bit. But sorry again, the Linux
>> representation is different and all drivers have to adhere to that.
>>
>> An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
>> addr 0xa1.
>
>
> OK, I understand! Will test and resend with conforming addressing. Thanks
> for all the feedback!

Nice one Wolfram. I wondered why the standard tools didn't work, but
hadn't gotten around to working out what was going on.

Thanks for taking a close look.

Cheers,

Joel
