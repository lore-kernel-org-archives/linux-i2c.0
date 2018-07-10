From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Tue, 10 Jul 2018 12:52:58 -0500
Message-ID: <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709224114.4h47enyt4tucqcou@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 07/09/2018 05:41 PM, Wolfram Sang wrote:
>> +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
> I just noticed this and wonder: Don't you need the LSB of the address?
> It is not the RW flag, this is encoded in msg->flags.

So, the hardware interprets the LSB as the RW flag. It wouldn't be 
possible to have a device addressed with the LSB set on this I2C master.

>
> Also, no seperate handling for 10 bit addresses? Technically, 7-bit 0x50
> is different on the wire from 10-bit 0x050. This is minor, though. There
> are no 10-bit devices out there. Still, did you test 10-bit support?

Indeed, real 10-bit addresses require some additional manipulation of 
this I2C master in order to work. We don't support it right now.

Thanks,
Eddie

>
> Rest looks good.
>
