From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/5] i2c: Add STM32F4 I2C driver
Date: Mon, 12 Dec 2016 09:34:29 +0100
Message-ID: <CAOAejn0gH3t8NGLUELfB3nv-UM=Gtr04JtLqrm=SiYfPVbYv-g@mail.gmail.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-3-git-send-email-cedric.madianga@gmail.com> <20161211214232.GA2552@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161211214232.GA2552@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your comments.
I will fix all of them + build errors reported by build-bot in the V6.

Best regards,

Cedric Madianga

2016-12-11 22:42 GMT+01:00 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
> Hi,
>
>> +config I2C_STM32F4
>> +     tristate "STMicroelectronics STM32F4 I2C support"
>> +     depends on ARCH_STM32  || COMPILE_TEST
>
> Double space.
>
>> +#define STM32F4_I2C_MIN_FREQ         2
>> +#define STM32F4_I2C_MAX_FREQ         42
>
> Those two must be unsigned to fix the build error (e.g. 2U) reported by
> build-bot.
>
> Also, I get the following build warnings:
>
>   CC      drivers/i2c/busses/i2c-stm32f4.o
> drivers/i2c/busses/i2c-stm32f4.c: In function =E2=80=98stm32f4_i2c_handle=
_rx_addr=E2=80=99:
> drivers/i2c/busses/i2c-stm32f4.c:445:6: warning: variable =E2=80=98sr2=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>   u32 sr2;
>       ^~~
> drivers/i2c/busses/i2c-stm32f4.c: In function =E2=80=98stm32f4_i2c_isr_ev=
ent=E2=80=99:
> drivers/i2c/busses/i2c-stm32f4.c:496:41: warning: variable =E2=80=98sr2=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>   u32 real_status, possible_status, ien, sr2;
>
> I assume those are reads to clear the register, so we really don't need
> to save the value in a variable.
>
> Rest is looking good.
>
> Thanks,
>
>    Wolfram
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
