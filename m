From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Mon, 27 Sep 2010 18:10:05 +0530
Message-ID: <1285591205.3643.63.camel@localhost.localdomain>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	 <1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	 <AANLkTimqT=xgoxycjFAwEr6LPTeK21-FB1F-7kP5baPE@mail.gmail.com>
Reply-To: pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimqT=xgoxycjFAwEr6LPTeK21-FB1F-7kP5baPE-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pablo Bitton <pablo.bitton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Pablo,

On Mon, 2010-09-13 at 16:23 +0200, Pablo Bitton wrote:
> Hi Philby,
>         i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
>                                                 char allow_sleep)
>          {
>                unsigned long timeout;
>         +       static u16 to_cnt;
>         
>                timeout = jiffies + dev->adapter.timeout;
>                while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
>                       & DAVINCI_I2C_STR_BB) {
>         -               if (time_after(jiffies, timeout)) {
>         -                       dev_warn(dev->dev,
>         -                                "timeout waiting for bus
>         ready\n");
>         -                       return -ETIMEDOUT;
>         +               if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
>         +                       if (time_after(jiffies, timeout)) {
>         +                               dev_warn(dev->dev,
>         +                               "timeout waiting for bus ready
>         \n");
>         +                               to_cnt++;
>         +                               return -ETIMEDOUT;
>         +                       } else {
>         +                               to_cnt = 0;
>         +                               i2c_recover_bus(dev);
>         +                               i2c_davinci_init(dev);
>         +                       }
>                        }
>                        if (allow_sleep)
>                                schedule_timeout(1);
>  
> The resulting loop has the following drawbacks:
> 1) If to_cnt reaches DAVINCI_I2C_MAX_TRIES+1 (which it currently
> can't, see 2) and the i2c bus collapses,
>     the kernel will be stuck in the loop forever, especially if
> allow_sleep is false.

I do not understand how to_cnt can reach DAVINCI_I2C_MAX_TRIES+1. You
seem to be contradicting your own statement, you also say that this
cannot happen!!

> 2) The to_cnt static var never increments beyond 1.
Precisely.

>  It's initialized to zero and then kept at zero until the timeout
> expires.
>     When the timeout expires, to_cnt is incremented once, until the
> next call to the function, where it will be zeroed again.

How then can your 1st assumption hold good?

>  3) Do we really want to retry recovering the bus thousands of times,
> until the timeout arrives?
>     It seems to me that if the bus recovery procedure didn't help
> after one or two tries, it probably never will.

Once a bus recovery is initiated, we are in the last phase of a recovery
and if that fails the user is left with no other choice but to reset the
target. From the very beginning the idea was to try until timeout.
Wouldn't you have a working system rather than to have to reset the
target?

> 
>  
> I  also have the following nitpicks:
> a) The timeout variable actually holds the finish time.
Well, that's just aesthetic makeover. I could say the timeout is 10
seconds and the finish time is 10 seconds, it sounds the same to me.

> b) The i2c_recover_bus function uses dev_err to report a bus recovery
> process,
>     but if all recovery attempts failed and the timeout was reached,
> only dev_warn is used to report the timeout.

Agreed. But your patch does not reflect this change.

> 
>  
> Other than that the patch is very helpful, thanks a lot.
> 
>  
> Below is my suggestion for the wait_bus_not_busy function. My patch
> has been tested on a DM6446.

All in all, your patch gives multiple checkpatch errors/warnings (spaces
instead of tabs etc). You have missed out parts of the code present in
the pristine kernel and so will not cleanly apply. To me, there are two
things that are of interest in your patch. First is you got rid of the
static variable definition and the other is usage of dev_err. I fail to
understand your assumption that the "kernel will be stuck in the loop
forever", hence I cannot tell how useful this patch really is.

> 
>  
> Signed-off-by: Pablo Bitton <pablo.bitton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> --
> diff --git a/drivers/i2c/busses/i2c-davinci.c
> b/drivers/i2c/busses/i2c-davinci.c
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> 
> 
> 
> 
> 
> @@ -220,16 +261,24 @@ static int i2c_davinci_init(struct
> davinci_i2c_dev *dev)
>  static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
>                                char allow_sleep)
>  {
> -     unsigned long timeout;
> +     unsigned long finish_time;
You have missed out on this line static u16 to_cnt;
> +     unsigned long to_cnt = 0;

>  
> -     timeout = jiffies + dev->adapter.timeout;
> +     finish_time = jiffies + dev->adapter.timeout;
> +     /* While bus busy */
>       while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
>              & DAVINCI_I2C_STR_BB) {

Your patch misses out on this line. 
if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
Shouldn't you show removing it in the patch?
> -           if (time_after(jiffies, timeout)) {
> +           if (time_after(jiffies, finish_time)) {
>                   dev_warn(dev->dev,
>                          "timeout waiting for bus ready\n");
This is the part where the bus recover procedure would have failed. In
this case we could use dev_err here instead of in the function
i2c_recover_bus().

Also this line..
to_cnt++;
is missing from your patch.
You should show that you are removing it.
>                   return -ETIMEDOUT;
>             }
> +           else if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> +                 dev_warn(dev->dev, "bus busy, performing bus
> recovery\n");
There is already a warning in the function i2c_recover_bus(). This can
be removed?
> +                   ++to_cnt;
Can we stick to to_cnt++; ?
> +                       i2c_recover_bus(dev);
> +                       i2c_davinci_init(dev);
> +           }
>             if (allow_sleep)
>                   schedule_timeout(1);
>       }

Regards,
Philby
