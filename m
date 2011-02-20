From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Sun, 20 Feb 2011 23:42:54 +0000
Message-ID: <20110220234254.GN15795@trinity.fluff.org>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4D5B10E3.5030208@fluff.org> <74CDBE0F657A3D45AFBB94109FB122FF03112A5345@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03112A5345-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 09:37:23AM -0800, Stephen Warren wrote:
> On 08/02/11 12:44, Mark Brown wrote:
> > ...
> > +		goto err_iounmap;
> > +	}
> > +	irq = res->start;
> > +
> > +	clk = clk_get(&pdev->dev, NULL);
> > +	if (!clk) {
> 
> This should be:
> 
> if (!IS_ERR(clk)) {
> 
> > +		ret = -ENOMEM;
> 
> This should probably be:
> 
> ret = PTR_ERR(clk);
> 
> although Ben made some comments in his review re: certain error codes being
> ignored by the higher layers; I'm not sure if that applies here or not.

at this point, we should probably print an error at-least. IIRC, it is
-ENODEV and possibly -EIO that get ignored, everything else should be
dealt with as an device-exists-but-is-not-working.
 
> > +		goto err_release_region;
> > +	}
> > +

thanks for spotting this one.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
