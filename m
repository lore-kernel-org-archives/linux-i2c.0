From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 5/6] i2c: designware: add SLAVE mode functions
Date: Fri, 09 Jun 2017 11:52:49 +0300
Message-ID: <1496998369.22624.68.camel@linux.intel.com>
References: <cover.1496942505.git.lolivei@synopsys.com>
         <434489944ec5de13e1ac4e8ad4ab161e22cb718c.1496942505.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <434489944ec5de13e1ac4e8ad4ab161e22cb718c.1496942505.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-06-08 at 18:36 +0100, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
> 
> All the SLAVE flow is added but it is not enabled via platform
> driver.

> +	} else {
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		stat = i2c_dw_read_clear_intrbits_slave(dev);
> +	}
> +

> +	//~ if (stat & DW_IC_INTR_TX_OVER)
> +		//~ dw_readl(dev, DW_IC_CLR_TX_OVER);

What is this?

> +
> +	return 1;
> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
