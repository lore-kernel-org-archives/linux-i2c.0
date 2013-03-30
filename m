From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: Remove detach_adapter
Date: Sat, 30 Mar 2013 15:52:01 +0100
Message-ID: <20130330155201.1e145ed6@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
	<1362853009-20789-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars,

On Sat,  9 Mar 2013 19:16:44 +0100, Lars-Peter Clausen wrote:
> The detach_adapter callback has been deprecated for quite some time and has no
> user left. Keeping it alive blocks other cleanups, so remove it.

I'm all for it. Originally I intended to remove both attach_adapter and
detach_adapter at the same time, unfortunately there are still users of
attach_adapter around, despite it being deprecated for 2 or 3 years
now. So the patch removing them is still sitting on my disk. Getting
rid of at least detach_adapter now is a good idea.

One minor comment:

> @@ -1088,11 +1077,9 @@ int i2c_del_adapter(struct i2c_adapter *adap)
>  
>  	/* Tell drivers about this removal */
>  	mutex_lock(&core_lock);
> -	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
> +	bus_for_each_drv(&i2c_bus_type, NULL, adap,
>  			       __process_removed_adapter);

This would fit on a single line now.

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
