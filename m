From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Wed, 9 Jan 2008 17:19:34 +0100
Message-ID: <20080109171934.4f894bdc@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801081112.46972.david-b@pacbell.net>
	<20080108215042.534e32fa@hyperion.delvare>
	<200801081344.45544.david-b@pacbell.net>
	<20080109142906.23a55f5f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080109142906.23a55f5f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Wed, 9 Jan 2008 14:29:06 +0100, Jean Delvare wrote:
> I rebuilt my kernel with CONFIG_STACKTRACE=y and
> CONFIG_FRAME_POINTER=y, hopefully that's what you were thinking about.
> Here's what I get with these options:
> 
> rmmod         D 0000000000000002     0  4221   4204
>  ffff81002345bcd8 0000000000000046 ffff8100234ab080 ffff81003f848040
>  ffff81002345bd08 ffffffff80252327 0000000200000001 7fffffffffffffff
>  7fffffffffffffff ffff81002d1e6b60 ffff81002d1e6b58 0000000000000002
> Call Trace:
>  [<ffffffff80252327>] __lock_acquire+0x967/0x1080
>  [<ffffffff80443215>] schedule_timeout+0x95/0xd0
>  [<ffffffff8044545b>] _spin_unlock_irq+0x2b/0x40
>  [<ffffffff80251485>] trace_hardirqs_on+0xd5/0x170
>  [<ffffffff8044545b>] _spin_unlock_irq+0x2b/0x40
>  [<ffffffff8044301f>] wait_for_common+0xdf/0x150
>  [<ffffffff802292a0>] default_wake_function+0x0/0x10
>  [<ffffffff804430f8>] wait_for_completion+0x18/0x20
>  [<ffffffff803ce894>] i2c_detach_client+0x54/0x90
>  [<ffffffff88309071>] :lm90:lm90_detach_client+0x71/0x90
>  [<ffffffff803cd85c>] detach_legacy_clients+0x8c/0xc0
>  [<ffffffff803cd7d0>] detach_legacy_clients+0x0/0xc0
>  [<ffffffff803a4f13>] device_for_each_child+0x33/0x60
>  [<ffffffff803cebe6>] i2c_del_driver+0x126/0x140
>  [<ffffffff88309f10>] :lm90:sensors_lm90_exit+0x10/0x12
>  [<ffffffff8025a51c>] sys_delete_module+0x13c/0x1e0
>  [<ffffffff80251485>] trace_hardirqs_on+0xd5/0x170
>  [<ffffffff80444ada>] trace_hardirqs_on_thunk+0x35/0x3a
>  [<ffffffff8020ba3e>] system_call+0x7e/0x83
> 
> Does it make more sense? The odd thing is:
> 
> (gdb) list *(__lock_acquire+0x967)
> 0xffffffff80252327 is in __lock_acquire (kernel/lockdep.c:2353).
> 2348     * We maintain the dependency maps and validate the locking attempt:
> 2349     */
> 2350    static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> 2351                              int trylock, int read, int check, int hardirqs_off,
> 2352                              unsigned long ip)
> 2353    {
> 2354            struct task_struct *curr = current;
> 2355            struct lock_class *class = NULL;
> 2356            struct held_lock *hlock;
> 2357            unsigned int depth, id;
> (gdb)
> 
> Not sure how it can block on an opening curly brace ;) Maybe I should
> disable CONFIG_LOCKDEP for now.

Here's what I get with CONFIG_LOCKDEP=n:

rmmod         D ffffffff804365c0     0  4198   4181
 ffff81002db39cd8 0000000000000082 ffff81002d907100 ffff81003f83d7e0
 ffff81003c5d0370 ffff81002db39d08 ffff81002d8408f8 7fffffffffffffff
 7fffffffffffffff ffff81002d840a38 0000000000000002 ffff81002db39d58
Call Trace:
 [<ffffffff80423c15>] schedule_timeout+0x95/0xd0
 [<ffffffff802bfa30>] sysfs_remove_dir+0x60/0x80
 [<ffffffff80308029>] kobject_put+0x19/0x20
 [<ffffffff80423a28>] wait_for_common+0xc8/0x130
 [<ffffffff80228330>] default_wake_function+0x0/0x10
 [<ffffffff80423af8>] wait_for_completion+0x18/0x20
 [<ffffffff803b4fd4>] i2c_detach_client+0x54/0x90
 [<ffffffff882f4071>] :lm90:lm90_detach_client+0x71/0x90
 [<ffffffff803b3fbc>] detach_legacy_clients+0x8c/0xc0
 [<ffffffff803b3f30>] detach_legacy_clients+0x0/0xc0
 [<ffffffff8038cbb3>] device_for_each_child+0x33/0x60
 [<ffffffff803b531c>] i2c_del_driver+0x11c/0x140
 [<ffffffff882f4f00>] :lm90:sensors_lm90_exit+0x10/0x12
 [<ffffffff802501d2>] sys_delete_module+0x132/0x1d0
 [<ffffffff8020b99e>] system_call+0x7e/0x83

(gdb) list *(schedule_timeout+0x95)
0xffffffff80423c15 is in schedule_timeout (kernel/timer.c:1059).
1054                     * in the caller. Nothing more. We could take
1055                     * MAX_SCHEDULE_TIMEOUT from one of the negative value
1056                     * but I' d like to return a valid offset (>=0) to allow
1057                     * the caller to do everything it want with the retval.
1058                     */
1059                    schedule();
1060                    goto out;
1061            default:
1062                    /*
1063                     * Another bit of PARANOID. Note that the retval will be
(gdb)

Hope it helps,
-- 
Jean Delvare
