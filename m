From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: add i2c adapter driver for i.MX3x SoCs
Date: Tue, 11 Nov 2008 09:47:36 +0200
Message-ID: <49193898.9000000@gmail.com>
References: <Pine.LNX.4.64.0811071857460.4513@axis700.grange> <gf9iln$n8b$1@ger.gmane.org> <Pine.LNX.4.64.0811102012380.8315@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0811102012380.8315-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <public-g.liakhovetski-Mmb7MZpHnFY-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
Cc: public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Guennadi Liakhovetski wrote:
> (please, use reply-to-all, thanks)
> 
> On Mon, 10 Nov 2008, Darius wrote:
> 
>> Guennadi Liakhovetski wrote:
>>> This is an updated and cleaned up i2c driver for i.MX3x from Freescale.
>>>
>>> Signed-off-by: Guennadi Liakhovetski <lg-ynQEQJNshbs-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>>
>>> ---
>>>
>>> Please comment, I'll also have to obtain ARM Acks for the arch/arm part, or,
>>> maybe, split it into two parts.
>>>
>> Hi, I have ready driver for MX1. Is it reason to make two separate drivers for
>> MX2/MX3 and MX1?
>> btw, pending patches for MX1 is main reason why I2C for imx driver is not in
>> kernel.
> 
> If it works with mx3 - great! I did see it, but I didn't realise it would 
> work with mx3. Please, confirm.

It is tested only with i.MXL.
We can see in mx1 and in mx3 user manuals, that both they has the same controller.
mx3 differs only in register width (16bit instead 32bit in mx1) and has 3 I2C devices (mx1 only one).
I don't have possibility to test it on mx3. Maybe you have?

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
