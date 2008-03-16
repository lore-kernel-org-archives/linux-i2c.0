From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
 pca-algorithm
Date: Sun, 16 Mar 2008 12:55:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803161249040.20723@shell4.speakeasy.net>
References: <20080308111337.440a7c83@hyperion.delvare>
	<20080310112640.GB12128@pengutronix.de>
	<20080310223116.73277c4f@hyperion.delvare>
	<20080314145010.GA28612@pengutronix.de>
	<20080314194628.07630698@hyperion.delvare>
	<20080316142834.GA4485@pengutronix.de>
	<20080316164457.19157e0c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080316164457.19157e0c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 16 Mar 2008, Jean Delvare wrote:
> On Sun, 16 Mar 2008 15:28:34 +0100, Wolfram Sang wrote:
> > On Fri, Mar 14, 2008 at 07:46:28PM +0100, Jean Delvare wrote:
> >
> > > > +	/* Use gpio_is_valid() when in mainline */
> > > > +	if (i2c->gpio > -1)
> > > > +		ret = gpio_request(i2c->gpio, i2c->adap.name);
> > > > +		if (ret == 0) {
> > > > +			gpio_direction_output(i2c->gpio, 1);
> > > > +			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
> > > > +		} else {
> > > > +			printk(KERN_WARNING "%s: Registering gpio failed!\n",
> > > > +				i2c->adap.name);
> > > > +			i2c->gpio = ret;
> > > > +		}
> > >
> > > You're missing curly braces around this block, aren't you?
> > Holy ..., yes, you are right. This is why I used to have braces even
> > around single instructions after if. This is, where CodingStyle gives me
> > most trouble.
>
> I can't agree more... This type of warning I am carefully ignoring when
> checkpatch.pl complains. In many cases, the extra braces don't hurt and
> protect us against future mistakes.

I've been bit by this exact same problem enough times that I've come to the
same conclusion.  Adding a second statement to a one-statement if and then
forgetting to add the brances almost always produces code that compiles
without warnings and almost works.  It ends up being very hard to track
down, and even when you do, it's easy to stare at right at the bug and not
see the missing braces.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
