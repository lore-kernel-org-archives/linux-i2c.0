From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
Date: Wed, 21 Oct 2015 18:56:44 -0700
Message-ID: <5628425C.5080104@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36832 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbbJVB4r (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 21:56:47 -0400
In-Reply-To: <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Le 20/10/2015 19:36, Jaedon Shin a =C3=A9crit :
> Add the necessary parenthesis for NOACK condition.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2=
c-brcmstb.c
> index 6b8bbf99880d..2d7d155029dc 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2=
c_dev *dev,
>  	}
> =20
>  	if ((CMD_RD || CMD_WR) &&
> -	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> +	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
>  		rc =3D -EREMOTEIO;
>  		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
>  			cmd_string[cmd]);
>=20


--=20
=46lorian
