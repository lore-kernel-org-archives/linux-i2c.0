From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 02/15] i2c: taos-evm: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 18:34:43 +0100
Message-ID: <20171031183443.060e93ab@endymion>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
        <20171031142149.32512-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51963 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753711AbdJaReq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 13:34:46 -0400
In-Reply-To: <20171031142149.32512-2-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>

On Tue, 31 Oct 2017 16:21:36 +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
> index addd90a8cb59..7c7fc01116a1 100644
> --- a/drivers/i2c/busses/i2c-taos-evm.c
> +++ b/drivers/i2c/busses/i2c-taos-evm.c
> @@ -282,8 +282,7 @@ static void taos_disconnect(struct serio *serio)
>  {
>  	struct taos_data *taos = serio_get_drvdata(serio);
>  
> -	if (taos->client)
> -		i2c_unregister_device(taos->client);
> +	i2c_unregister_device(taos->client);
>  	i2c_del_adapter(&taos->adapter);
>  	serio_close(serio);
>  	kfree(taos);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
