From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: fix platform driver probe rename
Date: Wed, 21 Oct 2015 12:27:29 +0300
Message-ID: <1445419649.22669.32.camel@linux.intel.com>
References: <4006973.dp9o3gm8C4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32438 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbJUJaH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 05:30:07 -0400
In-Reply-To: <4006973.dp9o3gm8C4@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2015-10-21 at 11:16 +0200, Arnd Bergmann wrote:
> A function rename was incomplete and missed the !CONFIG_PM
> case:
>=20
> i2c-designware-platdrv.c:340:13: error: 'dw_i2c_plat_prepare'
> undeclared here (not in a function)
> i2c-designware-platdrv.c:341:14: error: 'dw_i2c_plat_complete'
> undeclared here (not in a function)
>=20
> This renames the macros accordingly.

Jarkko sent this already couple hours ago.

>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6ad6fde3970c ("i2c: designware: Rename platform driver probe
> and PM functions")
> ---
> Found on ARM randconfig builds
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index f6b252a8ffd1..eb55760ccd9f 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -307,8 +307,8 @@ static void dw_i2c_plat_complete(struct device
> *dev)
> =C2=A0		pm_request_resume(dev);
> =C2=A0}
> =C2=A0#else
> -#define dw_i2c_prepare	NULL
> -#define dw_i2c_complete	NULL
> +#define dw_i2c_plat_prepare	NULL
> +#define dw_i2c_plat_complete	NULL
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_PM
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
