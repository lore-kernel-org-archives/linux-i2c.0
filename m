From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/9] i2c: brcmstb: make the driver buildable on
 BMIPS_GENERIC
Date: Wed, 21 Oct 2015 18:56:16 -0700
Message-ID: <56284240.90405@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34754 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbbJVB4U (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 21:56:20 -0400
In-Reply-To: <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Le 20/10/2015 19:36, Jaedon Shin a =C3=A9crit :
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for
> I2C.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b86178e8fb..fd983c5b36f2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -394,7 +394,7 @@ config I2C_BCM_KONA
> =20
>  config I2C_BRCMSTB
>  	tristate "BRCM Settop I2C controller"
> -	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	default y
>  	help
>  	  If you say yes to this option, support will be included for the
>=20


--=20
=46lorian
