From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/3] Blackfin I2C updates for 2.6.31
Date: Mon, 1 Jun 2009 23:49:49 +0100
Message-ID: <20090601224949.GA18453@fluff.org.uk>
References: <1243405210-26227-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243405210-26227-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 27, 2009 at 02:20:07AM -0400, Mike Frysinger wrote:
> Fixes for bugs in the Blackfin on-chip I2C controller.

do you have somewhere I can pull this from (with the corrections
from review)?
 
> Frank Shew (1):
>   Blackfin I2C/TWI Drivers: fix bug - not work well on BF537
> 
> Michael Hennerich (1):
>   Blackfin I2C/TWI Driver: make sure we don't end up with a CLKDIV=0
> 
> Sonic Zhang (1):
>   Blackfin I2C TWI Driver: fix bug - REPEAT START mode doesn't repeat
> 
>  drivers/i2c/busses/Kconfig        |    2 +-
>  drivers/i2c/busses/i2c-bfin-twi.c |   47 +++++++++++++++++++++++-------------
>  2 files changed, 31 insertions(+), 18 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
