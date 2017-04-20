From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v8 5/6] i2c: designware: add SLAVE mode functions
Date: Thu, 20 Apr 2017 15:50:08 +0300
Message-ID: <47b60352-183b-0cf6-b8a6-7aea2fd2d111@linux.intel.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
 <fd93983d95d31974c917eab15221d675f08a50f6.1492014220.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:34585 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966455AbdDTMuN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 08:50:13 -0400
In-Reply-To: <fd93983d95d31974c917eab15221d675f08a50f6.1492014220.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 04/12/2017 07:47 PM, Luis Oliveira wrote:
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
> v7-v8
> - no changes
>
>  drivers/i2c/busses/Kconfig                 |  14 +-
>  drivers/i2c/busses/Makefile                |   1 +
>  drivers/i2c/busses/i2c-designware-common.c |   6 +
>  drivers/i2c/busses/i2c-designware-core.h   |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c  | 403 +++++++++++++++++++++++++++++
>  5 files changed, 425 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 144cbadc7c72..84efa57f90b3 100644
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

I didn't notice this before - is there reason to select I2C_SLAVE_EEPROM?

-- 
Jarkko
