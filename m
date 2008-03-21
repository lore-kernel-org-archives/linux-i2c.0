From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Use of in_atomic in i2c_transfer (Was: use of
 preempt_count instead of in_atomic() at leds-gpio.c)
Date: Fri, 21 Mar 2008 16:42:35 +0100
Message-ID: <20080321164235.26c95e17@hyperion.delvare>
References: <20080316184349.GA28543@khazad-dum.debian.net>
	<200803161246.23909.david-b@pacbell.net>
	<20080318001429.896acf51.akpm@linux-foundation.org>
	<20080320225612.GB20788@khazad-dum.debian.net>
	<20080320164741.734e838c.akpm@linux-foundation.org>
	<20080320180802.426ad2d1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080320180802.426ad2d1.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Mar 2008 18:08:02 -0700, Andrew Morton wrote:
> On Thu, 20 Mar 2008 21:36:04 -0300 Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org> wrote:
> 
> > Well, so far so good for LEDs, but what about the other users of in_atomic
> > that apparently should not be doing it either?
> 
> Ho hum. (...)
>
> ./drivers/i2c/i2c-core.c
> 
>   Possibly buggy: deadlockable
> 
> 
> The usual pattern for most of the above is
> 
> 	if (!in_atomic())
> 		do_something_which_might_sleep();
> 
> problem is, in_atomic() returns false inside spinlock on non-preptible
> kernels.  So if anyone calls those functions inside spinlock they will
> incorrectly schedule and another task can then come in and try take the
> already-held lock.
> 
> Now, it happens that in_atomic() returns true on non-preemtible kernels
> when running in interrupt or softirq context.  But if the above code really
> is using in_atomic() to detect am-i-called-from-interrupt and NOT
> am-i-called-from-inside-spinlock, they should be using in_irq(),
> in_softirq() or in_interrupt().

Mike, Russell: Andrew says that we shouldn't use in_atmomic() in
i2c_transfer(). This means that the approach I suggested to implement
polled-mode to i2c bus drivers, and on which i2c-pxa relies, is not
correct, sorry about that. We will have to come up with something else,
but I am not sure what.

Andrew says that the caller should know in advance whether sleeping is
allowed or not, so we should presumably have a different i2c_transfer
function for cases where the caller can't sleep. In our case my feeling
is that the bus driver knows whether it can sleep or not (at least
that's how it is implemented in i2c-pxa right now) but the caller does
not, so I don't know on what basis a different i2c_transfer would be
called.

Maybe we can move the use_pio flag from pxa-private structure to the
i2c_adapter structure, so that i2c_transfer can access it? Originally I
wanted to avoid making this structure bigger but now it seems we don't
really have the choice.

Please comment.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
