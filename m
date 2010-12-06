From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c_intel_mid: Improve error reporting
Date: Mon, 06 Dec 2010 04:31:41 +0000
Message-ID: <4CFC672D.2020302@fluff.org>
References: <20101124144904.10210.90314.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101124144904.10210.90314.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 24/11/10 14:49, Alan Cox wrote:
> From: Catalin Popescu <catalinx.popescu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The error messages printed from mrst_i2c_abort() didn't give slave address info.
> 
> But I2C device driver developers always need this to check which slave device
> has the problem.
> 
> This patch enhances the error message format by adding slave address info to
> each error message.
> 
> Signed-off-by: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Ported to upstream driver branch and tidied a spot]
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-intel-mid.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
> index 80f70d3..bdf17da 100644
> --- a/drivers/i2c/busses/i2c-intel-mid.c
> +++ b/drivers/i2c/busses/i2c-intel-mid.c
> @@ -78,7 +78,7 @@ struct intel_mid_i2c_private {
>  	void __iomem *base;
>  	int speed;
>  	struct completion complete;
> -	int abort;
> +	u32 abort;
>  	u8 *rx_buf;
>  	int rx_buf_len;
>  	enum mid_i2c_status status;
> @@ -464,9 +464,15 @@ static inline bool intel_mid_i2c_address_neq(const struct i2c_msg *p1,
>  static void intel_mid_i2c_abort(struct intel_mid_i2c_private *i2c)
>  {
>  	/* Read about source register */
> -	int abort = i2c->abort;
> +	u32 abort = i2c->abort;
>  	struct i2c_adapter *adap = &i2c->adap;
>  
> +	if (abort & (ABRT_MASTER_DIS | ABRT_10B_RD_NORSTRT |
> +	    ABRT_SBYTE_NORSTRT | ABRT_SBYTE_ACKDET | ABRT_TXDATA_NOACK |
> +	    ABRT_10ADDR2_NOACK | ABRT_10ADDR1_NOACK | ABRT_7B_ADDR_NOACK))
> +		dev_err(&adap->dev, "i2c abort on address 0x%x\n",
> +							i2c->msg->addr);
> +
>  	/* Single transfer error check:
>  	 * According to databook, TX/RX FIFOs would be flushed when
>  	 * the abort interrupt occured.
> @@ -550,7 +556,8 @@ static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
>  	i2c->status = STATUS_READ_START;
>  	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
>  	if (!err) {
> -		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
> +		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
> +						i2c->msg->addr);
>  		intel_mid_i2c_hwinit(i2c);
>  		return -ETIMEDOUT;
>  	}
> @@ -602,7 +609,8 @@ static int xfer_write(struct i2c_adapter *adap,
>  	i2c->status = STATUS_WRITE_START;
>  	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
>  	if (!err) {
> -		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
> +		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
> +							i2c->msg->addr);
>  		intel_mid_i2c_hwinit(i2c);
>  		return -ETIMEDOUT;
>  	} else {
> 

ok, will queue for next merge window.
