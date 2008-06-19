From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: multi-master lost-arbitration improvement
 for i2c-algo-pcf (take 2)
Date: Thu, 19 Jun 2008 14:01:43 +0200
Message-ID: <20080619140143.3cd40e71@hyperion.delvare>
References: <ec7cefb0806121410g154b546dx1cb2562898dba4b6@mail.gmail.com>
	<20080613090746.0008ed77@hyperion.delvare>
	<ec7cefb0806181759n56229fbdga0aaa0b6060a6c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ec7cefb0806181759n56229fbdga0aaa0b6060a6c3f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Eric,

On Wed, 18 Jun 2008 17:59:00 -0700, Eric Brower wrote:
> On Fri, Jun 13, 2008 at 12:07 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > You said "not a problem" but you did not change the code? It's still
> > using mdelay rather than msleep. msleep would be more reasonable, you
> > really have no reason to keep the CPU busy while waiting for the other
> > master to complete his transaction. I'm doing this change.
> 
> I recall the reason.  On this implementation (Sun envctrltwo), i2c
> components are used in interrupt context (environmental monitoring
> interrupts are ack'ed by reading a PCF8574).  This is not really
> within the design of the in-kernel I2C subsystem (due to use of
> mutexes in i2c_transfer), but we've managed to wrap all accesses to
> i2c with spinlocks-- ugly, but it lets us work.  I'm not sure if there
> is any work going on to address this drawback, or if any other
> consumer needs in_interrupt access as my driver does.  As an aside,
> this out-of-kernel driver was done as a proof-of-concept to remove
> existing drivers (prior to the i2c subsystem) that do their own I2C;
> you decide which is worse. :)
> 
> My preference is to mdelay() here, so we don't exacerbate the issue of
> sleeping code in the i2c subsystem.  A few bus drivers do this, but
> that is fine-- the bus drivers understand the platform well enough to
> know this is safe for them.  No (other) algo drivers do this.

Actually the i2c-algo-pca driver does sleep (while waiting for bus to
become free.) Given that there are only 3 algo drivers, that's 33% ;)

> If you object, perhaps we can implement a callback in i2c-algo-pcf
> rather than an mdelay value.  A default value could msleep for some
> arbitrary time period (as you have suggested), or can be reassigned to
> mdelay().
> 
> Given the infrequency of lost arbitration, and the lack of any other
> consumers of lab_mdelay in i2c-algo-pcf, I'm voting for mdelay rather
> than a callback implementation.

The infrequency of lost arbitration is hardly an argument. It might be
frequent in some setups, we just don't know. And the increased latency
might be a problem to some, even if not frequent.

I agree that having a callback for lab_mdelay would be overkill.

We already started implementing support for non-sleeping i2c transactions:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=cea443a81c9c6257bf2d00f1392f7d1d4ce03b75

But later on, Andrew Morton complained that this approach (detecting
the context) was wrong and we should always know the context in
advance. Meaning that we should let i2c bus drivers advertise is they
must never sleep. I made a proposal to fix the problem:

http://lists.lm-sensors.org/pipermail/i2c/2008-March/003177.html

but the thread died quickly and nothing actually happened. My plan was
to add a no_sleep flag to struct i2c_adapter, and let i2c_transfer
decide between mutex_trylock and mutex_lock_nested based on this. If we
did that, then i2c-algo-pcf could check the value of this flag to
decide whether mdelay or msleep is the right thing to do.

I didn't have the time (nor motivation) to implement the idea. As you
apparently have an interest in this, would you possibly take care of
this?

For now I've reverted my change, so i2c-algo-pcf uses mdelay again. But
I've added a comment stating that this should be revisited once we have
a way to know if sleeping is OK or not.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
