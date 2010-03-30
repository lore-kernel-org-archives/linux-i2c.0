From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC] i2c-core: erase pointer to clientdata on removal
Date: Tue, 30 Mar 2010 13:01:37 +0200
Message-ID: <20100330130137.7e06bebf@hyperion.delvare>
References: <1269942157-23062-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269942157-23062-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 30 Mar 2010 11:42:37 +0200, Wolfram Sang wrote:
> After discovering that a lot of i2c-drivers leave the pointer to their
> clientdata dangling, it was decided to let the core handle this issue.
> It is assumed that the core may access the private data after remove()
> as there are no guarantees for the lifetime of such pointers anyhow (see
> thread starting at http://lkml.org/lkml/2010/3/21/68)
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
>  Documentation/i2c/writing-clients |    5 +++++
>  drivers/i2c/i2c-core.c            |    8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
> index 3219ee0..5ebf5af 100644
> --- a/Documentation/i2c/writing-clients
> +++ b/Documentation/i2c/writing-clients
> @@ -74,6 +74,11 @@ structure at all.  You should use this to keep device-specific data.
>  	/* retrieve the value */
>  	void *i2c_get_clientdata(const struct i2c_client *client);
>  
> +Note that starting with kernel 2.6.34, you don't have to set the `data' field
> +to NULL in remove() or if probe() failed anymore. The i2c-core does this
> +automatically on these occasions. Those are also the only times the core will
> +touch this field.
> +
>  
>  Accessing the client
>  ====================
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 3202a86..b9306b1 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -117,8 +117,10 @@ static int i2c_device_probe(struct device *dev)
>  	dev_dbg(dev, "probe\n");
>  
>  	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> -	if (status)
> +	if (status) {
>  		client->driver = NULL;
> +		i2c_set_clientdata(client, NULL);
> +	}
>  	return status;
>  }
>  
> @@ -139,8 +141,10 @@ static int i2c_device_remove(struct device *dev)
>  		dev->driver = NULL;
>  		status = 0;
>  	}
> -	if (status == 0)
> +	if (status == 0) {
>  		client->driver = NULL;
> +		i2c_set_clientdata(client, NULL);
> +	}
>  	return status;
>  }
>  

Applied, thanks.

-- 
Jean Delvare
