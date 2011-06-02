From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Bug 35572] eeprom module: modprobing hangs
Date: Thu, 2 Jun 2011 16:17:42 +0200
Message-ID: <20110602161742.1b22051a@endymion.delvare>
References: <bug-35572-10286@https.bugzilla.kernel.org/>
	<20110601144240.9525825b.akpm@linux-foundation.org>
	<201106021753.50961.markotahal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201106021753.50961.markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Otahal <markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2 Jun 2011 17:53:42 +0200, Marek Otahal wrote:
> I'm attaching the whole backtrace and adding the interesting part here too:
> Thank you, Mark
> 
> PS: Is there a way to kill the modprobe process? ctrl+c nor kill -9 work for me, so i have to reboot every time.

I don't think there is another way, sorry.

> -----------------------------------------------
> [  462.667305] hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
> [  770.753437] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  770.806696] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  770.860064] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  770.913400] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  770.966721] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  771.020018] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  771.073382] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  771.126696] [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [  771.340045] [drm] GMBUS timed out, falling back to bit banging on pin 4 [i915 gmbus dpc]
> [  961.296817] INFO: task modprobe:4538 blocked for more than 120 seconds.
> [  961.296831] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  961.296843] modprobe        D e1001bec     0  4538   4495 0x00000000
> [  961.296865]  e1001bfc 00000086 00000002 e1001bec 00000001 e1001c63 e1001b72 e1001b76
> [  961.296894]  00000000 33343030 ab3291d1 00000001 f14c2c00 e1001c30 00000001 c14e1440
> [  961.296921]  f657ca00 c14e1440 f657c440 f4e6c000 f5862f70 e1001bc8 c11ad279 e1001bfc
> [  961.296949] Call Trace:
> [  961.296977]  [<c11ad279>] ? format_decode+0x319/0x380
> [  961.296993]  [<c11af1aa>] ? vsnprintf+0x2ea/0x3d0
> [  961.297060]  [<c132f1ed>] __mutex_lock_slowpath+0x10d/0x2b0
> [  961.297133]  [<c132f39b>] mutex_lock+0xb/0x20
> [  961.297188]  [<f805820d>] i2c_add_adapter+0x2d/0xa0 [i2c_core]
> [  961.297239]  [<f806b90d>] __i2c_bit_add_bus+0x17d/0x2f0 [i2c_algo_bit]
> [  961.297291]  [<f80581e0>] ? i2c_add_numbered_adapter+0xd0/0xd0 [i2c_core]
> [  961.297342]  [<f806ba9d>] i2c_bit_add_bus+0xd/0x10 [i2c_algo_bit]
> [  961.297415]  [<f82cd52b>] intel_gpio_create+0x11b/0x170 [i915]
> [  961.297517]  [<f82ce4aa>] gmbus_xfer+0xbca/0xdf0 [i915]
> [  961.297599]  [<f80583c5>] i2c_transfer+0x85/0xb0 [i2c_core]
> [  961.297653]  [<f80586c4>] i2c_smbus_xfer+0x234/0x540 [i2c_core]
> [  961.297671]  [<c11a0001>] ? blk_throtl_work+0x291/0x4d0
> [  961.297687]  [<c131515b>] ? klist_add_tail+0x3b/0x50
> [  961.297703]  [<c124c0df>] ? put_device+0xf/0x20
> [  961.297718]  [<c124d123>] ? device_add+0x73/0x5f0
> [  961.297788]  [<f8058f99>] i2c_default_probe+0xe9/0x130 [i2c_core]
> [  961.297830]  [<c124c335>] ? device_for_each_child+0x45/0x50
> [  961.297907]  [<f8059153>] i2c_do_add_adapter+0x173/0x260 [i2c_core]
> [  961.297933]  [<c11a8fd8>] ? kobject_uevent_env+0xf8/0x430
> [  961.297955]  [<c11a8e90>] ? add_uevent_var+0xc0/0xc0
> [  961.298034]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
> [  961.298110]  [<f8059652>] __process_new_driver+0x22/0x2b [i2c_core]
> [  961.298136]  [<c124e8e1>] bus_for_each_dev+0x41/0x70
> [  961.298210]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
> [  961.298286]  [<f80577ab>] i2c_for_each_dev+0x2b/0x50 [i2c_core]
> [  961.298365]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
> [  961.298441]  [<f80593bf>] i2c_register_driver+0x4f/0xa0 [i2c_core]
> [  961.298470]  [<c1066c65>] ? notifier_call_chain.isra.0+0x45/0x60
> [  961.298500]  [<f8710012>] eeprom_init+0x12/0x14 [eeprom]
> [  961.298524]  [<c1001120>] do_one_initcall+0x30/0x170
> [  961.298572]  [<f8710000>] ? 0xf870ffff
> [  961.298599]  [<c107b453>] sys_init_module+0xe03/0x1a20
> [  961.298738]  [<c1330edf>] sysenter_do_call+0x12/0x28

OK, I see what's going on. This is a deadlock on i2c-core's main mutex
(drivers/i2c/i2c-core.c:core_lock). It is taken a first time by the
eeprom driver, to walk all the i2c adapters in search for supported
devices. Then it is taken a second time by the i915 driver, when it
attempts to register a new i2c adapter in the middle of the operation.

This only happens with the eeprom driver because legacy device
detection is only enabled on i915 for class I2C_CLASS_DDC, which in
turn is only set by the eeprom driver.

This only happens with the i915 driver, because it attempts to create a
new i2c adapter in the middle of a transaction. This is very uncommon,
the i2c core was never designed for this.

I suspect that the regression is caused by
8f9a3f9b63b8cd3f03be9dc53533f90bd4120e5f. Before this commit, the
software bit-banged interface was created earlier. So I would suggest
that we revert this commit from 2.6.39 and upstream for the time being.

For the long term, I think that the i2c implementation of i915 should
be reworked. Having two i2c adapters per actual bus, one for hardware
controlled and one for software controlled, is confusing and dangerous.
And creating a bus on the fly in the middle of a transaction is just as
bad. If you really can't instantiate only the one you need, then you
should instantiate the software controlled one (i2c_bit_add_adapter),
then update the algorithm to switch to hardware controlled where
possible, and ultimately undo that update if the hardware controller
turns out to be non-working. I can't write the code as I don't have any
supported piece of hardware and I'm not familiar with the code, but I
can help review any patch if you want.

-- 
Jean Delvare
