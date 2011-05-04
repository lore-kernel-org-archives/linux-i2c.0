From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [REPOST PATCH] i2c: pxa2xx: remove ifdef CONFIG_OF
Date: Wed, 4 May 2011 22:52:02 +0100
Message-ID: <20110504215202.GZ15795@trinity.fluff.org>
References: <20110411083447.GB4018@linutronix.de> <20110503135826.GA4966@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110503135826.GA4966-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 03, 2011 at 07:58:26AM -0600, Grant Likely wrote:
> On Mon, Apr 11, 2011 at 10:34:47AM +0200, Sebastian Andrzej Siewior wrote:
> > Since commit c9e358d ("driver-core: remove conditionals around
> > devicetree pointers") there is no need for CONFIG_OF around of_node and
> > of_match_table. Grant removed this ifdefs from all driver which were in
> > tree at the time, this one was merged later.
> > 
> > Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> 
> Hey Ben,
> 
> Can you pick up this patch?

ok, will sort this out.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
