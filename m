From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: core: fix wakeup irq parsing
Date: Thu, 12 Nov 2015 10:16:25 -0800
Message-ID: <20151112181625.GA8494@dtor-ws>
References: <1447335746-11114-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447335746-11114-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, "# v4 . 3" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 12, 2015 at 03:42:26PM +0200, Grygorii Strashko wrote:
> This patch fixes obvious copy-past error in wake up irq parsing
> code which leads to the fact that dev_pm_set_wake_irq() will
> be called with wrong IRQ number when "wakeup" IRQ is not
> defined in DT.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: <stable@vger.kernel.org> # v4.3
> Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup interrupt in device tree")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I wonder if we should change dev_pm_set_wake_irq and
dev_pm_set_dedicated_wake_irq to check if passed in IRQ is valid.

> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 040af5c..ba8eb08 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -715,7 +715,7 @@ static int i2c_device_probe(struct device *dev)
>  		if (wakeirq > 0 && wakeirq != client->irq)
>  			status = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
>  		else if (client->irq > 0)
> -			status = dev_pm_set_wake_irq(dev, wakeirq);
> +			status = dev_pm_set_wake_irq(dev, client->irq);
>  		else
>  			status = 0;
>  
> -- 
> 2.6.3
> 

-- 
Dmitry
