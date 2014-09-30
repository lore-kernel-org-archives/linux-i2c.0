From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: hix5hd2: add devicetree documentation
Date: Tue, 30 Sep 2014 11:01:25 +0200
Message-ID: <2135291.ciFUCkAm4U@wuerfel>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org> <1411878129-19743-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411878129-19743-2-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 28 September 2014 12:22:07 Zhangfei Gao wrote:
> +
> +Required properties:
> +- compatible: Must be "hisilicon,hix5hd2-i2c"
> +  Specifically, the following versions of the chipset are supported:
> +         Hi3716CV200 (support six I2C module)
> +         Hi3719CV100 (support six I2C module)
> +         Hi3718CV100 (support six I2C module)
> +         Hi3719MV100 (support two I2C module)
> +         Hi3718MV100 (support two I2C module)
> 

How do you detect the specific model? Is there a hardware register that
lets you know the type?
If you have a device specific "compatible" string, you should list all
the known strings.

	Arnd
