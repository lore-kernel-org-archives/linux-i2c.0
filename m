From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH AUTOSEL 4.18 39/59] i2c: omap: Enable for ARCH_K3
Date: Thu, 15 Nov 2018 10:05:02 +0530
Message-ID: <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
References: <20181114222335.99339-1-sashal@kernel.org>
 <20181114222335.99339-39-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181114222335.99339-39-sashal@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 15/11/18 3:53 AM, Sasha Levin wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> [ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
merged to mainline in v4.19. Since I don't see c77245722fb4 in
stable tree, please drop this commit from stable queues prior to v4.19
(4.18, 4.14, 4.9, 4.4 and 3.18).

> 
> Allow I2C_OMAP to be built for K3 platforms.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2ec87b1..fb3a3707a66e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -754,7 +754,7 @@ config I2C_OCORES
>  
>  config I2C_OMAP
>  	tristate "OMAP I2C adapter"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP || ARCH_K3
>  	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
>  	help
>  	  If you say yes to this option, support will be included for the
> 

-- 
Regards
Vignesh
