From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: parport: fix spelling mistake: "Atmost" -> "At
 most"
Date: Mon, 27 Jan 2020 10:11:03 +0100
Message-ID: <20200127101103.111bac39@endymion>
References: <20200125202020.12861-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200125202020.12861-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 25 Jan 2020 20:20:20 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a module parameter description.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i2c/busses/i2c-parport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
> index f8f94a25af26..81eb441b2387 100644
> --- a/drivers/i2c/busses/i2c-parport.c
> +++ b/drivers/i2c/busses/i2c-parport.c
> @@ -129,7 +129,7 @@ static int parport[MAX_DEVICE] = {0, -1, -1, -1};
>  module_param_array(parport, int, NULL, 0);
>  MODULE_PARM_DESC(parport,
>  		 "List of parallel ports to bind to, by index.\n"
> -		 " Atmost " __stringify(MAX_DEVICE) " devices are supported.\n"
> +		 " At most " __stringify(MAX_DEVICE) " devices are supported.\n"
>  		 " Default is one device connected to parport0.\n"
>  );
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
