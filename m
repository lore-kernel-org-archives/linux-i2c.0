From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Thu, 16 Oct 2008 12:13:15 +0200
Message-ID: <20081016121315.2adb5de1@hyperion.delvare>
References: <20080821.024327.144744678.davem@davemloft.net>
	<20081015143321.7df02b35@hyperion.delvare>
	<20081015.143452.114860633.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015.143452.114860633.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Wed, 15 Oct 2008 14:34:52 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Date: Wed, 15 Oct 2008 14:33:21 +0200
> 
> > For another, with the introduction of I2C classes several years ago,
> > I2C device drivers should no longer probe random I2C adapters.  
> 
> Jean, they do, that's why I wrote this change.
> 
> > They should only probe adapters which share a class bit with them,
> 
> The pcf driver sets the class bit used by FAN and temperature sensors,
> so the I2C layer goes poking around all of the standard address
> locations each of those drivers list.

By setting this class flag in your driver, you ask for these probes.

> I don't want that to happen, ever.  I know exactly what address each
> and every I2C device sits at, so I don't want auto probing at all even
> even if the class bits match.

Then just don't set any class flag in your i2c bus driver and you're
done. Easy as that, just as was done by the powerpc folks for the
i2c-mpc driver (as you just found out yourself.)

> Again where the heck were you two months ago when I submitted these
> changes originally?  I could have been working on changes meanwhile,
> but instead you're reviewing this stuff _NOW_ in the middle of the
> merge window when I have to be on top of things for networking and
> sparc stuff going into the tree.

Two months ago, I was processing all the patches and other requests
that had been sent to me while I was on vacation. I was also taking
care of my family. The fact that I didn't review your patches when you
sent them is unfortunate, but it happened, and similar events will
happen again in the future because there's only so many hours in a day
and only so much work I can do for free on my spare time. Whatever my
wife and baby daughter need from me has higher priority than kernel
patches. You can understand that, can't you?

You're complaining because I'm reviewing your patches during the merge
window. But you did you not bother reminding me about these patches
earlier, while it was pretty obvious that I had missed them? My i2c
patch set is public [1] and if a patch isn't there then it won't go to
Linus. You're blaming it on me, but you could as well blame it on
yourself.

I'm not quite sure why you are complaining anyway. I finally reviewed
your patches. And as far as this one is concerned, I just gave you a
much simpler way to achieve what you wanted to achieve.

[1] http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
