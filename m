From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] i2c: hix5hd2: add i2c controller driver
Date: Mon, 29 Sep 2014 20:49:22 +0800
Message-ID: <54295552.2020501@linaro.org>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org> <1411878129-19743-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411878129-19743-3-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 09/28/2014 12:22 PM, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>
> Signed-off-by: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/i2c/busses/Kconfig       |   10 +
>   drivers/i2c/busses/Makefile      |    1 +
>   drivers/i2c/busses/i2c-hix5hd2.c |  554 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 565 insertions(+)
>   create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..ba0f43c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -77,6 +77,16 @@ config I2C_AMD8111
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-amd8111.
>
> +config I2C_HIX5HD2
> +	tristate "Hix5hd2 high-speed I2C driver"
> +	depends on ARCH_HIX5HD2

Would like to remove the dependence in next version to enable compile-test.
The commit 4c255791ffd6410f ("asm-generic: io: implement relaxed 
accessor macros as conditional wrappers") adds wrappers to asm-generic 
of {read,write}{b,w,l,q}_relaxed.

Thanks
