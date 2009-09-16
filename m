From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: Prevent priority inversion on top of bus lock
Date: Wed, 16 Sep 2009 13:51:59 +0200
Message-ID: <20090916135159.0d74f178@hyperion.delvare>
References: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
	<1253099829-17655-2-git-send-email-mika.kuoppala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253099829-17655-2-git-send-email-mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 16 Sep 2009 14:17:09 +0300, Mika Kuoppala wrote:
> Low priority thread holding the i2c bus mutex could block
> more high priority threads to access the bus resulting in
> unacceptable latencies. Change the mutex type to
> rt_mutex preventing priority inversion.
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   12 ++++++------
>  include/linux/i2c.h    |    3 +--
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0e45c29..40f645f 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -548,7 +548,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  		goto out_list;
>  	}
>  
> -	mutex_init(&adap->bus_lock);
> +	rt_mutex_init(&adap->bus_lock);
>  
>  	/* Set default timeout to 1 second if not already set */
>  	if (adap->timeout == 0)
> @@ -1018,12 +1018,12 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  #endif
>  
>  		if (in_atomic() || irqs_disabled()) {
> -			ret = mutex_trylock(&adap->bus_lock);
> +			ret = rt_mutex_trylock(&adap->bus_lock);
>  			if (!ret)
>  				/* I2C activity is ongoing. */
>  				return -EAGAIN;
>  		} else {
> -			mutex_lock_nested(&adap->bus_lock, adap->level);
> +			rt_mutex_lock(&adap->bus_lock);

Hmm, rt_mutex doesn't handle locking model validation as regular
mutexes have? Looks like a regression to me.

>  		}
>  
>  		/* Retry automatically on arbitration loss */
> @@ -1035,7 +1035,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  			if (time_after(jiffies, orig_jiffies + adap->timeout))
>  				break;
>  		}
> -		mutex_unlock(&adap->bus_lock);
> +		rt_mutex_unlock(&adap->bus_lock);
>  
>  		return ret;
>  	} else {
> @@ -1839,7 +1839,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>  	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
>  
>  	if (adapter->algo->smbus_xfer) {
> -		mutex_lock(&adapter->bus_lock);
> +		rt_mutex_lock(&adapter->bus_lock);
>  
>  		/* Retry automatically on arbitration loss */
>  		orig_jiffies = jiffies;
> @@ -1853,7 +1853,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>  				       orig_jiffies + adapter->timeout))
>  				break;
>  		}
> -		mutex_unlock(&adapter->bus_lock);
> +		rt_mutex_unlock(&adapter->bus_lock);
>  	} else
>  		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
>  					      command, protocol, data);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index f4784c0..ddca85d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -340,8 +340,7 @@ struct i2c_adapter {
>  	void *algo_data;
>  
>  	/* data fields that are valid for all devices	*/
> -	u8 level; 			/* nesting level for lockdep */
> -	struct mutex bus_lock;
> +	struct rt_mutex bus_lock;
>  
>  	int timeout;			/* in jiffies */
>  	int retries;


-- 
Jean Delvare
