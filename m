From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c: i2c_del_adapter: Don't treat removing a
 non-registered adapter as error
Date: Sat, 30 Mar 2013 19:17:20 +0100
Message-ID: <20130330191720.0134ee7e@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
	<1362853009-20789-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-3-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  9 Mar 2013 19:16:45 +0100, Lars-Peter Clausen wrote:
> Currently i2c_del_adapter() returns -EINVAL when it gets an adapter which is not
> registered. But none of the users of i2c_del_adapter() depend on this behavior,

At least two used to depend on it actually, and this is even why this
code was added in the first place. See:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2004-November/009350.html
The check was added for the i2c-amd756-s4882 and i2c-nforce2-s4985
old-style SMBus multiplexing drivers.

Meanwhile a safer check was added:

commit 399d6b26539d83dd734746dc2292d53fbc5807b2
Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date:   Sun Aug 10 22:56:15 2008 +0200

    i2c: Fix oops on bus multiplexer driver loading
    
    The two I2C bus multiplexer drivers (i2c-amd756-s4882 and
    i2c-nforce2-s4985) make use of the bus they want to multiplex before
    checking if it is really present. Swap the instructions to test for
    presence first. This fixes a oops reported by Ingo Molnar.
    
So these drivers indeed no longer depend on i2c_del_adapter() to detect
whether their parent I2C adapter has been added or not.

These two drivers should be removed and replaced with code using the
standard I2C multiplexing infrastructure anyway, but it's not clear
when anyone will find the time to actually do that.

> so for the sake of being able to sanitize the return type of i2c_del_adapter
> argue, that the purpose of i2c_del_adapter() is to remove an I2C adapter from
> the system. If the adapter is not registered in the first place this becomes a
> no-op. So we can return success without having to do anything.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a853cb3..7727d33 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1072,7 +1072,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
>  	if (found != adap) {
>  		pr_debug("i2c-core: attempting to delete unregistered "
>  			 "adapter [%s]\n", adap->name);
> -		return -EINVAL;
> +		return 0;
>  	}
>  
>  	/* Tell drivers about this removal */

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

A more radical approach would be to say that you are simply not
supposed to try and remove an adapter that was never added, so the
whole check is pointless and should be removed. After all,
i2c_unregister_device() and i2c_del_driver() do not have such a check.
I don't know how cautious other subsystems are but I suspect most don't
have such a check either.

-- 
Jean Delvare
