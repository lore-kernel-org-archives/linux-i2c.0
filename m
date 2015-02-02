From: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
Date: Mon, 2 Feb 2015 14:15:44 -0800
Message-ID: <CAL85gmD+0cJfZoWo8ujmjwy9yaKjNPjJaUm00Vrv5o9kcg-ozA@mail.gmail.com>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
	<1412726809-7525-5-git-send-email-fkan@apm.com>
	<1894616.4yY7dajl4R@wuerfel>
	<CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
	<20150130061118.GA995@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150130061118.GA995@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 29, 2015 at 10:11 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> > ctx->dev is probably the wrong device here. The i2c controller is not
>> > DMA capable itself, you need to have a pointer to the device that actually
>> > performs the DMA here.
>>
>> Arnd, I do agree this may not be the best identification. There is no
>> representation for this on the Linux side. I could put it as NULL. However,
>> there are other i2c bus drivers that seem to do the same thing. Please
>> let me know what you think.
>
> For completeness: Those drivers need fixing!
I have some doubts. I could hack up a dts node for the helper
processor that is doing the dma. However, the dma master could be
anything for that matter. I am not sure how I can write this in a
generic manner.
