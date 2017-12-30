From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: mux: reg: don't log an error for probe deferral
Date: Sat, 30 Dec 2017 23:08:13 +0100
Message-ID: <3bc5094c-f8e5-bb69-37dd-de61ce70d8f7@axentia.se>
References: <20171218161839.14821-1-alexander.sverdlin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00112.outbound.protection.outlook.com ([40.107.0.112]:20064
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750828AbdL3WIc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 17:08:32 -0500
In-Reply-To: <20171218161839.14821-1-alexander.sverdlin@nokia.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, linux-i2c@vger.kernel.org
Cc: Tomasz Bachorski <tomasz.bachorski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>

On 2017-12-18 17:18, Alexander Sverdlin wrote:
> From: Tomasz Bachorski <tomasz.bachorski@nokia.com>
> 
> It's possible that i2c_mux_reg_probe_dt() could return -EPROBE_DEFER.
> In that case, driver will request a probe deferral and an error
> suggesting device tree parsing problem will be reported. This is
> a pretty confusing information. Let's change the error handling,
> so driver will be able to request probe deferral without logging
> not related errors.
> 
> Signed-off-by: Tomasz Bachorski <tomasz.bachorski@nokia.com>

Patch applied to i2c-mux/for-next, thanks!

Cheers,
Peter

> ---
>  drivers/i2c/muxes/i2c-mux-reg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
> index f6c9c3dc6cad..c948e5a4cb04 100644
> --- a/drivers/i2c/muxes/i2c-mux-reg.c
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c
> @@ -177,6 +177,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
>  			sizeof(mux->data));
>  	} else {
>  		ret = i2c_mux_reg_probe_dt(mux, pdev);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Error parsing device tree");
>  			return ret;
> 
