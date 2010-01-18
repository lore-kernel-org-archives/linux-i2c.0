From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Mon, 18 Jan 2010 13:23:25 -0800
Message-ID: <6cb013311001181323q79aba15dif165ff41d79734a7@mail.gmail.com>
References: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
	<1263056154-20085-1-git-send-email-darkstar6262@gmail.com>
	<20100118124855.GB8036@sortiz.org> <20100118153624.GA13811@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100118153624.GA13811-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 18, 2010 at 7:36 AM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> w=
rote:
> On Mon, Jan 18, 2010 at 01:48:55PM +0100, Samuel Ortiz wrote:
>> Hi Cory,
>>
>> I applied this patch, thanks a lot.
>> In the future, I'd like to see the GPIO handling from this patch mov=
ed to
>> drivers/gpio. Could you please look at that ?

Absolutely, thanks for applying it!  I'll send out a follow-on patch
as soon as I've got that change.

> I forgot to add that I also made it build on non ARM patforms. This l=
ine:
> set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> became:
> #ifdef CONFIG_ARM
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_irq_flags(=
irq, IRQF_VALID | IRQF_PROBE);
> #else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_irq_probe(=
irq);
> #endif
>

Ah, cool, thanks!

- Cory
