From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: cadence: Fix the driver in interrupt flurry case
Date: Mon, 18 Feb 2019 16:10:42 +0100
Message-ID: <fb0df818-7267-b8f5-4968-8a57db1905e6@xilinx.com>
References: <1550232196-6567-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550232196-6567-1-git-send-email-shubhrajyoti.datta@gmail.com>
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
To: shubhrajyoti.datta@gmail.com, linux-i2c@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 15. 02. 19 13:03, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In case there are a lot of interrupts then the hold bit is not
> released protect the code by making it atomic by disabling interrupts.

There are two sentences in one.

Isn't it "released. Protect"?

> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b136057..92829be 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -365,6 +365,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  {
>  	unsigned int ctrl_reg;
>  	unsigned int isr_status;
> +	unsigned long flags;
>  
>  	id->p_recv_buf = id->p_msg->buf;
>  	id->recv_count = id->p_msg->len;
> @@ -405,6 +406,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
>  	}
>  
> +	local_irq_save(flags);
>  	/* Set the slave address in address register - triggers operation */
>  	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
>  						CDNS_I2C_ADDR_OFFSET);
> @@ -413,6 +415,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
>  		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
>  			cdns_i2c_clear_bus_hold(id);
> +	local_irq_restore(flags);
>  	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
>  }
>  
> 

The rest looks good.
M
