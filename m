From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/03] i2c-i801: Add basic interrupt support
Date: Wed, 13 Aug 2008 21:17:22 +0200
Message-ID: <48A33342.1050105@gmail.com>
References: <488762C8.6090105@gmail.com>
	<20080812101545.600ca850@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080812101545.600ca850-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey Jean,
> Please provide patches that can be applied with patch -p1 from the root
> of the kernel source tree.
>   
Will do, sorry about that

> Having this here is a bit confusing, you should leave all the
> transaction types (from I801_QUICK to I801_I2C_BLOCK_LAST) as a block.
>   
Oops, not a smart place to put this constant, I agree. Moved to

> I801_HST_CNT_INTREN (which could probably be renamed to just
> I801_INTREN for brevity) would go first.
>
> Also note that the drivers already had a define for this flag, named
> ENABLE_INT9, although it was disabled. I agree that I801_INTREN is a
> better name, but it would probably be a good idea to delete ENABLE_INT9
> and all references thereto first, otherwise the code becomes a little
> confusing.
>   
Will do. I'll just delete ENABLE_INT9 all together.

> You never really use the irq value, only whether it is -1 or not. So it
> might make more sense to turn it into a flag and rename it to use_irq?
>   
Yup, seems like a waste to store the value :)

> Please make this HZ/2 a define so that it's easy to change. 
Done

> Ideally this define would replace MAX_TIMEOUT (in a separate patch) so 
> that both
> the poll-based and the interrupt-driven paths have the same timeout 
> value. Right now,
> the timeout handling of the poll-based path is rather ugly (the actual 
> timeout depends on
> the value of HZ.)
Hm, seems like a very sensible thing to do. However, I have no idea how 
to implement that, since you don't really know how long msleep slept, or 
not? I sadly don't really have time to look into this right now, sorry.

> Not sure why you make this wait interruptible. The poll-based path
> isn't interruptible, and you do not handle the interrupted case anyway.
>   
I'm not an expert, but I think this is the right way to use it.
The interupt handler i801_isr catches the interrupt, saves the status to 
algo_data and calls wake_up_interruptable. This will wake up the wait.

I'm not sure whether this is the correct way or not. Any input from an 
interrupt expert is very much welcome.
I did test it without the event_interruptable, which produces nonsense, 
like:

====
polling
====
[root@localhost busses]# time i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- 54 55 -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- UU -- -- -- --

real    0m0.235s
user    0m0.000s
sys     0m0.003s

====
wait_event_interruptable_timeout
====
[root@localhost busses]# time i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- 54 55 -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- UU -- -- -- --

real    0m0.130s
user    0m0.001s
sys     0m0.009s

====
wait_event_timeout
====
[root@localhost busses]# time i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- 0a -- -- -- -- --
10: 10 -- -- -- -- -- -- -- -- 19 -- -- -- -- 1e --
20: -- -- -- -- 24 -- -- -- -- 29 -- -- -- -- -- --
30: 30 -- -- 33 -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

real    0m4.090s
user    0m0.000s
sys     0m0.004s

> The polled-based path has additional logic to handle the timeout case
> (by resetting the controller.) I would guess you want the same for the
> interrupt-driven path?
>   
Agree. After merging to 2.6.27-rc3, I noticed a helper function called 
i801_check_post was added. Seems to be the ideal place to pass the 
return data to.

> Please add a trailing comma.
>   
Done
> i801_adapter.name is a rather long string, I think I'd rather use
> i801_driver.name to register the IRQ.
>   
Ok
> I think you have a race here. You free the irq before removing the i2c
> adapter. What will happen if someone initiates an I2C transaction after
> the IRQ has been freed? It would probably be better to remove the i2c
> adapter first.
>   
Quite an obvious race as well... Changed already.
> Other than that, it looks good to me, good work. Note though that I am
> in no way an expert of interrupt handling, as this is the first
> PC-style SMBus controller driver which gets converted to use interrupts
> instead of polling.
>   
Thanks. I'm by no means an expert as well, it's all quite new to me. 
Thanks a lot for your patience.

I'll send you an updated patch later this evening. I don't know anything 
about config files though, so that'll have to wait a bit... The module 
parameter will be added though.

Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
