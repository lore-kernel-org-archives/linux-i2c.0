From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/15] ARM: ux500: Remove unused i2c platform_data
 initialisation code
Date: Thu, 10 May 2012 13:24:45 +0200
Message-ID: <CACRpkdbnXutBe=0Ng70BxTH3Qh87uyU=NO1f4U-8iZyPu2NvaQ@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
	<1336155805-18554-3-git-send-email-lee.jones@linaro.org>
	<CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
	<4FAA4576.1020106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FAA4576.1020106-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 9, 2012 at 12:22 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 09/05/12 09:46, Linus Walleij wrote:
>> So why not copy the contents of arch/arm/plat-nomadik/include/plat/i2c.h
>> into drivers/i2c/busses/i2c-nomadik.c and delete that header from
>> plat at the same time?
>>
>> Then there sure is no way for platforms to sneak in any platform
>> data any other way.
>
> I have no problem in doing that. Can I submit a separate patch?

Sure. Acked-by on this then...

Yours,
Linus Walleij
