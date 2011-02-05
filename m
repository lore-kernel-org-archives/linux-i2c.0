From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 02/10] i2c-designware: split of i2c-designware.c into
	core and bus specific parts
Date: Sat, 5 Feb 2011 17:45:07 +0000
Message-ID: <20110205174507.GH15795@trinity.fluff.org>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com> <1296699608-13227-3-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1296699608-13227-3-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 02, 2011 at 06:20:00PM -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch splits i2c-designware.c into a core library and associated
> header file and two bus specific parts for platform bus and PCI bus.

not a library, it is a driver card.
 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig                  |   15 +-
>  drivers/i2c/busses/Makefile                 |    5 +-
>  drivers/i2c/busses/i2c-designware-core.c    |  563 +++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h    |  194 ++++++
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |  199 ++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  199 ++++++
>  drivers/i2c/busses/i2c-designware.c         |  884 ---------------------------
>  7 files changed, 1171 insertions(+), 888 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-core.c
>  create mode 100644 drivers/i2c/busses/i2c-designware-core.h
>  create mode 100644 drivers/i2c/busses/i2c-designware-pcidrv.c
>  create mode 100644 drivers/i2c/busses/i2c-designware-platdrv.c
>  delete mode 100644 drivers/i2c/busses/i2c-designware.c

what happens when you use 'rename' detection when submitting?
 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..a815606 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -347,15 +347,24 @@ config I2C_DAVINCI
>  	  devices such as DaVinci NIC.
>  	  For details please see http://www.ti.com/davinci
>  
> -config I2C_DESIGNWARE
> -	tristate "Synopsys DesignWare"
> +config I2C_DESIGNWARE_PLATFORM
> +	tristate "Synopsys DesignWare Platfrom"
>  	depends on HAVE_CLK
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  Synopsys DesignWare I2C adapter. Only master mode is supported.
>  
>  	  This driver can also be built as a module.  If so, the module
> -	  will be called i2c-designware.
> +	  will be called i2c-designware-platform.

not so happy about change in module name.

> +config I2C_DESIGNWARE_PCI
> +	tristate "Synopsys DesignWare PCI"
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Synopsys DesignWare I2C adapter. Only master mode is supported.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-designware-pci.
>  
>  config I2C_GPIO
>  	tristate "GPIO-based bitbanging I2C"

snipped the rest, assuming the rest is just moves.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
