From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Why isn't IRQ shared for i2c-ocore
Date: Fri, 8 May 2015 08:47:44 +0200
Message-ID: <CAMuHMdWXFmPWsL4QyjwV+X-mruS0pU2Uzj7aSSxTQDJ=K+32XA@mail.gmail.com>
References: <55304D8E.8070204@freescale.com>
	<55312AF7.7070504@freescale.com>
	<20150420064231.GE3447@x1>
	<55352839.70905@freescale.com>
	<20150420181651.GF3447@x1>
	<5535460B.2060309@freescale.com>
	<20150421073534.GK3447@x1>
	<554A8A8B.1020703@freescale.com>
	<20150507070149.GB3400@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150507070149.GB3400@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: York Sun <yorksun@freescale.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Linux I2C <linux-i2c@vger.kernel.org>, wolfram@the-dreams.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 7, 2015 at 9:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> I have a follow up question regarding interrupt. I see many I2C bus drivers
>> request interrupt with flag = 0. Why not using IRQF_SHARED?
>
> Probably because that particular IRQ is only used by the I2C
> Controller.  I'm not exactly sure that you're getting at?  Why do you
> think it should be shared?  You should only flag it as shared if it
> is.

However, that's something the driver can't know.
Sharing interrupts is an integration property. The same IP core may share its
interrupt on one SoC, and not on another.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
