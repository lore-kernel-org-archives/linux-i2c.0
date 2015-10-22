From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/9] i2c: brcmstb: fix typo in i2c-brcmstb
Date: Wed, 21 Oct 2015 18:56:24 -0700
Message-ID: <56284248.7040603@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-3-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35488 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbbJVB41 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 21:56:27 -0400
In-Reply-To: <1445395021-4204-3-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Le 20/10/2015 19:36, Jaedon Shin a =C3=A9crit :
> Fixes the "definitions" where it is spelled "defintions".
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2=
c-brcmstb.c
> index 8e9637eea512..6b8bbf99880d 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -41,7 +41,7 @@
>  #define BSC_CTL_REG_INT_EN_SHIFT			6
>  #define BSC_CTL_REG_DIV_CLK_MASK			0x00000080
> =20
> -/* BSC_IIC_ENABLE r/w enable and interrupt field defintions */
> +/* BSC_IIC_ENABLE r/w enable and interrupt field definitions */
>  #define BSC_IIC_EN_RESTART_MASK				0x00000040
>  #define BSC_IIC_EN_NOSTART_MASK				0x00000020
>  #define BSC_IIC_EN_NOSTOP_MASK				0x00000010
>=20


--=20
=46lorian
