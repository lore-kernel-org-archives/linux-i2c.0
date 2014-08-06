From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] i2c: i2c-imx: Fix format warning for dev_dbg
Date: Tue, 05 Aug 2014 20:09:57 -0700
Message-ID: <1407294597.31231.2.camel@joe-AO725>
References: <1407293685-7003-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407293685-7003-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, s.hauer@pengutronix.de, jg1.han@samsung.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, b35083@freescale.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-08-06 at 10:54 +0800, Xiubo Li wrote:
> drivers/i2c/busses/i2c-imx.c: In function i2c_imx_probe()
> drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 4 has type resource_size_t [-Wformat=]
>   dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
[]
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
[]
> @@ -687,9 +687,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
> -		res->start, res->end);
> +		(unsigned int)res->start, (unsigned int)res->end);

Probably better to use:

	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n, res);

>  	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
> -		resource_size(res), res->start);
> +		(unsigned int)resource_size(res), (unsigned int)res->start);

and remove this.
