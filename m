From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 7/8] i2c: rk3x: add i2c support for rk3399 soc
Date: Thu, 12 May 2016 14:09:24 -0700
Message-ID: <CAD=FV=W1-DDtuLUzW1uLiFxuhpnmhnKB1od_yweY=WJ-4u3=kQ@mail.gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
	<1462908698-27284-1-git-send-email-david.wu@rock-chips.com>
	<CAD=FV=Uf-U3RBpgFbR3LkPAJTWqz3d02+H7iyA-SS-y=r3cXjA@mail.gmail.com>
	<5733D7AA.1060500@rock-chips.com>
	<57349C36.4030401@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57349C36.4030401-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Brian Norris <briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

David,

On Thu, May 12, 2016 at 8:07 AM, David.Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> I also found a subtle bug, it would clean the con register by use
> "i2c_writel(i2c, 0, REG_CON)" in rk3x_i2c_stop(). So i think it would be
> fixed by using read-modify-write way here in next version.

Good catch.  I look forward to the next version (maybe the last
version, since this series is looking really good).

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
