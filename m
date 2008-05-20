From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch/rft 2.6.26-rc1] i2c-core: stop using
	i2c_adapter.clients
Date: Tue, 20 May 2008 09:22:19 -0700
Message-ID: <200805200922.19990.david-b@pacbell.net>
References: <200805042124.45551.david-b@pacbell.net>
	<20080520155232.4937c52a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520155232.4937c52a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 20 May 2008, Jean Delvare wrote:
> I remember doing the same change several months ago, but finally
> dropping the patch because it was deadlocking. Your patch has the exact
> same problem: rmmod'ing a legacy i2c driver deadlocks.

I thought that had been resolved as part of another patch
resolving a self-deadlock ... I guess not!  I'll have to
set up a test rig with a legacy driver module, I guess.


I'll have a closer look at this.  This wait-for-completion
hook is clearly an abuse of the driver model code, but it
might be practical to solve it by upping refcounts for legacy
code and having a list of pending deletes.

Did lockdep tell you more about locking goofage here, or
is this the only symptiom?


> rmmod =A0 =A0 =A0 =A0 D ffffffff80443380 =A0 =A0 0 =A04669 =A0 4652
> =A0ffff81002e177cc8 0000000000000086 ffff81002e1dc190 ffff81003f8a1240
> =A0ffff81002e177cc8 ffff81002e177cc8 ffff81002e226b90 7fffffffffffffff
> =A00000000000000002 7fffffffffffffff ffff81003f172648 ffff81002e177d48
> Call Trace:
> =A0[<ffffffff8042c175>] schedule_timeout+0x95/0xd0
> =A0[<ffffffff802c3ce0>] ? sysfs_remove_dir+0x60/0x80
> =A0[<ffffffff8042bf31>] wait_for_common+0xd1/0x160
> =A0[<ffffffff80225080>] ? default_wake_function+0x0/0x10
> =A0[<ffffffff8030d4e7>] ? kobject_put+0x27/0x60
> =A0[<ffffffff8042c058>] wait_for_completion+0x18/0x20
> =A0[<ffffffff803b4fe2>] i2c_detach_client+0x82/0xc0
> =A0[<ffffffffa02e4071>] :lm90:lm90_detach_client+0x71/0x90
> =A0[<ffffffff803b4f0b>] i2c_do_detach_client+0x8b/0xe0
> =A0[<ffffffff803b4e80>] ? i2c_do_detach_client+0x0/0xe0
> =A0[<ffffffff8038d473>] device_for_each_child+0x33/0x60
> =A0[<ffffffff803b45e6>] i2c_del_driver+0x106/0x120
> =A0[<ffffffffa02e4f10>] :lm90:sensors_lm90_exit+0x10/0x12
> =A0[<ffffffff8024d41e>] sys_delete_module+0x12e/0x1f0
> =A0[<ffffffff8020b43b>] system_call_after_swapgs+0x7b/0x80
> =

> I even seem to remember that you had been able to explain this deadlock
> back then...

Yeah, that's why I have various i2c lock removal patches
floating around.


> Obviously I can't take your patch until this is solved.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
