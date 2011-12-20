From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers
	driver
Date: Tue, 20 Dec 2011 20:07:50 +0000
Message-ID: <20111220200750.GA2577@n2100.arm.linux.org.uk>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323852927-13521-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	err = clk_prepare(clk);
> +	err = clk_enable(clk);
...
> +	clk_disable(clk);
> +
> +	dev_info(&pdev->dev, " I2C adapter ready to operate\n");
> +
> +	return 0;
> +}
> +
> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
> +{
> +	clk_disable(siic->clk);
> +	clk_unprepare(siic->clk);
> +	clk_put(siic->clk);

This doesn't look right - look at the state which you leave the clk in
upon successful probe, and now look at what you do when you do a remove.

It seems that you disable an already disabled clock to me.
