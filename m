From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 16:44:59 +0530
Message-ID: <53CF9933.8030908@gmail.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com> <20140723114834.411f6bb4@ipc1.ka-ro> <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b1778af62e7b42b39381fb2699b34eb1-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 07/23/2014 04:41 PM, Yao Yuan wrote:
> Hi,
>
> Thanks for your review.
>
> Lothar Wa=C3=9Fmann wrote:
>> Yuan Yao wrote:
>>> Add dma support for i2c. This function depend on DMA driver.
>>> You can turn on it by write both the dmas and dma-name properties i=
n dts node.
>>>
>>> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>> ---
>>>   drivers/i2c/busses/i2c-imx.c | 377
> [...]
>>> +
>>> +fail_rx:
>>> +	dma_release_channel(dma->chan_rx);
>>> +fail_tx:
>>> +	dma_release_channel(dma->chan_tx);
>>> +fail_al:
>>> +	devm_kfree(dev, dma);
>>>
>> No need for this one (that's the whole point of using devm_kzalloc()=
)!
>>
> When DMA request failed, I2C will switch to PIO mode. So if the faile=
d reason is just like DMA channel request failed. At this time the DMA =
should free by devm_kfree(). Is it?

If probe failed the memory will be freed automatically because
we are using devm_kzalloc()...

If we use devm_kzalloc() ,no need to free manually on fail...

--=20
Regards,
Varka Bhadram.
