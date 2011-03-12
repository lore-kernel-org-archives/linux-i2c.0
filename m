From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 05/13] i2c-designware: split of i2c-designware.c into
 core and bus specific parts
Date: Sat, 12 Mar 2011 13:00:28 -0800
Message-ID: <20110312130028.8cf8973b.rdunlap@xenotime.net>
References: <1299961407-26852-1-git-send-email-dirk.brandewie@gmail.com>
	<1299961407-26852-6-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299961407-26852-6-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 12 Mar 2011 12:23:19 -0800 dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch splits i2c-designware.c into three pieces:
>      i2c-designware-core.c, contains the code that interacts directly
>      with the core.
> 
>      i2c-designware-platdrv.c, contains the code specific to the
>      platform driver using the core.
> 
>      i2c-designware-core.h contains the definitions and declareations
>      shared by i2c-designware-core.c and i2c-designware-platdrv.c.
> 
> This patch is the first in a set to allow multiple instances of the
> designware I2C core in the system.
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig                         |    6 +-
>  drivers/i2c/busses/Makefile                        |    3 +-
>  .../{i2c-designware.c => i2c-designware-core.c}    |  353 +-------------------
>  drivers/i2c/busses/i2c-designware-core.h           |  194 +++++++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c        |  199 +++++++++++
>  5 files changed, 412 insertions(+), 343 deletions(-)
>  rename drivers/i2c/busses/{i2c-designware.c => i2c-designware-core.c} (60%)
>  create mode 100644 drivers/i2c/busses/i2c-designware-core.h
>  create mode 100644 drivers/i2c/busses/i2c-designware-platdrv.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..35b5e6b 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -347,15 +347,15 @@ config I2C_DAVINCI
>  	  devices such as DaVinci NIC.
>  	  For details please see http://www.ti.com/davinci
>  
> -config I2C_DESIGNWARE
> -	tristate "Synopsys DesignWare"
> +config I2C_DESIGNWARE_PLATFORM
> +	tristate "Synopsys DesignWare Platfrom"

	                              Platform

>  	depends on HAVE_CLK
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  Synopsys DesignWare I2C adapter. Only master mode is supported.
>  
>  	  This driver can also be built as a module.  If so, the module
> -	  will be called i2c-designware.
> +	  will be called i2c-designware-platform.
>  
>  config I2C_GPIO
>  	tristate "GPIO-based bitbanging I2C"

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
