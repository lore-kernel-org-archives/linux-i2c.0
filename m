From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/7] of: fill the archdata for I2C devices
Date: Tue, 21 Oct 2008 22:14:46 -0600
Message-ID: <20081022041446.GA7176@secretlab.ca>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081016171256.GC5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752794AbYJVEPA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081016171256.GC5515@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, "Steven A. Falco" <sfalco@harris.com>, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2008 at 09:12:56PM +0400, Anton Vorontsov wrote:
> For I2C devices we just setting the the node pointer in the archdata.
> This is needed so that the other code would know device's node.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Looks okay to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/of/of_i2c.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index 6a98dc8..f9e18ed 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -24,6 +24,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  
>  	for_each_child_of_node(adap_node, node) {
>  		struct i2c_board_info info = {};
> +		struct dev_archdata dev_ad = {};
>  		const u32 *addr;
>  		int len;
>  
> @@ -41,6 +42,9 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  
>  		info.addr = *addr;
>  
> +		dev_archdata_set_node(&dev_ad, node);
> +		info.archdata = &dev_ad;
> +
>  		request_module(info.type);
>  
>  		result = i2c_new_device(adap, &info);
> @@ -51,6 +55,13 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  			irq_dispose_mapping(info.irq);
>  			continue;
>  		}
> +
> +		/*
> +		 * Get the node to not lose the dev_archdata->of_node.
> +		 * Currently there is no way to put it back, as well as no
> +		 * of_unregister_i2c_devices() call.
> +		 */
> +		of_node_get(node);
>  	}
>  }
>  EXPORT_SYMBOL(of_register_i2c_devices);
> -- 
> 1.5.6.3
> 
