From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/2] support hisilicon i2c
Date: Mon, 5 Aug 2013 10:13:14 +0800
Message-ID: <CAMj5BkjMw2oxWy5+fgT9hoHLT-DiSv6u7zSzAhi8B_d-=-v8Vw@mail.gmail.com>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374844938-25505-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 26, 2013 at 9:22 PM, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> V4:
> rebase on 3.11
>
> v3:
> patch 02, use size instead of threshold
>
> v2:
> Suggested by Baruch
> Support hisilicon i2c in i2c-designware-platdrv.c, and adding two optional properties
>
> Zhangfei Gao (2):
>   i2c: designware: use module_platform_driver
>   i2c: designware: add two optional property tx/rx-fifo-size
>
>  .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c        |   17 +++++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>

"Basically OK, but please resend for 3.12, so we get enough testing
before entering mainline. I am a bit anxious of side
effects and 3.11 is too near."

Dear Wolfram

The patches are rebased on 3.11 rc2 as your suggestion,
Do you have any other suggestion?

Thanks
