From: Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 3/5] i2c: aspeed: fix master pending state handling
Date: Tue, 8 Oct 2019 22:00:46 +0000
Message-ID: <422eea61-7cb9-e471-83fb-3f554ff5e079@fb.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-4-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191007231313.4700-4-jae.hyun.yoo@linux.intel.com>
Content-Language: en-US
Content-ID: <F304E12DA9821C4995799DE8ABF9051C@namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On 10/7/19 4:13 PM, Jae Hyun Yoo wrote:
> In case of master pending state, it should not trigger the master
> command because this H/W is sharing the same data buffer for slave
> and master operations, so this commit fixes the issue with making
> the master command triggering happen when the state goes to active
> state.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index fa66951b05d0..40f6cf98d32e 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -336,18 +336,19 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
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
> @@ -432,7 +433,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  		if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
>  			goto out_no_complete;
>  
> -		bus->master_state = ASPEED_I2C_MASTER_START;
> +		aspeed_i2c_do_start(bus);
>  	}

Shall we move the restart-master logic from master_irq to bus_irq? The reason being:
master transaction cannot be restarted when aspeed-i2c is running in slave state and
receives STOP interrupt, because aspeed_i2c_master_irq won't be called in this case.


Cheers,

Tao
