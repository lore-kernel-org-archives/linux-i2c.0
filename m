From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] I2C-Octeon: Use common error handling code in
 octeon_i2c_probe()
Date: Wed, 25 Oct 2017 08:52:48 -0700
Message-ID: <77df0e64-bf30-b6d0-b28b-ddb3c0574dfe@caviumnetworks.com>
References: <73affb84-9cdd-9f5c-b96a-5a392739e789@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <73affb84-9cdd-9f5c-b96a-5a392739e789@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-i2c@vger.kernel.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 10/25/2017 02:52 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>

NAK.  We don't need any more Markus Elfring spam.


> Date: Wed, 25 Oct 2017 11:45:48 +0200
> 
> Add a jump target so that a specific error message is stored only once
> at the end of this function implementation.

Please read C standard about duplicate literal strings to see why this 
is a completely misleading and false statement.


> Replace two calls of the function "dev_err" by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/i2c/busses/i2c-octeon-platdrv.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
> index 64bda83e65ac..ac8a1099c523 100644
> --- a/drivers/i2c/busses/i2c-octeon-platdrv.c
> +++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
> @@ -207,10 +207,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>   		result = devm_request_irq(&pdev->dev, i2c->hlc_irq,
>   					  octeon_i2c_hlc_isr78, 0,
>   					  DRV_NAME, i2c);
> -		if (result < 0) {
> -			dev_err(i2c->dev, "failed to attach interrupt\n");
> -			goto out;
> -		}
> +		if (result < 0)
> +			goto report_failure;
>   	} else {
>   		i2c->int_enable = octeon_i2c_int_enable;
>   		i2c->int_disable = octeon_i2c_int_disable;
> @@ -220,10 +218,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>   
>   	result = devm_request_irq(&pdev->dev, i2c->irq,
>   				  octeon_i2c_isr, 0, DRV_NAME, i2c);
> -	if (result < 0) {
> -		dev_err(i2c->dev, "failed to attach interrupt\n");
> -		goto out;
> -	}
> +	if (result < 0)
> +		goto report_failure;
>   
>   	if (OCTEON_IS_MODEL(OCTEON_CN38XX))
>   		i2c->broken_irq_check = true;
> @@ -251,6 +247,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>   	dev_info(i2c->dev, "probed\n");
>   	return 0;
>   
> +report_failure:
> +	dev_err(i2c->dev, "failed to attach interrupt\n");
>   out:
>   	return result;
>   };
> 

