From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 15:24:34 +0100
Message-ID: <20090123152434.423ba1e7@hyperion.delvare>
References: <20090122150230.GA10952@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090122150230.GA10952-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 22 Jan 2009 16:02:30 +0100, Rodolfo Giometti wrote:
> Hello Jean,
> 
> I'm working again on virtual i2c adapter support :) since I received
> several letters asking for this support. That's why I'd like to have
> from you some advice in order to propose a working code.
> 
> Looking at latest i2c code I suppose we can modify the
> i2c_del_driver() function as follow:
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index b1c9abe..3454878 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver)
>         class_for_each_device(&i2c_adapter_class, NULL, driver,
>                               __detach_adapter);
> 
> +       mutex_unlock(&core_lock);
> +
>         driver_unregister(&driver->driver);
>         pr_debug("i2c-core: driver [%s] unregistered\n",
>         driver->driver.name);
> -
> -       mutex_unlock(&core_lock);
>  }
>  EXPORT_SYMBOL(i2c_del_driver);

What tree is this patch against? I can't get it to apply on top of
2.6.29-rc2.

-- 
Jean Delvare
