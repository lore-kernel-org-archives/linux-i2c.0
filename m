From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] i2c: tegra: Add i2c support
Date: Wed, 16 Feb 2011 09:37:23 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5345@HQMAIL01.nvidia.com>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4D5B10E3.5030208@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D5B10E3.5030208-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/02/11 12:44, Mark Brown wrote:
> ...
> +		goto err_iounmap;
> +	}
> +	irq = res->start;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (!clk) {

This should be:

if (!IS_ERR(clk)) {

> +		ret = -ENOMEM;

This should probably be:

ret = PTR_ERR(clk);

although Ben made some comments in his review re: certain error codes being
ignored by the higher layers; I'm not sure if that applies here or not.

> +		goto err_release_region;
> +	}
> +

-- 
nvpublic
