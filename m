From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] eeprom: at24: use a common prefix for all symbols in
 at24.c
Date: Wed, 6 Dec 2017 12:03:49 +0100
Message-ID: <20171206110349.zjxadfdxgo5qcmex@pengutronix.de>
References: <20171206101926.14995-1-brgl@bgdev.pl>
 <20171206101926.14995-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36177 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754929AbdLFLDv (ORCPT
        <rfc822;linux-i2c@vger.kernel.ORG>); Wed, 6 Dec 2017 06:03:51 -0500
Content-Disposition: inline
In-Reply-To: <20171206101926.14995-3-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 06, 2017 at 11:19:26AM +0100, Bartosz Golaszewski wrote:
> There are a couple symbols defined in the driver source file which are
> missing the at24_ prefix. This patch fixes that.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2426f2c111c7..4ead21d0dcc5 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -93,17 +93,17 @@ struct at24_data {
>   *
>   * This value is forced to be a power of two so that writes align on pages.
>   */
> -static unsigned int io_limit = 128;
> -module_param(io_limit, uint, 0000);
> -MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
> +static unsigned int at24_io_limit = 128;
> +module_param(at24_io_limit, uint, 0000);
> +MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)");

You change the names of the module parameters here. I think this is not
a good idea as now you have to pass

	at24.at24_io_limit=...

on the kernel command line. If you still want this change, I think there
is some documentation that needs adaption, too.

Best regards
Uwe
 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
