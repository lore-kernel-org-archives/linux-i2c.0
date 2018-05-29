From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 2/7] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 29 May 2018 16:27:48 -0700
Message-ID: <e7ca95e5-580b-d88d-ed22-09299c76ce8e@infradead.org>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On 05/29/2018 03:24 PM, Eddie James wrote:
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2e..ebba369 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1330,4 +1330,15 @@ config I2C_ZX2967
>  	  This driver can also be built as a module. If so, the module will be
>  	  called i2c-zx2967.
>  
> +config I2C_FSI
> +	tristate "FSI I2C driver"
> +	depends on FSI
> +	help
> +	  Driver for FSI bus attached I2C masters. These are I2C masters that
> +	  are connected to the system over a FSI bus, instead of the more

	                              over an FSI bus,

> +	  common PCI or MMIO interface.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called as i2c-fsi.
> +
>  endmenu


-- 
~Randy
