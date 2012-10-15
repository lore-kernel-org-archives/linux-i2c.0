From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-ocores: Use devm_request_and_ioremap()
Date: Mon, 15 Oct 2012 09:10:15 +0200
Message-ID: <20121015091015.2887fcb9@endymion.delvare>
References: <1344408872-1051-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344408872-1051-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Thierry,

On Wed,  8 Aug 2012 08:54:32 +0200, Thierry Reding wrote:
> Replacing the devm_request_mem_region() and devm_ioremap_nocache() calls
> by a single call to devm_request_and_ioremap() simplifies the code.
> 
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index bffd550..1fad4ae 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -283,18 +283,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>  	if (!i2c)
>  		return -ENOMEM;
>  
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "Memory region busy\n");
> -		return -EBUSY;
> -	}
> -
> -	i2c->base = devm_ioremap_nocache(&pdev->dev, res->start,
> -					 resource_size(res));
> -	if (!i2c->base) {
> -		dev_err(&pdev->dev, "Unable to map registers\n");
> -		return -EIO;
> -	}
> +	i2c->base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!i2c->base)
> +		return -EADDRNOTAVAIL;

I would suggest sticking to -EBUSY, AFAIK EADDRNOTAVAIL is for network
address errors.

>  
>  	pdata = pdev->dev.platform_data;
>  	if (pdata) {

-- 
Jean Delvare
