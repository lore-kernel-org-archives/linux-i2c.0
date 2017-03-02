From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RESEND PATCH v6 4/6] i2c: designware: introducing I2C_SLAVE
 definitions
Date: Thu, 2 Mar 2017 15:46:48 +0200
Message-ID: <3a84bb00-ab25-e36f-5552-0d4232c60e36@linux.intel.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <01815bce74cdb525f45d4088648b11dcc48da040.1488383202.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01815bce74cdb525f45d4088648b11dcc48da040.1488383202.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 03/01/17 17:59, Luis Oliveira wrote:
> - Definitions were added to core library
> - A example was added to designware-core.txt Documentation that shows
>   how the slave can be setup using DTS
>
> SLAVE related definitions were added to the core of the controller.
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> V5->V6
> - Included an example of use in the device tree binding document
> (with the RESEND)
> - Removed the i2c-designware.txt binding leading 0 to add the Rob
>   Herring ack.
>
>  .../devicetree/bindings/i2c/i2c-designware.txt     | 16 +++++++++-
>  drivers/i2c/busses/i2c-designware-core.h           | 35 ++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 3 deletions(-)
>
...
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index 35d7264d9e3a..b620d76ffc8d 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -1,5 +1,5 @@
...
> @@ -196,7 +221,11 @@
>   * @acquire_lock: function to acquire a hardware lock on the bus
>   * @release_lock: function to release a hardware lock on the bus
>   * @pm_runtime_disabled: true if pm runtime is disabled
> - *
> + * @dynamic_tar_update_enabled: true if dynamic TAR update is enabled
> + * @disable: function to disable the controller
> + * @disable_int: function to disable all interrupts
> + * @init: function to initialize the I2C hardware
> + * @mode: operation mode - I2C slave or I2C master
>   * HCNT and LCNT parameters can be used if the platform knows more accurate
>   * values than the one computed based only on the input clock frequency.
>   * Leave them to be %0 if not used.
> @@ -206,6 +235,7 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct i2c_client		*slave;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
>  	struct dw_pci_controller *controller;
>  	int			cmd_err;
> @@ -225,6 +255,7 @@ struct dw_i2c_dev {
>  	struct i2c_adapter	adapter;
>  	u32			functionality;
>  	u32			master_cfg;
> +	u32			slave_cfg;
>  	unsigned int		tx_fifo_depth;
>  	unsigned int		rx_fifo_depth;
>  	int			rx_outstanding;

You should add comments for "slave" and "slave_cfg" since they are added 
here and move comments for other members variables to patches 3/6 and 
5/6 where they are added.

-- 
Jarkko
