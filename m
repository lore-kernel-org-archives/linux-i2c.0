From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3 1/8] i2c: iproc: I2C read up to 255 bytes support
Date: Sun, 20 Jan 2019 13:41:14 -0800
Message-ID: <e3f402dc-3fa9-4d3c-8fc5-956737c1a3f3@broadcom.com>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <1547791464-3540-2-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1547791464-3540-2-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com
Cc: mark.rutland@arm.com, Shreesha Rajashekar <shreesha@broadcom.com>, heikki.krogerus@linux.intel.com, vigneshr@ti.com, ajayg@nvidia.com, wsa@the-dreams.de, rayagonoda.kokatanur@braodcom.com, aaron.wu@analog.com, pierre-yves.mordret@st.com, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, manivannan.sadhasivam@linaro.org, jdelvare@suse.de, f.fainelli@gmail.com, eajames@linux.vnet.ibm.com, shreesha.rajashekar@broadcom.com, bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org, devicetree@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com
List-Id: linux-i2c@vger.kernel.org



On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
> From: Shreesha Rajashekar <shreesha@broadcom.com>
> 
> Add support to allow I2C RX transfer up to 255 bytes.
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 98 +++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 4c8c3bc4669c..eb7339a0280e 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -80,6 +80,10 @@
>  
>  #define I2C_TIMEOUT_MSEC             50000
>  #define M_TX_RX_FIFO_SIZE            64
> +#define M_RX_FIFO_MAX_THLD_VALUE     (M_TX_RX_FIFO_SIZE - 1)
> +
> +#define M_RX_MAX_READ_LEN            255
> +#define M_RX_FIFO_THLD_VALUE         50
>  
>  enum bus_speed_index {
>  	I2C_SPD_100K = 0,
> @@ -102,17 +106,41 @@ struct bcm_iproc_i2c_dev {
>  
>  	/* bytes that have been transferred */
>  	unsigned int tx_bytes;
> +	/* bytes that have been read */
> +	unsigned int rx_bytes;
> +	unsigned int thld_bytes;
>  };
>  
>  /*
>   * Can be expanded in the future if more interrupt status bits are utilized
>   */
> -#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT))
> +#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
> +		| BIT(IS_M_RX_THLD_SHIFT))
> +
> +static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	struct i2c_msg *msg = iproc_i2c->msg;
> +
> +	/* Read valid data from RX FIFO */
> +	while (iproc_i2c->rx_bytes < msg->len) {
> +		if (!((readl(iproc_i2c->base +
> +		M_FIFO_CTRL_OFFSET) >>
> +		M_FIFO_RX_CNT_SHIFT) &
> +		M_FIFO_RX_CNT_MASK))
> +			break;
> +
> +		msg->buf[iproc_i2c->rx_bytes] =
> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> +		iproc_i2c->rx_bytes++;
> +	}
> +}
>  
>  static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  {
>  	struct bcm_iproc_i2c_dev *iproc_i2c = data;
>  	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +	u32 tmp;
>  
>  	status &= ISR_MASK;
>  
> @@ -136,8 +164,6 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  
>  			/* mark the last byte */
>  			if (idx == msg->len - 1) {
> -				u32 tmp;
> -
>  				val |= BIT(M_TX_WR_STATUS_SHIFT);
>  
>  				/*
> @@ -156,6 +182,32 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  		iproc_i2c->tx_bytes += tx_bytes;
>  	}
>  
> +	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
> +		struct i2c_msg *msg = iproc_i2c->msg;
> +		u32 bytes_left;
> +
> +		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
> +		bytes_left = msg->len - iproc_i2c->rx_bytes;
> +		if (bytes_left == 0) {
> +			/* finished reading all data, disable rx thld event */
> +			tmp = readl(iproc_i2c->base + IE_OFFSET);
> +			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + IE_OFFSET);
> +		} else if (bytes_left < iproc_i2c->thld_bytes) {
> +			/* set bytes left as threshold */
> +			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			iproc_i2c->thld_bytes = bytes_left;
> +		}
> +		/*
> +		 * bytes_left >= iproc_i2c->thld_bytes,
> +		 * hence no need to change the THRESHOLD SET.
> +		 * It will remain as iproc_i2c->thld_bytes itself
> +		 */
> +	}
> +
>  	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
>  		iproc_i2c->xfer_is_done = 1;
>  		complete(&iproc_i2c->done);
> @@ -253,7 +305,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  {
>  	int ret, i;
>  	u8 addr;
> -	u32 val;
> +	u32 val, tmp, val_intr_en;
>  	unsigned int tx_bytes;
>  	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
>  
> @@ -298,7 +350,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 * transaction is done, i.e., the internal start_busy bit, transitions
>  	 * from 1 to 0.
>  	 */
> -	val = BIT(IE_M_START_BUSY_SHIFT);
> +	val_intr_en = BIT(IE_M_START_BUSY_SHIFT);
>  
>  	/*
>  	 * If TX data size is larger than the TX FIFO, need to enable TX
> @@ -307,9 +359,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	if (!(msg->flags & I2C_M_RD) &&
>  	    msg->len > iproc_i2c->tx_bytes)
> -		val |= BIT(IE_M_TX_UNDERRUN_SHIFT);
> -
> -	writel(val, iproc_i2c->base + IE_OFFSET);
> +		val_intr_en |= BIT(IE_M_TX_UNDERRUN_SHIFT);
>  
>  	/*
>  	 * Now we can activate the transfer. For a read operation, specify the
> @@ -317,11 +367,27 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	val = BIT(M_CMD_START_BUSY_SHIFT);
>  	if (msg->flags & I2C_M_RD) {
> +		iproc_i2c->rx_bytes = 0;
> +		if (msg->len > M_RX_FIFO_MAX_THLD_VALUE)
> +			iproc_i2c->thld_bytes = M_RX_FIFO_THLD_VALUE;
> +		else
> +			iproc_i2c->thld_bytes = msg->len;
> +
> +		/* set threshold value */
> +		tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +		tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +		tmp |= iproc_i2c->thld_bytes << M_FIFO_RX_THLD_SHIFT;
> +		writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +
> +		/* enable the RX threshold interrupt */
> +		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
> +
>  		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
>  		       (msg->len << M_CMD_RD_CNT_SHIFT);
>  	} else {
>  		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
>  	}
> +	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
>  	writel(val, iproc_i2c->base + M_CMD_OFFSET);
>  
>  	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> @@ -353,17 +419,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  		return ret;
>  	}
>  
> -	/*
> -	 * For a read operation, we now need to load the data from FIFO
> -	 * into the memory buffer
> -	 */
> -	if (msg->flags & I2C_M_RD) {
> -		for (i = 0; i < msg->len; i++) {
> -			msg->buf[i] = (readl(iproc_i2c->base + M_RX_OFFSET) >>
> -				      M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -395,9 +450,8 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>  
> -static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> -	/* need to reserve one byte in the FIFO for the slave address */
> -	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> +static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	.max_read_len = M_RX_MAX_READ_LEN,
>  };
>  
>  static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
> 

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
