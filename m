From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: Account for repeated start time requirement
Date: Thu, 18 Dec 2014 09:46:00 -0800
Message-ID: <CAD=FV=Vt3q_7g=SmnV5ZCd-Evr_17BTMR9LWsFax8qOwtkSw6Q@mail.gmail.com>
References: <1418325511-16648-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418325511-16648-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, yiwei cai <cyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Dec 11, 2014 at 11:18 AM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Rockchip I2C the controller drops SDA low in the repeated start
> condition at half the SCL high time.
>
> If we want to meet timing requirements, that means we need to hold SCL
> high for (4.7us * 2) when we're sending a repeated start (.6us * 2 for
> Fast-mode).  That lets us achieve minimum tSU;STA.  However, we don't
> want to always hold SCL high for that long because we'd never be able
> to make 100kHz or 400kHz speeds.
>
> Let's fix this by doing our clock calculations twice: once taking the
> above into account and once running at normal speeds.  We'll use the
> slower speed when sending the start bit and the normal speed
> otherwise.
>
> Note: we really only need the conservative timing when sending
> _repeated_ starts, not when sending the first start.  We don't account
> for this so technically the first start bit will be longer too.
> ...well, except in the case when we use the combined write/read
> optimization which doesn't use the same code.
>
> As part of this change we needed to account for the SDA falling time.
> The specification indicates that this should be the same, but we'll
> follow Designware and add a binding.  Note that we deviate from
> Designware and assign the default SDA falling time to be the same as
> the SCL falling time, which is incredibly likely.
>
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Note: This is based on Addy's patch (i2c: rk3x: fix bug that cause
> measured high_ns doesn't meet I2C specification) that can be found at
> <https://patchwork.kernel.org/patch/5475331/>.
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  7 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 90 +++++++++++++++++-----
>  2 files changed, 74 insertions(+), 23 deletions(-)

So apparently the person who tested this for me got mixed up and told
me it was good, but it wasn't.  :(

I've sent up a new version.  I've tested it myself this time but
certainly would appreciate any extra testing folks can do on it...
See <https://patchwork.kernel.org/patch/5515551/>

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
