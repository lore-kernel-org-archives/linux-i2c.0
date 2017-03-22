From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v7 5/6] i2c: designware: add SLAVE mode functions
Date: Wed, 22 Mar 2017 17:02:04 +0200
Message-ID: <16a4f45c-d536-6a0a-6bc3-38eb54817c03@linux.intel.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
 <6cc329a6ceeaf88412bb956986df1c9e3d95bccb.1490007620.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62984 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760665AbdCVPCK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 22 Mar 2017 11:02:10 -0400
In-Reply-To: <6cc329a6ceeaf88412bb956986df1c9e3d95bccb.1490007620.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 03/20/17 13:10, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
>
> All the SLAVE flow is added but it is not enabled via platform
> driver.
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> v6-v7
> - changed error description in [ABRT_SLAVE_RD_INTX]. @Jarkko
> - moved "bool mode;" comment/description to this patch
>
>  drivers/i2c/busses/Kconfig                 |  14 +-
>  drivers/i2c/busses/Makefile                |   1 +
>  drivers/i2c/busses/i2c-designware-common.c |   6 +
>  drivers/i2c/busses/i2c-designware-core.h   |   4 +
>  drivers/i2c/busses/i2c-designware-slave.c  | 403 +++++++++++++++++++++++++++++
>  5 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8adc0f1d7ad0..f23575da67fd 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -474,11 +474,23 @@ config I2C_DESIGNWARE_PLATFORM
>  	depends on (ACPI && COMMON_CLK) || !ACPI
>  	help
>  	  If you say yes to this option, support will be included for the
> -	  Synopsys DesignWare I2C adapter. Only master mode is supported.
> +	  Synopsys DesignWare I2C adapter.
>
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-designware-platform.
>
> +config I2C_DESIGNWARE_SLAVE
> +	bool "Synopsys DesignWare Slave"
> +	select I2C_SLAVE
> +	select I2C_SLAVE_EEPROM
> +	depends on I2C_DESIGNWARE_PLATFORM
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Synopsys DesignWare I2C slave adapter.
> +
> +	  This is not a standalone module, this module compiles together with
> +	  i2c-designware-core.
> +
>  config I2C_DESIGNWARE_PCI
>  	tristate "Synopsys DesignWare PCI"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index c89a4314c563..678cf6f4a552 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>  obj-$(CONFIG_I2C_DESIGNWARE_CORE)	+= i2c-designware-core.o
>  i2c-designware-core-objs := i2c-designware-common.o i2c-designware-master.o
> +i2c-designware-core-$(CONFIG_I2C_DESIGNWARE_SLAVE) += i2c-designware-slave.o
>  obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
>  i2c-designware-platform-objs := i2c-designware-platdrv.o
>  i2c-designware-platform-$(CONFIG_I2C_DESIGNWARE_BAYTRAIL) += i2c-designware-baytrail.o
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 6357c7c78f6d..5cc089ad9e19 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -56,6 +56,12 @@ static char *abort_sources[] = {
>  		"trying to use disabled adapter",
>  	[ARB_LOST] =
>  		"lost arbitration",
> +	[ABRT_SLAVE_FLUSH_TXFIFO] =
> +		"read command so flush old data in the TX FIFO",
> +	[ABRT_SLAVE_ARBLOST] =
> +		"slave lost the bus while transmitting data to a remote master",
> +	[ABRT_SLAVE_RD_INTX] =
> +		"incorrect slave-transmitter mode configuration",
>  };
>
>  u32 dw_readl(struct dw_i2c_dev *dev, int offset)
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index 33087e640f69..08072dbe0ff4 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -225,6 +225,7 @@
>   * @disable: function to disable the controller
>   * @disable_int: function to disable all interrupts
>   * @init: function to initialize the I2C hardware
> + * @mode: operation mode - I2C slave or I2C master
>   *
>   * HCNT and LCNT parameters can be used if the platform knows more accurate
>   * values than the one computed based only on the input clock frequency.
> @@ -278,6 +279,7 @@ struct dw_i2c_dev {
>  	void			(*disable)(struct dw_i2c_dev *dev);
>  	void			(*disable_int)(struct dw_i2c_dev *dev);
>  	int			(*init)(struct dw_i2c_dev *dev);
> +	bool			mode;
>  };
>
"bool mode" is not self explaining. Let it either be int which then get 
value DW_IC_MASTER or DW_IC_SLAVE or use "bool master" or "bool slave" 
with boolean value. Should actually move to patch 6/6 as it's used there.

-- 
Jarkko
