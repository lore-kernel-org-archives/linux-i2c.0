From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Resend Patch 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
Date: Tue, 22 Apr 2014 14:45:10 +0300
Message-ID: <20140422114510.GM30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-10-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398147855-9868-10-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 22, 2014 at 02:24:15PM +0800, Lan Tianyu wrote:
> This patch is to add CONFIG_I2C_ACPI. Current there is a race between
> removing I2C ACPI operation region and ACPI AML code accessing.
> So make i2c core built-in if CONFIG_I2C_ACPI is set.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/i2c/Kconfig  | 17 ++++++++++++++++-
>  drivers/i2c/Makefile |  2 +-
>  include/linux/i2c.h  |  2 +-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 7b7ea32..c670d49 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -2,7 +2,9 @@
>  # I2C subsystem configuration
>  #
>  
> -menuconfig I2C
> +menu "I2C support"
> +
> +config I2C
>  	tristate "I2C support"
>  	select RT_MUTEXES
>  	---help---
> @@ -21,6 +23,17 @@ menuconfig I2C
>  	  This I2C support can also be built as a module.  If so, the module
>  	  will be called i2c-core.
>  
> +config I2C_ACPI
> +	bool "I2C ACPI support"
> +	select I2C
> +	depends on ACPI
> +	default y
> +	help
> +	  Say Y here if you want to enable I2C ACPI function. ACPI table
> +	  provides I2C slave devices' information to enumerate these devices.
> +	  This option also allows ACPI AML code to access I2C slave devices
> +	  via I2C ACPI operation region to fulfill ACPI method.
> +

I'm wondering, can we provide some sort of wrapper function from ACPI core
that is guaranteed to be built in to the kernel image and use it instead of
adding new Kconfig options?
