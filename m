From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 09:51:10 +0100
Message-ID: <20090123095110.7b0c7b82@hyperion.delvare>
References: <20090122150230.GA10952@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090122150230.GA10952-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

On Thu, 22 Jan 2009 16:02:30 +0100, Rodolfo Giometti wrote:
> Hello Jean,
> 
> I'm working again on virtual i2c adapter support :) since I received
> several letters asking for this support. That's why I'd like to have
> from you some advice in order to propose a working code.

Thanks for keeping up with this despite my lack of support. I really
hope that we can get this done this year.

Did you speak with Dave Miller already? Some months ago he proposed an
horrible hack to implement support for I2C bus multiplexing, which I
nacked and I pointed him to you.

Last year I have been working with David Brownell of cleaning up
i2c-core so that adding things like multiplexing support is easier, in
particular when it comes to the locking model. It's not completely done
yet but I think we're on the right track. My hope was that we could
finish the cleanups first and add multiplexing support only then, but
maybe I was too optimistic, the cleanups take longer than I expected.

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
> 
> Unluckely I'm not an i2c guru so I'd like to ask to you. If such
> modification is correct I can provide a simple support with no
> modifications to the i2c core! Apart this one, of course... :)

Honestly, I am not sure either. The locking model isn't completely
cleared yet, we still need to get rid of the 3 dozen remaining legacy
i2c chip drivers before we can finish it. I _think_ the above it
correct, after all we do not hold the lock when calling
driver_register() so I can't see why we would need to hold it when
calling driver_unregister()... unless either i2c_client_release() or
i2c_client_dev_release() needs this.

David should know better, as he designed the thing in the first place.
David, can you please comment on the proposed change?

> If you agree I can send a patchset, but everything is based on the
> above change...

I would like to propose that you create yourself an account on
i2c.wiki.kernel.org. I've just added a "Work in progress" section on
the main page so that other interested developers can keep track of
what is happening. You could create a page describing your progress and
things that need to be done. And I should do the same for my part.

Oh, and please stop calling the thing "virtual i2c adapter support".
These adapters are very real. What you are working on is better
described as "i2c bus multiplexing support".

Thanks,
-- 
Jean Delvare
