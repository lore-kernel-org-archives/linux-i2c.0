From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Date: Fri, 2 May 2008 16:46:10 +0200
Message-ID: <20080502164610.277ec04b@hyperion.delvare>
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
	<9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910805020723p7900c132j872893113f9d739e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Fri, 2 May 2008 10:23:01 -0400, Jon Smirl wrote:
> On 2/19/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >  >       i2c->irq = platform_get_irq(pdev, 0);
> >  > -     if (i2c->irq < 0) {
> >  > +     if (i2c->irq < NO_IRQ) {
> >
> >
> > I am skeptical about this one. Can platform_get_irq() really return
> >  NO_IRQ? I thought that the IRQ resource would be plain missing if the
> >  device has no IRQ, so I would expect:
> >
> >
> >         i2c->irq = platform_get_irq(pdev, 0);
> >         if (i2c->irq < 0)
> >
> >                 i2c->irq = NO_IRQ; /* Use polling */
> >
> >  Testing against NO_IRQ suggests that devices with no IRQ would still
> >  have an IRQ resource defined and explicitly set to NO_IRQ. Sounds weird
> >  to me. Can you please clarify this point?
> 
> Your fix is correct. I'm not sure polling worked in the original driver.

OK, can you send an updated patch then?

Thanks.

> >  For what it's worth, no other kernel driver checks for irq < NO_IRQ.
> >  They all check for irq < 0 after calling platform_get_irq().
> >
> >
> >  >               result = -ENXIO;
> >  >               goto fail_get_irq;
> >  >       }

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
