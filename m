From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: at91: enable probe deferring on dma channel request
Date: Fri, 21 Nov 2014 16:03:34 +0100
Message-ID: <2530739.DkVu7IemRV@wuerfel>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com> <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416577472-24542-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 21 November 2014 14:44:32 Ludovic Desroches wrote:
> If dma controller is not probed, defer i2c probe.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---

Reviewed-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>


> 
> Arnd,
> 
> It's a combination of the first patch I sent and yours. As you said that my
> patch "looks wrong but actually it's ok" I didn't dare to add your
> signed-off-by.

I think a good way to deal with this is to explain in the patch description
who wrote what part.

	Arnd
