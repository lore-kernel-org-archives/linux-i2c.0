From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch/rft 2.6.26-rc1] i2c-core: stop using
 i2c_adapter.clients
Date: Tue, 20 May 2008 15:52:32 +0200
Message-ID: <20080520155232.4937c52a@hyperion.delvare>
References: <200805042124.45551.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805042124.45551.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sun, 4 May 2008 21:24:45 -0700, David Brownell wrote:
> This changes how the I2C core iterates devices connected to a given
> i2c_adapter, making it use driver model facilities instead of the
> deprecated i2c_adapter.clients list.  The two functions affected are
> i2c_del_adapter() and i2c_del_driver().
> 
> This is something of a bugfix:  updates to that list are protected by a
> lock (i2c_adapter.clist_lock) which is completly ignored by those two
> iteration loops ...
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> Builds fine, and I have a hard time seeing this break.  But this
> hasn't really been tested.
> 
>  drivers/i2c/i2c-core.c |   91 +++++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 43 deletions(-)

I remember doing the same change several months ago, but finally
dropping the patch because it was deadlocking. Your patch has the exact
same problem: rmmod'ing a legacy i2c driver deadlocks.

rmmod         D ffffffff80443380     0  4669   4652
 ffff81002e177cc8 0000000000000086 ffff81002e1dc190 ffff81003f8a1240
 ffff81002e177cc8 ffff81002e177cc8 ffff81002e226b90 7fffffffffffffff
 0000000000000002 7fffffffffffffff ffff81003f172648 ffff81002e177d48
Call Trace:
 [<ffffffff8042c175>] schedule_timeout+0x95/0xd0
 [<ffffffff802c3ce0>] ? sysfs_remove_dir+0x60/0x80
 [<ffffffff8042bf31>] wait_for_common+0xd1/0x160
 [<ffffffff80225080>] ? default_wake_function+0x0/0x10
 [<ffffffff8030d4e7>] ? kobject_put+0x27/0x60
 [<ffffffff8042c058>] wait_for_completion+0x18/0x20
 [<ffffffff803b4fe2>] i2c_detach_client+0x82/0xc0
 [<ffffffffa02e4071>] :lm90:lm90_detach_client+0x71/0x90
 [<ffffffff803b4f0b>] i2c_do_detach_client+0x8b/0xe0
 [<ffffffff803b4e80>] ? i2c_do_detach_client+0x0/0xe0
 [<ffffffff8038d473>] device_for_each_child+0x33/0x60
 [<ffffffff803b45e6>] i2c_del_driver+0x106/0x120
 [<ffffffffa02e4f10>] :lm90:sensors_lm90_exit+0x10/0x12
 [<ffffffff8024d41e>] sys_delete_module+0x12e/0x1f0
 [<ffffffff8020b43b>] system_call_after_swapgs+0x7b/0x80

I even seem to remember that you had been able to explain this deadlock
back then...

Obviously I can't take your patch until this is solved.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
