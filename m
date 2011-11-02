From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Wed, 2 Nov 2011 10:52:10 +0000
Message-ID: <20111102105210.GZ19187@n2100.arm.linux.org.uk>
References: <1320228610-18129-1-git-send-email-Barry.Song@csr.com> <20111102103904.GB4937@totoro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111102103904.GB4937@totoro>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 02, 2011 at 10:39:04AM +0000, Jamie Iles wrote:
> > +	clk = clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(clk)) {
> > +		err = PTR_ERR(clk);
> > +		dev_err(&pdev->dev, "Clock get failed\n");
> > +		goto out;
> > +	}
> > +
> > +	clk_enable(clk);
> 
> The return value of clk_enable() should really be checked.

Now that the clk_prepare() patch has been enabled, new drivers should be
written assuming that clk_prepare() will be necessary before clk_enable().

And one may query why it's not possible to use clk_enable()...clk_disable()
around the transfer itself, so the clock can be turned off while the device
is idle.  Obviously if its expecting to be operated in slave mode as well
then you may need to keep the clock enabled.
