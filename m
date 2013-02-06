From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] i2c: davinci: update to devm_* API
Date: Wed, 06 Feb 2013 15:51:36 +0400
Message-ID: <511243C8.8060400@mvista.com>
References: <1360149736-32523-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360149736-32523-1-git-send-email-manishv.b-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 06-02-2013 15:22, Vishwanathrao Badarkhe, Manish wrote:

> Update the code to use devm_* API so that driver
> core will manage resources.

> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
> ---
> Changes since V1:
>    - Rebase on top of v3.8-rc6 of linus tree.
>    - Apply devm operation on clk_get.

> :100644 100644 6a0a553... da4e218... M	drivers/i2c/busses/i2c-davinci.c
>   drivers/i2c/busses/i2c-davinci.c |   45 +++++++++++---------------------------
>   1 files changed, 13 insertions(+), 32 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 6a0a553..da4e218 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
[...]
> @@ -699,22 +693,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>   		dev->pdata = &davinci_i2c_platform_data_default;
>   	}
>
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(dev->clk)) {
>   		r = -ENODEV;
>   		goto err_free_mem;
>   	}
>   	clk_prepare_enable(dev->clk);
>
> -	dev->base = ioremap(mem->start, resource_size(mem));
> +	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
>   	if (!dev->base) {
>   		r = -EBUSY;

    Comment to devm_request_and_ioremap() suggests returning -EADDRNOTAVAIL on 
failure. -EBUSY wasn't the right code even before this change, should have 
been -ENOMEM.

WBR, Sergei
