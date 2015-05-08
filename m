From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Why isn't IRQ shared for i2c-ocore
Date: Fri, 8 May 2015 09:07:59 +0200
Message-ID: <CAMuHMdUFj40OjEHOovFVbtOgr92fJeAq41Hf3h+CqsfPm4aSsQ@mail.gmail.com>
References: <55304D8E.8070204@freescale.com>
	<55312AF7.7070504@freescale.com>
	<20150420064231.GE3447@x1>
	<55352839.70905@freescale.com>
	<20150420181651.GF3447@x1>
	<5535460B.2060309@freescale.com>
	<20150421073534.GK3447@x1>
	<554A8A8B.1020703@freescale.com>
	<20150507070149.GB3400@x1>
	<CAMuHMdWXFmPWsL4QyjwV+X-mruS0pU2Uzj7aSSxTQDJ=K+32XA@mail.gmail.com>
	<20150508065747.GG16220@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150508065747.GG16220@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 8, 2015 at 8:57 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Fri, 08 May 2015, Geert Uytterhoeven wrote:
>
>> On Thu, May 7, 2015 at 9:01 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> >> I have a follow up question regarding interrupt. I see many I2C bus drivers
>> >> request interrupt with flag = 0. Why not using IRQF_SHARED?
>> >
>> > Probably because that particular IRQ is only used by the I2C
>> > Controller.  I'm not exactly sure that you're getting at?  Why do you
>> > think it should be shared?  You should only flag it as shared if it
>> > is.
>>
>> However, that's something the driver can't know.
>> Sharing interrupts is an integration property. The same IP core may share its
>> interrupt on one SoC, and not on another.
>
> I guess that would depend on the IP.  If this is part of an MFD, you'd
> know if you only hand a single interrupt line coming into the chip or
> not.  If the IP can be moved around (copy & pasted) into different
> chips, then yes, that might change.
>
> How does one share an interrupt with other drivers if all them don't
> know the IRQ is shared thought?

All drivers sharing the same interrupt must pass IRQF_SHARED, cfr. the
checks in __setup_irq().

Traditionally, PC (ISA) drivers didn't share interrupts, as the ISA bus
prohibited interrupt sharing.
Amiga drivers did.

New drivers should support IRQ sharing.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
