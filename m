From: Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] i2c: aspeed: fix master pending state handling
Date: Thu, 10 Oct 2019 21:20:56 +0000
Message-ID: <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Content-Language: en-US
Content-ID: <A053BE086CCCF6439AB4C13CF4C23ADE@namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, Cedric Le Goater <clg@kaod.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
> In case of master pending state, it should not trigger a master
> command, otherwise data could be corrupted because this H/W shares
> the same data buffer for slave and master operations. It also means
> that H/W command queue handling is unreliable because of the buffer
> sharing issue. To fix this issue, it clears command queue if a
> master command is queued in pending state to use S/W solution
> instead of H/W command queue handling. Also, it refines restarting
> mechanism of the pending master command.
> 
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 54 +++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index fa66951b05d0..7b098ff5f5dd 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -108,6 +108,12 @@
>  #define ASPEED_I2CD_S_TX_CMD				BIT(2)
>  #define ASPEED_I2CD_M_TX_CMD				BIT(1)
>  #define ASPEED_I2CD_M_START_CMD				BIT(0)
> +#define ASPEED_I2CD_MASTER_CMDS_MASK					       \
> +		(ASPEED_I2CD_M_STOP_CMD |				       \
> +		 ASPEED_I2CD_M_S_RX_CMD_LAST |				       \
> +		 ASPEED_I2CD_M_RX_CMD |					       \
> +		 ASPEED_I2CD_M_TX_CMD |					       \
> +		 ASPEED_I2CD_M_START_CMD)
>  
>  /* 0x18 : I2CD Slave Device Address Register   */
>  #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
> @@ -336,18 +342,19 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
>  	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
>  	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
>  
> -	bus->master_state = ASPEED_I2C_MASTER_START;
> -
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  	/*
>  	 * If it's requested in the middle of a slave session, set the master
>  	 * state to 'pending' then H/W will continue handling this master
>  	 * command when the bus comes back to the idle state.
>  	 */
> -	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
> +	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE) {
>  		bus->master_state = ASPEED_I2C_MASTER_PENDING;
> +		return;
> +	}
>  #endif /* CONFIG_I2C_SLAVE */
>  
> +	bus->master_state = ASPEED_I2C_MASTER_START;
>  	bus->buf_index = 0;
>  
>  	if (msg->flags & I2C_M_RD) {
> @@ -422,20 +429,6 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  		}
>  	}
>  
> -#if IS_ENABLED(CONFIG_I2C_SLAVE)
> -	/*
> -	 * A pending master command will be started by H/W when the bus comes
> -	 * back to idle state after completing a slave operation so change the
> -	 * master state from 'pending' to 'start' at here if slave is inactive.
> -	 */
> -	if (bus->master_state == ASPEED_I2C_MASTER_PENDING) {
> -		if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
> -			goto out_no_complete;
> -
> -		bus->master_state = ASPEED_I2C_MASTER_START;
> -	}
> -#endif /* CONFIG_I2C_SLAVE */
> -
>  	/* Master is not currently active, irq was for someone else. */
>  	if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE ||
>  	    bus->master_state == ASPEED_I2C_MASTER_PENDING)
> @@ -462,11 +455,15 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  		/*
>  		 * If a peer master starts a xfer immediately after it queues a
> -		 * master command, change its state to 'pending' then H/W will
> -		 * continue the queued master xfer just after completing the
> -		 * slave mode session.
> +		 * master command, clear the queued master command and change
> +		 * its state to 'pending'. To simplify handling of pending
> +		 * cases, it uses S/W solution instead of H/W command queue
> +		 * handling.
>  		 */
>  		if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
> +			writel(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +				~ASPEED_I2CD_MASTER_CMDS_MASK,
> +			       bus->base + ASPEED_I2C_CMD_REG);

Sorry for the late comments (just noticed this line while testing the patch):

I assume this line is aimed at stopping the running master commands, but as per
AST2500 datasheet, it's NOP to write 0 to MASTER_STOP/MASTER_RX/MASTER_TX bits.
Maybe all we need is writing 1 to MASTER_STOP field?


Cheers,

Tao 

>  			bus->master_state = ASPEED_I2C_MASTER_PENDING;
>  			dev_dbg(bus->dev,
>  				"master goes pending due to a slave start\n");
> @@ -629,6 +626,14 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			irq_handled |= aspeed_i2c_master_irq(bus,
>  							     irq_remaining);
>  	}
> +
> +	/*
> +	 * Start a pending master command at here if a slave operation is
> +	 * completed.
> +	 */
> +	if (bus->master_state == ASPEED_I2C_MASTER_PENDING &&
> +	    bus->slave_state == ASPEED_I2C_SLAVE_INACTIVE)
> +		aspeed_i2c_do_start(bus);
>  #else
>  	irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
>  #endif /* CONFIG_I2C_SLAVE */
> @@ -691,6 +696,15 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>  		     ASPEED_I2CD_BUS_BUSY_STS))
>  			aspeed_i2c_recover_bus(bus);
>  
> +		/*
> +		 * If timed out and the state is still pending, drop the pending
> +		 * master command.
> +		 */
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
> +			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
>  		return -ETIMEDOUT;
>  	}
>  
> 
