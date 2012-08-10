From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: (i2c-diolan-u2c) Fix master_xfer return code
Date: Fri, 10 Aug 2012 11:28:26 +0530
Message-ID: <CAM=Q2ctnrO6hJkPDa_daDRFNyig3+GVDkgW_MGMjV24jEM8T5Q@mail.gmail.com>
References: <1344527240-18266-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344527240-18266-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Gunter,
A minor suggestion below.

On Thu, Aug 9, 2012 at 9:17 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> The master_xfer function returns 0 on success. It should return the number of
> successful transactions.
>
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-diolan-u2c.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> index aedb94f..dae3ddf 100644
> --- a/drivers/i2c/busses/i2c-diolan-u2c.c
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> @@ -405,6 +405,7 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
>                         }
>                 }
>         }
> +       ret = num;
So if all the messages get transferred this is right.

However if only a few go through should we return the number of
successful transactions
instead of error?

>  abort:
>         sret = diolan_i2c_stop(dev);
>         if (sret < 0 && ret >= 0)
> --
> 1.7.9.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
