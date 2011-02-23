From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: implementing a slave driver
Date: Wed, 23 Feb 2011 01:02:16 +0000
Message-ID: <20110223010216.GX15795@trinity.fluff.org>
References: <201102192253.40287.marc.dietrich@ap.physik.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201102192253.40287.marc.dietrich-wkdnK3oF/XPYtB+G+YtuwQgYPMzSbZxj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Dietrich <Marc.Dietrich-wkdnK3oF/XPYtB+G+YtuwQgYPMzSbZxj@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 19, 2011 at 10:53:12PM +0100, Marc Dietrich wrote:
> Hi,
> 
> the HW I'm using (tegra) can be configured to act as a slave. This function is 
> needed to communicate with an embedded controller (which is the master). I 
> like to know if this slave function can/should be implemented in the 
> i2c/busses/i2c-tegra.c driver or better outside, e.g. in the driver for the 
> embedded controller.
> 
> I haven't found any other hw so far which has this function and it seems that 
> the i2c layer does not provide any interface for the communication with a 
> master.

There's a couple of adapters that do this in the ARM world, all the 
samsung ones and the most of the pxas (if not all)

It might be worth doing a simple slave driver, but I'm not sure how
many would really want to use it?

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
