From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 23:12:19 +0200
Message-ID: <20080604231219.67c3a4c8@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041155n7551ac74lf29c8a32163ec09a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Wed, 4 Jun 2008 14:55:06 -0400, Jon Smirl wrote:
> On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >  This patch set demonstrates a new concept which I would like to add to
> >  the i2c subsystem. It is named "i2c listeners" and is based on the
> >  following structure:
> 
> How does this fit in with the existing driver bus structure in kernel?

It's outside of the bus structure. The device driver model defines how
drivers bind to the devices they support. It doesn't imply much on how
devices are instantiated. For bus types where the present devices are
enumerated (like PCI) the device instantiation is pretty
straightforward, but in the case of I2C/SMBus where you have to either
know in advance or actively probe and guess which devices are there,
you clearly need additional code and strategy to instantiate the
devices.

That's the very reason why the i2c subsystem didn't originally follow
the device driver model (until David converted it to add support for
the standard model in addition to our custom one.)

> This sounds a lot like hot plug and buses already implement hot plug
> events.  This isn't exactly hot plug but it may be close enough that
> the existing bus APIs will work. Note that both devices and entire
> buses can be hot plugged with existing code.

I don't think it is related to hotplug at all. The issue here is not
whether devices are hotplugged or not. It's also not about how the
drivers are notified about devices and how they bind to them. The issue
is the step before that: how do you find and instantiate the devices if
you have no preliminary knowledge on what devices are present.

Now, if I have really been duplicating a mechanism that exists in the
driver core, I'll be happy to simplify my code to take benefit of it.
But then please point me to the exact piece of code you're thinking
about.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
