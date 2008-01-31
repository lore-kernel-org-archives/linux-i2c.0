From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
	support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 15:56:04 -0800
Message-ID: <200801311556.05395.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<200801310248.41076.david-b@pacbell.net>
	<Pine.LNX.4.64.0801311425300.6494@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311425300.6494-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> On Thu, 31 Jan 2008, David Brownell wrote:
> 
> > > > > > +#ifndef NO_GPIO
> > > > > > +#define NO_GPIO                        ((unsigned int)-1)
> > > > > > +#endif
> > > > > > +
> > > > > 
> > > > > I don't understand this.
> > > > 
> > > > Me either; *ANY* negative number is invalid as a GPIO number,
> > > > not just "-1"...
> > > 
> > > Ok, this one should rather go into a separate patch. I'd like to have such 
> > > a macro to check whether the platform is using a GPIO with this specific 
> > > camera or not. Similar to NO_IRQ.
> > 
> > Then maybe there should be an is_valid_gpio() predicate.
> > Anything not between 0..MAX_INT would fail.  And there
> > should be a Documentation/gpio.txt update to match.
> 
> hm, but if you deliberately want an invalid gpio number?

Any negative number suffices -- like "-EINVAL".  But that's a
separate problem from the one you said you wanted to solve...

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
