From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 7/7] i2c: fsi: Add bus recovery
Date: Tue, 26 Jun 2018 11:38:33 +0900
Message-ID: <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:19PM -0500, Eddie James wrote:
> Bus recovery should reset the engine and force clock the bus 9 times
> to recover most situations.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index d6cab4b..940b198 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -611,6 +611,24 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
>  		I2C_FUNC_SMBUS_BLOCK_DATA;
>  }
>  
> +static int fsi_i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	int rc;
> +	struct fsi_i2c_port *port = adap->algo_data;
> +	struct fsi_i2c_master *master = port->master;
> +
> +	mutex_lock(&master->lock);
> +
> +	rc = fsi_i2c_reset(master, port->port);
> +
> +	mutex_unlock(&master->lock);
> +	return rc;
> +}
> +
> +static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
> +	.recover_bus = fsi_i2c_recover_bus,
> +};
> +

This all won't have any effect since you never call i2c_recover_bus
which calls back into i2c_bus_recovery_info callbacks.
