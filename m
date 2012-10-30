From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
Date: Tue, 30 Oct 2012 18:50:03 +0300
Message-ID: <508FF72B.5080708@mvista.com>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351593581-19555-1-git-send-email-iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 10/30/2012 01:39 PM, Nobuhiro Iwamatsu wrote:

> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
> This validates to use mv64xxx in this SoC.

> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 65dd599..ff53cf4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -474,7 +474,7 @@ config I2C_MPC
>  
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
> -	depends on (MV64X60 || PLAT_ORION)
> +	depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)

  Could remove useless parens, while at it...

WBR, Sergei
