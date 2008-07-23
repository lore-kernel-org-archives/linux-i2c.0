From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: class_for_each_device() oops
Date: Wed, 23 Jul 2008 16:06:47 -0700
Message-ID: <200807231606.48016.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I happened across this ... it looks like the root cause
is that an i2c driver ("smbus_alert") gets registered
before the class ("i2c_adapter") being iterated.

(This used the latest version of the patch adding SMBus
alert support to I2C.  It's not mainline, although it's
been posted a few times.)


Now, obviously a trivial fix is to change that init order,
and just accept that there's now an init dependency which
didn't exist before.  But on the other hand I don't think
that it's reasonable to oops there; it's needless, and in
fact it never oopsed before!  

In this case adding 

	if (!class->p)
		return -EINVAL;

at the top of class_for_each_device() would prevent such
oopses from ever happening.

- Dave



=== "insmod i2c-core"
BUG: unable to handle kernel NULL pointer dereference at 000000e4
IP: [<c03381ef>] mutex_lock_nested+0x65/0x23c
*pde = 00000000 
Oops: 0000 [#1] PREEMPT 
Modules linked in: i2c_core(+) loop forcedeth ehci_hcd ohci_hcd

Pid: 2599, comm: insmod Not tainted (2.6.26-dev #40)
EIP: 0060:[<c03381ef>] EFLAGS: 00010002 CPU: 0
EIP is at mutex_lock_nested+0x65/0x23c
EAX: 00000b92 EBX: f8a7ba80 ECX: 00000000 EDX: c03381ef
ESI: 000000b0 EDI: 00000246 EBP: f65a3e80 ESP: f65a3e48
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process insmod (pid: 2599, ti=f65a2000 task=f64eba00 task.ti=f65a2000)
Stack: c025bf42 00000000 f65a3e80 f8a7ba20 f65a3e60 f64eba00 f65a3ea0 c03383be 
       f8a77226 00000000 f8a7ba58 f8a7ba80 00000000 f8a7bb00 f65a3e9c c025bf42 
       f8a7ba80 ffffffea f8a7ba80 00000000 f8a60e40 f65a3eb0 f8a77242 f8a789c1 
Call Trace:
 [<c025bf42>] ? class_for_each_device+0x2d/0xad
 [<c03383be>] ? mutex_lock_nested+0x234/0x23c
 [<f8a77226>] ? i2c_register_driver+0x65/0x95 [i2c_core]
 [<c025bf42>] ? class_for_each_device+0x2d/0xad
 [<f8a77242>] ? i2c_register_driver+0x81/0x95 [i2c_core]
 [<f8a789c1>] ? __attach_adapter+0x0/0x25 [i2c_core]
 [<f881a023>] ? i2c_init+0x23/0x76 [i2c_core]
 [<c013ab8d>] ? sys_init_module+0x1270/0x13eb
 [<c0131e69>] ? trace_hardirqs_off+0xb/0xd
 [<c025b263>] ? bus_register+0x0/0x1d0
 [<c0102b81>] ? sysenter_past_esp+0x6a/0xa5
 =======================
Code: 74 21 e8 95 35 ec ff 85 c0 74 18 83 3d 20 23 7b c0 00 75 0f ba 86 00 00 00 b8 c7 a9 3d c0 e8 87 0a de ff 9c 5f fa e8 6f 9c df ff <39> 76 34 8d 46 04 c7 46 04 00 00 00 00 89 45 d4 74 21 e8 5a 35 
EIP: [<c03381ef>] mutex_lock_nested+0x65/0x23c SS:ESP 0068:f65a3e48
---[ end trace c3a87e2e592c29fc ]---

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
