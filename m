From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Wed, 9 Jan 2008 14:29:06 +0100
Message-ID: <20080109142906.23a55f5f@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801081112.46972.david-b@pacbell.net>
	<20080108215042.534e32fa@hyperion.delvare>
	<200801081344.45544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801081344.45544.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 8 Jan 2008 13:44:45 -0800, David Brownell wrote:
> On Tuesday 08 January 2008, Jean Delvare wrote:
> > On Tue, 8 Jan 2008 11:12:46 -0800, David Brownell wrote:
> > > On Tuesday 08 January 2008, Jean Delvare wrote:
> > > > Hmm, I get a lockup when removing any legacy chip driver or any bus
> > > > driver with legacy clients attached. 
> > > 
> > > Lockup?  More details ...
> > 
> > There's not much to say. "rmmod lm90" (or "rmmod i2c-parport") never
> > returns, that's about it.
> 
> The rest of the system behaves, or not?  A "lockup" to me implies
> something so catastrophic that the hardware watchdog will soon fire
> and the system will reboot.
> 
> I'm guessing that's not the case here.  Stil not-good, but not as
> much of a catastrophe.

Sorry for being vague. Yes, the rest of the system behaves, only the
"rmmod" process is stuck.

> This isn't wholly meaningful to me.  If release_sysfs_dirent() is
> wedging, then why does the stack show it's sysfs_addrm_finish()?
> I guess the right question is what's going on where the PC points.  :)

How do I know? I'm using SysRq+t to get the stack trace, it doesn't
seem to give me any extra information.

> > > >   [<ffffffff8041bca5>] schedule_timeout+0x95/0xd0
> > > 
> > > This looks like stack garbage...
> > 
> > What makes you think so? A second stack trace shows it as well.
> 
> Because schedule_timeout() doesn't call into sysfs.  :)

True, but OTOH there are so many ways callback can be stored for later
use that I am no longer surprised when I see apparently unrelated
functions call each other ;)

> Some platforms have compiler options to make stack tracing be
> more sensible -- e.g. to always force frame pointers to be used,
> so that stackdump utilities don't ever need to guess.

I rebuilt my kernel with CONFIG_STACKTRACE=y and
CONFIG_FRAME_POINTER=y, hopefully that's what you were thinking about.
Here's what I get with these options:

rmmod         D 0000000000000002     0  4221   4204
 ffff81002345bcd8 0000000000000046 ffff8100234ab080 ffff81003f848040
 ffff81002345bd08 ffffffff80252327 0000000200000001 7fffffffffffffff
 7fffffffffffffff ffff81002d1e6b60 ffff81002d1e6b58 0000000000000002
Call Trace:
 [<ffffffff80252327>] __lock_acquire+0x967/0x1080
 [<ffffffff80443215>] schedule_timeout+0x95/0xd0
 [<ffffffff8044545b>] _spin_unlock_irq+0x2b/0x40
 [<ffffffff80251485>] trace_hardirqs_on+0xd5/0x170
 [<ffffffff8044545b>] _spin_unlock_irq+0x2b/0x40
 [<ffffffff8044301f>] wait_for_common+0xdf/0x150
 [<ffffffff802292a0>] default_wake_function+0x0/0x10
 [<ffffffff804430f8>] wait_for_completion+0x18/0x20
 [<ffffffff803ce894>] i2c_detach_client+0x54/0x90
 [<ffffffff88309071>] :lm90:lm90_detach_client+0x71/0x90
 [<ffffffff803cd85c>] detach_legacy_clients+0x8c/0xc0
 [<ffffffff803cd7d0>] detach_legacy_clients+0x0/0xc0
 [<ffffffff803a4f13>] device_for_each_child+0x33/0x60
 [<ffffffff803cebe6>] i2c_del_driver+0x126/0x140
 [<ffffffff88309f10>] :lm90:sensors_lm90_exit+0x10/0x12
 [<ffffffff8025a51c>] sys_delete_module+0x13c/0x1e0
 [<ffffffff80251485>] trace_hardirqs_on+0xd5/0x170
 [<ffffffff80444ada>] trace_hardirqs_on_thunk+0x35/0x3a
 [<ffffffff8020ba3e>] system_call+0x7e/0x83

Does it make more sense? The odd thing is:

(gdb) list *(__lock_acquire+0x967)
0xffffffff80252327 is in __lock_acquire (kernel/lockdep.c:2353).
2348     * We maintain the dependency maps and validate the locking attempt:
2349     */
2350    static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
2351                              int trylock, int read, int check, int hardirqs_off,
2352                              unsigned long ip)
2353    {
2354            struct task_struct *curr = current;
2355            struct lock_class *class = NULL;
2356            struct held_lock *hlock;
2357            unsigned int depth, id;
(gdb)

Not sure how it can block on an opening curly brace ;) Maybe I should
disable CONFIG_LOCKDEP for now.

-- 
Jean Delvare
