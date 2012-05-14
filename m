From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
Date: Mon, 14 May 2012 09:41:18 +0100
Message-ID: <4FB0C52E.9030109@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-7-git-send-email-lee.jones@linaro.org> <CACRpkdanG7KgYuZw29KwZe7wRp-AVZJ9n_hwBEZzf5gDAbGneg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdanG7KgYuZw29KwZe7wRp-AVZJ9n_hwBEZzf5gDAbGneg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09/05/12 13:20, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wrot=
e:
>
>> ab8500-i2c is used as core code to register the ab8500 device.
>> After allocating ab8500 memory, it immediately calls into
>> ab8500-core where the real initialisation takes place. This
>> patch moves all core registration and memory allocation into
>> the true ab8500-core file and removes ab8500-i2c completely.
>>
>> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This code is in a separate file for a reason:
>
> git checkout v2.6.37
> $ ls drivers/mfd/
> ab8500-core.c
> ab8500-debugfs.c
> ab8500-i2c.c
> ab8500-spi.c
>
> So the driver supports different backendsm and at one point
> there was both the SPI and "I2C" (actually PRCMU) backend.
>
> And the physical component has an SPI port as well.
>
> However nowadays it's not used, since the component is design to
> be used by the PRCMU I2C channel and nothing else, the SPI
> mode was just for prototyping and testing. On newer boards
> and the Snowball the SPI isn't even routed.
>
> (...)
> +static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data=
)
> +static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
>
> As you might have noticed, many people have been confused by
> the "i2c" naming of these things. Yes, there is physically an I2C
> carrying these out but in Linux terms that's just confusing, it's mix=
ing
> hardware and software terminology. Take this opportunity to
> rename them:
>
> static int ab8500_prcmu_write(struct ab8500 *ab8500, u16 addr, u8 dat=
a)
> static int ab8500_prcmu_read(struct ab8500 *ab8500, u16 addr)
>
> etc, so they have a meaningful name.

Again, something that I'm happy to do, and again something I'd like to=20
do as a separate patch (I'll create a patch-set with this and your othe=
r=20
'clean-up' requests if that's okay with you?)

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
