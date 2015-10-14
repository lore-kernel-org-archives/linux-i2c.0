From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 2/6] watchdog: Add support for Freescale Layerscape
 platforms
Date: Wed, 14 Oct 2015 07:06:33 -0700
Message-ID: <561E6169.2000509@roeck-us.net>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-3-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1444822498-16477-3-git-send-email-B48286@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Zhiqiang Hou <B48286@freescale.com>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, mark.rutland@arm.com
Cc: Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com, scottwood@freescale.com, bhupesh.sharma@freescale.com, leoli@freescale.com, wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net, mturquette@baylibre.com, sboyd@codeaurora.org, Wenbin.Song@freescale.com
List-Id: linux-i2c@vger.kernel.org

On 10/14/2015 04:34 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V3:
>   - No change.
>
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..448dbaf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
>
>   config IMX2_WDT
>   	tristate "IMX2+ Watchdog"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>   	select REGMAP_MMIO
>   	select WATCHDOG_CORE
>   	help
>

