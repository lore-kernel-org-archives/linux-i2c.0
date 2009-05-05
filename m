From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [stable] [PATCH] i2c: fix bit algorithm timeout for low values.
Date: Tue, 5 May 2009 08:05:43 +0200
Message-ID: <20090505080543.50b9e569@hyperion.delvare>
References: <1240528153-5370-1-git-send-email-airlied@gmail.com>
	<20090424114259.70f74ccd@hyperion.delvare>
	<20090504215325.GA31248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090504215325.GA31248-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Greg,

On Mon, 4 May 2009 14:53:25 -0700, Greg KH wrote:
> On Fri, Apr 24, 2009 at 11:42:59AM +0200, Jean Delvare wrote:
> > Hi Dave,
> > 
> > On Fri, 24 Apr 2009 09:09:13 +1000, Dave Airlie wrote:
> > > From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > 
> > > When fetching DDC using i2c algo bit, we were often seeing timeouts
> > > before getting valid EDID on a retry. The VESA spec states 2ms is the
> > > DDC timeout, so when this translates into 1 jiffie and we are close
> > > to the end of the time period, it could return with a timeout less than
> > > 2ms.
> > > 
> > > Change this code to use time_after instead of time_after_eq.
> > > 
> > > Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/i2c/algos/i2c-algo-bit.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> > > index d420cc5..e25e139 100644
> > > --- a/drivers/i2c/algos/i2c-algo-bit.c
> > > +++ b/drivers/i2c/algos/i2c-algo-bit.c
> > > @@ -104,7 +104,7 @@ static int sclhi(struct i2c_algo_bit_data *adap)
> > >  		 * chips may hold it low ("clock stretching") while they
> > >  		 * are processing data internally.
> > >  		 */
> > > -		if (time_after_eq(jiffies, start + adap->timeout))
> > > +		if (time_after(jiffies, start + adap->timeout))
> > >  			return -ETIMEDOUT;
> > >  		cond_resched();
> > >  	}
> > 
> > Applied, thanks. I agree this should go in stable.
> 
> I don't see this in Linus's tree anywhere, am I just missing it?

You're correct, it's not there yet, I'll push it to Linus today. Busy
busy busy.

-- 
Jean Delvare
