From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: add i2c_check_quirks helper function
Date: Sat, 31 Oct 2015 10:18:41 +0000
Message-ID: <56349581.8070900@kernel.org>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-4-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446118467-26453-4-git-send-email-nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 29/10/15 11:34, Nicola Corna wrote:
> This patch adds a i2c_check_quirks helper function to check the quirk flags
> of an i2c adapter, in a similar way to i2c_check_functionality.
> 
> Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
I don't know about everyone else, but I'm finding this particular style
of email thread very difficult to follow.
Perhaps either:
* Start a new thread for each new series version.
* label the whole series with a rolling version number rather than doing it
  on a per patch basis.

Would just make it easier to keep track when one reads the thread a while
after it started!

Jonathan
> ---
>  include/linux/i2c.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 9697002..51028f3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -617,6 +617,20 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
>  	return (func & i2c_get_functionality(adap)) == func;
>  }
>  
> +/**
> + * i2c_check_quirks() - Function for checking the quirk flags in an i2c adapter
> + * @adap: i2c adapter
> + * @quirks: quirk flags
> + *
> + * Return: true if the adapter has all the specified quirk flags, false if not
> + */
> +static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
> +{
> +	if (!adap->quirks)
> +		return false;
> +	return (adap->quirks->flags & quirks) == quirks;
> +}
> +
>  /* Return the adapter number for a specific adapter */
>  static inline int i2c_adapter_id(struct i2c_adapter *adap)
>  {
> 
