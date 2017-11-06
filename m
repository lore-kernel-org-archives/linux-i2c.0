From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: i2c-tools: i2cbusses: Avoid buffer overflows in sysfs paths
Date: Mon, 6 Nov 2017 13:04:26 +0100
Message-ID: <20171106120426.lyo6azbrxxok4gan@pengutronix.de>
References: <20171031081604.18a9ca54@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52613 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752362AbdKFME2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Nov 2017 07:04:28 -0500
Content-Disposition: inline
In-Reply-To: <20171031081604.18a9ca54@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

Hello Jean,

On Tue, Oct 31, 2017 at 08:16:04AM +0100, Jean Delvare wrote:
> sprintf isn't safe, use snprintf instead.
> ---
>  tools/i2cbusses.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/tools/i2cbusses.c
> +++ b/tools/i2cbusses.c
> @@ -220,18 +220,18 @@ struct i2c_adap *gather_i2c_busses(void)
>  
>  		/* this should work for kernels 2.6.5 or higher and */
>  		/* is preferred because is unambiguous */
> -		sprintf(n, "%s/%s/name", sysfs, de->d_name);
> +		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);

OK, now instead of running in a buffer overflow in sprintf you might
call fopen with a partial (maybe unterminated?) filename. While this is
definitively better, you should check the return value of snprintf to be
completely safe here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
