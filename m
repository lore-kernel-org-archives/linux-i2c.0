From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: new style i2c client problem: probe () is not called
Date: Wed, 14 May 2008 22:20:06 +0100
Message-ID: <20080514212006.GA16881@fluff.org.uk>
References: <g0bqa9$b3$1@ger.gmane.org> <20080513104921.GA4485@pengutronix.de>
	<g0bub0$eqh$1@ger.gmane.org>
	<20080513141337.20068339@hyperion.delvare>
	<g0c2qb$ue1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <g0c2qb$ue1$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 13, 2008 at 03:45:29PM +0300, Darius wrote:
>   > This code looks OK to me. But which driver handles i2c bus 0? Does your
> > platform code create i2c bus 0? i2c-code will instantiate the ov7670
> > i2c device when i2c bus 0 is created by i2c_add_numbered_adapter(). So
> > if you don't see it created, I suspect that i2c bus 0 itself is never
> > registered.
> > 
> 
> Thanks, there was the problem. I have modified i2c adapter driver to use 
>   i2c_add_numbered_adapter() instead i2c_add_adapter() and pass to the 
> adapter->nr = pdev->id. now probe is called.

I'm not so sure this 1:1 mapping of platform to i2c bus ID is such a
good idea, what if you have two i2c controllers and want to swap the
two of them around?
 
> Jean, what do you think about adding my i2c driver to mainline kernel?
> I've added this to Russel patch tracking system. Now it is a bit 
> ugraded. Should I make new patch and send it here?

As a rule, stuff that touches drivers/i2c should be submitted via the
i2c list with a cc: to the architecture specific list as a courtesy to
the maintainer of that arch. It is not really within Russell (or any
other arch maintainer) remit to be actually submitting upstream for
drivers/i2c.

If a patch really has to touch both drivers/i2c and some other part of
the kernel, then it either is up to the architecture maintainer(s) to
ack the package for inclusion via the i2c tree, or up to both the i2c
and architecture maintainers to get someone like akpm to merge.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
