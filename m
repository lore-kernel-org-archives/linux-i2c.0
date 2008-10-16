From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Thu, 16 Oct 2008 14:57:41 +0200
Message-ID: <20081016145741.1d94f482@hyperion.delvare>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
	<20081015.143212.196108134.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015.143212.196108134.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
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
Cc: mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Wed, 15 Oct 2008 14:32:12 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Date: Wed, 15 Oct 2008 14:19:14 +0200
> 
> > Of course we can start with a local implementation in i2c-algo-pcf and
> > we move it to i2c-core later if needed.
> 
> Please let's be practical and handle things this way.
> 
> > That's not exactly elegant. I'd rather make .xfer_begin and .xfer_end
> > optional and check for NULL before calling them from pcf_xfer(). That's
> > less intrusive also, you don't even need to touch the individual bus
> > drivers using the i2c-algo-pcf module if they don't need these hooks.
> 
> I think it's more elegant to remove as many conditionals from
> generic code as possible.

I see many good reasons to prefer having conditionals in a central
place over empty callback functions in virtually every i2c bus driver.

First reason: I don't expect many drivers to make use of the pre/post
transaction hooks. Given that a test is cheaper than a function call,
overall performance with conditionals should be better. I suspect this
will also make the builds faster and the binary code smaller (although
I'm not going to benchmark it.)

Second reason: with empty callback functions, it's not immediately
obvious which i2c bus drivers use these hooks and which do not. This
case is specific enough that I think there is value in being able to
trace it.

Third reason: changing things in a central place is easier. You may
not think it's important because there is a rather small number of
PCF8454-based bus drivers are the moment, but if we do the same for
i2c-algo-bit, it has no less than 27 users and I don't feel like
changing them all. If the prototype of the hooks ever changes, having
to go through several dozen drivers to update otherwise useless
callback functions sounds plain wrong. Same if we implement the hooks in
i2c-algo-pcf and i2c-algo-bit today and later decide to move them to
i2c-core: having 2 i2c algo drivers to update is fairly easy, having 30
i2c bus drivers to update is much more work.

I'm not sure what are your reasons for preferring empty callback
functions? I can't remember seeing this approach used in any part of
the kernel I touched. And for what it's worth, i2c-core is full of
tests for callback functions, and I can't remember anyone objecting.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
