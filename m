From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: (i2c-diolan-u2c) Fix master_xfer return code
Date: Fri, 10 Aug 2012 10:06:24 -0700
Message-ID: <20120810170624.GC29281@roeck-us.net>
References: <1344527240-18266-1-git-send-email-linux@roeck-us.net>
 <CAM=Q2ctnrO6hJkPDa_daDRFNyig3+GVDkgW_MGMjV24jEM8T5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctnrO6hJkPDa_daDRFNyig3+GVDkgW_MGMjV24jEM8T5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 10, 2012 at 11:28:26AM +0530, Shubhrajyoti Datta wrote:
> Hi Gunter,
> A minor suggestion below.
> 
> On Thu, Aug 9, 2012 at 9:17 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > The master_xfer function returns 0 on success. It should return the number of
> > successful transactions.
> >
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-diolan-u2c.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> > index aedb94f..dae3ddf 100644
> > --- a/drivers/i2c/busses/i2c-diolan-u2c.c
> > +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> > @@ -405,6 +405,7 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
> >                         }
> >                 }
> >         }
> > +       ret = num;
> So if all the messages get transferred this is right.
> 
> However if only a few go through should we return the number of
> successful transactions
> instead of error?
> 
Most other I2C bus drivers do the same, so I decided to not make the code
more complicated than necessary and do it the same way. Also, I prefer to have
the actual error code returned to the caller, not "I transferred x of your y
messages, but I won't tell you what went wrong with the rest".

If that prevents it from getting integrated, I'll be happy to change it. 

Thanks,
Guenter
