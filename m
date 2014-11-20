From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6] i2c: rk3x: handle dynamic clock rate changes correctly
Date: Wed, 19 Nov 2014 22:16:23 -0800
Message-ID: <CAD=FV=VFCfvoi=ef6uD40Q385MonBikJD2cgAD3mwXt+kOyctg@mail.gmail.com>
References: <5274716.Gef1fPceY6@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5274716.Gef1fPceY6@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Max,

On Tue, Nov 18, 2014 at 3:18 PM, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> -static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
> -                              unsigned long *div_low, unsigned long *div_high)
> +/**
> + * Calculate divider values for desired SCL frequency
> + *
> + * @clk_rate: I2C input clock rate
> + * @scl_rate: Desired SCL rate
> + * @div_low: Divider output for low
> + * @div_high: Divider output for high
> + *
> + * Returns: 0 on success, -EINVAL on unreachable SCL rate. In that case
> + * a best-effort divider value is returned in divs.

I don't think it's returning a best-effort divider with your current
pach.  It will return an error and leave the "div_high" or "div_low"
as some value > 0xffff.

I'll also note that your patch doesn't fix the bug in the old code
that a divider of 0xffff exactly is considered an error.

I kinda doubt that anyone ever trips this condition, but I figured I'd
mention it.

-Doug
