From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 02/28] Remove OF_I2C
Date: Sun, 09 Feb 2014 20:58:54 +0100
Message-ID: <1391975934.25855.14.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
	 <1391971686-9517-3-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391971686-9517-3-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Wolfram Sang <wsa@the-dreams.de>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed031..de17c55 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -387,7 +387,7 @@ config I2C_CBUS_GPIO
>  
>  config I2C_CPM
>  	tristate "Freescale CPM1 or CPM2 (MPC8xx/826x)"
> -	depends on (CPM1 || CPM2) && OF_I2C
> +	depends on CPM1 || CPM2
>  	help
>  	  This supports the use of the I2C interface on Freescale
>  	  processors with CPM1 or CPM2.

This needs testing. Since when is OF_I2C orphaned? Ie, when was the last
time it was possible to set I2C_CPM?


Paul Bolle
