From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 1/2] i2c: designware: add SLAVE mode functions
Date: Tue, 27 Jun 2017 17:22:06 +0300
Message-ID: <1498573326.22624.196.camel@linux.intel.com>
References: <cover.1498126241.git.lolivei@synopsys.com>
         <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-06-22 at 11:17 +0100, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
> 
> All the SLAVE flow is added but it is not enabled via platform
> driver.

There are couple of nits, otherwise I'm okay with the patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> V11-v12
> - Changed ifdef condition in the Makefile fixed Kbuild error

+ rebased on top of latest i2c-next (drop applied patches effectively)

> +static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
> +{
> 

> +	dev_dbg(dev->dev,

> +		"%#x STAUTS SLAVE_ACTTVITY=%#x : RAW_INTR_STAT=%#x"
> +		" : INTR_STAT=%#x\n",

Don't split string literals.

> +		enabled, slave_activity, raw_stat, stat);


> +					dev_vdbg(dev->dev, "Byte %X
> acked!",
> +						 val);

I'm not sure it's any helpful.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
