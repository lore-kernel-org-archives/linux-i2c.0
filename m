From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Tue, 20 Apr 2010 01:06:21 +0100
Message-ID: <20100420000621.GK32401@fluff.org.uk>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1270575738-22388-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
> This series of davinci I2C driver updates and fixes is targetted for
> 2.6.35.  It has been tested in davinci git on multiple davinci SoCs.
> 
> Ben, since these changes are isolated to the davinci driver only, if
> you prefer I can merge them upstream along with my davinci changes for
> 2.6.35.  

I'll get them into -next when I rebase it. The first in the series
could be a -rc candidate as it looks like a useful bugfix?
 
> This series is based on v2.6.34-rc3
> 
> Chaithrika U S (4):
>   i2c: davinci: misc. cleanups: remove MOD_REG_BIT and IO_ADDRESS usage
>   i2c: davinci: Add helper functions for power management
>   i2c: davinci: Add suspend/resume support
>   i2c: davinci: Add cpufreq support
> 
> Dirk Behme (1):
>   i2c: davinci: Fix smbus Oops with AIC33 usage
> 
> Philby John (1):
>   i2c: davinci: bus recovery procedure to clear the bus
> 
>  drivers/i2c/busses/i2c-davinci.c |  314 ++++++++++++++++++++++++++++++--------
>  1 files changed, 251 insertions(+), 63 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
