From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH 2/8] i2c: at91: add warning about transmission issues
 for some devices
Date: Mon, 3 Sep 2012 07:54:35 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC8F370@wm021.weinmann.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346404884-18451-3-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org'" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Cc: "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org'" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote on Friday, August 31, 2012 11:21 AM
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Some devices don't have clock streching in transmission mode. It can
> lead to premature stop sendings if the latency to write data in the
> transmission register is too long. In this case, prefer the i2c-gpio
> driver.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>

> ---
>  drivers/i2c/busses/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d9c4918..da77c37 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -300,6 +300,12 @@ config I2C_AT91
>  	  to support combined I2C messages.  Use the i2c-gpio driver
>  	  unless your system can cope with this limitation.
> 
> +	  Caution! at91rm9200, at91sam9261, at91sam9260, at91sam9263
> devices
> +	  don't have clock stretching in transmission mode. For that reason,
> +	  you can encounter underrun issues causing premature stop
> sendings if
> +	  the latency to fill the transmission register is too long. If you
> +	  are facing this situation, use the i2c-gpio driver.
> +
>  config I2C_AU1550
>  	tristate "Au1550/Au1200/Au1300 SMBus interface"
>  	depends on MIPS_ALCHEMY
> --
> 1.7.11.3
