From: Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [RESEND][PATCH 1/2] i2c: versatile: Allow compile test build
Date: Mon, 11 Jul 2016 09:44:57 +0100
Message-ID: <20160711084457.GI8609@e106497-lin.cambridge.arm.com>
References: <1468042283.21863.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51377 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030542AbcGKIo7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 11 Jul 2016 04:44:59 -0400
Content-Disposition: inline
In-Reply-To: <1468042283.21863.2.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org

On Sat, Jul 09, 2016 at 01:31:23PM +0800, Axel Lin wrote:
> There is no build dependency for this driver, so enable COMPILE_TEST =
to get
> better build coverage.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

=46or the whole series:

Tested-and-acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks,
Liviu

> ---
> Resend with CC VE maintainers.
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index faa8e68..6e0bba0 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -924,7 +924,7 @@ config I2C_UNIPHIER_F
> =20
>  config I2C_VERSATILE
>  	tristate "ARM Versatile/Realview I2C bus support"
> -	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
> +	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMP=
ILE_TEST
>  	select I2C_ALGOBIT
>  	help
>  	  Say yes if you want to support the I2C serial bus on ARMs Versati=
le
> --=20
> 2.5.0
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
