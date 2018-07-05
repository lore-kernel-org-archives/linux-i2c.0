From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Date: Thu, 5 Jul 2018 13:52:13 -0500
Message-ID: <ab5a5b9c-931e-e8ca-d064-92a917e00a3b@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023823.i3fmdegn2sric5kx@ninjato>
 <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
 <20180702182434.5wxxszpgpf6wergl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702182434.5wxxszpgpf6wergl@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 07/02/2018 01:24 PM, Wolfram Sang wrote:
>>>> +	if (msg->flags & I2C_M_RD)
>>>> +		cmd |= I2C_CMD_READ;
>>> Since you support MANGLING, I'd think you can easily support
>>> I2C_M_REV_DIR_ADDR here, too?
>> Hm, I don't really understand the purpose of that flag. From the docs:
>>
>> This toggles the Rd/Wr flag. That is, if you want to do a write, but
>>      need to emit an Rd instead of a Wr, or vice versa, you set this
>>      flag. For example:
>> S Addr Rd [A] Data [A] Data [A] ... [A] Data [A] P
>>
>> I don't think our hardware supports this type of operation.
> I'd think something like this should do:
>
> 	if (msg->flags & I2C_M_REV_DIR_ADDR)
> 		cmd ^= I2C_CMD_READ;

I meant that the hardware cannot interpret this, it would be a 
meaningless command unfortunately.

>
