From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: timeouts reach -1
Date: Sun, 1 Feb 2009 13:18:54 +0100
Message-ID: <20090201131854.64f54b28@hyperion.delvare>
References: <49842682.2020903@gmail.com>
	<20090131221043.23d3ecab@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090131221043.23d3ecab-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 31 Jan 2009 22:10:43 +0100, Jean Delvare wrote:
> Hi Roel,
> 
> On Sat, 31 Jan 2009 11:22:58 +0100, Roel Kluin wrote:
> > With a postfix decrement these timeouts reach -1 rather than 0,
> > but after the loop it is tested whether they have become 0.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > (...)
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index 6af6814..6379ec1 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -644,7 +644,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
> >  
> >  	i2c_pxa_start_message(i2c);
> >  
> > -	while (timeout-- && i2c->msg_num > 0) {
> > +	while (--timeout && i2c->msg_num > 0) {
> >  		i2c_pxa_handler(0, i2c);
> >  		udelay(10);
> >  	}
> 
> Good catch. Applied, thanks for reporting.

On second thought, shouldn't the msg_num test be done first and the
timeout test second? With the current order, you could exit with a
timeout error while all the messages were successfully transferred.

-- 
Jean Delvare
