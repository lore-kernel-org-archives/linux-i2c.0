From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 2/7] i2c: Add FSI-attached I2C master algorithm
Date: Tue, 5 Jun 2018 08:31:16 -0500
Message-ID: <adbc4f16-326c-1cc8-a293-cfd5e2d8a070@linux.vnet.ibm.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528138850-18259-3-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
 <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-i2c@vger.kernel.org



On 06/04/2018 06:38 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 22:21 +0300, Andy Shevchenko wrote:
>>> +#define I2C_INT_ENABLE         0x0000ff80
>>> +#define I2C_INT_ERR            0x0000fcc0
>> Now it looks like a flags combinations.
>> For me as for reader would be better to see quickly a decoded line.
>>
>> My proposal is to introduce something like following
>>
>> _INT_ALL  GENMASK()
>> _INT_ENABLE (_INT_ALL & ~(_FOO | _BAR))
>> _INT_ERR ... similar way as above ...
>>
>> What do you think?
> I don't think this absolutely needs to change but yes, open coding is
> error prone. However I would think it more readable to use positive
> logic and just list all the bits that are *set* even if it's a bit more
> text:
>
> #define I2C_INT_ERR	(I2C_INT_INV_CMD	|\                			
>   I2C_INT_PARITY         |\
> 			 I2C_INT_BE_OVERRUN	|\
> 			.../...)
>
> #define I2C_INT_ENABLE	(I2C_INT_ERR		|\
> 			 I2C_INT_DAT_REQ	|\
> 			 I2C_INT_CMD_COMP)
>
> Note: Eddie, I notice I2C_INT_BUSY is in "ERR" but not in "ENABLE", any
> reason for that ?

Yes, we don't want to enable an interrupt if I2C gets into the busy 
state, as that happens during every transfer.  However it would likely 
be an error condition if we get that when the transfer is supposed to be 
complete. These were from the legacy driver... I just realized that 
neither are actually being used in this driver, so I will drop them.

Thanks,
Eddie

>
> Cheers,
> Ben.
>
