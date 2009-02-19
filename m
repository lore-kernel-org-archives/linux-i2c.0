From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Thu, 19 Feb 2009 17:26:05 +0100
Message-ID: <20090219172605.7e70a797@hyperion.delvare>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org>
	<20090108154604.2cade06e@hyperion.delvare>
	<200901081155.27866.david-b@pacbell.net>
	<20090109100145.GA12376@clifford.at>
	<20090214121745.39dfddf9@hyperion.delvare>
	<20090214180014.GA19352@clifford.at>
	<20090215113122.5bcc3f3d@hyperion.delvare>
	<20090216131026.GA17437@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090216131026.GA17437-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Clifford,

On Mon, 16 Feb 2009 14:10:26 +0100, Clifford Wolf wrote:
> On Sun, Feb 15, 2009 at 11:31:22AM +0100, Jean Delvare wrote:
> > Care to improve my patch to actually implement your idea? I'm a bit
> > short on spare time these days.
> 
> here is my improved version. unfortunatly I was only able to compile-test
> it since I have unrelated problems (open firmware changes in recent kernels) 
> with my i2c test platform...
> 
> I have copied the code from the i2c-mpc timeout handling which I have
> tested some weeks ago, so I am 99.9% sure that it does exactly what it
> should do.. ;-)
> 
> --snip--
> i2c: Automatically retry transfers on arbitration loss.
> 
> Each i2c_adapter controls how many attempts will be made and for how long
> retransmitting the message is tried, using the retries and timout values.
> 
> Signed-off-by: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index b346a68..f3cb4f8 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1000,7 +1000,8 @@ module_exit(i2c_exit);
>   */
>  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
>  {
> -	int ret;
> +	unsigned long orig_jiffies = jiffies;

I think you should initialize orig_jiffies *after* you get the bus
lock. Otherwise the behavior depends on how long you had to wait to get
control of the bus. Or was is intended?

> +	int ret, try;
>  
>  	/* REVISIT the fault reporting model here is weak:
>  	 *
> @@ -1038,7 +1039,14 @@ int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
>  			mutex_lock_nested(&adap->bus_lock, adap->level);
>  		}
>  
> -		ret = adap->algo->master_xfer(adap,msgs,num);
> +		/* Retry automatically on arbitration loss */
> +		for (ret = 0, try = 0; try <= adap->retries; try++) {
> +			ret = adap->algo->master_xfer(adap, msgs, num);
> +			if (ret != -EAGAIN)
> +				break;
> +			if (time_after(jiffies, orig_jiffies + adap->timeout))

This assumes that adap->timeout is expressed in jiffies. Which
according to a comment in include/linux/i2c-dev.h, is the case, but
this must be for historical reasons. This never made sense to me, as it
means that the actual timeout value depends on the value of HZ.

The key problem here is that the timeout value is exported to
user-space and can be changed by user-space. And user-space normally
doesn't know the value of HZ... So the timeout value should be
expressed in a constant time unit.

I see 3 possible solutions:
1* Ignore the problem and keep using jiffies for the timeout value. Most
   drivers will need to be fixed to specify a timeout in jiffies (e.g.
   msecs_to_jiffies(100)) and not a raw number.
2* Say that the value is expressed in units of 10 ms. This is
   historically equivalent to a jiffy (as Linux started with HZ=100) to
   backwards compatibility is preserved. Drivers have to be updated to
   convert the value to jiffies if calling time_after() or equivalent.
   The only drawback I see is that this isn't a terribly natural unit.
3* Say that the value is expressed in ms. This means that all drivers
   have to be updated both for timeout initialization and use, AND
   user-space may be surprised by the change. The only positive side is
   that ms is a natural, finer-grained unit.

The second solution sounds the best to me. Opinions?

This problem isn't directly related to your patch, however so far
drivers were handling the timeout internally so I didn't really care.
Now that your patch will make use of the timeout value in i2c-core, I'd
like to clarify the situation first.


> +				break;
> +		}
>  		mutex_unlock(&adap->bus_lock);
>  
>  		return ret;
> @@ -1956,9 +1964,20 @@ s32 i2c_smbus_xfer(struct i2c_adapter * adapter, u16 addr, unsigned short flags,
>  	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
>  
>  	if (adapter->algo->smbus_xfer) {
> +		unsigned long orig_jiffies = jiffies;
> +		int try;
> +
>  		mutex_lock(&adapter->bus_lock);
> -		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
> -						command, protocol, data);
> +		/* Retry automatically on arbitration loss */
> +		for (res = 0, try = 0; try <= adapter->retries; try++) {
> +			res = adapter->algo->smbus_xfer(adapter, addr, flags,
> +							read_write, command,
> +							protocol, data);
> +			if (res != -EAGAIN)
> +				break;
> +			if (time_after(jiffies, orig_jiffies + adapter->timeout))
> +				break;
> +		}
>  		mutex_unlock(&adapter->bus_lock);
>  	} else
>  		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
> 


-- 
Jean Delvare
