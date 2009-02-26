From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/algo-pca: use timeout for checking the state
 machine
Date: Thu, 26 Feb 2009 22:25:17 +0100
Message-ID: <20090226222517.51c29801@hyperion.delvare>
References: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de>
	<1235492536-31695-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235492536-31695-3-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Feb 2009 17:22:15 +0100, Wolfram Sang wrote:
> We now timeout also if the state machine does not change within the
> given time. For that, the driver-specific completion-functions are
> extended to return true or false depending on the timeout. This then
> gets checked in the algorithm.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c      |   39 +++++++++++++++++---------------
>  drivers/i2c/busses/i2c-pca-isa.c      |   18 +++++++++++----
>  drivers/i2c/busses/i2c-pca-platform.c |   20 ++++++++--------
>  3 files changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
> index 59ee88a..4153aff 100644
> --- a/drivers/i2c/algos/i2c-algo-pca.c
> +++ b/drivers/i2c/algos/i2c-algo-pca.c
> @@ -60,14 +60,14 @@ static void pca9665_reset(void *pd)
>   *
>   * returns after the start condition has occurred
>   */
> -static void pca_start(struct i2c_algo_pca_data *adap)
> +static int pca_start(struct i2c_algo_pca_data *adap)
>  {
>  	int sta = pca_get_con(adap);
>  	DEB2("=== START\n");
>  	sta |= I2C_PCA_CON_STA;
>  	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_SI);
>  	pca_set_con(adap, sta);
> -	pca_wait(adap);
> +	return pca_wait(adap);
>  }
>  
>  /*
> @@ -75,14 +75,14 @@ static void pca_start(struct i2c_algo_pca_data *adap)
>   *
>   * return after the repeated start condition has occurred
>   */
> -static void pca_repeated_start(struct i2c_algo_pca_data *adap)
> +static int pca_repeated_start(struct i2c_algo_pca_data *adap)
>  {
>  	int sta = pca_get_con(adap);
>  	DEB2("=== REPEATED START\n");
>  	sta |= I2C_PCA_CON_STA;
>  	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_SI);
>  	pca_set_con(adap, sta);
> -	pca_wait(adap);
> +	return pca_wait(adap);
>  }
>  
>  /*
> @@ -108,7 +108,7 @@ static void pca_stop(struct i2c_algo_pca_data *adap)
>   *
>   * returns after the address has been sent
>   */
> -static void pca_address(struct i2c_algo_pca_data *adap,
> +static int pca_address(struct i2c_algo_pca_data *adap,
>  			struct i2c_msg *msg)
>  {
>  	int sta = pca_get_con(adap);
> @@ -125,7 +125,7 @@ static void pca_address(struct i2c_algo_pca_data *adap,
>  	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI);
>  	pca_set_con(adap, sta);
>  
> -	pca_wait(adap);
> +	return pca_wait(adap);
>  }
>  
>  /*
> @@ -133,7 +133,7 @@ static void pca_address(struct i2c_algo_pca_data *adap,
>   *
>   * Returns after the byte has been transmitted
>   */
> -static void pca_tx_byte(struct i2c_algo_pca_data *adap,
> +static int pca_tx_byte(struct i2c_algo_pca_data *adap,
>  			__u8 b)
>  {
>  	int sta = pca_get_con(adap);
> @@ -143,7 +143,7 @@ static void pca_tx_byte(struct i2c_algo_pca_data *adap,
>  	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI);
>  	pca_set_con(adap, sta);
>  
> -	pca_wait(adap);
> +	return pca_wait(adap);
>  }
>  
>  /*
> @@ -163,7 +163,7 @@ static void pca_rx_byte(struct i2c_algo_pca_data *adap,
>   *
>   * Returns after next byte has arrived.
>   */
> -static void pca_rx_ack(struct i2c_algo_pca_data *adap,
> +static int pca_rx_ack(struct i2c_algo_pca_data *adap,
>  		       int ack)
>  {
>  	int sta = pca_get_con(adap);
> @@ -174,7 +174,7 @@ static void pca_rx_ack(struct i2c_algo_pca_data *adap,
>  		sta |= I2C_PCA_CON_AA;
>  
>  	pca_set_con(adap, sta);
> -	pca_wait(adap);
> +	return pca_wait(adap);
>  }
>  
>  static int pca_xfer(struct i2c_adapter *i2c_adap,
> @@ -187,6 +187,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  	int numbytes = 0;
>  	int state;
>  	int ret;
> +	int completed = 1;
>  	unsigned long timeout = jiffies + i2c_adap->timeout;
>  
>  	while (pca_status(adap) != 0xf8) {
> @@ -231,18 +232,18 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  
>  		switch (state) {
>  		case 0xf8: /* On reset or stop the bus is idle */
> -			pca_start(adap);
> +			completed = pca_start(adap);
>  			break;
>  
>  		case 0x08: /* A START condition has been transmitted */
>  		case 0x10: /* A repeated start condition has been transmitted */
> -			pca_address(adap, msg);
> +			completed = pca_address(adap, msg);
>  			break;
>  
>  		case 0x18: /* SLA+W has been transmitted; ACK has been received */
>  		case 0x28: /* Data byte in I2CDAT has been transmitted; ACK has been received */
>  			if (numbytes < msg->len) {
> -				pca_tx_byte(adap, msg->buf[numbytes]);
> +				completed = pca_tx_byte(adap, msg->buf[numbytes]);
>  				numbytes++;
>  				break;
>  			}
> @@ -250,7 +251,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  			if (curmsg == num)
>  				pca_stop(adap);
>  			else
> -				pca_repeated_start(adap);
> +				completed = pca_repeated_start(adap);
>  			break;
>  
>  		case 0x20: /* SLA+W has been transmitted; NOT ACK has been received */
> @@ -259,21 +260,21 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  			goto out;
>  
>  		case 0x40: /* SLA+R has been transmitted; ACK has been received */
> -			pca_rx_ack(adap, msg->len > 1);
> +			completed = pca_rx_ack(adap, msg->len > 1);
>  			break;
>  
>  		case 0x50: /* Data bytes has been received; ACK has been returned */
>  			if (numbytes < msg->len) {
>  				pca_rx_byte(adap, &msg->buf[numbytes], 1);
>  				numbytes++;
> -				pca_rx_ack(adap, numbytes < msg->len - 1);
> +				completed = pca_rx_ack(adap, numbytes < msg->len - 1);
>  				break;
>  			}
>  			curmsg++; numbytes = 0;
>  			if (curmsg == num)
>  				pca_stop(adap);
>  			else
> -				pca_repeated_start(adap);
> +				completed = pca_repeated_start(adap);
>  			break;
>  
>  		case 0x48: /* SLA+R has been transmitted; NOT ACK has been received */
> @@ -296,7 +297,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  				if (curmsg == num)
>  					pca_stop(adap);
>  				else
> -					pca_repeated_start(adap);
> +					completed = pca_repeated_start(adap);
>  			} else {
>  				DEB2("NOT ACK sent after data byte received. "
>  				     "Not final byte. numbytes %d. len %d\n",
> @@ -322,6 +323,8 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  			break;
>  		}
>  
> +		if (!completed)
> +			goto out;
>  	}
>  
>  	ret = curmsg;
> diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
> index 84d035c..a523be8 100644
> --- a/drivers/i2c/busses/i2c-pca-isa.c
> +++ b/drivers/i2c/busses/i2c-pca-isa.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
> @@ -43,6 +44,7 @@ static int irq = -1;
>   * in the actual clock rate */
>  static int clock  = 59000;
>  
> +static struct i2c_adapter pca_isa_ops;
>  static wait_queue_head_t pca_wait;
>  
>  static void pca_isa_writebyte(void *pd, int reg, int val)
> @@ -68,16 +70,22 @@ static int pca_isa_readbyte(void *pd, int reg)
>  
>  static int pca_isa_waitforcompletion(void *pd)
>  {
> -	int ret = 0;
> +	long ret = ~0;
> +	unsigned long timeout;
>  
>  	if (irq > -1) {
> -		ret = wait_event_interruptible(pca_wait,
> -					       pca_isa_readbyte(pd, I2C_PCA_CON) & I2C_PCA_CON_SI);
> +		ret = wait_event_interruptible_timeout(pca_wait,
> +				pca_isa_readbyte(pd, I2C_PCA_CON)
> +				& I2C_PCA_CON_SI, pca_isa_ops.timeout);
>  	} else {
> -		while ((pca_isa_readbyte(pd, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
> +		/* Do polling */
> +		timeout = jiffies + pca_isa_ops.timeout;
> +		while (((pca_isa_readbyte(pd, I2C_PCA_CON)
> +				& I2C_PCA_CON_SI) == 0)
> +				&& (ret = time_before(jiffies, timeout)))
>  			udelay(100);
>  	}
> -	return ret;
> +	return ret > 0;
>  }
>  
>  static void pca_isa_resetchip(void *pd)
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index 51d179b..df5e593 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -81,24 +82,23 @@ static void i2c_pca_pf_writebyte32(void *pd, int reg, int val)
>  static int i2c_pca_pf_waitforcompletion(void *pd)
>  {
>  	struct i2c_pca_pf_data *i2c = pd;
> -	int ret = 0;
> +	long ret = ~0;
> +	unsigned long timeout;
>  
>  	if (i2c->irq) {
> -		ret = wait_event_interruptible(i2c->wait,
> +		ret = wait_event_interruptible_timeout(i2c->wait,
>  			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> -			& I2C_PCA_CON_SI);
> +			& I2C_PCA_CON_SI, i2c->adap.timeout);
>  	} else {
> -		/*
> -		 * Do polling...
> -		 * XXX: Could get stuck in extreme cases!
> -		 *      Maybe add timeout, but using irqs is preferred anyhow.
> -		 */
> -		while ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> +		/* Do polling */
> +		timeout = jiffies + i2c->adap.timeout;
> +		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
>  				& I2C_PCA_CON_SI) == 0)
> +				&& (ret = time_before(jiffies, timeout)))
>  			udelay(100);
>  	}
>  
> -	return ret;
> +	return ret > 0;
>  }
>  
>  static void i2c_pca_pf_dummyreset(void *pd)

Looks good. Applied, thanks.

-- 
Jean Delvare
