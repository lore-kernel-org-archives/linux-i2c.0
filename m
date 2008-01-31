From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [i2c] [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
 support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 14:30:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311425300.6494@axis700.grange>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<200801302052.04336.david-b@pacbell.net>
	<Pine.LNX.4.64.0801311025210.6494@axis700.grange>
	<200801310248.41076.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801310248.41076.david-b@pacbell.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jan 2008, David Brownell wrote:

> > > > > +#ifndef NO_GPIO
> > > > > +#define NO_GPIO                        ((unsigned int)-1)
> > > > > +#endif
> > > > > +
> > > > 
> > > > I don't understand this.
> > > 
> > > Me either; *ANY* negative number is invalid as a GPIO number,
> > > not just "-1"...
> > 
> > Ok, this one should rather go into a separate patch. I'd like to have such 
> > a macro to check whether the platform is using a GPIO with this specific 
> > camera or not. Similar to NO_IRQ.
> 
> Then maybe there should be an is_valid_gpio() predicate.
> Anything not between 0..MAX_INT would fail.  And there
> should be a Documentation/gpio.txt update to match.

hm, but if you deliberately want an invalid gpio number?

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
