From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Thu, 18 Dec 2008 22:29:36 +0000
Message-ID: <20081218222936.GI8032@fluff.org.uk>
References: <20081212152426.745254309@fluff.org.uk> <20081215101616.GB12431@fluff.org.uk> <20081215112226.18f7fb29@hyperion.delvare> <200812181016.28184.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200812181016.28184.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 18, 2008 at 10:16:27AM -0800, David Brownell wrote:
> On Monday 15 December 2008, Jean Delvare wrote:
> > 
> > > > > I was thinking that -EINVAL is almost the least informative
> > > > > diagnostic code possible, since so many places return it
> > > > > that it's usually hard to find out *which* invalid parameter
> > > > > triggered ...
> > > > > 
> > > > > Is there a less-overloaded code you could return?
> > > > 
> > > > -EINVAL sounds right to me, all that's really missing is dev_dbg()
> > > > messages in the drivers to log what the exact problem was. 
> 
> Fair enough, though it just papers over how ambiguous -EINVAL is.

Unforunately there's not a lot of choice in errno.h for other options.
 
> > > It might be more acceptable to be dev_err(), that way it will get
> > > printed no matter what debug options have been selected. If so, a
> > > seperate patch is probably in order to make the change.
> > 
> > As far as I can see, such errors would be caused by development-time
> > mistakes, so dev_dbg() seems appropriate. dev_err() would make the
> > binaries larger for all end-users.
> 
> Right, dev_dbg() is the way to go.  I'd ack a version of this patch
> which pairs these -EINVAL changes with dev_dbg() messages to make
> these problems less painful to track down.  dev_err() is much abused.

Ok, I'll try and sort that out for you as soon as possible.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
