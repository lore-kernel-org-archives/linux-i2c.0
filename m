From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Add support for 64bit system
Date: Tue, 15 Mar 2011 16:12:01 +0000
Message-ID: <20110315161201.GJ17460@trinity.fluff.org>
References: <1300204963-15855-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1300204963-15855-1-git-send-email-galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 15, 2011 at 11:02:43AM -0500, Kumar Gala wrote:
> Currently i2c-mpc supports 32bit system only, this modification makes it
> supported on both 32-bit and 64-bit systems.  The P5020 is the first
> 64-bit PPC system with the i2c-mpc controller.
> 
> Based in patch from Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Signed-off-by: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

ok, will add to -next

> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..107d5c2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -433,7 +433,7 @@ config I2C_IXP2000
>  
>  config I2C_MPC
>  	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
> -	depends on PPC32
> +	depends on PPC
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
> -- 
> 1.7.2.3
> 

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
