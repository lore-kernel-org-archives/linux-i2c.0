From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Mon, 15 Dec 2008 10:15:25 +0000
Message-ID: <20081215101524.GA12431@fluff.org.uk>
References: <20081212152426.745254309@fluff.org.uk> <20081214213349.GA19483@fluff.org.uk> <200812141611.17555.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200812141611.17555.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Dec 14, 2008 at 04:11:17PM -0800, David Brownell wrote:
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

The only other ones that I think would be close are:

       ENOTSUP         Operation not supported (POSIX.1)
       EPROTO          Protocol error (POSIX.1)
       ENOENT	       No such file or directory
       EFAULT	       Bad address

Feedback welcone.
 
> I have no issue with the patch other than that.
> 
> - Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
