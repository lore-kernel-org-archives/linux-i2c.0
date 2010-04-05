From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: i2c-pnx: Improvements and fixes
Date: Tue, 6 Apr 2010 00:00:45 +0100
Message-ID: <20100405230045.GD32401@fluff.org.uk>
References: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
 <a08234131003221009j1ec74009jc2eb289386455b65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a08234131003221009j1ec74009jc2eb289386455b65-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 22, 2010 at 10:09:11AM -0700, Kevin Wells wrote:
> Hi Vitaly,
> 
> Can you please ack these patches for the i2c-pnx driver? These are all
> important changes for the i2c-pnx.

I'm going to take no news as good news, and apply these unless anyone
objects before the pull request.
 
> thanks,
> Kevin
> 
> On Tue, Mar 16, 2010 at 3:55 PM,  <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > This patch set fixes a stop condition issue with transfers, caps
> > the maximum computed divider generated from the parent clock,
> > and disables the I2C peripheral clock when the I2C bus isn't in
> > use (to save power).
> >
> > Patch 3 was previously posted a few months ago, but I didn't
> > follow up on getting it into the driver.
> >
> > All code is tested on the lpc3250.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
