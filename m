From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-gpio: fix name issue when i2c gpio node GT
 1
Date: Mon, 15 Oct 2012 10:03:11 -0600
Message-ID: <507C33BF.6020604@wwwdotorg.org>
References: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350287477-30936-1-git-send-email-voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/15/2012 01:51 AM, Bo Shen wrote:
> When i2c-gpio node number is greater than 1, the name for each is same
> So add the patch to fix it.
> 
> The adap->name printing information is add by myself
> 
> without this patch the log information is as following
> ---<8---
> adap->name = i2c-gpio-1
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c-gpio-1
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
> 
> with this patch, the log information is as following
> ---<8---
> adap->name = i2c.2
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c.3
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---

I think this is reasonable, although I imagine this has zero effect on
the I2C bus number that's assigned to the device, so I'm not sure how it
interacts with or supports the other Atmel patch series you sent, which
I didn't really look at in much detail.

Reviewed-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
