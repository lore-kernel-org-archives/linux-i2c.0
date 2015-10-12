From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] i2c: return probe deferred status on
 dev_pm_domain_attach
Date: Mon, 12 Oct 2015 14:01:04 -0700
Message-ID: <20151012210104.GC4010@dtor-ws>
References: <1444683283-32460-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444683283-32460-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 12, 2015 at 09:54:43PM +0100, Kieran Bingham wrote:
> A change of return status was introduced in commit 3fffd1283927
> ("i2c: allow specifying separate wakeup interrupt in device tree")
> 
> The commit prevents the defer status being passed up the call stack
> appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.
> 
> Catch the PROBE_DEFER and clear up the IRQ wakeup status
> 
> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
> Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree")

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> ---
> V2:
>  Fall through the error path before returning -EPROBE_DEFER
> 
> V3:
>  Drop the if/else for cleaner code path
> 
>  drivers/i2c/i2c-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5f89f1e3c2f2..a59c3111f7fb 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -694,12 +694,12 @@ static int i2c_device_probe(struct device *dev)
>  		goto err_clear_wakeup_irq;
>  
>  	status = dev_pm_domain_attach(&client->dev, true);
> -	if (status != -EPROBE_DEFER) {
> -		status = driver->probe(client, i2c_match_id(driver->id_table,
> -					client));
> -		if (status)
> -			goto err_detach_pm_domain;
> -	}
> +	if (status == -EPROBE_DEFER)
> +		goto err_clear_wakeup_irq;
> +
> +	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> +	if (status)
> +		goto err_detach_pm_domain;
>  
>  	return 0;
>  
> -- 
> 2.1.4
> 

-- 
Dmitry
