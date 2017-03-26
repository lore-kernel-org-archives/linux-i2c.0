From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Re: [PATCH v4 1/4] i2c: designware: wait for disable/enable only if
 necessary
Date: Sun, 26 Mar 2017 20:44:59 +0100
Message-ID: <20170326194459.GB4209@dell-m4800.Home>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
 <1471990736-30190-2-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471990736-30190-2-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-i2c@vger.kernel.org, Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 23, 2016 at 07:18:53PM -0300, Lucas De Marchi wrote:
> From: José Roberto de Souza <jose.souza@intel.com>
> 
> If we aren't going to continue using the controller we can just disable
> it instead of waiting for it to complete. The biggest improvement here
> is when a I2C transaction is completed and it doesn't block until
> the adapter is disabled. When a new transfer is needed we will disable
> and wait for its completion.
> 
> This way the adapter will continue changing its state in parallel to the
> execution of the thread that requested the I2C transaction saving most
> of the time 25~250 usec per I2C transaction.
> 
> A simple program doing a register read (1 byte write, 1 byte read)
> alternating on 2 different slaves repeated 25k times for each and
> measurements taken 4 times we get:
> 
> perf stat -r4 chrt -f 10 ./i2c-test /dev/i2c-1 25000 0x40 0x6 0x1e 0x00
> 
> Before:
> 	30.879317977 seconds time elapsed                 ( +- 14.83% )
> After:
> 	8.638705161 seconds time elapsed                  ( +-  5.90% )
> 
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 99b54be..2c61585 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -252,10 +252,15 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
>  
>  static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>  {
> +	dw_writel(dev, enable, DW_IC_ENABLE);
> +}
> +
> +static void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable)
> +{
>  	int timeout = 100;
>  
>  	do {
> -		dw_writel(dev, enable, DW_IC_ENABLE);
> +		__i2c_dw_enable(dev, enable);
>  		if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
>  			return;
>  
> @@ -321,7 +326,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	}
>  
>  	/* Disable the adapter */
> -	__i2c_dw_enable(dev, false);
> +	__i2c_dw_enable_and_wait(dev, false);
>  
>  	/* set standard and fast speed deviders for high/low periods */
>  
> @@ -414,7 +419,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  	u32 ic_con, ic_tar = 0;
>  
>  	/* Disable the adapter */
> -	__i2c_dw_enable(dev, false);
> +	__i2c_dw_enable_and_wait(dev, false);
>  
>  	/* if the slave address is ten bit address, enable 10BITADDR */
>  	ic_con = dw_readl(dev, DW_IC_CON);
> @@ -833,7 +838,7 @@ tx_aborted:
>  void i2c_dw_disable(struct dw_i2c_dev *dev)
>  {
>  	/* Disable controller */
> -	__i2c_dw_enable(dev, false);
> +	__i2c_dw_enable_and_wait(dev, false);
>  
>  	/* Disable all interupts */
>  	dw_writel(dev, 0, DW_IC_INTR_MASK);
> -- 
> 2.7.4
> 

Regression reported: https://bugzilla.kernel.org/show_bug.cgi?id=194969
