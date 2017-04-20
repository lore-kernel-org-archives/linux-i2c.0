From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: make sure i2c_master_send/recv return negative
 error codes
Date: Thu, 20 Apr 2017 12:41:43 +0200
Message-ID: <20170420124143.606ae032@endymion>
References: <20170401175435.GA12354@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S940574AbdDTKlq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 06:41:46 -0400
In-Reply-To: <20170401175435.GA12354@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmirty,

On Sat, 1 Apr 2017 10:54:35 -0700, Dmitry Torokhov wrote:
> There is theoretical possibility that i2c_master_send() and
> i2c_master_recv() may return non-negative result on error: we pass
> return values from i2c_xfer() unmodified to the caller, unless we
> transferred exactly 1 message. Let's ensure we always return negative on
> error.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/i2c/i2c-core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6efeba42d10b..34b0482333f4 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2835,7 +2835,10 @@ int i2c_master_send(const struct i2c_client *client, const void *buf, int count)
>  	 * If everything went ok (i.e. 1 msg transmitted), return #bytes
>  	 * transmitted, else error code.
>  	 */
> -	return (ret == 1) ? count : ret;
> +	if (likely(ret == 1))
> +		return count;
> +
> +	return ret < 0 ? ret : -EIO;
>  }
>  EXPORT_SYMBOL(i2c_master_send);
>  
> @@ -2865,7 +2868,10 @@ int i2c_master_recv(const struct i2c_client *client, void *buf, int count)
>  	 * If everything went ok (i.e. 1 msg received), return #bytes received,
>  	 * else error code.
>  	 */
> -	return (ret == 1) ? count : ret;
> +	if (likely(ret == 1))
> +		return count;
> +
> +	return ret < 0 ? ret : -EIO;
>  }
>  EXPORT_SYMBOL(i2c_master_recv);
>  

I'm not convinced.

Firstly, that would be a device driver bug, and I can't see how
silently working around it here helps. If a driver is broken, it should be
fixed. So I would expect a log message.

Secondly, I believe i2c_master_send() and i2c_master_recv() should be
able to trust the return value of i2c_transfer(), which in turn should
be able to trust the return value of __i2c_transfer(). If you really
want to check the value returned by i2c_algo->master_xfer() for
validity, this should be done in __i2c_transfer(). But then again, I
find it hard to justify the run-time overhead for working drivers, so
maybe it should only be done if CONFIG_I2C_DEBUG_BUS is enabled.

-- 
Jean Delvare
SUSE L3 Support

-- 
Jean Delvare
SUSE L3 Support

-- 
Jean Delvare
SUSE L3 Support
