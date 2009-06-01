From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: I2C patch merging for embedded systems
Date: Mon, 1 Jun 2009 23:47:02 +0100
Message-ID: <20090601224702.GJ14476@trinity.fluff.org>
References: <8bd0f97a0905312242k451f5492g1a9b3e6d7f7899a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a0905312242k451f5492g1a9b3e6d7f7899a3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 01, 2009 at 01:42:27AM -0400, Mike Frysinger wrote:
> going by MAINTAINERS, Ben Dooks watches over embedded platforms.  does
> that mean you'll merge patches posted (e.g. the Blackfin I2C driver),
> or should i merge them through the Blackfin tree ?  or will Jean still
> do this via his quilt ?

Even if they are going via the blackfin tree, they need to have been
reviewed on ther i2c list by at-least myself and anyone else interested
in these.

For driver additions, I would prefer if they went via me so that we
don't end up with merge fun in the Kconfig of Makefiles.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
