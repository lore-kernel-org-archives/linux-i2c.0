From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/1] Better i2c access latencies in high load situations
Date: Mon, 21 Sep 2009 18:30:03 +0200
Message-ID: <20090921183003.7892a109@hyperion.delvare>
References: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
	<20090916134944.4a329d62@hyperion.delvare>
	<1253102935.13914.7.camel@adserver2>
	<20090916224328.47e349ab@hyperion.delvare>
	<1253538847.3157.56.camel@adserver2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253538847.3157.56.camel@adserver2>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

On Mon, 21 Sep 2009 16:14:07 +0300, Mika Kuoppala wrote:
> On Wed, 2009-09-16 at 22:43 +0200, ext Jean Delvare wrote:
> > On Wed, 16 Sep 2009 15:08:55 +0300, Mika Kuoppala wrote:
> > > Hi Jean,
> > > 
> > > On Wed, 2009-09-16 at 13:49 +0200, ext Jean Delvare wrote:
> > > 
> > > > Can you please define "get a kick"? I don't know anything about
> > > > rt_mutex.
> > > > 
> > > 
> > > Sorry for using a vague metaphor. Documentation/rt-mutex.txt explains it
> > > as:
> > > 
> > > "A low priority owner of a rt-mutex inherits the priority of a higher
> > > priority waiter until the rt-mutex is released. If the temporarily
> > > boosted owner blocks on a rt-mutex itself it propagates the priority
> > > boosting to the owner of the other rt_mutex it gets blocked on. The
> > > priority boosting is immediately removed once the rt_mutex has been
> > > unlocked."
> > > 
> > > You might want to also take a look at Documentation/rt-mutex-design.txt
> > 
> > Thanks for the clarification. It all makes a lot of sense. I'll give
> > your patch a try, although I don't use I2C for anything time-critical
> > so I doubt it makes a difference for me.
> > 
> 
> I tried to write an application which could show the priority inversion
> in action on top of this bus mutex. This application spawns 3 different
> child processes each reading one byte of data from a specified slave
> address and register. Multiple times. Each child has different priority.
> The program to produce these results is at the end of this email.
> 
> Without patch: i2c: Prevent priority inversion on top of bus lock
> ~ # ./a.out
> Spawning 3 workers with different priorities
> Each worker will read one byte from /dev/i2c-2:0x4b:0x00 10000 times
> ( 941)PRIO -5     rt  7973 ms lat:  579 min, 313294 max,  795 avg (us)
> ( 940)PRIO 0      rt 16412 ms lat:  549 min, 796479 max, 1637 avg (us)
> ( 942)SCHED_FIFO  rt 28148 ms lat:  580 min, 796509 max, 1535 avg (us)
> Total run time 28152313 usecs
> 
> With patch: i2c: Prevent priority inversion on top of bus lock
> ~ # ./a.out
> Spawning 3 workers with different priorities
> Each worker will read one byte from /dev/i2c-2:0x4b:0x00 10000 times
> ( 960)PRIO -5     rt 13069 ms lat:  580 min,   2472 max, 1302 avg (us)
> ( 959)PRIO 0      rt 20420 ms lat:  519 min,  16632 max, 2037 avg (us)
> ( 961)SCHED_FIFO  rt 20420 ms lat:  580 min,   1282 max,  762 avg (us)
> Total run time 20424682 usecs
> 
> PRIO -5 and PRIO 0 process are busylooping on top of i2c_read and the
> SCHED_FIFO is sleeping 1ms after each read for not to steal all cpu
> cycles.
> 
> As we can see from the results without the patch, the SCHED_FIFO doesn't
> have much effect and maximum latencies grow quite large.

Indeed. I see similar results here (kernel 2.6.31, i2c-nforce2):

Before patch:

# ./prioinv 
Spawning 3 workers with different priorities
Each worker will read one byte from /dev/i2c-0:0x51:0x00 1000 times
pid: 4583 is PRIO_PROCESS 0
pid: 4584 is PRIO_PROCESS -5
pid: 4585 is SCHED_FIFO
(4583)PRIO 0      rt 19308 ms lat: 4974 min,  24989 max, 19308 avg (us)
(4584)PRIO -5     rt 23988 ms lat: 15912 min, 836616 max, 23987 avg (us)
(4585)SCHED_FIFO  rt 23996 ms lat: 14909 min, 844525 max, 22990 avg (us)
Total run time 23997362 usecs

With patch:

# ./prioinv 
Spawning 3 workers with different priorities
Each worker will read one byte from /dev/i2c-0:0x51:0x00 1000 times
pid: 2021 is PRIO_PROCESS -5
pid: 2022 is SCHED_FIFO
pid: 2020 is PRIO_PROCESS 0
(2022)SCHED_FIFO  rt 15948 ms lat: 6817 min,  15171 max, 14941 avg (us)
(2021)PRIO -5     rt 15997 ms lat: 5029 min,  32173 max, 15996 avg (us)
(2020)PRIO 0      rt 24012 ms lat: 4321 min, 16004516 max, 24011 avg (us)
Total run time 24013759 usecs

> With patch, the maximum latencies are much better. Averages follow the
> respective priorities. rt_mutex ensures that the wait time to reaquire
> the lock is kept minimum by not letting low priority process to hold it.
> This leads to better bus utilization and we finish almost 8 seconds
> (~27%) quicker in total. And most importantly the lower priority
> processes can't keep the bus mutex for themselves and destroy the
> SCHED_FIFO access latencies.

I don't see the general performance improvement you see, but the
latency improvement is there.

> Obviously this benchmark is made to emphasize this problem. Nevertheless
> myself and Peter have witnessed this problem in real world workload.
> 
> > But now I am curious, why don't we use rt_mutex instead of regular
> > mutex all around the place?
> > 
> 
> What do you mean by all around the place ?

I meant all the kernel mutexes; no kidding :)

> In scope of i2c-core there is no point of converting the client list
> lock into rt_mutex due to lack of contention. As there is no free lunch
> the rt_mutex struct takes more space and cpu cycles. Also it could be
> that rt_mutex is more novel feature and code is converted conservatively
> and only when there is real need for it.

Ah, OK, thanks for the explanation. Now I know enough to consider
applying your patch. We're unfortunately a little late for 2.6.32, so
my plan is to include your patch in my i2c tree and schedule it for
inclusion in kernel 2.6.33.

Note that I had to modify drivers/net/sfc/sfe4001.c too as it accesses
the mutex directly.

-- 
Jean Delvare
