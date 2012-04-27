From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
Date: Fri, 27 Apr 2012 11:27:16 -0400
Message-ID: <CAMiH66HVddWNBNpnSgDviOsYY0pg64wE+iyp2bzwrozJyGyY5g@mail.gmail.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
	<20378.25703.527491.719116@ipc1.ka-ro>
	<20120427132538.GU28063@b20223-02.ap.freescale.net>
	<20378.47000.131486.237752@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20378.47000.131486.237752-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2012 at 11:13 AM, Lothar Wa=C3=9Fmann <LW@karo-electron=
ics.de> wrote:
> Hi,
>
> Richard Zhao writes:
>> On Fri, Apr 27, 2012 at 11:18:31AM +0200, Lothar Wa=C3=9Fmann wrote:
>> > Hi,
>> >
>> > Richard Zhao writes:
>> > > device_prep_dma_cyclic may be call in audio trigger function whi=
ch is
>> > > atomic context, so we make it atomic too.
>> > >
>> > > =C2=A0- change channel0 lock to spinlock.
>> > > =C2=A0- Use polling to wait for channel0 finish running.
>> > >
>> > > Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
>> > >
>> > Actually I didn't sign off the patch that I posted, because I want=
ed
>> > to wait for more comments first.
>> I send it out with slight modifications because the series highly
>> depend on it. Will you take it over or let me put it in next version=
?
>> Both are ok to me.
>>
> I think you should keep it as part of your sound patches and I will
> test your final version on our hardware.
>
I hope we can get a conclusion that the prep_slave_sg() can be called
in atomic context or not.
My patch "add DMA support to UART" heavily depends on it.

Huang Shijie

>
> Lothar Wa=C3=9Fmann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
> ___________________________________________________________
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
