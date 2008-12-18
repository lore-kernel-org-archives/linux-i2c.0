From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Thu, 18 Dec 2008 10:16:27 -0800
Message-ID: <200812181016.28184.david-b@pacbell.net>
References: <20081212152426.745254309@fluff.org.uk> <20081215101616.GB12431@fluff.org.uk> <20081215112226.18f7fb29@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081215112226.18f7fb29-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 15 December 2008, Jean Delvare wrote:
> 
> > > > I was thinking that -EINVAL is almost the least informative
> > > > diagnostic code possible, since so many places return it
> > > > that it's usually hard to find out *which* invalid parameter
> > > > triggered ...
> > > > 
> > > > Is there a less-overloaded code you could return?
> > > 
> > > -EINVAL sounds right to me, all that's really missing is dev_dbg()
> > > messages in the drivers to log what the exact problem was. 

Fair enough, though it just papers over how ambiguous -EINVAL is.


> > It might be more acceptable to be dev_err(), that way it will get
> > printed no matter what debug options have been selected. If so, a
> > seperate patch is probably in order to make the change.
> 
> As far as I can see, such errors would be caused by development-time
> mistakes, so dev_dbg() seems appropriate. dev_err() would make the
> binaries larger for all end-users.

Right, dev_dbg() is the way to go.  I'd ack a version of this patch
which pairs these -EINVAL changes with dev_dbg() messages to make
these problems less painful to track down.  dev_err() is much abused.

- Dave
