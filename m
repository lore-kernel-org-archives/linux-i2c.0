From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Mon, 15 Dec 2008 08:46:00 +0100
Message-ID: <20081215084600.5d237fea@hyperion.delvare>
References: <20081212152426.745254309@fluff.org.uk>
	<20081214213349.GA19483@fluff.org.uk>
	<200812141611.17555.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812141611.17555.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 14 Dec 2008 16:11:17 -0800, David Brownell wrote:
> On Sunday 14 December 2008, Ben Dooks wrote:
> > Has anyone reveiwed this patch? Are there any comments, or can this
> > be commited at somepoint (even if it is during the next merge window)?
> 
> I was thinking that -EINVAL is almost the least informative
> diagnostic code possible, since so many places return it
> that it's usually hard to find out *which* invalid parameter
> triggered ...
> 
> Is there a less-overloaded code you could return?

-EINVAL sounds right to me, all that's really missing is dev_dbg()
messages in the drivers to log what the exact problem was. 

> I have no issue with the patch other than that.

-- 
Jean Delvare
