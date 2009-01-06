From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: i2c-next pull request
Date: Tue, 6 Jan 2009 16:21:45 +0000
Message-ID: <20090106162145.GJ8032@fluff.org.uk>
References: <E1LJn9P-00013j-2W@teyla.home.fluff.org> <alpine.LFD.2.00.0901051858250.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901051858250.3057-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 05, 2009 at 07:01:34PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 5 Jan 2009, Ben Dooks wrote:
> >
> > are available in the git repository at:
> > 
> >   git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-next
> 
> I fixed up a conflict that _looked_ trivial in 
> drivers/i2c/busses/i2c-s3c2410.c, and since I can't even compile-test it, 
> you should double-check. We had one branch remove the need for 
> regs-gpio.h, and the ARM merge had moved the header files around..
> 
> All the commits in question were actually yours, they just came in from 
> different trees. So if it's not right, I'm sure you can fix it up ;)

Thanks, it compiles fine on the s3c6400, will test the s3c24xx build
later.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
