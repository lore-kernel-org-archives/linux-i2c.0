From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: sirf: add support for new SiRFmarco SMP SoC
Date: Thu, 24 Jan 2013 08:27:36 +0100
Message-ID: <20130124072736.GJ8364@nekote.pengutronix.de>
References: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
 <1356489017-17737-2-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1356489017-17737-2-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 26, 2012 at 10:30:17AM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> 
> the driver is also compatible with SiRFmarco except SiRFprimaII,
> so simply add "sirf,marco-i2c" to OF match table.
> 
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Why can't you use the existing compatible entry as a fallback like in:

	compatible = "sirf,marco-i2c", "sirf,prima2-i2c";
?

> ---
>  drivers/i2c/busses/i2c-sirf.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
> index 181d7c2..ed38b16 100644
> --- a/drivers/i2c/busses/i2c-sirf.c
> +++ b/drivers/i2c/busses/i2c-sirf.c
> @@ -439,6 +439,7 @@ static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
>  
>  static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
>  	{ .compatible = "sirf,prima2-i2c", },
> +	{ .compatible = "sirf,marco-i2c", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
> -- 
