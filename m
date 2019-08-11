From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Sun, 11 Aug 2019 06:40:11 +0200
Message-ID: <b3ea72a6-1d5a-4d9a-142f-ab0b6acbb157@enpas.org>
References: <20190811043253.24938-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190811043253.24938-1-max@enpas.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/11/2019 06:32 AM, Max Staudt wrote:
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1300,6 +1300,17 @@ config I2C_ELEKTOR
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-elektor.
>  
> +config I2C_ICY
> +	tristate "ICY Zorro card"
> +	depends on ZORRO && BROKEN_ON_SMP
> +	select I2C_ALGOPCF


I forgot to remove BROKEN_ON_SMP - I see no reason why this would be the case with the polling-only driver as it is now.


Max
