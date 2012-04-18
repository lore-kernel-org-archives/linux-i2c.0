From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Wed, 18 Apr 2012 15:39:02 +0900
Message-ID: <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
	<CACRpkdbQRB37kYfCwn6+xUxBkVVo9f3RwUk5pstVPcfK8bivZw@mail.gmail.com>
	<CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg@mail.gmail.com>
	<20120417143901.GA22406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417143901.GA22406-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 17, 2012 at 11:39 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
>> >> From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>> >>
>> >> Turn off the clock and regulator to the I2C block using runtime
>> >> PM.
>> >>
>> >> Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
>> >> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>> >> Signed-off-by: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>> >> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >
>> > Dooks, are you OK with merging this patch now?
>>
>
> As I understood, Mark acked it? I didn't dive into the details, so it would be
> nice for me to have an ACK (or at least a not NACK) from Magnus.

I'm a bit hesitant to ack because the runtime suspend/resume callbacks
are used differently than we would do on arch/sh and
arch/arm/mach-shmobile. This difference may or may not be a good
thing. I'm afraid I know too little about the nomadik platform to say
anything wise. =)

Our drivers assume that the ->runtime_suspend() and ->runtime_resume()
callbacks are executed before/after the power is turned off/on for a
certain power domain. The way they are used in this patch more seems
like they are expected to be called regardless of the state of the
rest of the devices sharing the underlying power domain. You probably
want to control the clocks and the regulators directly - independently
of the rest of the devices.You may want to look into struct
gpd_dev_ops for various ways to interface to the pm domain code.

Exactly what is a good fit depends on how the underlying SoC code maps
the runtime pm clock and domain code to the actual hardware.

Cheers,

/ magnus
