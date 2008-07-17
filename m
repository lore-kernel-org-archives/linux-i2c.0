From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [crash, bisected] I2C,
	kobject (ffff81003e8c4160): tried to	init an initialized object
Date: Thu, 17 Jul 2008 11:49:30 +0200
Message-ID: <20080717094930.GA9044@elte.hu>
References: <20080714224945.629446fa@hyperion.delvare>
	<20080716082352.GA30483@elte.hu>
	<20080716110702.3ca61eb2@hyperion.delvare>
	<20080716120801.3e9b4c80@hyperion.delvare>
	<20080716141826.1d88d05e@hyperion.delvare>
	<20080717092655.GA6115@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080717092655.GA6115-X9Un+BFzKDI@public.gmane.org>
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
Cc: Ulrich Drepper <drepper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, john stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


* Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org> wrote:

> -tip testing found another (similar) i2c crash with latest -git, on a 
> Core2Duo laptop:

found another bootup crash on an Athlon 64 X2 testsystem:

[   19.610000] bus: 'pci': add driver amd756_smbus
[   19.615204] initcall amd756_init+0x0/0x20 returned 0 after 9 msecs
[   19.620000] calling  amd756_s4882_init+0x0/0x2d7
[   19.624242] ------------[ cut here ]------------
[   19.628415] WARNING: at kernel/mutex.c:134 mutex_lock_nested+0xc0/0x267()
[   19.630000] Pid: 1, comm: swapper Not tainted 2.6.26-tip #20066
[   19.630000] 
[   19.630000] Call Trace:
[   19.630000]  [<ffffffff802358f5>] warn_on_slowpath+0x58/0x7f
[   19.630000]  [<ffffffff80263ac6>] ? ftrace_record_ip+0x20c/0x263
[   19.630000]  [<ffffffff80514faa>] ? _raw_spin_unlock+0x8e/0x93
[   19.630000]  [<ffffffff80507c44>] ? debug_locks_off+0x4/0x3c
[   19.630000]  [<ffffffff80263ac6>] ? ftrace_record_ip+0x20c/0x263
[   19.630000]  [<ffffffff8020b3a4>] ? mcount_call+0x5/0x31
[   19.630000]  [<ffffffff80861c19>] mutex_lock_nested+0xc0/0x267
[   19.630000]  [<ffffffff806e8ffd>] ? i2c_smbus_xfer+0x59/0x49c
[   19.630000]  [<ffffffff80cc8575>] ? amd756_s4882_init+0x0/0x2d7
[   19.630000]  [<ffffffff8020b3a4>] ? mcount_call+0x5/0x31
[   19.630000]  [<ffffffff806e8ffd>] i2c_smbus_xfer+0x59/0x49c
[   19.630000]  [<ffffffff80263ac6>] ? ftrace_record_ip+0x20c/0x263
[   19.630000]  [<ffffffff80514faa>] ? _raw_spin_unlock+0x8e/0x93
[   19.630000]  [<ffffffff80cc8584>] ? amd756_s4882_init+0xf/0x2d7
[   19.630000]  [<ffffffff80263ac6>] ? ftrace_record_ip+0x20c/0x263
[   19.630000]  [<ffffffff80cc8575>] ? amd756_s4882_init+0x0/0x2d7
[   19.630000]  [<ffffffff8020b3a4>] ? mcount_call+0x5/0x31
[   19.630000]  [<ffffffff80cc8575>] ? amd756_s4882_init+0x0/0x2d7
[   19.630000]  [<ffffffff80cc85b6>] amd756_s4882_init+0x41/0x2d7
[   19.630000]  [<ffffffff8024e325>] ? getnstimeofday+0x3f/0xa1
[   19.630000]  [<ffffffff8024bf25>] ? ktime_get_ts+0x4e/0x53
[   19.630000]  [<ffffffff80cc8575>] ? amd756_s4882_init+0x0/0x2d7
[   19.630000]  [<ffffffff80ca49a0>] kernel_init+0x143/0x2a4
[   19.630000]  [<ffffffff80863721>] ? _spin_unlock_irq+0x2b/0x37
[   19.630000]  [<ffffffff8020c9f9>] child_rip+0xa/0x11
[   19.630000]  [<ffffffff80ca485d>] ? kernel_init+0x0/0x2a4
[   19.630000]  [<ffffffff8020c9ef>] ? child_rip+0x0/0x11
[   19.630000] 
[   19.630000] ---[ end trace 0e79313125261797 ]---
[   19.630000] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   19.630000] IP: [<ffffffff80861c66>] mutex_lock_nested+0x10d/0x267

with this config:

  http://redhat.com/~mingo/misc/config-Thu_Jul_17_11_34_08_CEST_2008.bad

i already had I2C_NFORCE2_S4985 off here, so it's a different one.

	Ingo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
