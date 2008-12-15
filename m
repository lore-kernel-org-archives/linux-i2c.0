From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Mon, 15 Dec 2008 11:22:26 +0100
Message-ID: <20081215112226.18f7fb29@hyperion.delvare>
References: <20081212152426.745254309@fluff.org.uk>
	<20081214213349.GA19483@fluff.org.uk>
	<200812141611.17555.david-b@pacbell.net>
	<20081215084600.5d237fea@hyperion.delvare>
	<20081215101616.GB12431@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081215101616.GB12431-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 15 Dec 2008 10:16:16 +0000, Ben Dooks wrote:
> On Mon, Dec 15, 2008 at 08:46:00AM +0100, Jean Delvare wrote:
> > On Sun, 14 Dec 2008 16:11:17 -0800, David Brownell wrote:
> > > On Sunday 14 December 2008, Ben Dooks wrote:
> > > > Has anyone reveiwed this patch? Are there any comments, or can this
> > > > be commited at somepoint (even if it is during the next merge window)?
> > > 
> > > I was thinking that -EINVAL is almost the least informative
> > > diagnostic code possible, since so many places return it
> > > that it's usually hard to find out *which* invalid parameter
> > > triggered ...
> > > 
> > > Is there a less-overloaded code you could return?
> > 
> > -EINVAL sounds right to me, all that's really missing is dev_dbg()
> > messages in the drivers to log what the exact problem was. 
> 
> It might be more acceptable to be dev_err(), that way it will get
> printed no matter what debug options have been selected. If so, a
> seperate patch is probably in order to make the change.

As far as I can see, such errors would be caused by development-time
mistakes, so dev_dbg() seems appropriate. dev_err() would make the
binaries larger for all end-users.

-- 
Jean Delvare
