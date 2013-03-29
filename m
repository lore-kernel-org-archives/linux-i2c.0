From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V4] i2c: davinci: update to devm_* API
Date: Fri, 29 Mar 2013 12:17:09 +0100
Message-ID: <20130329111709.GA6359@the-dreams.de>
References: <1362483885-16561-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362483885-16561-1-git-send-email-manishv.b-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 05, 2013 at 05:14:45PM +0530, Vishwanathrao Badarkhe, Manish wrote:
> Update the code to use devm_* API so that driver
> core will manage resources.
> 
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>

Applied the following fix:

> +	dev->base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(dev->base)) {
> +		r = PTR_ERR(dev->base);
> +		dev_err(&pdev->dev, "I2C region already claimed\n");
> +		goto err_unuse_clocks;

No dev_err after devm_ioremap_resource. make coccicheck will tell you
about this.

Otherwise: Applied to for-next, thanks!
