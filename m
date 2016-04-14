From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 10:24:56 +0200
Message-ID: <20160414082456.GK10108@pengutronix.de>
References: <1460619774.4294.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52255 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887AbcDNIY7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 04:24:59 -0400
Content-Disposition: inline
In-Reply-To: <1460619774.4294.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>

Hello Axel,

On Thu, Apr 14, 2016 at 03:42:54PM +0800, Axel Lin wrote:
> Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. =
The
> variable set here is later used as a divisor.

This is correct in principle. I thought it's ok to misbehave if the DT
is broken? In this case the current code is just fine.

Best regards
Uwe

> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-=
efm32.c
> index 8eff627..394c695 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -389,7 +389,7 @@ static int efm32_i2c_probe(struct platform_device=
 *pdev)
>  	ddata->location =3D location;
> =20
>  	ret =3D of_property_read_u32(np, "clock-frequency", &frequency);
> -	if (!ret) {
> +	if (!ret && frequency !=3D 0) {
>  		dev_dbg(&pdev->dev, "using frequency %u\n", frequency);
>  	} else {
>  		frequency =3D 100000;

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
