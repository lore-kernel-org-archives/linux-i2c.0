From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH RESEND 1/1] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Tue, 26 Jan 2010 16:29:06 +0100
Message-ID: <4B5F0A42.6060401@pelagicore.com>
References: <4B55D74C.2010806@pelagicore.com> <20100124154930.GE28675@fluff.org.uk> <4B5C8460.2040309@pelagicore.com> <20100126144402.GE12774@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100126144402.GE12774-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Sun, Jan 24, 2010 at 06:33:20PM +0100, Richard R?jfors wrote:
>>
>>>> +
>>>> +#define XIIC_MSB_OFFSET 0
>>>> +#define XIIC_REG_OFFSET (0x100+XIIC_MSB_OFFSET)
>>> givevn you're running everything through indirect read/write calls,
>>> how about doing it in there?
>> Could do, bad thing is that it would add in an addition during runtime
>> rather than having the C preprocessor doing it.
>>
>> I think I would like to leave it as is.
>>
>> What do you think?
> 
> Compilers aren't that stupid nowadays, they can generally sort this
> thing out at compile time, esepcially with inline code. Try it and
> see what happens...

If a constant value needs to be added to the sum of two input parameters of a function, I don's see
any option for the compiler but add it runtime.

>>>> +
>>>> +	/* add in known devices to the bus */
>>>> +	for (i = 0; i < pdata->num_devices; i++)
>>>> +		i2c_new_device(&i2c->adap, pdata->devices + i);
>>> wouldn't i2c_register_board_info() do the job for you too?
>> No actually not, we had a discussion about this like 6-9 months ago,
>> when I posted the similar solution as a patch to ocores. Problem is that
>> we don't know the bus number in advance and in theory several boards
>> containing the I2C bus could in theory show up.
>> I would like to see the same solution here.
> 
> Sorry, you've just registered the bus so should now know the number?

Ahh, you mean to call i2c_register_board_info in here after the i2c_add_adapter call?

The boardinfo list is only checked when adding the adapter. Adding the boardinfo afterwards has no
effect.
A second problem would be that every time we probe we would append the same boardinfo again... (the
device could be removed and come back).

We can not do the register_board_info before adding the adapter because then we don't know the bus
number.

--Richard
