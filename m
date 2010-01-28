From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH RESEND 1/1] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Thu, 28 Jan 2010 16:49:59 +0100
Message-ID: <4B61B227.4070200@pelagicore.com>
References: <4B55D74C.2010806@pelagicore.com> <20100124154930.GE28675@fluff.org.uk> <4B5C8460.2040309@pelagicore.com> <20100126144402.GE12774@fluff.org.uk> <4B5F0A42.6060401@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5F0A42.6060401-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Richard R=F6jfors wrote:
> Ben Dooks wrote:
>> On Sun, Jan 24, 2010 at 06:33:20PM +0100, Richard R?jfors wrote:
>>>>> +
>>>>> +#define XIIC_MSB_OFFSET 0
>>>>> +#define XIIC_REG_OFFSET (0x100+XIIC_MSB_OFFSET)
>>>> givevn you're running everything through indirect read/write calls=
,
>>>> how about doing it in there?
>>> Could do, bad thing is that it would add in an addition during runt=
ime
>>> rather than having the C preprocessor doing it.
>>>
>>> I think I would like to leave it as is.
>>>
>>> What do you think?
>> Compilers aren't that stupid nowadays, they can generally sort this
>> thing out at compile time, esepcially with inline code. Try it and
>> see what happens...
>=20
> If a constant value needs to be added to the sum of two input paramet=
ers of a function, I don's see
> any option for the compiler but add it runtime.

Ah, we can not add in the offset in the read/write functions. Because a=
ll registers are not offset:ed.
(The interrupt registers registered further down).

I will post an updated patch shortly.

Thanks for the feedback.

--Richard
