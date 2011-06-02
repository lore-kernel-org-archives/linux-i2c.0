From: Marek Otahal <markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 35572] New: eeprom module: modprobing hangs
Date: Thu, 2 Jun 2011 17:53:42 +0200
Message-ID: <201106021753.50961.markotahal@gmail.com>
References: <bug-35572-10286@https.bugzilla.kernel.org/> <20110601144240.9525825b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2027105.p6i3tfHL7L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110601144240.9525825b.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--nextPart2027105.p6i3tfHL7L
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,=20

thank you for advice to debug, the things I tried follow..

On Wednesday 01 of June 2011 23:42:40 Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>=20
> On Sat, 21 May 2011 20:17:32 GMT
>=20
> bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D35572
> >=20
> >            Summary: eeprom module: modprobing hangs
> >            Product: Other
> >            Version: 2.5
> >    =20
> >     Kernel Version: 2.6.39
> >    =20
> >           Platform: All
> >        =20
> >         OS/Version: Linux
> >        =20
> >               Tree: Mainline
> >            =20
> >             Status: NEW
> >          =20
> >           Severity: normal
> >           Priority: P1
> >         =20
> >          Component: Modules
> >        =20
> >         AssignedTo: other_modules-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
> >         ReportedBy: markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >         Regression: No
>=20
> This is drivers/misc/eeprom/eeprom.c?
>=20
> That driver doesn't really have a maintainer.  Perhaps the i2c
> developers can help debug this?
>=20
> > modbrobing eeprom module hangs, but does not crash the kernel. Occurs
> > with 2.6.39, with 2.6.38 and prev works ok.
>=20
> So 2.6.38 did not have this bug?
>=20
> The driver didn't change between .38 and .39.
Yes, it works ok on 2.6.38 kernel. Someone above suggested it might be rela=
ted to i915 driver(?)
>=20
> > Confirmed by other user, the bug
> > reported in Arch can be found here:
> > https://bugs.archlinux.org/24376
> > ....
> > Thank you and please let me know if i can provide more info to debug.
> > Regards, Mark
>=20
> One thing you could try is to modprobe the driver and then from another
> terminal, do a `ps aux' and see if the modprobe is in "R", "D" or "S"
> state.  Then do an
modprobe is in D+ state.
>=20
> 	echo t > /proc/sysrq-trigger
>=20
> (or "echo w" if it was in D state) and then run "dmesg -s 1000000 >
> foo", then send us the backtrace for that stuck modprobe instance.
> Please ensure that your email client doesn't wordwrap the trace!
I'm attaching the whole backtrace and adding the interesting part here too:
Thank you, Mark

PS: Is there a way to kill the modprobe process? ctrl+c nor kill -9 work fo=
r me, so i have to reboot every time.
=20
=2D----------------------------------------------
[  462.667305] hda-intel: IRQ timing workaround is activated for card #0. S=
uggest a bigger bdl_pos_adj.
[  770.753437] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  770.806696] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  770.860064] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  770.913400] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  770.966721] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  771.020018] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  771.073382] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  771.126696] [drm] GMBUS timed out, falling back to bit banging on pin 0 =
[i915 gmbus disabled]
[  771.340045] [drm] GMBUS timed out, falling back to bit banging on pin 4 =
[i915 gmbus dpc]
[  961.296817] INFO: task modprobe:4538 blocked for more than 120 seconds.
[  961.296831] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  961.296843] modprobe        D e1001bec     0  4538   4495 0x00000000
[  961.296865]  e1001bfc 00000086 00000002 e1001bec 00000001 e1001c63 e1001=
b72 e1001b76
[  961.296894]  00000000 33343030 ab3291d1 00000001 f14c2c00 e1001c30 00000=
001 c14e1440
[  961.296921]  f657ca00 c14e1440 f657c440 f4e6c000 f5862f70 e1001bc8 c11ad=
279 e1001bfc
[  961.296949] Call Trace:
[  961.296977]  [<c11ad279>] ? format_decode+0x319/0x380
[  961.296993]  [<c11af1aa>] ? vsnprintf+0x2ea/0x3d0
[  961.297060]  [<c132f1ed>] __mutex_lock_slowpath+0x10d/0x2b0
[  961.297133]  [<c132f39b>] mutex_lock+0xb/0x20
[  961.297188]  [<f805820d>] i2c_add_adapter+0x2d/0xa0 [i2c_core]
[  961.297239]  [<f806b90d>] __i2c_bit_add_bus+0x17d/0x2f0 [i2c_algo_bit]
[  961.297291]  [<f80581e0>] ? i2c_add_numbered_adapter+0xd0/0xd0 [i2c_core]
[  961.297342]  [<f806ba9d>] i2c_bit_add_bus+0xd/0x10 [i2c_algo_bit]
[  961.297415]  [<f82cd52b>] intel_gpio_create+0x11b/0x170 [i915]
[  961.297517]  [<f82ce4aa>] gmbus_xfer+0xbca/0xdf0 [i915]
[  961.297599]  [<f80583c5>] i2c_transfer+0x85/0xb0 [i2c_core]
[  961.297653]  [<f80586c4>] i2c_smbus_xfer+0x234/0x540 [i2c_core]
[  961.297671]  [<c11a0001>] ? blk_throtl_work+0x291/0x4d0
[  961.297687]  [<c131515b>] ? klist_add_tail+0x3b/0x50
[  961.297703]  [<c124c0df>] ? put_device+0xf/0x20
[  961.297718]  [<c124d123>] ? device_add+0x73/0x5f0
[  961.297788]  [<f8058f99>] i2c_default_probe+0xe9/0x130 [i2c_core]
[  961.297830]  [<c124c335>] ? device_for_each_child+0x45/0x50
[  961.297907]  [<f8059153>] i2c_do_add_adapter+0x173/0x260 [i2c_core]
[  961.297933]  [<c11a8fd8>] ? kobject_uevent_env+0xf8/0x430
[  961.297955]  [<c11a8e90>] ? add_uevent_var+0xc0/0xc0
[  961.298034]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[  961.298110]  [<f8059652>] __process_new_driver+0x22/0x2b [i2c_core]
[  961.298136]  [<c124e8e1>] bus_for_each_dev+0x41/0x70
[  961.298210]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[  961.298286]  [<f80577ab>] i2c_for_each_dev+0x2b/0x50 [i2c_core]
[  961.298365]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[  961.298441]  [<f80593bf>] i2c_register_driver+0x4f/0xa0 [i2c_core]
[  961.298470]  [<c1066c65>] ? notifier_call_chain.isra.0+0x45/0x60
[  961.298500]  [<f8710012>] eeprom_init+0x12/0x14 [eeprom]
[  961.298524]  [<c1001120>] do_one_initcall+0x30/0x170
[  961.298572]  [<f8710000>] ? 0xf870ffff
[  961.298599]  [<c107b453>] sys_init_module+0xe03/0x1a20
[  961.298738]  [<c1330edf>] sysenter_do_call+0x12/0x28
[ 1081.296837] INFO: task modprobe:4538 blocked for more than 120 seconds.
[ 1081.296855] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1081.296871] modprobe        D e1001bec     0  4538   4495 0x00000000
[ 1081.296898]  e1001bfc 00000086 00000002 e1001bec 00000001 e1001c63 e1001=
b72 e1001b76
[ 1081.296938]  00000000 33343030 ab3291d1 00000001 f14c2c00 e1001c30 00000=
001 c14e1440
[ 1081.296980]  f657ca00 c14e1440 f657c440 f4e6c000 f5862f70 e1001bc8 c11ad=
279 e1001bfc
[ 1081.297019] Call Trace:
[ 1081.297055]  [<c11ad279>] ? format_decode+0x319/0x380
[ 1081.297079]  [<c11af1aa>] ? vsnprintf+0x2ea/0x3d0
[ 1081.297165]  [<c132f1ed>] __mutex_lock_slowpath+0x10d/0x2b0
[ 1081.297283]  [<c132f39b>] mutex_lock+0xb/0x20
[ 1081.297362]  [<f805820d>] i2c_add_adapter+0x2d/0xa0 [i2c_core]
[ 1081.297437]  [<f806b90d>] __i2c_bit_add_bus+0x17d/0x2f0 [i2c_algo_bit]
[ 1081.297515]  [<f80581e0>] ? i2c_add_numbered_adapter+0xd0/0xd0 [i2c_core]
[ 1081.297584]  [<f806ba9d>] i2c_bit_add_bus+0xd/0x10 [i2c_algo_bit]
[ 1081.297665]  [<f82cd52b>] intel_gpio_create+0x11b/0x170 [i915]
[ 1081.297767]  [<f82ce4aa>] gmbus_xfer+0xbca/0xdf0 [i915]
[ 1081.297867]  [<f80583c5>] i2c_transfer+0x85/0xb0 [i2c_core]
[ 1081.298032]  [<f80586c4>] i2c_smbus_xfer+0x234/0x540 [i2c_core]
[ 1081.298052]  [<c11a0001>] ? blk_throtl_work+0x291/0x4d0
[ 1081.298068]  [<c131515b>] ? klist_add_tail+0x3b/0x50
[ 1081.298084]  [<c124c0df>] ? put_device+0xf/0x20
[ 1081.298099]  [<c124d123>] ? device_add+0x73/0x5f0
[ 1081.298168]  [<f8058f99>] i2c_default_probe+0xe9/0x130 [i2c_core]
[ 1081.298185]  [<c124c335>] ? device_for_each_child+0x45/0x50
[ 1081.298239]  [<f8059153>] i2c_do_add_adapter+0x173/0x260 [i2c_core]
[ 1081.298258]  [<c11a8fd8>] ? kobject_uevent_env+0xf8/0x430
[ 1081.298273]  [<c11a8e90>] ? add_uevent_var+0xc0/0xc0
[ 1081.298329]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1081.298381]  [<f8059652>] __process_new_driver+0x22/0x2b [i2c_core]
[ 1081.298399]  [<c124e8e1>] bus_for_each_dev+0x41/0x70
[ 1081.298452]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1081.298505]  [<f80577ab>] i2c_for_each_dev+0x2b/0x50 [i2c_core]
[ 1081.298557]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1081.298610]  [<f80593bf>] i2c_register_driver+0x4f/0xa0 [i2c_core]
[ 1081.298629]  [<c1066c65>] ? notifier_call_chain.isra.0+0x45/0x60
[ 1081.298647]  [<f8710012>] eeprom_init+0x12/0x14 [eeprom]
[ 1081.298663]  [<c1001120>] do_one_initcall+0x30/0x170
[ 1081.298697]  [<f8710000>] ? 0xf870ffff
[ 1081.298714]  [<c107b453>] sys_init_module+0xe03/0x1a20
[ 1081.298825]  [<c1330edf>] sysenter_do_call+0x12/0x28
[ 1201.296846] INFO: task modprobe:4538 blocked for more than 120 seconds.
[ 1201.296859] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1201.296872] modprobe        D e1001bec     0  4538   4495 0x00000000
[ 1201.296893]  e1001bfc 00000086 00000002 e1001bec 00000001 e1001c63 e1001=
b72 e1001b76
[ 1201.296922]  00000000 33343030 ab3291d1 00000001 f14c2c00 e1001c30 00000=
001 c14e1440
[ 1201.296949]  f657ca00 c14e1440 f657c440 f4e6c000 f5862f70 e1001bc8 c11ad=
279 e1001bfc
[ 1201.296977] Call Trace:
[ 1201.297005]  [<c11ad279>] ? format_decode+0x319/0x380
[ 1201.297021]  [<c11af1aa>] ? vsnprintf+0x2ea/0x3d0
[ 1201.297090]  [<c132f1ed>] __mutex_lock_slowpath+0x10d/0x2b0
[ 1201.297164]  [<c132f39b>] mutex_lock+0xb/0x20
[ 1201.297231]  [<f805820d>] i2c_add_adapter+0x2d/0xa0 [i2c_core]
[ 1201.297370]  [<f806b90d>] __i2c_bit_add_bus+0x17d/0x2f0 [i2c_algo_bit]
[ 1201.297426]  [<f80581e0>] ? i2c_add_numbered_adapter+0xd0/0xd0 [i2c_core]
[ 1201.297477]  [<f806ba9d>] i2c_bit_add_bus+0xd/0x10 [i2c_algo_bit]
[ 1201.297550]  [<f82cd52b>] intel_gpio_create+0x11b/0x170 [i915]
[ 1201.297653]  [<f82ce4aa>] gmbus_xfer+0xbca/0xdf0 [i915]
[ 1201.297737]  [<f80583c5>] i2c_transfer+0x85/0xb0 [i2c_core]
[ 1201.297791]  [<f80586c4>] i2c_smbus_xfer+0x234/0x540 [i2c_core]
[ 1201.297809]  [<c11a0001>] ? blk_throtl_work+0x291/0x4d0
[ 1201.297826]  [<c131515b>] ? klist_add_tail+0x3b/0x50
[ 1201.297841]  [<c124c0df>] ? put_device+0xf/0x20
[ 1201.297856]  [<c124d123>] ? device_add+0x73/0x5f0
[ 1201.297927]  [<f8058f99>] i2c_default_probe+0xe9/0x130 [i2c_core]
[ 1201.297944]  [<c124c335>] ? device_for_each_child+0x45/0x50
[ 1201.297998]  [<f8059153>] i2c_do_add_adapter+0x173/0x260 [i2c_core]
[ 1201.298016]  [<c11a8fd8>] ? kobject_uevent_env+0xf8/0x430
[ 1201.298031]  [<c11a8e90>] ? add_uevent_var+0xc0/0xc0
[ 1201.298089]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1201.298144]  [<f8059652>] __process_new_driver+0x22/0x2b [i2c_core]
[ 1201.298161]  [<c124e8e1>] bus_for_each_dev+0x41/0x70
[ 1201.298215]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1201.298268]  [<f80577ab>] i2c_for_each_dev+0x2b/0x50 [i2c_core]
[ 1201.298332]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1201.298408]  [<f80593bf>] i2c_register_driver+0x4f/0xa0 [i2c_core]
[ 1201.298436]  [<c1066c65>] ? notifier_call_chain.isra.0+0x45/0x60
[ 1201.298464]  [<f8710012>] eeprom_init+0x12/0x14 [eeprom]
[ 1201.298487]  [<c1001120>] do_one_initcall+0x30/0x170
[ 1201.298534]  [<f8710000>] ? 0xf870ffff
[ 1201.298560]  [<c107b453>] sys_init_module+0xe03/0x1a20
[ 1201.298727]  [<c1330edf>] sysenter_do_call+0x12/0x28
[ 1206.700674] SysRq : Show Blocked State
[ 1206.700688]   task                PC stack   pid father
[ 1206.700880] modprobe        D e1001bec     0  4538   4495 0x00000000
[ 1206.700897]  e1001bfc 00000086 00000002 e1001bec 00000001 e1001c63 e1001=
b72 e1001b76
[ 1206.700916]  00000000 33343030 ab3291d1 00000001 f14c2c00 e1001c30 00000=
001 c14e1440
[ 1206.700934]  f657ca00 c14e1440 f657c440 f4e6c000 f5862f70 e1001bc8 c11ad=
279 e1001bfc
[ 1206.700954] Call Trace:
[ 1206.700974]  [<c11ad279>] ? format_decode+0x319/0x380
[ 1206.700986]  [<c11af1aa>] ? vsnprintf+0x2ea/0x3d0
[ 1206.701046]  [<c132f1ed>] __mutex_lock_slowpath+0x10d/0x2b0
[ 1206.701127]  [<c132f39b>] mutex_lock+0xb/0x20
[ 1206.701178]  [<f805820d>] i2c_add_adapter+0x2d/0xa0 [i2c_core]
[ 1206.701227]  [<f806b90d>] __i2c_bit_add_bus+0x17d/0x2f0 [i2c_algo_bit]
[ 1206.701277]  [<f80581e0>] ? i2c_add_numbered_adapter+0xd0/0xd0 [i2c_core]
[ 1206.701325]  [<f806ba9d>] i2c_bit_add_bus+0xd/0x10 [i2c_algo_bit]
[ 1206.701388]  [<f82cd52b>] intel_gpio_create+0x11b/0x170 [i915]
[ 1206.701485]  [<f82ce4aa>] gmbus_xfer+0xbca/0xdf0 [i915]
[ 1206.701570]  [<f80583c5>] i2c_transfer+0x85/0xb0 [i2c_core]
[ 1206.701620]  [<f80586c4>] i2c_smbus_xfer+0x234/0x540 [i2c_core]
[ 1206.701636]  [<c11a0001>] ? blk_throtl_work+0x291/0x4d0
[ 1206.701649]  [<c131515b>] ? klist_add_tail+0x3b/0x50
[ 1206.701660]  [<c124c0df>] ? put_device+0xf/0x20
[ 1206.701671]  [<c124d123>] ? device_add+0x73/0x5f0
[ 1206.701737]  [<f8058f99>] i2c_default_probe+0xe9/0x130 [i2c_core]
[ 1206.701751]  [<c124c335>] ? device_for_each_child+0x45/0x50
[ 1206.701799]  [<f8059153>] i2c_do_add_adapter+0x173/0x260 [i2c_core]
[ 1206.701814]  [<c11a8fd8>] ? kobject_uevent_env+0xf8/0x430
[ 1206.701826]  [<c11a8e90>] ? add_uevent_var+0xc0/0xc0
[ 1206.701876]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1206.701924]  [<f8059652>] __process_new_driver+0x22/0x2b [i2c_core]
[ 1206.701939]  [<c124e8e1>] bus_for_each_dev+0x41/0x70
[ 1206.701986]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1206.702035]  [<f80577ab>] i2c_for_each_dev+0x2b/0x50 [i2c_core]
[ 1206.702084]  [<f8059630>] ? i2c_del_adapter+0x1f0/0x1f0 [i2c_core]
[ 1206.702132]  [<f80593bf>] i2c_register_driver+0x4f/0xa0 [i2c_core]
[ 1206.702149]  [<c1066c65>] ? notifier_call_chain.isra.0+0x45/0x60
[ 1206.702163]  [<f8710012>] eeprom_init+0x12/0x14 [eeprom]
[ 1206.702176]  [<c1001120>] do_one_initcall+0x30/0x170
[ 1206.702204]  [<f8710000>] ? 0xf870ffff
[ 1206.702218]  [<c107b453>] sys_init_module+0xe03/0x1a20
[ 1206.702338]  [<c1330edf>] sysenter_do_call+0x12/0x28
[ 1206.702354] Sched Debug Version: v0.10, 2.6.39-ARCH #1
[ 1206.702363] ktime                                   : 1206702.352548
[ 1206.702371] sched_clk                               : 1205697.782307
[ 1206.702379] cpu_clk                                 : 1206702.350662
[ 1206.702386] jiffies                                 : 272010
[ 1206.702392] sched_clock_stable                      : 0
[ 1206.702398]=20
[ 1206.702401] sysctl_sched
[ 1206.702407]   .sysctl_sched_latency                    : 12.000000
[ 1206.702415]   .sysctl_sched_min_granularity            : 1.500000
[ 1206.702423]   .sysctl_sched_wakeup_granularity         : 2.000000
[ 1206.702430]   .sysctl_sched_child_runs_first           : 0
[ 1206.702436]   .sysctl_sched_features                   : 7279
[ 1206.702444]   .sysctl_sched_tunable_scaling            : 1 (logaritmic)
[ 1206.702452]=20
[ 1206.702455] cpu#0, 1596.132 MHz
[ 1206.702460]   .nr_running                    : 3
[ 1206.702466]   .load                          : 2729
[ 1206.702472]   .nr_switches                   : 1666116
[ 1206.702478]   .nr_load_updates               : 220382
[ 1206.702484]   .nr_uninterruptible            : 1
[ 1206.702490]   .next_balance                  : 0.272012
[ 1206.702497]   .curr->pid                     : 4201
[ 1206.702505]   .clock                         : 1206700.465859
[ 1206.702511]   .cpu_load[0]                   : 541
[ 1206.702517]   .cpu_load[1]                   : 516
[ 1206.702523]   .cpu_load[2]                   : 322
[ 1206.702529]   .cpu_load[3]                   : 197
[ 1206.702536]   .cpu_load[4]                   : 144
[ 1206.702545]=20
[ 1206.702547] cfs_rq[0]:/autogroup-37
[ 1206.702554]   .exec_clock                    : 0.000000
[ 1206.702562]   .MIN_vruntime                  : 0.000001
[ 1206.702569]   .min_vruntime                  : 4993.594736
[ 1206.702576]   .max_vruntime                  : 0.000001
[ 1206.702583]   .spread                        : 0.000000
[ 1206.702590]   .spread0                       : -892796.751521
[ 1206.702597]   .nr_spread_over                : 0
[ 1206.702603]   .nr_running                    : 1
[ 1206.702610]   .load                          : 1024
[ 1206.702617]   .load_avg                      : 0.000000
[ 1206.702624]   .load_period                   : 9.999999
[ 1206.702630]   .load_contrib                  : 0
[ 1206.702637]   .load_tg                       : 0
[ 1206.702645]   .se->exec_start                : 1206700.465859
[ 1206.702652]   .se->vruntime                  : 897784.646895
[ 1206.702660]   .se->sum_exec_runtime          : 4949.823694
[ 1206.702666]   .se->load.weight               : 1024
[ 1206.702675]=20
[ 1206.702678] cfs_rq[0]:/autogroup-20
[ 1206.702684]   .exec_clock                    : 0.000000
[ 1206.702692]   .MIN_vruntime                  : 0.000001
[ 1206.702699]   .min_vruntime                  : 82651.825963
[ 1206.702706]   .max_vruntime                  : 0.000001
[ 1206.702713]   .spread                        : 0.000000
[ 1206.702721]   .spread0                       : -815138.520294
[ 1206.702727]   .nr_spread_over                : 0
[ 1206.702733]   .nr_running                    : 0
[ 1206.702740]   .load                          : 0
[ 1206.702747]   .load_avg                      : 6057.359872
[ 1206.702754]   .load_period                   : 9.071832
[ 1206.702760]   .load_contrib                  : 667
[ 1206.702767]   .load_tg                       : 1574
[ 1206.702775]   .se->exec_start                : 1206700.003418
[ 1206.702783]   .se->vruntime                  : 897790.346257
[ 1206.702790]   .se->sum_exec_runtime          : 82669.707003
[ 1206.702797]   .se->load.weight               : 2
[ 1206.702805]=20
[ 1206.702808] cfs_rq[0]:/autogroup-32
[ 1206.702814]   .exec_clock                    : 0.000000
[ 1206.702822]   .MIN_vruntime                  : 289034.537793
[ 1206.702829]   .min_vruntime                  : 289035.678598
[ 1206.702837]   .max_vruntime                  : 289034.537793
[ 1206.702844]   .spread                        : 0.000000
[ 1206.702852]   .spread0                       : -608754.667659
[ 1206.702858]   .nr_spread_over                : 0
[ 1206.702865]   .nr_running                    : 1
[ 1206.702871]   .load                          : 1024
[ 1206.702877]   .load_avg                      : 2606.827683
[ 1206.702884]   .load_period                   : 7.060708
[ 1206.702891]   .load_contrib                  : 394
[ 1206.702897]   .load_tg                       : 909
[ 1206.702905]   .se->exec_start                : 1206699.263284
[ 1206.702913]   .se->vruntime                  : 897785.937817
[ 1206.702920]   .se->sum_exec_runtime          : 472433.308035
[ 1206.702927]   .se->load.weight               : 681
[ 1206.702934]=20
[ 1206.702936] cfs_rq[0]:/
[ 1206.702942]   .exec_clock                    : 0.000000
[ 1206.702950]   .MIN_vruntime                  : 897784.346257
[ 1206.702958]   .min_vruntime                  : 897790.346257
[ 1206.702965]   .max_vruntime                  : 897785.937817
[ 1206.702972]   .spread                        : 1.591560
[ 1206.702979]   .spread0                       : 0.000000
[ 1206.702986]   .nr_spread_over                : 0
[ 1206.702993]   .nr_running                    : 3
[ 1206.702999]   .load                          : 2729
[ 1206.703006]   .load_avg                      : 0.000000
[ 1206.703013]   .load_period                   : 0.000000
[ 1206.703019]   .load_contrib                  : 0
[ 1206.703026]   .load_tg                       : 0
[ 1206.703033]=20
[ 1206.703036] runnable tasks:
[ 1206.703039]             task   PID         tree-key  switches  prio     =
exec-runtime         sum-exec        sum-sleep
[ 1206.703044] ------------------------------------------------------------=
=2D---------------------------------------------
[ 1206.703161]          firefox  3926    289034.537793    264413   120     =
          0               0               0.000000               0.000000  =
             0.000000 /autogroup-32
[ 1206.703205] R           bash  4201      4993.594736       118   120     =
          0               0               0.000000               0.000000  =
             0.000000 /autogroup-37
[ 1206.703232]      kworker/0:3  4750    897784.346257      2597   120     =
          0               0               0.000000               0.000000  =
             0.000000 /
[ 1206.703256]=20
[ 1206.703258] cpu#1, 1596.132 MHz
[ 1206.703264]   .nr_running                    : 3
[ 1206.703270]   .load                          : 1478
[ 1206.703277]   .nr_switches                   : 1715530
[ 1206.703283]   .nr_load_updates               : 200464
[ 1206.703290]   .nr_uninterruptible            : 0
[ 1206.703296]   .next_balance                  : 0.272020
[ 1206.703302]   .curr->pid                     : 3005
[ 1206.703310]   .clock                         : 1206703.243963
[ 1206.703316]   .cpu_load[0]                   : 1478
[ 1206.703322]   .cpu_load[1]                   : 1026
[ 1206.703328]   .cpu_load[2]                   : 633
[ 1206.703334]   .cpu_load[3]                   : 397
[ 1206.703340]   .cpu_load[4]                   : 292
[ 1206.703349]=20
[ 1206.703351] cfs_rq[1]:/autogroup-20
[ 1206.703357]   .exec_clock                    : 0.000000
[ 1206.703365]   .MIN_vruntime                  : 0.000001
[ 1206.703372]   .min_vruntime                  : 72584.908065
[ 1206.703379]   .max_vruntime                  : 0.000001
[ 1206.703386]   .spread                        : 0.000000
[ 1206.703393]   .spread0                       : -825205.438192
[ 1206.703400]   .nr_spread_over                : 0
[ 1206.703406]   .nr_running                    : 0
[ 1206.703412]   .load                          : 1024
[ 1206.703419]   .load_avg                      : 4124.161792
[ 1206.703427]   .load_period                   : 5.380653
[ 1206.703432]   .load_contrib                  : 774
[ 1206.703438]   .load_tg                       : 1441
[ 1206.703446]   .se->exec_start                : 1206703.408312
[ 1206.703454]   .se->vruntime                  : 919383.747396
[ 1206.703461]   .se->sum_exec_runtime          : 72594.153351
[ 1206.703467]   .se->load.weight               : 620
[ 1206.703475]=20
[ 1206.703478] cfs_rq[1]:/autogroup-9
[ 1206.703485]   .exec_clock                    : 0.000000
[ 1206.703492]   .MIN_vruntime                  : 0.000001
[ 1206.703499]   .min_vruntime                  : 4998.478127
[ 1206.703506]   .max_vruntime                  : 0.000001
[ 1206.703513]   .spread                        : 0.000000
[ 1206.703516]   .spread0                       : -892791.868130
[ 1206.703516]   .nr_spread_over                : 0
[ 1206.703516]   .nr_running                    : 0
[ 1206.703516]   .load                          : 0
[ 1206.703516]   .load_avg                      : 1279.999872
[ 1206.703516]   .load_period                   : 8.070143
[ 1206.703516]   .load_contrib                  : 158
[ 1206.703516]   .load_tg                       : 158
[ 1206.703516]   .se->exec_start                : 1206681.362771
[ 1206.703516]   .se->vruntime                  : 919375.864455
[ 1206.703516]   .se->sum_exec_runtime          : 2512.975151
[ 1206.703516]   .se->load.weight               : 2
[ 1206.703516]=20
[ 1206.703516] cfs_rq[1]:/autogroup-32
[ 1206.703516]   .exec_clock                    : 0.000000
[ 1206.703516]   .MIN_vruntime                  : 287717.141074
[ 1206.703516]   .min_vruntime                  : 287720.953312
[ 1206.703516]   .max_vruntime                  : 287717.141074
[ 1206.703516]   .spread                        : 0.000000
[ 1206.703516]   .spread0                       : -610069.392945
[ 1206.703516]   .nr_spread_over                : 0
[ 1206.703516]   .nr_running                    : 2
[ 1206.703516]   .load                          : 2048
[ 1206.703516]   .load_avg                      : 2929.511347
[ 1206.703516]   .load_period                   : 5.367701
[ 1206.703516]   .load_contrib                  : 515
[ 1206.703516]   .load_tg                       : 909
[ 1206.703516]   .se->exec_start                : 1206703.534125
[ 1206.703516]   .se->vruntime                  : 919387.199619
[ 1206.703516]   .se->sum_exec_runtime          : 464780.243939
[ 1206.703516]   .se->load.weight               : 858
[ 1206.703516]=20
[ 1206.703516] cfs_rq[1]:/
[ 1206.703516]   .exec_clock                    : 0.000000
[ 1206.703516]   .MIN_vruntime                  : 919383.908395
[ 1206.703516]   .min_vruntime                  : 919387.199619
[ 1206.703516]   .max_vruntime                  : 919383.908395
[ 1206.703516]   .spread                        : 0.000000
[ 1206.703516]   .spread0                       : 21596.853362
[ 1206.703516]   .nr_spread_over                : 0
[ 1206.703516]   .nr_running                    : 2
[ 1206.703516]   .load                          : 1478
[ 1206.703516]   .load_avg                      : 0.000000
[ 1206.703516]   .load_period                   : 0.000000
[ 1206.703516]   .load_contrib                  : 0
[ 1206.703516]   .load_tg                       : 0
[ 1206.703516]=20
[ 1206.703516] runnable tasks:
[ 1206.703516]             task   PID         tree-key  switches  prio     =
exec-runtime         sum-exec        sum-sleep
[ 1206.703516] ------------------------------------------------------------=
=2D---------------------------------------------
[ 1206.703516]                X  3005     72585.005702    398233   120     =
          0               0               0.000000               0.000000  =
             0.000000 /autogroup-20
[ 1206.703516] R           kwin  3673    287716.183317    287687   120     =
          0               0               0.000000               0.000000  =
             0.000000 /autogroup-32
[ 1206.703516]          konsole  3749    287717.141074     12943   120     =
          0               0               0.000000               0.000000  =
             0.000000 /autogroup-32
[ 1206.703516]
=2D----------------------------------------------
>=20
> Thanks.

=2D-=20

Marek Otahal :o)

--nextPart2027105.p6i3tfHL7L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJN57IHAAoJEKvC5zPWx/wKnskP/RVUT7nxuqlECtiKzkZ8WM7/
2JZYvUN7wRf3cCQy7tJT41NqWbI/zpzbCIrK5b9itvgyQmlhDLPXuJ2Kkz5Ka+jE
FmBt6whDH+pRo4XTdaUMhSZ7NYZfscK1d48bkodPZmQzeb0H8o1aNg8TSw3eN6l2
1QkRs5M8UHIzQC/cAdrgGlPOANwM6VPxlSXOifC9V0fI1XQVQZaudNFg2KY0kkEH
xmHkfARjk8HHluwJG0vrvtvoByHaYvvvMrFnZAoBVNTwwPLRj6zB4XFj9kmFENXa
uZvq7zvIcHl82oPdOjU35Wm868UMFr/+03iHvPd89ob9Shr8CJkvmk9zqpLwFZGp
74RWAU3Pu4+3XkfAh8bjck+BSu8daqoTne61vwHTY5lPB/HrH+9RKBMaPE5eyUhd
Sc9/mCmMxr9ZJUoDdTXvpC+lXf1apW4mE6HmZTRSTIkQ2AzGvWhvFbmQeNXVq1l+
m8tHgjMqjAW1G78V4/Tpkm+VbH3Wk5SW4Dl62X9GXIUgeHIaW2baVsXpXXxNc/RD
LiQAiI3EtDlfbLUvXQliFFVGsa8HSoAHns1gwYxR198j8+6Q/ZEN3Q481tqZQv6J
8aiAR3abP6+XCQifZXuPUot09Ci1xA0jZM9eFdJ6rg8WITYVuNJzQr998VNObb47
MdfKdZ/4XL7qKUXT/HUA
=oTP6
-----END PGP SIGNATURE-----

--nextPart2027105.p6i3tfHL7L--
