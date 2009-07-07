From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Wed, 8 Jul 2009 00:19:38 +0100
Message-ID: <20090707231938.GA9907@fluff.org.uk>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1246920516-31462-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 06, 2009 at 03:48:34PM -0700, Kevin Hilman wrote:
> Here are a couple fixes for the i2c driver on the TI DaVinci family
> of SoCs.  These have been tested for awhile in the DaVinci git
> repo are needed for 2.6.31.
> 
> These apply on v2.6.31-rc2.

ok, do you have a git branch to pull, or should I apply
them from the mailing list>
 
> David Brownell (1):
>   i2c-davinci: behave with i2cdetect
> 
> Kevin Hilman (1):
>   i2c-davinci: convert clock usage after clkdev conversion
> 
>  drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
