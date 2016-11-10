From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Thu, 10 Nov 2016 16:30:16 +0100
Message-ID: <20161110153016.GJ26304@bigcity.dyn.berto.se>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34786 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933884AbcKJPaW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Nov 2016 10:30:22 -0500
Received: by mail-lf0-f45.google.com with SMTP id o141so120445605lff.1
        for <linux-i2c@vger.kernel.org>; Thu, 10 Nov 2016 07:30:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161109084406.GA22213@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org

Hi Simon and Wolfram,

Following up with my findings based on our IRC discussion.

On 2016-11-09 09:44:07 +0100, Simon Horman wrote:
> Hi Wolfram,
> 
> On Sun, Nov 06, 2016 at 09:20:18PM +0100, Wolfram Sang wrote:
> > So, here is the newest series for using the I2C demuxer on Gen2 boards.
> > Initially done by Simon. The intention of this series is to extend use of the
> > demuxer for I2C on the lager, koelsch, porter, koelsch, alt and silk boards to
> > cover all I2C IP blocks that are either already used or exposed via an EXIO
> > connector.
> > 
> > I tested this on a Lager board where I could successfully switch between I2C,
> > IIC, and GPIO on I2C2.
> > 
> > Simon, can you test with your script on the other boards? If all works, I'll
> > pick up the i2c patch for 4.9, so the DTS changes should be fine for 4.10.
> > 
> > The branch is here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/ip-switch-rework
> 
> I have tested these patches on alt, gose, lager and koelsch.
> The switching part seems to work fine, in so far as my test script
> succeeds. However, it seems that some IP blocks are not able to handle
> this switching. In particular I needed to disable VIDEO_RCAR_VIN and 
> REGULATOR_DA9210 to avoid errors shown in the logs below.

I tested the unbind/bind cycle we talked about, I'm testing on Koelsch 
using renesas-drivers-2016-11-08-v4.9-rc4 and shmobile_defconifg with 
the following additions:

# needed for systemd init...
CONFIG_CGROUPS=y
CONFIG_SECCOMP=y

# needed to grab large frame sizes
CONFIG_CMA=y
CONFIG_CMA_SIZE_MBYTES=64

# unrelated but is need for the HDMI input
CONFIG_VIDEO_ADV7604=y

qv4l2 -d /dev/video26
# video works fine

echo 2-0020 > /sys/bus/i2c/drivers/adv7180/unbind
# Any attempt to open /dev/video26 fails with EBUSY, this is expect
# when it do not have all devices available.

echo 2-0020 > /sys/bus/i2c/drivers/adv7180/bind
qv4l2 -d /dev/video26
# video works fine again

The VIN driver issue I mention on IRC was my fault, I tested an old 
build which did not contain a fix for rcar-vin Gen2.

So the conclusion is that the adv7180 and rcar-vin in 
renesas-drivers-2016-11-08-v4.9-rc4 can handle the rebind cycle. But 
looking at the boot logs it looks like you are using an older version of 
the rcar-vin driver, see bellow.

> 
> My suggestion is to drop the following patches until those problems
> can be sorted out, most likely via driver updates.
> 
> ARM: dts: alt: use demuxer for I2C1
> ARM: dts: gose: use demuxer for I2C2
> ARM: dts: lager: use demuxer for IIC2/I2C2
> ARM: dts: lager: use demuxer for IIC3/I2C3
> ARM: dts: koelsch: use demuxer for I2C2
> 
> I am not in a position to test silk or porter at this time.
> But by the same reasoning above I wonder if the following should
> be dropped for now.
> 
> ARM: dts: gose: use demuxer for I2C2
> ARM: dts: silk: use demuxer for I2C1
> 
> Some boot logs follow:
> 
> board: koelsch
> config: shmobile_defconfig; VIDEO_RCAR_VIN not set
> # ./exercise-i2c-demux.sh 
> ./exercise-i2c-demux.sh 
> I2C Demux: i2c-12. Master: 1:/i2c-9 (1)
> [   60.782245] i2c-gpio i2c-9: using pins 796 (SDA) and 795 (SCL)
> I2C Demux: i2c-12. Master: 0:/i2c@e6518000 (0)
> [   66.812087] i2c-rcar e6518000.i2c: probed
> I2C Demux: i2c-13. Master: 1:/i2c-10 (1)
> [   72.853085] i2c-gpio i2c-10: using pins 941 (SDA) and 940 (SCL)
> [   72.860037] adv7180 13-0020: chip found @ 0x20 (i2c-demux (master i2c-10))
> [   72.876990] i2c i2c-10: sendbytes: NAK bailout.
> [   72.913992] at24 13-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
> I2C Demux: i2c-13. Master: 0:/i2c@e6530000 (0)
> [   78.942593] i2c-rcar e6530000.i2c: probed
> [   78.947595] adv7180 13-0020: chip found @ 0x20 (i2c-demux (master i2c-2))
> [   78.979763] at24 13-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
> I2C Demux: i2c-14. Master: 1:/i2c-11 (1)
> [   85.022244] i2c-gpio i2c-11: using pins 794 (SDA) and 793 (SCL)
> I2C Demux: i2c-14. Master: 0:/i2c@e6520000 (0)
> [   91.052892] i2c-rcar e6520000.i2c: probed
> 
> board: koelsch
> config: shmobile_defconfig
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-12. Master: 1:/i2c-9 (1)
> [   44.742363] i2c-gpio i2c-9: using pins 796 (SDA) and 795 (SCL)
> I2C Demux: i2c-12. Master: 0:/i2c@e6518000 (0)
> [   51.591786] i2c-rcar e6518000.i2c: probed
> I2C Demux: i2c-13. Master: 1:/i2c-10 (1)
> [   57.630256] rcar-vin e6ef1000.video: Removing video25

This line tells me you are using the rcar-vin without the Gen3 patches.  
Part of Gen3 enablement is to rework the bind/unbind handling to be 
smarter since there are more subdevices involved. Can you rerun the 
tests on top of renesas-drivers-2016-11-08-v4.9-rc4?  That branch 
contains the VIN Gen3 patches.

> [   57.638391] i2c-gpio i2c-10: using pins 941 (SDA) and 940 (SCL)
> [   57.646081] adv7180 13-0020: chip found @ 0x20 (i2c-demux (master i2c-10))
> [   57.663185] i2c i2c-10: sendbytes: NAK bailout.
> [   57.682324] kobject (ee422118): tried to init an initialized object, something is seriously wrong.

Yes, this is a bug in the rcar-vin driver which is addressed in the Gen3 
patches. However I'm not sure those patches will make it to v4.10, not 
much review from the V4L2 side yet (Geert and Sergei have had a few 
comments so there will at lest be one more iteration).

If this is a big blocker I can try and break out the fix from the Gen3 
patch series, but I fear even that series would be quiet large since a 
rework on the whole logic is needed to fix this (maybe a workaround can 
be figure out to fix this until Gen3 patches are accepted). Let me know 
what you think.

> [   57.691333] CPU: 0 PID: 1823 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00308-g0c970223ab93 #124
> [   57.700203] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [   57.706380] Backtrace: 
> [   57.708849] [<c010a094>] (dump_backtrace) from [<c010a234>] (show_stack+0x18/0x1c)
> [   57.716414]  r6:c08360fc[   57.718770]  r5:00000000
>  r4:60000013[   57.722352]  r3:00404000
> [   57.724882] 
> [   57.726378] [<c010a21c>] (show_stack) from [<c02df780>] (dump_stack+0x80/0xa0)
> [   57.733601] [<c02df700>] (dump_stack) from [<c02e1668>] (kobject_init+0x3c/0x98)
> [   57.740992]  r5:c0a2c900[   57.743347]  r4:ee422118
> [   57.745876] 
> [   57.747375] [<c02e162c>] (kobject_init) from [<c03baab0>] (device_initialize+0x28/0x94)
> [   57.755373]  r5:c0a7db24[   57.757727]  r4:ee422110
> [   57.760256] 
> [   57.761748] [<c03baa88>] (device_initialize) from [<c03bc4e0>] (device_register+0x14/0x20)
> [   57.770007]  r5:00000019[   57.772361]  r4:ee422110
> [   57.774890] 
> [   57.776384] [<c03bc4cc>] (device_register) from [<c04a02c4>] (__video_register_device+0xf4c/0x123c)
> [   57.785424]  r4:ee422020[   57.787778]  r3:00000019
> [   57.790308] 
> [   57.791801] [<c049f378>] (__video_register_device) from [<c04cd124>] (rvin_v4l2_probe+0x204/0x268)
> [   57.800753]  r10:c0a3330c[   57.803194]  r9:00000000
>  r8:c0a34338[   57.806776]  r7:c077d784
>  r6:ee422388[   57.810357]  r5:ee54b054
> [   57.812887]  r4:ee422010[   57.815241] 
> [   57.816734] [<c04ccf20>] (rvin_v4l2_probe) from [<c04cac5c>] (rvin_digital_notify_complete+0xe8/0x11c)
> [   57.826034]  r7:00002006[   57.828388]  r6:ee422010
>  r5:00000000[   57.831969]  r4:ee4223cc
> [   57.834498] 
> [   57.835990] [<c04cab74>] (rvin_digital_notify_complete) from [<c04af7d8>] (v4l2_async_test_notify+0xe0/0xec)
> [   57.845811]  r7:c04cab74[   57.848165]  r6:ee4223fc
>  r5:ee54b054[   57.851746]  r4:ee4223cc
> [   57.854275] 
> [   57.855766] [<c04af6f8>] (v4l2_async_test_notify) from [<c04afb34>] (v4l2_async_register_subdev+0x6c/0xc4)
> [   57.865413]  r7:ee54b100[   57.867767]  r6:ee4223cc
>  r5:ee54b054[   57.871349]  r4:c0a34320
> [   57.873878] 
> [   57.875371] [<c04afac8>] (v4l2_async_register_subdev) from [<c049ba04>] (adv7180_probe+0x31c/0x3cc)
> [   57.884410]  r8:00000001[   57.886764]  r7:ee54b054
>  r6:00000000[   57.890346]  r5:ee549600
>  r4:ee54b010[   57.893927]  r3:00000000
> [   57.896465] [<c049b6e8>] (adv7180_probe) from [<c0491854>] (i2c_device_probe+0x1a0/0x1f4)
> [   57.904636]  r9:ee4ee000[   57.906991]  r8:c049b6e8
>  r7:ee549600[   57.910572]  r6:ee549604
>  r5:c077508c[   57.914153]  r4:ee549620
> [   57.916689] [<c04916b4>] (i2c_device_probe) from [<c03be600>] (driver_probe_device+0x134/0x2b0)
> [   57.925382]  r8:ef362c60[   57.927735]  r7:00000014
>  r6:c0a337d4[   57.931317]  r5:00000000
>  r4:ee549620[   57.934898]  r3:c04916b4
> [   57.937432] [<c03be4cc>] (driver_probe_device) from [<c03bea0c>] (__device_attach_driver+0xa4/0xb0)
> [   57.946471]  r7:00000000[   57.948825]  r6:ee4efca8
>  r5:c0a337d4[   57.952406]  r4:ee549620
> [   57.954936] 
> [   57.956428] [<c03be968>] (__device_attach_driver) from [<c03bd0ec>] (bus_for_each_drv+0x58/0x94)
> [   57.965208]  r6:c03be968[   57.967562]  r5:ee4efc80
>  r4:ee4efca8[   57.971144]  r3:ef160d70
> [   57.973673] 
> [   57.975165] [<c03bd094>] (bus_for_each_drv) from [<c03be384>] (__device_attach+0x8c/0x104)
> [   57.983423]  r7:00000000[   57.985777]  r6:00000001
>  r5:ee549654[   57.989358]  r4:ee549620
> [   57.991887] 
> [   57.993378] [<c03be2f8>] (__device_attach) from [<c03bea44>] (device_initial_probe+0x14/0x18)
> [   58.001897]  r7:00000000[   58.004251]  r6:ee549620
>  r5:c0a33358[   58.007832]  r4:ee549620
> [   58.010362] 
> [   58.011853] [<c03bea30>] (device_initial_probe) from [<c03bd2a0>] (bus_probe_device+0x30/0x88)
> [   58.020465] [<c03bd270>] (bus_probe_device) from [<c03bc1dc>] (device_add+0x38c/0x514)
> [   58.028376]  r6:00000000[   58.030730]  r5:ee549628
>  r4:ee549620[   58.034311]  r3:00000000
> [   58.036840] 
> [   58.038332] [<c03bbe50>] (device_add) from [<c03bc4e8>] (device_register+0x1c/0x20)
> [   58.045983]  r10:ffffffed[   58.048424]  r8:ef7f46d0
>  r7:ee549604[   58.052005]  r6:ee549620
>  r5:ef362c20[   58.055587]  r4:ee549620
> [   58.058123] [<c03bc4cc>] (device_register) from [<c0491e84>] (i2c_new_device+0x114/0x184)
> [   58.066295]  r4:ee549600[   58.068649]  r3:00000020
> [   58.071178] 
> [   58.072670] [<c0491d70>] (i2c_new_device) from [<c04921dc>] (of_i2c_register_device+0x160/0x184)
> [   58.081450]  r7:ef7f4a1c[   58.083803]  r6:ef362c60
>  r5:ef362c20[   58.087385]  r4:ef7f4a1c
> [   58.089914] 
> [   58.091407] [<c049207c>] (of_i2c_register_device) from [<c0492454>] (i2c_register_adapter+0x254/0x398)
> [   58.100707]  r5:ef362c20[   58.103061]  r4:00000000
> [   58.105591] 
> [   58.107083] [<c0492200>] (i2c_register_adapter) from [<c0492608>] (__i2c_add_numbered_adapter+0x70/0x94)
> [   58.116557]  r8:ef362e6c[   58.118911]  r7:00000000
>  r6:00000001[   58.122493]  r5:0000000d
>  r4:ef362c20[   58.126074]  r3:00000001
> [   58.128610] [<c0492598>] (__i2c_add_numbered_adapter) from [<c0492c58>] (i2c_add_adapter+0x3c/0xc8)
> [   58.137650]  r5:ef362810[   58.140004]  r4:ef362c20
> [   58.142533] 
> [   58.144025] [<c0492c1c>] (i2c_add_adapter) from [<c0499f84>] (i2c_demux_activate_master+0x104/0x15c)
> [   58.153152]  r5:ef362810[   58.155506]  r4:ef362c10
> [   58.158035] 
> [   58.159527] [<c0499e80>] (i2c_demux_activate_master) from [<c049a178>] (current_master_store+0xa0/0xb4)
> [   58.168913]  r10:ee4eff80[   58.171355]  r8:ef362e50
>  r7:00000001[   58.174936]  r6:00000000
>  r5:00000002[   58.178517]  r4:ef362c10
> [   58.181052] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   58.189484]  r8:00000051[   58.191838]  r7:ee453a0c
>  r6:ef161180[   58.195419]  r5:00000002
>  r4:ef161180[   58.198999] 
> [   58.200495] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   58.208411] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   58.216669]  r4:ee453a00[   58.219024]  r3:c0240140
> [   58.221553] 
> [   58.223045] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   58.230956]  r10:00000000[   58.233397]  r8:00022900
>  r7:00000002[   58.236979]  r6:ee4eff80
>  r5:c023f658[   58.240560]  r4:ee57c780
> [   58.243093] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   58.250397]  r8:ee4eff80[   58.252751]  r7:00022900
>  r6:00000002[   58.256331]  r5:00000000
>  r4:ee57c780[   58.259912] 
> [   58.261404] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   58.268447]  r10:00000000[   58.270888]  r8:c0107104
>  r7:00022900[   58.274469]  r6:00000002
>  r5:ee57c780[   58.278050]  r4:ee57c780
> [   58.280586] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   58.288149]  r7:00000004[   58.290504]  r6:000217bc
>  r5:00000002[   58.294085]  r4:00022900
> [   58.296614] 
> [   58.299808] rcar-vin e6ef1000.video: Device registered as video25
> [   58.328488] at24 13-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
> I2C Demux: i2c-13. Master: 0:/i2c@e6530000 (0)
> [   64.370408] rcar-vin e6ef1000.video: Removing video25
> [   64.375646] Unable to handle kernel NULL pointer dereference at virtual address 00000005
> [   64.383761] pgd = ee584000
> [   64.386466] [00000005] *pgd=7fc30835
> [   64.390058] Internal error: Oops: 817 [#1] SMP ARM
> [   64.394851] CPU: 0 PID: 1823 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00308-g0c970223ab93 #124
> [   64.403718] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [   64.409895] task: ee879000 task.stack: ee4ee000
> [   64.414430] PC is at driver_deferred_probe_del+0x34/0x54
> [   64.419739] LR is at driver_deferred_probe_del+0x18/0x54
> [   64.425048] pc : [<c03be1ac>]    lr : [<c03be190>]    psr: a0000013
> [   64.425048] sp : ee4efc48  ip : ee4efc48  fp : ee4efc5c
> [   64.436521] r10: ee4eff80  r9 : ee4ee000  r8 : 00000100
> [   64.441742] r7 : 00000000  r6 : ef21ea10  r5 : ee87ad38  r4 : ee422110
> [   64.448264] r3 : ef3d3900  r2 : ef3d3944  r1 : 00000000  r0 : 00000001
> [   64.454789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   64.461920] Control: 10c5387d  Table: 6e58406a  DAC: 00000051
> [   64.467662] Process exercise-i2c-de (pid: 1823, stack limit = 0xee4ee210)
> [   64.474446] Stack: (0xee4efc48 to 0xee4f0000)
> [   64.478801] fc40:                   00000040 ee422110 ee4efc8c ee4efc60 c03baf54 c03be184
> [   64.486977] fc60: 3a313800 00003636 ee4ee000 ee4eff80 ee422110 ee4223cc ee549600 00000000
> [   64.495152] fc80: ee4efca4 ee4efc90 c03baff0 c03bae00 00000001 ee422020 ee4efcbc ee4efca8
> [   64.503326] fca0: c04a05f8 c03bafe8 c094f360 ee422010 ee4efcd4 ee4efcc0 c04ccf18 c04a05c0
> [   64.511500] fcc0: ee54b054 ee4223cc ee4efcec ee4efcd8 c04cab00 c04cceec c04caad8 ee54b054
> [   64.519675] fce0: ee4efd04 ee4efcf0 c04afc0c c04caae4 ee54b054 ee54b010 ee4efd24 ee4efd08
> [   64.527849] fd00: c049aa14 c04afb98 c049a9f4 ee549620 c0a337d4 c0a33358 ee4efd3c ee4efd28
> [   64.536024] fd20: c0491684 c049aa00 ee549620 c0a337d4 ee4efd54 ee4efd40 c03be8f4 c049163c
> [   64.544198] fd40: ee549654 ee549620 ee4efd6c ee4efd58 c03bea94 c03be864 ee549620 ef160d30
> [   64.552372] fd60: ee4efd8c ee4efd70 c03bd3d8 c03bea7c 0000000a ee549620 ee4efe08 ef362c60
> [   64.560547] fd80: ee4efdbc ee4efd90 c03baf44 c03bd304 ee9a0d14 c03baddc ee4efdc4 ee4efda8
> [   64.568721] fda0: ee549620 ee4efe08 c04928a4 00000000 ee4efdd4 ee4efdc0 c03baff0 c03bae00
> [   64.576896] fdc0: 00000008 ee549600 ee4efdec ee4efdd8 c049265c c03bafe8 00000061 ee549600
> [   64.585070] fde0: ee4efe04 ee4efdf0 c04928e4 c0492638 c0861000 00000000 ee4efe2c ee4efe08
> [   64.593244] fe00: c03bb2ec c04928b0 ef372680 ee9b2594 ef362c20 ef362c60 c0a7f848 ef362c20
> [   64.601419] fe20: ee4efe54 ee4efe30 c0492e18 c03bb2b4 00000002 ef362c10 00000002 00000001
> [   64.609593] fe40: 00000000 00000025 ee4efe84 ee4efe58 c049a13c c0492d18 00000000 00000000
> [   64.617767] fe60: ee4efe5c ee9b0680 00000002 ee9b0680 ee364b0c 00000051 ee4efe94 ee4efe88
> [   64.625942] fe80: c03ba1ac c049a0e4 ee4efeac ee4efe98 c0240184 c03ba198 c0240140 ee364b00
> [   64.634117] fea0: ee4efedc ee4efeb0 c023f7a8 c024014c 00000000 00000000 ee57c300 c023f658
> [   64.642291] fec0: ee4eff80 00000002 00022900 00000000 ee4eff4c ee4efee0 c01e2124 c023f664
> [   64.650465] fee0: 00000000 ef2b3000 ef2b3000 eeb39000 0000000a 0000000b ee4f7000 0000000a
> [   64.658640] ff00: ee4eff3c ee4eff10 c01fe1b8 ee5b29c0 0000000b ee5b29c0 0000000a 00000001
> [   64.666814] ff20: ee4eff3c ee4eff30 ee57c300 ee57c300 00000000 00000002 00022900 ee4eff80
> [   64.674988] ff40: ee4eff7c ee4eff50 c01e238c c01e20fc c01fe64c c01fdc5c ee57c300 ee57c300
> [   64.683163] ff60: 00000002 00022900 c0107104 00000000 ee4effa4 ee4eff80 c01e24e4 c01e22d4
> [   64.691337] ff80: 00000000 00000000 00022900 00000002 000217bc 00000004 00000000 ee4effa8
> [   64.699512] ffa0: c0106f40 c01e24a8 00022900 00000002 00000001 00022900 00000002 00022902
> [   64.707686] ffc0: 00022900 00000002 000217bc 00000004 00000002 00000000 00022700 000219cc
> [   64.715860] ffe0: 00000001 bef14770 00012db1 b6f53b9c 60000010 00000001 37363534 3a3b3938
> [   64.724030] Backtrace: 
> [   64.726491] [<c03be178>] (driver_deferred_probe_del) from [<c03baf54>] (device_del+0x160/0x1e8)
> [   64.735183]  r4:ee422110[   64.737538]  r3:00000040
> [   64.740068] 
> [   64.741560] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   64.749385]  r7:00000000[   64.751739]  r6:ee549600
>  r5:ee4223cc[   64.755321]  r4:ee422110
> [   64.757850] 
> [   64.759345] [<c03bafdc>] (device_unregister) from [<c04a05f8>] (video_unregister_device+0x44/0x4c)
> [   64.768297]  r4:ee422020[   64.770651]  r3:00000001
> [   64.773181] 
> [   64.774675] [<c04a05b4>] (video_unregister_device) from [<c04ccf18>] (rvin_v4l2_remove+0x38/0x40)
> [   64.783541]  r4:ee422010[   64.785895]  r3:c094f360
> [   64.788425] 
> [   64.789916] [<c04ccee0>] (rvin_v4l2_remove) from [<c04cab00>] (rvin_digital_notify_unbind+0x28/0x4c)
> [   64.799042]  r4:ee4223cc[   64.801396]  r3:ee54b054
> [   64.803925] 
> [   64.805417] [<c04caad8>] (rvin_digital_notify_unbind) from [<c04afc0c>] (v4l2_async_unregister_subdev+0x80/0x90)
> [   64.815585]  r4:ee54b054[   64.817939]  r3:c04caad8
> [   64.820468] 
> [   64.821961] [<c04afb8c>] (v4l2_async_unregister_subdev) from [<c049aa14>] (adv7180_remove+0x20/0x8c)
> [   64.831087]  r5:ee54b010[   64.833441]  r4:ee54b054
> [   64.835970] 
> [   64.837463] [<c049a9f4>] (adv7180_remove) from [<c0491684>] (i2c_device_remove+0x54/0x84)
> [   64.845634]  r6:c0a33358[   64.847989]  r5:c0a337d4
>  r4:ee549620[   64.851569]  r3:c049a9f4
> [   64.854098] 
> [   64.855590] [<c0491630>] (i2c_device_remove) from [<c03be8f4>] (__device_release_driver+0x9c/0x110)
> [   64.864629]  r5:c0a337d4[   64.866983]  r4:ee549620
> [   64.869512] 
> [   64.871003] [<c03be858>] (__device_release_driver) from [<c03bea94>] (device_release_driver+0x24/0x30)
> [   64.880303]  r5:ee549620[   64.882657]  r4:ee549654
> [   64.885186] 
> [   64.886678] [<c03bea70>] (device_release_driver) from [<c03bd3d8>] (bus_remove_device+0xe0/0xf0)
> [   64.895457]  r5:ef160d30[   64.897811]  r4:ee549620
> [   64.900340] 
> [   64.901833] [<c03bd2f8>] (bus_remove_device) from [<c03baf44>] (device_del+0x150/0x1e8)
> [   64.909830]  r6:ef362c60[   64.912184]  r5:ee4efe08
>  r4:ee549620[   64.915765]  r3:0000000a
> [   64.918294] 
> [   64.919786] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   64.927610]  r7:00000000[   64.929965]  r6:c04928a4
>  r5:ee4efe08[   64.933545]  r4:ee549620
> [   64.936074] 
> [   64.937567] [<c03bafdc>] (device_unregister) from [<c049265c>] (i2c_unregister_device+0x30/0x34)
> [   64.946346]  r4:ee549600[   64.948700]  r3:00000008
> [   64.951229] 
> [   64.952722] [<c049262c>] (i2c_unregister_device) from [<c04928e4>] (__unregister_client+0x40/0x50)
> [   64.961674]  r4:ee549600[   64.964029]  r3:00000061
> [   64.966558] 
> [   64.968050] [<c04928a4>] (__unregister_client) from [<c03bb2ec>] (device_for_each_child+0x44/0x80)
> [   64.977003]  r4:00000000[   64.979357]  r3:c0861000
> [   64.981886] 
> [   64.983378] [<c03bb2a8>] (device_for_each_child) from [<c0492e18>] (i2c_del_adapter+0x10c/0x1ac)
> [   64.992157]  r7:ef362c20[   64.994512]  r6:c0a7f848
>  r5:ef362c60[   64.998092]  r4:ef362c20
> [   65.000621] 
> [   65.002113] [<c0492d0c>] (i2c_del_adapter) from [<c049a13c>] (current_master_store+0x64/0xb4)
> [   65.010632]  r8:00000025[   65.012986]  r7:00000000
>  r6:00000001[   65.016567]  r5:00000002
>  r4:ef362c10[   65.020148]  r3:00000002
> [   65.022683] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   65.031114]  r8:00000051[   65.033468]  r7:ee364b0c
>  r6:ee9b0680[   65.037050]  r5:00000002
>  r4:ee9b0680[   65.040630] 
> [   65.042126] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   65.050041] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   65.058298]  r4:ee364b00[   65.060653]  r3:c0240140
> [   65.063182] 
> [   65.064675] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   65.072586]  r10:00000000[   65.075027]  r8:00022900
>  r7:00000002[   65.078607]  r6:ee4eff80
>  r5:c023f658[   65.082188]  r4:ee57c300
> [   65.084721] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   65.092025]  r8:ee4eff80[   65.094379]  r7:00022900
>  r6:00000002[   65.097960]  r5:00000000
>  r4:ee57c300[   65.101540] 
> [   65.103031] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   65.110074]  r10:00000000[   65.112515]  r8:c0107104
>  r7:00022900[   65.116096]  r6:00000002
>  r5:ee57c300[   65.119677]  r4:ee57c300
> [   65.122214] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   65.129777]  r7:00000004[   65.132132]  r6:000217bc
>  r5:00000002[   65.135713]  r4:00022900
> [   65.138242] 
> [   65.139732] Code: e1520001 0a000005 e5931048 e5930044 (e5801004) 
> [   65.145837] ---[ end trace d7a178c2931274b3 ]---
> Segmentation fault
> 
> board: lager
> config: shmobile_defconfig; VIDEO_RCAR_VIN not set; REGULATOR_DA9210 not set
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-10. Master: 1:/i2c@e6508000 (1)
> [   68.660717] i2c-rcar e6508000.i2c: probed
> I2C Demux: i2c-10. Master: 0:/i2c@e6500000 (0)
> [   74.690381] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
> I2C Demux: i2c-11. Master: 2:/i2c-8 (2)
> [   80.730230] i2c-gpio i2c-8: using pins 979 (SDA) and 978 (SCL)
> I2C Demux: i2c-11. Master: 1:/i2c@e6518000 (1)
> [   86.760649] i2c-rcar e6518000.i2c: probed
> I2C Demux: i2c-11. Master: 0:/i2c@e6510000 (0)
> [   92.790396] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
> I2C Demux: i2c-12. Master: 2:/i2c-9 (2)
> [   98.830849] i2c-gpio i2c-9: using pins 842 (SDA) and 841 (SCL)
> [   98.837689] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [   98.853987] i2c i2c-9: sendbytes: NAK bailout.
> I2C Demux: i2c-12. Master: 1:/i2c@e6530000 (1)
> [  104.911287] i2c-rcar e6530000.i2c: probed
> [  104.916217] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-2))
> I2C Demux: i2c-12. Master: 0:/i2c@e6520000 (0)
> [  110.971195] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
> [  110.979598] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-6))
> I2C Demux: i2c-13. Master: 1:/i2c@e6540000 (1)
> [  117.081495] i2c-rcar e6540000.i2c: probed
> [  117.089796] da9063 13-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
> [  117.123513] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
> I2C Demux: i2c-13. Master: 0:/i2c@e60b0000 (0)
> [  123.201655] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
> [  123.214052] da9063 13-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
> [  123.249609] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
> 
> board: lager
> config: shmobile_defconfig; VIDEO_RCAR_VIN not set
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-10. Master: 1:/i2c@e6508000 (1)
> [   60.002572] i2c-rcar e6508000.i2c: probed
> I2C Demux: i2c-10. Master: 0:/i2c@e6500000 (0)
> [   66.032289] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
> I2C Demux: i2c-11. Master: 2:/i2c-8 (2)
> [   72.072038] i2c-gpio i2c-8: using pins 979 (SDA) and 978 (SCL)
> I2C Demux: i2c-11. Master: 1:/i2c@e6518000 (1)
> [   78.102453] i2c-rcar e6518000.i2c: probed
> I2C Demux: i2c-11. Master: 0:/i2c@e6510000 (0)
> [   84.132195] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
> I2C Demux: i2c-12. Master: 2:/i2c-9 (2)
> [   90.172747] i2c-gpio i2c-9: using pins 842 (SDA) and 841 (SCL)
> [   90.179391] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [   90.195671] i2c i2c-9: sendbytes: NAK bailout.
> I2C Demux: i2c-12. Master: 1:/i2c@e6530000 (1)
> [   96.254118] i2c-rcar e6530000.i2c: probed
> [   96.259121] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-2))
> I2C Demux: i2c-12. Master: 0:/i2c@e6520000 (0)
> [  102.312792] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
> [  102.320643] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-6))
> I2C Demux: i2c-13. Master: 1:/i2c@e6540000 (1)
> [  108.431603] ------------[ cut here ]------------
> [  108.436239] WARNING: CPU: 0 PID: 1983 at drivers/regulator/core.c:4102 regulator_unregister+0x6c/0xb8
> [  108.445494] CPU: 0 PID: 1983 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00309-g8ef5284b21f6 #130
> [  108.454364] Hardware name: Generic R8A7790 (Flattened Device Tree)
> [  108.460539] Backtrace: 
> [  108.463002] [<c010a094>] (dump_backtrace) from [<c010a234>] (show_stack+0x18/0x1c)
> [  108.470567]  r6:c0813174[  108.472921]  r5:00000000
>  r4:60000013[  108.476504]  r3:00404000
> [  108.479033] 
> [  108.480528] [<c010a21c>] (show_stack) from [<c02df780>] (dump_stack+0x80/0xa0)
> [  108.487751] [<c02df700>] (dump_stack) from [<c011e434>] (__warn+0xc4/0xf0)
> [  108.494620]  r5:c03538e0[  108.496974]  r4:00000000
> [  108.499503] 
> [  108.500994] [<c011e370>] (__warn) from [<c011e518>] (warn_slowpath_null+0x28/0x30)
> [  108.508558]  r10:c03c0fe0[  108.510999]  r8:edd31cf0
>  r7:ef200e40[  108.514580]  r6:00000006
>  r5:ee819f00[  108.518161]  r4:ee81e800
> [  108.520696] [<c011e4f0>] (warn_slowpath_null) from [<c03538e0>] (regulator_unregister+0x6c/0xb8)
> [  108.529481] [<c0353874>] (regulator_unregister) from [<c0354348>] (devm_rdev_release+0x14/0x18)
> [  108.538173]  r4:ee81c620[  108.540527]  r3:c0354334
> [  108.543056] 
> [  108.544551] [<c0354334>] (devm_rdev_release) from [<c03c1344>] (release_nodes+0x1a8/0x1d4)
> [  108.552813] [<c03c119c>] (release_nodes) from [<c03c1720>] (devres_release_all+0x4c/0x54)
> [  108.560984]  r10:edd31f80[  108.563425]  r9:edd30000
>  r8:00000100[  108.567006]  r7:00000000
>  r6:c0a33358[  108.570587]  r5:c0a24f14
> [  108.573117]  r4:ee81c620[  108.575470] 
> [  108.576962] [<c03c16d4>] (devres_release_all) from [<c03be8fc>] (__device_release_driver+0xa4/0x110)
> [  108.586088]  r4:ee81c620[  108.588442]  r3:00000000
> [  108.590971] 
> [  108.592461] [<c03be858>] (__device_release_driver) from [<c03bea94>] (device_release_driver+0x24/0x30)
> [  108.601761]  r5:ee81c620[  108.604115]  r4:ee81c654
> [  108.606643] 
> [  108.608137] [<c03bea70>] (device_release_driver) from [<c03bd3d8>] (bus_remove_device+0xe0/0xf0)
> [  108.616915]  r5:ef1cc430[  108.619269]  r4:ee81c620
> [  108.621799] 
> [  108.623291] [<c03bd2f8>] (bus_remove_device) from [<c03baf44>] (device_del+0x150/0x1e8)
> [  108.631289]  r6:ef339460[  108.633643]  r5:edd31e08
>  r4:ee81c620[  108.637223]  r3:00000009
> [  108.639752] 
> [  108.641243] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [  108.649067]  r7:00000000[  108.651421]  r6:c04928a4
>  r5:edd31e08[  108.655002]  r4:ee81c620
> [  108.657531] 
> [  108.659026] [<c03bafdc>] (device_unregister) from [<c049265c>] (i2c_unregister_device+0x30/0x34)
> [  108.667805]  r4:ee81c600[  108.670159]  r3:00000008
> [  108.672688] 
> [  108.674180] [<c049262c>] (i2c_unregister_device) from [<c04928e4>] (__unregister_client+0x40/0x50)
> [  108.683133]  r4:ee81c600[  108.685487]  r3:00000061
> [  108.688016] 
> [  108.689508] [<c04928a4>] (__unregister_client) from [<c03bb2ec>] (device_for_each_child+0x44/0x80)
> [  108.698460]  r4:00000000[  108.700814]  r3:c085f000
> [  108.703343] 
> [  108.704835] [<c03bb2a8>] (device_for_each_child) from [<c0492e18>] (i2c_del_adapter+0x10c/0x1ac)
> [  108.713614]  r7:ef339420[  108.715968]  r6:c0a7f848
>  r5:ef339460[  108.719548]  r4:ef339420
> [  108.722077] 
> [  108.723570] [<c0492d0c>] (i2c_del_adapter) from [<c049a13c>] (current_master_store+0x64/0xb4)
> [  108.732089]  r8:00000024[  108.734443]  r7:00000001
>  r6:00000000[  108.738023]  r5:00000002
>  r4:ef339410[  108.741603]  r3:00000002
> [  108.744137] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [  108.752568]  r8:00000051[  108.754923]  r7:ee96868c
>  r6:edf27e80[  108.758503]  r5:00000002
>  r4:edf27e80[  108.762083] 
> [  108.763578] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [  108.771494] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [  108.779752]  r4:ee968680[  108.782106]  r3:c0240140
> [  108.784635] 
> [  108.786127] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [  108.794037]  r10:00000000[  108.796478]  r8:00022908
>  r7:00000002[  108.800059]  r6:edd31f80
>  r5:c023f658[  108.803639]  r4:ee74f180
> [  108.806171] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [  108.813474]  r8:edd31f80[  108.815828]  r7:00022908
>  r6:00000002[  108.819408]  r5:00000000
>  r4:ee74f180[  108.822988] 
> [  108.824479] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [  108.831521]  r10:00000000[  108.833962]  r8:c0107104
>  r7:00022908[  108.837542]  r6:00000002
>  r5:ee74f180[  108.841123]  r4:ee74f180
> [  108.843657] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [  108.851220]  r7:00000004[  108.853574]  r6:000217bc
>  r5:00000002[  108.857155]  r4:00022908
> [  108.859684] 
> [  108.861210] ---[ end trace 9401af63a0ace05e ]---
> [  108.867822] i2c-rcar e6540000.i2c: probed
> [  108.876079] da9063 13-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
> [  108.905011] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
> I2C Demux: i2c-13. Master: 0:/i2c@e60b0000 (0)
> [  115.013246] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
> [  115.026068] da9063 13-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
> [  115.062028] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
> 
> board: lager
> config: shmobile_defconfig
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-10. Master: 1:/i2c@e6508000 (1)
> [   48.436144] i2c-rcar e6508000.i2c: probed
> I2C Demux: i2c-10. Master: 0:/i2c@e6500000 (0)
> [   54.465184] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
> I2C Demux: i2c-11. Master: 2:/i2c-8 (2)
> [   60.504997] i2c-gpio i2c-8: using pins 979 (SDA) and 978 (SCL)
> I2C Demux: i2c-11. Master: 1:/i2c@e6518000 (1)
> [   66.535450] i2c-rcar e6518000.i2c: probed
> I2C Demux: i2c-11. Master: 0:/i2c@e6510000 (0)
> [   72.565219] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
> I2C Demux: i2c-12. Master: 2:/i2c-9 (2)
> [   78.604003] rcar-vin e6ef1000.video: Removing video34
> [   78.611313] i2c-gpio i2c-9: using pins 842 (SDA) and 841 (SCL)
> [   78.618005] adv7180 12-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [   78.634358] i2c i2c-9: sendbytes: NAK bailout.
> [   78.656005] kobject (ee695918): tried to init an initialized object, something is seriously wrong.
> [   78.664990] CPU: 2 PID: 1986 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00309-g8ef5284b21f6 #133
> [   78.673858] Hardware name: Generic R8A7790 (Flattened Device Tree)
> [   78.680033] Backtrace: 
> [   78.682500] [<c010a094>] (dump_backtrace) from [<c010a234>] (show_stack+0x18/0x1c)
> [   78.690064]  r6:c08360fc[   78.692419]  r5:00000000
>  r4:60000013[   78.696000]  r3:00404000
> [   78.698530] 
> [   78.700026] [<c010a21c>] (show_stack) from [<c02df780>] (dump_stack+0x80/0xa0)
> [   78.707248] [<c02df700>] (dump_stack) from [<c02e1668>] (kobject_init+0x3c/0x98)
> [   78.714637]  r5:c0a2c900[   78.716992]  r4:ee695918
> [   78.719521] 
> [   78.721017] [<c02e162c>] (kobject_init) from [<c03baab0>] (device_initialize+0x28/0x94)
> [   78.729014]  r5:c0a7db24[   78.731368]  r4:ee695910
> [   78.733897] 
> [   78.735390] [<c03baa88>] (device_initialize) from [<c03bc4e0>] (device_register+0x14/0x20)
> [   78.743648]  r5:00000022[   78.746002]  r4:ee695910
> [   78.748531] 
> [   78.750026] [<c03bc4cc>] (device_register) from [<c04a02c4>] (__video_register_device+0xf4c/0x123c)
> [   78.759065]  r4:ee695820[   78.761419]  r3:00000022
> [   78.763948] 
> [   78.765441] [<c049f378>] (__video_register_device) from [<c04cd124>] (rvin_v4l2_probe+0x204/0x268)
> [   78.774393]  r10:c0a3330c[   78.776834]  r9:00000000
>  r8:c0a34338[   78.780414]  r7:c077d784
>  r6:ee695b88[   78.783995]  r5:ee760654
> [   78.786524]  r4:ee695810[   78.788878] 
> [   78.790370] [<c04ccf20>] (rvin_v4l2_probe) from [<c04cac5c>] (rvin_digital_notify_complete+0xe8/0x11c)
> [   78.799669]  r7:00002006[   78.802023]  r6:ee695810
>  r5:00000000[   78.805604]  r4:ee695bcc
> [   78.808133] 
> [   78.809625] [<c04cab74>] (rvin_digital_notify_complete) from [<c04af7d8>] (v4l2_async_test_notify+0xe0/0xec)
> [   78.819445]  r7:c04cab74[   78.821799]  r6:ee695bfc
>  r5:ee760654[   78.825380]  r4:ee695bcc
> [   78.827908] 
> [   78.829398] [<c04af6f8>] (v4l2_async_test_notify) from [<c04afb34>] (v4l2_async_register_subdev+0x6c/0xc4)
> [   78.839045]  r7:ee760700[   78.841399]  r6:ee695bcc
>  r5:ee760654[   78.844980]  r4:c0a34320
> [   78.847508] 
> [   78.849000] [<c04afac8>] (v4l2_async_register_subdev) from [<c049ba04>] (adv7180_probe+0x31c/0x3cc)
> [   78.858039]  r8:00000001[   78.860393]  r7:ee760654
>  r6:00000000[   78.863973]  r5:ee760200
>  r4:ee760610[   78.867554]  r3:00000000
> [   78.870090] [<c049b6e8>] (adv7180_probe) from [<c0491854>] (i2c_device_probe+0x1a0/0x1f4)
> [   78.878261]  r9:ee7a6000[   78.880615]  r8:c049b6e8
>  r7:ee760200[   78.884195]  r6:ee760204
>  r5:c077508c[   78.887776]  r4:ee760220
> [   78.890311] [<c04916b4>] (i2c_device_probe) from [<c03be600>] (driver_probe_device+0x134/0x2b0)
> [   78.899003]  r8:ee9c0460[   78.901357]  r7:00000014
>  r6:c0a337d4[   78.904937]  r5:00000000
>  r4:ee760220[   78.908517]  r3:c04916b4
> [   78.911050] [<c03be4cc>] (driver_probe_device) from [<c03bea0c>] (__device_attach_driver+0xa4/0xb0)
> [   78.920089]  r7:00000000[   78.922443]  r6:ee7a7ca8
>  r5:c0a337d4[   78.926023]  r4:ee760220
> [   78.928552] 
> [   78.930044] [<c03be968>] (__device_attach_driver) from [<c03bd0ec>] (bus_for_each_drv+0x58/0x94)
> [   78.938822]  r6:c03be968[   78.941176]  r5:ee7a7c80
>  r4:ee7a7ca8[   78.944757]  r3:ef1cc470
> [   78.947286] 
> [   78.948777] [<c03bd094>] (bus_for_each_drv) from [<c03be384>] (__device_attach+0x8c/0x104)
> [   78.957035]  r7:00000000[   78.959389]  r6:00000001
>  r5:ee760254[   78.962969]  r4:ee760220
> [   78.965498] 
> [   78.966988] [<c03be2f8>] (__device_attach) from [<c03bea44>] (device_initial_probe+0x14/0x18)
> [   78.975506]  r7:00000000[   78.977860]  r6:ee760220
>  r5:c0a33358[   78.981440]  r4:ee760220
> [   78.983969] 
> [   78.985461] [<c03bea30>] (device_initial_probe) from [<c03bd2a0>] (bus_probe_device+0x30/0x88)
> [   78.994071] [<c03bd270>] (bus_probe_device) from [<c03bc1dc>] (device_add+0x38c/0x514)
> [   79.001981]  r6:00000000[   79.004335]  r5:ee760228
>  r4:ee760220[   79.007915]  r3:00000000
> [   79.010444] 
> [   79.011936] [<c03bbe50>] (device_add) from [<c03bc4e8>] (device_register+0x1c/0x20)
> [   79.019586]  r10:ffffffed[   79.022027]  r8:ef7f4204
>  r7:ee760204[   79.025607]  r6:ee760220
>  r5:ee9c0420[   79.029187]  r4:ee760220
> [   79.031723] [<c03bc4cc>] (device_register) from [<c0491e84>] (i2c_new_device+0x114/0x184)
> [   79.039894]  r4:ee760200[   79.042248]  r3:00000020
> [   79.044776] 
> [   79.046268] [<c0491d70>] (i2c_new_device) from [<c04921dc>] (of_i2c_register_device+0x160/0x184)
> [   79.055047]  r7:ef7f4550[   79.057401]  r6:ee9c0460
>  r5:ee9c0420[   79.060981]  r4:ef7f4550
> [   79.063510] 
> [   79.065001] [<c049207c>] (of_i2c_register_device) from [<c0492454>] (i2c_register_adapter+0x254/0x398)
> [   79.074301]  r5:ee9c0420[   79.076655]  r4:00000000
> [   79.079184] 
> [   79.080676] [<c0492200>] (i2c_register_adapter) from [<c0492608>] (__i2c_add_numbered_adapter+0x70/0x94)
> [   79.090149]  r8:ee9c067c[   79.092503]  r7:00000000
>  r6:00000002[   79.096083]  r5:0000000c
>  r4:ee9c0420[   79.099663]  r3:00000001
> [   79.102198] [<c0492598>] (__i2c_add_numbered_adapter) from [<c0492c58>] (i2c_add_adapter+0x3c/0xc8)
> [   79.111237]  r5:ee697c10[   79.113591]  r4:ee9c0420
> [   79.116120] 
> [   79.117612] [<c0492c1c>] (i2c_add_adapter) from [<c0499f84>] (i2c_demux_activate_master+0x104/0x15c)
> [   79.126737]  r5:ee697c10[   79.129092]  r4:ee9c0410
> [   79.131621] 
> [   79.133112] [<c0499e80>] (i2c_demux_activate_master) from [<c049a178>] (current_master_store+0xa0/0xb4)
> [   79.142499]  r10:ee7a7f80[   79.144939]  r8:ee9c0650
>  r7:00000002[   79.148520]  r6:00000000
>  r5:00000002[   79.152100]  r4:ee9c0410
> [   79.154634] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   79.163065]  r8:00000051[   79.165419]  r7:ee57398c
>  r6:eddd8c00[   79.169000]  r5:00000002
>  r4:eddd8c00[   79.172580] 
> [   79.174076] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   79.181990] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   79.190248]  r4:ee573980[   79.192602]  r3:c0240140
> [   79.195131] 
> [   79.196623] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   79.204533]  r10:00000000[   79.206974]  r8:00022908
>  r7:00000002[   79.210555]  r6:ee7a7f80
>  r5:c023f658[   79.214135]  r4:ef157cc0
> [   79.216668] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   79.223971]  r8:ee7a7f80[   79.226325]  r7:00022908
>  r6:00000002[   79.229905]  r5:00000000
>  r4:ef157cc0[   79.233485] 
> [   79.234975] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   79.242018]  r10:00000000[   79.244458]  r8:c0107104
>  r7:00022908[   79.248039]  r6:00000002
>  r5:ef157cc0[   79.251619]  r4:ef157cc0
> [   79.254153] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   79.261717]  r7:00000004[   79.264071]  r6:000217bc
>  r5:00000002[   79.267651]  r4:00022908
> [   79.270180] 
> [   79.271861] rcar-vin e6ef1000.video: Device registered as video34
> I2C Demux: i2c-12. Master: 1:/i2c@e6530000 (1)
> [   85.313987] rcar-vin e6ef1000.video: Removing video34
> [   85.319073] Unable to handle kernel NULL pointer dereference at virtual address 00000010
> [   85.327187] pgd = edc9c000
> [   85.329940] [00000010] *pgd=7fd3a835
> [   85.333542] Internal error: Oops: 17 [#1] SMP ARM
> [   85.338248] CPU: 0 PID: 1986 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00309-g8ef5284b21f6 #133
> [   85.347115] Hardware name: Generic R8A7790 (Flattened Device Tree)
> [   85.353291] task: ef132540 task.stack: ee7a6000
> [   85.357827] PC is at klist_put+0x20/0x94
> [   85.361747] LR is at klist_del+0x14/0x18
> [   85.365667] pc : [<c064c118>]    lr : [<c064c350>]    psr: a0000013
> [   85.365667] sp : ee7a7c30  ip : ee7a7c50  fp : ee7a7c4c
> [   85.377139] r10: ee7a7f80  r9 : ee7a6000  r8 : 00000100
> [   85.382360] r7 : 00000001  r6 : 00000000  r5 : ee695bcc  r4 : ee67a314
> [   85.388882] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
> [   85.395406] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   85.402537] Control: 10c5387d  Table: 6dc9c06a  DAC: 00000051
> [   85.408278] Process exercise-i2c-de (pid: 1986, stack limit = 0xee7a6210)
> [   85.415062] Stack: (0xee7a7c30 to 0xee7a8000)
> [   85.419416] 7c20:                                     ee695910 ee695bcc ef2c7a10 00000000
> [   85.427590] 7c40: ee7a7c5c ee7a7c50 c064c350 c064c104 ee7a7c8c ee7a7c60 c03bae48 c064c348
> [   85.435765] 7c60: 00000200 00000100 ee7a6000 ee7a7f80 ee695910 ee695bcc ee760200 00000000
> [   85.443939] 7c80: ee7a7ca4 ee7a7c90 c03baff0 c03bae00 00000001 ee695820 ee7a7cbc ee7a7ca8
> [   85.452113] 7ca0: c04a05f8 c03bafe8 c094f360 ee695810 ee7a7cd4 ee7a7cc0 c04ccf18 c04a05c0
> [   85.460287] 7cc0: ee760654 ee695bcc ee7a7cec ee7a7cd8 c04cab00 c04cceec c04caad8 ee760654
> [   85.468461] 7ce0: ee7a7d04 ee7a7cf0 c04afc0c c04caae4 ee760654 ee760610 ee7a7d24 ee7a7d08
> [   85.476636] 7d00: c049aa14 c04afb98 c049a9f4 ee760220 c0a337d4 c0a33358 ee7a7d3c ee7a7d28
> [   85.484810] 7d20: c0491684 c049aa00 ee760220 c0a337d4 ee7a7d54 ee7a7d40 c03be8f4 c049163c
> [   85.492984] 7d40: ee760254 ee760220 ee7a7d6c ee7a7d58 c03bea94 c03be864 ee760220 ef1cc430
> [   85.501157] 7d60: ee7a7d8c ee7a7d70 c03bd3d8 c03bea7c 0000000a ee760220 ee7a7e08 ee9c0460
> [   85.509331] 7d80: ee7a7dbc ee7a7d90 c03baf44 c03bd304 eddef694 c03baddc ee7a7dc4 ee7a7da8
> [   85.517505] 7da0: ee760220 ee7a7e08 c04928a4 00000000 ee7a7dd4 ee7a7dc0 c03baff0 c03bae00
> [   85.525679] 7dc0: 00000008 ee760200 ee7a7dec ee7a7dd8 c049265c c03bafe8 00000061 ee760200
> [   85.533854] 7de0: ee7a7e04 ee7a7df0 c04928e4 c0492638 c0861000 00000000 ee7a7e2c ee7a7e08
> [   85.542027] 7e00: c03bb2ec c04928b0 ef12f200 eddefd94 ee9c0420 ee9c0460 c0a7f848 ee9c0420
> [   85.550201] 7e20: ee7a7e54 ee7a7e30 c0492e18 c03bb2b4 00000003 ee9c0410 00000002 00000002
> [   85.558375] 7e40: 00000001 00000026 ee7a7e84 ee7a7e58 c049a13c c0492d18 00000000 00000001
> [   85.566549] 7e60: ee7a7e5c ee55f640 00000002 ee55f640 eea8578c 00000051 ee7a7e94 ee7a7e88
> [   85.574723] 7e80: c03ba1ac c049a0e4 ee7a7eac ee7a7e98 c0240184 c03ba198 c0240140 eea85780
> [   85.582897] 7ea0: ee7a7edc ee7a7eb0 c023f7a8 c024014c 00000000 00000000 ee70be40 c023f658
> [   85.591071] 7ec0: ee7a7f80 00000002 00022908 00000000 ee7a7f4c ee7a7ee0 c01e2124 c023f664
> [   85.599244] 7ee0: 00000000 ee308000 ee308000 edce6800 0000000a 0000000b ede27180 0000000a
> [   85.607418] 7f00: ee7a7f3c ee7a7f10 c01fe1b8 ef39e000 0000000b ef39e000 0000000a 00000001
> [   85.615592] 7f20: ee7a7f3c ee7a7f30 ee70be40 ee70be40 00000000 00000002 00022908 ee7a7f80
> [   85.623766] 7f40: ee7a7f7c ee7a7f50 c01e238c c01e20fc c01fe64c c01fdc5c ee70be40 ee70be40
> [   85.631940] 7f60: 00000002 00022908 c0107104 00000000 ee7a7fa4 ee7a7f80 c01e24e4 c01e22d4
> [   85.640114] 7f80: 00000000 00000000 00022908 00000002 000217bc 00000004 00000000 ee7a7fa8
> [   85.648288] 7fa0: c0106f40 c01e24a8 00022908 00000002 00000001 00022908 00000002 0002290a
> [   85.656462] 7fc0: 00022908 00000002 000217bc 00000004 00000002 00000000 00022728 000219cc
> [   85.664636] 7fe0: 00000001 bef2a770 00012db1 b6eabb9c 60000010 00000001 04080020 00800000
> [   85.672806] Backtrace: 
> [   85.675262] [<c064c0f8>] (klist_put) from [<c064c350>] (klist_del+0x14/0x18)
> [   85.682305]  r7:00000000[   85.684660]  r6:ef2c7a10
>  r5:ee695bcc[   85.688242]  r4:ee695910
> [   85.690771] 
> [   85.692266] [<c064c33c>] (klist_del) from [<c03bae48>] (device_del+0x54/0x1e8)
> [   85.699488] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   85.707312]  r7:00000000[   85.709666]  r6:ee760200
>  r5:ee695bcc[   85.713247]  r4:ee695910
> [   85.715777] 
> [   85.717270] [<c03bafdc>] (device_unregister) from [<c04a05f8>] (video_unregister_device+0x44/0x4c)
> [   85.726222]  r4:ee695820[   85.728576]  r3:00000001
> [   85.731106] 
> [   85.732599] [<c04a05b4>] (video_unregister_device) from [<c04ccf18>] (rvin_v4l2_remove+0x38/0x40)
> [   85.741464]  r4:ee695810[   85.743818]  r3:c094f360
> [   85.746347] 
> [   85.747838] [<c04ccee0>] (rvin_v4l2_remove) from [<c04cab00>] (rvin_digital_notify_unbind+0x28/0x4c)
> [   85.756964]  r4:ee695bcc[   85.759318]  r3:ee760654
> [   85.761847] 
> [   85.763339] [<c04caad8>] (rvin_digital_notify_unbind) from [<c04afc0c>] (v4l2_async_unregister_subdev+0x80/0x90)
> [   85.773507]  r4:ee760654[   85.775861]  r3:c04caad8
> [   85.778390] 
> [   85.779883] [<c04afb8c>] (v4l2_async_unregister_subdev) from [<c049aa14>] (adv7180_remove+0x20/0x8c)
> [   85.789008]  r5:ee760610[   85.791363]  r4:ee760654
> [   85.793892] 
> [   85.795385] [<c049a9f4>] (adv7180_remove) from [<c0491684>] (i2c_device_remove+0x54/0x84)
> [   85.803555]  r6:c0a33358[   85.805909]  r5:c0a337d4
>  r4:ee760220[   85.809490]  r3:c049a9f4
> [   85.812018] 
> [   85.813511] [<c0491630>] (i2c_device_remove) from [<c03be8f4>] (__device_release_driver+0x9c/0x110)
> [   85.822550]  r5:c0a337d4[   85.824904]  r4:ee760220
> [   85.827433] 
> [   85.828923] [<c03be858>] (__device_release_driver) from [<c03bea94>] (device_release_driver+0x24/0x30)
> [   85.838222]  r5:ee760220[   85.840576]  r4:ee760254
> [   85.843105] 
> [   85.844597] [<c03bea70>] (device_release_driver) from [<c03bd3d8>] (bus_remove_device+0xe0/0xf0)
> [   85.853375]  r5:ef1cc430[   85.855730]  r4:ee760220
> [   85.858259] 
> [   85.859751] [<c03bd2f8>] (bus_remove_device) from [<c03baf44>] (device_del+0x150/0x1e8)
> [   85.867748]  r6:ee9c0460[   85.870102]  r5:ee7a7e08
>  r4:ee760220[   85.873683]  r3:0000000a
> [   85.876212] 
> [   85.877703] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   85.885527]  r7:00000000[   85.887881]  r6:c04928a4
>  r5:ee7a7e08[   85.891462]  r4:ee760220
> [   85.893991] 
> [   85.895484] [<c03bafdc>] (device_unregister) from [<c049265c>] (i2c_unregister_device+0x30/0x34)
> [   85.904263]  r4:ee760200[   85.906617]  r3:00000008
> [   85.909145] 
> [   85.910638] [<c049262c>] (i2c_unregister_device) from [<c04928e4>] (__unregister_client+0x40/0x50)
> [   85.919590]  r4:ee760200[   85.921944]  r3:00000061
> [   85.924473] 
> [   85.925964] [<c04928a4>] (__unregister_client) from [<c03bb2ec>] (device_for_each_child+0x44/0x80)
> [   85.934917]  r4:00000000[   85.937270]  r3:c0861000
> [   85.939799] 
> [   85.941291] [<c03bb2a8>] (device_for_each_child) from [<c0492e18>] (i2c_del_adapter+0x10c/0x1ac)
> [   85.950070]  r7:ee9c0420[   85.952424]  r6:c0a7f848
>  r5:ee9c0460[   85.956005]  r4:ee9c0420
> [   85.958534] 
> [   85.960026] [<c0492d0c>] (i2c_del_adapter) from [<c049a13c>] (current_master_store+0x64/0xb4)
> [   85.968544]  r8:00000026[   85.970898]  r7:00000001
>  r6:00000002[   85.974479]  r5:00000002
>  r4:ee9c0410[   85.978059]  r3:00000003
> [   85.980593] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   85.989025]  r8:00000051[   85.991379]  r7:eea8578c
>  r6:ee55f640[   85.994959]  r5:00000002
>  r4:ee55f640[   85.998539] 
> [   86.000034] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   86.007949] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   86.016207]  r4:eea85780[   86.018561]  r3:c0240140
> [   86.021090] 
> [   86.022582] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   86.030493]  r10:00000000[   86.032934]  r8:00022908
>  r7:00000002[   86.036515]  r6:ee7a7f80
>  r5:c023f658[   86.040095]  r4:ee70be40
> [   86.042628] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   86.049931]  r8:ee7a7f80[   86.052285]  r7:00022908
>  r6:00000002[   86.055865]  r5:00000000
>  r4:ee70be40[   86.059445] 
> [   86.060936] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   86.067979]  r10:00000000[   86.070419]  r8:c0107104
>  r7:00022908[   86.074000]  r6:00000002
>  r5:ee70be40[   86.077580]  r4:ee70be40
> [   86.080115] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   86.087679]  r7:00000004[   86.090033]  r6:000217bc
>  r5:00000002[   86.093614]  r4:00022908
> [   86.096143] 
> [   86.097633] Code: e1a04000 e1a07001 e3c66001 e1a00006 (e5965010) 
> [   86.103771] ---[ end trace f0ea74a32bf1cc0d ]---
> Segmentation fault
> 
> board: gose
> config: shmobile_defconfig; VIDEO_RCAR_VIN not set
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-11. Master: 1:/i2c-9 (1)
> [  331.304940] i2c-gpio i2c-9: using pins 941 (SDA) and 940 (SCL)
> [  331.313364] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [  331.330047] i2c i2c-9: sendbytes: NAK bailout.
> I2C Demux: i2c-11. Master: 0:/i2c@e6530000 (0)
> [  337.905799] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-2))
> [  338.952995] i2c-rcar e6530000.i2c: error -110 : 3
> [  339.992979] i2c-rcar e6530000.i2c: error -110 : 3
> [  341.032982] i2c-rcar e6530000.i2c: error -110 : 3
> [  341.037711] adv7180: probe of 11-0020 failed with error -110
> [  343.112988] i2c-rcar e6530000.i2c: error -110 : 2
> [  343.117722] adv7511: probe of 11-0039 failed with error -110
> I2C Demux: i2c-12. Master: 1:/i2c-10 (1)
> [  349.714698] i2c-gpio i2c-10: using pins 794 (SDA) and 793 (SCL)
> I2C Demux: i2c-12. Master: 0:/i2c@e6520000 (0)
> [  356.055515] i2c-rcar e6520000.i2c: probed
> 
> board: gose
> config: shmobile_defconfig
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-11. Master: 1:/i2c-9 (1)
> [  550.437217] rcar-vin e6ef1000.video: Removing video0
> [  550.443980] i2c-gpio i2c-9: using pins 941 (SDA) and 940 (SCL)
> [  550.452007] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [  550.468789] i2c i2c-9: sendbytes: NAK bailout.
> [  550.489320] kobject (df7e7918): tried to init an initialized object, something is seriously wrong.
> [  550.498375] CPU: 0 PID: 1626 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00311-gcbca9815acde #137
> [  550.507243] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [  550.513679] Backtrace: 
> [  550.516146] [<c010a094>] (dump_backtrace) from [<c010a234>] (show_stack+0x18/0x1c)
> [  550.523710]  r6:c08360fc[  550.526064]  r5:00000000
>  r4:60000013[  550.529645]  r3:00400000
> [  550.532174] 
> [  550.533669] [<c010a21c>] (show_stack) from [<c02df780>] (dump_stack+0x80/0xa0)
> [  550.540891] [<c02df700>] (dump_stack) from [<c02e1668>] (kobject_init+0x3c/0x98)
> [  550.548281]  r5:c0a2c900[  550.550635]  r4:df7e7918
> [  550.553164] 
> [  550.554659] [<c02e162c>] (kobject_init) from [<c03baab0>] (device_initialize+0x28/0x94)
> [  550.562656]  r5:c0a7db24[  550.565010]  r4:df7e7910
> [  550.567540] 
> [  550.569030] [<c03baa88>] (device_initialize) from [<c03bc4e0>] (device_register+0x14/0x20)
> [  550.577288]  r5:00000000[  550.579641]  r4:df7e7910
> [  550.582170] 
> [  550.583663] [<c03bc4cc>] (device_register) from [<c04a02c4>] (__video_register_device+0xf4c/0x123c)
> [  550.592702]  r4:df7e7820[  550.595055]  r3:00000000
> [  550.597584] 
> [  550.599075] [<c049f378>] (__video_register_device) from [<c04cd124>] (rvin_v4l2_probe+0x204/0x268)
> [  550.608027]  r10:c0a3330c[  550.610468]  r9:00000000
>  r8:c0a34338[  550.614048]  r7:c077d784
>  r6:df7e7b88[  550.617629]  r5:debbd654
> [  550.620157]  r4:df7e7810[  550.622510] 
> [  550.624002] [<c04ccf20>] (rvin_v4l2_probe) from [<c04cac5c>] (rvin_digital_notify_complete+0xe8/0x11c)
> [  550.633301]  r7:00002006[  550.635654]  r6:df7e7810
>  r5:00000000[  550.639235]  r4:df7e7bcc
> [  550.641763] 
> [  550.643254] [<c04cab74>] (rvin_digital_notify_complete) from [<c04af7d8>] (v4l2_async_test_notify+0xe0/0xec)
> [  550.653074]  r7:c04cab74[  550.655427]  r6:df7e7bfc
>  r5:debbd654[  550.659007]  r4:df7e7bcc
> [  550.661536] 
> [  550.663026] [<c04af6f8>] (v4l2_async_test_notify) from [<c04afb34>] (v4l2_async_register_subdev+0x6c/0xc4)
> [  550.672672]  r7:debbd700[  550.675026]  r6:df7e7bcc
>  r5:debbd654[  550.678606]  r4:c0a34320
> [  550.681134] 
> [  550.682626] [<c04afac8>] (v4l2_async_register_subdev) from [<c049ba04>] (adv7180_probe+0x31c/0x3cc)
> [  550.691665]  r8:00000001[  550.694018]  r7:debbd654
>  r6:00000000[  550.697598]  r5:debbd200
>  r4:debbd610[  550.701178]  r3:00000000
> [  550.703714] [<c049b6e8>] (adv7180_probe) from [<c0491854>] (i2c_device_probe+0x1a0/0x1f4)
> [  550.711884]  r9:ded30000[  550.714238]  r8:c049b6e8
>  r7:debbd200[  550.717818]  r6:debbd204
>  r5:c077508c[  550.721397]  r4:debbd220
> [  550.723932] [<c04916b4>] (i2c_device_probe) from [<c03be600>] (driver_probe_device+0x134/0x2b0)
> [  550.732623]  r8:dec5a860[  550.734977]  r7:00000012
>  r6:c0a337d4[  550.738557]  r5:00000000
>  r4:debbd220[  550.742137]  r3:c04916b4
> [  550.744670] [<c03be4cc>] (driver_probe_device) from [<c03bea0c>] (__device_attach_driver+0xa4/0xb0)
> [  550.753708]  r7:00000000[  550.756062]  r6:ded31ca8
>  r5:c0a337d4[  550.759642]  r4:debbd220
> [  550.762170] 
> [  550.763661] [<c03be968>] (__device_attach_driver) from [<c03bd0ec>] (bus_for_each_drv+0x58/0x94)
> [  550.772439]  r6:c03be968[  550.774793]  r5:ded31c80
>  r4:ded31ca8[  550.778372]  r3:df535d70
> [  550.780901] 
> [  550.782391] [<c03bd094>] (bus_for_each_drv) from [<c03be384>] (__device_attach+0x8c/0x104)
> [  550.790649]  r7:00000000[  550.793002]  r6:00000001
>  r5:debbd254[  550.796582]  r4:debbd220
> [  550.799110] 
> [  550.800599] [<c03be2f8>] (__device_attach) from [<c03bea44>] (device_initial_probe+0x14/0x18)
> [  550.809117]  r7:00000000[  550.811471]  r6:debbd220
>  r5:c0a33358[  550.815051]  r4:debbd220
> [  550.817579] 
> [  550.819069] [<c03bea30>] (device_initial_probe) from [<c03bd2a0>] (bus_probe_device+0x30/0x88)
> [  550.827679] [<c03bd270>] (bus_probe_device) from [<c03bc1dc>] (device_add+0x38c/0x514)
> [  550.835589]  r6:00000000[  550.837943]  r5:debbd228
>  r4:debbd220[  550.841523]  r3:00000000
> [  550.844051] 
> [  550.845542] [<c03bbe50>] (device_add) from [<c03bc4e8>] (device_register+0x1c/0x20)
> [  550.853192]  r10:ffffffed[  550.855632]  r8:dfbf6240
>  r7:debbd204[  550.859212]  r6:debbd220
>  r5:dec5a820[  550.862792]  r4:debbd220
> [  550.865326] [<c03bc4cc>] (device_register) from [<c0491e84>] (i2c_new_device+0x114/0x184)
> [  550.873497]  r4:debbd200[  550.875852]  r3:00000020
> [  550.878380] 
> [  550.879872] [<c0491d70>] (i2c_new_device) from [<c04921dc>] (of_i2c_register_device+0x160/0x184)
> [  550.888650]  r7:dfbf658c[  550.891003]  r6:dec5a860
>  r5:dec5a820[  550.894583]  r4:dfbf658c
> [  550.897112] 
> [  550.898603] [<c049207c>] (of_i2c_register_device) from [<c0492454>] (i2c_register_adapter+0x254/0x398)
> [  550.907902]  r5:dec5a820[  550.910256]  r4:00000000
> [  550.912784] 
> [  550.914276] [<c0492200>] (i2c_register_adapter) from [<c0492608>] (__i2c_add_numbered_adapter+0x70/0x94)
> [  550.923748]  r8:dec5aa6c[  550.926102]  r7:00000000
>  r6:00000001[  550.929682]  r5:0000000b
>  r4:dec5a820[  550.933262]  r3:00000001
> [  550.935797] [<c0492598>] (__i2c_add_numbered_adapter) from [<c0492c58>] (i2c_add_adapter+0x3c/0xc8)
> [  550.944836]  r5:df7e8c10[  550.947190]  r4:dec5a820
> [  550.949719] 
> [  550.951210] [<c0492c1c>] (i2c_add_adapter) from [<c0499f84>] (i2c_demux_activate_master+0x104/0x15c)
> [  550.960336]  r5:df7e8c10[  550.962689]  r4:dec5a810
> [  550.965218] 
> [  550.966708] [<c0499e80>] (i2c_demux_activate_master) from [<c049a178>] (current_master_store+0xa0/0xb4)
> [  550.976094]  r10:ded31f80[  550.978535]  r8:dec5aa50
>  r7:00000001[  550.982115]  r6:00000000
>  r5:00000002[  550.985694]  r4:dec5a810
> [  550.988228] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [  550.996659]  r8:00000051[  550.999013]  r7:dee9b28c
>  r6:df534480[  551.002593]  r5:00000002
>  r4:df534480[  551.006172] 
> [  551.007667] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [  551.015581] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [  551.023839]  r4:dee9b280[  551.026193]  r3:c0240140
> [  551.028721] 
> [  551.030213] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [  551.038123]  r10:00000000[  551.040564]  r8:00022900
>  r7:00000002[  551.044143]  r6:ded31f80
>  r5:c023f658[  551.047723]  r4:ded5ff00
> [  551.050255] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [  551.057558]  r8:ded31f80[  551.059911]  r7:00022900
>  r6:00000002[  551.063491]  r5:00000000
>  r4:ded5ff00[  551.067071] 
> [  551.068561] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [  551.075603]  r10:00000000[  551.078043]  r8:c0107104
>  r7:00022900[  551.081623]  r6:00000002
>  r5:ded5ff00[  551.085203]  r4:ded5ff00
> [  551.087737] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [  551.095300]  r7:00000004[  551.097653]  r6:000217bc
>  r5:00000002[  551.101234]  r4:00022900
> [  551.103762] 
> [  551.105893] rcar-vin e6ef1000.video: Device registered as video0
> [  551.666091] Unable to handle kernel NULL pointer dereference at virtual address 00000001
> [  551.674187] pgd = c0004000
> [  551.676891] [00000001] *pgd=00000000
> [  551.680475] Internal error: Oops: 5 [#1] SMP ARM
> [  551.685093] CPU: 1 PID: 1641 Comm: modprobe Not tainted 4.9.0-rc2-00311-gcbca9815acde #137
> [  551.693352] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [  551.699787] task: df798000 task.stack: dee86000
> [  551.704330] PC is at __wake_up_common+0x28/0x80
> [  551.708857] LR is at __wake_up_locked+0x1c/0x24
> [  551.713384] pc : [<c015374c>]    lr : [<c0153a1c>]    psr: 40000093
> [  551.713384] sp : dee87da8  ip : dee87dd8  fp : dee87dd4
> [  551.724855] r10: 00000000  r9 : 00000000  r8 : 00000003
> [  551.730075] r7 : 00000001  r6 : df7e5800  r5 : df7e5880  r4 : df7e5820
> [  551.736597] r3 : 00000001  r2 : 00000001  r1 : 00000003  r0 : fffffff5
> [  551.743120] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  551.750337] Control: 10c5387d  Table: 5e42806a  DAC: 00000051
> [  551.756078] Process modprobe (pid: 1641, stack limit = 0xdee86210)
> [  551.762253] Stack: (0xdee87da8 to 0xdee88000)
> [  551.766607] 7da0:                   00000000 00000000 df7e5880 df7e5800 40000093 00000000
> [  551.774781] 7dc0: 00000000 00000000 dee87dec dee87dd8 c0153a1c c0153730 00000000 c0140ba0
> [  551.782955] 7de0: dee87e14 dee87df0 c021f268 c0153a0c dec0bf8c 00000000 dec0bf80 00000001
> [  551.791128] 7e00: 00000003 00000000 dee87e44 dee87e18 c0153770 c021f138 00000000 dec0bf88
> [  551.799302] 7e20: 20000093 00000001 00000003 00000000 dee86000 00000001 dee87e74 dee87e48
> [  551.807476] 7e40: c01539ec c0153730 00000000 dee87e58 c01296bc dee87eb0 00000011 df798540
> [  551.815649] 7e60: df4a26e4 de4d87e0 dee87e9c dee87e78 c012a7fc c01539b8 df798000 00000011
> [  551.823822] 7e80: 00000000 dec0bf84 60000093 dec0ba80 dee87eac dee87ea0 c012a864 c012a634
> [  551.831996] 7ea0: dee87f54 dee87eb0 c012bb40 c012a85c 00000011 00000000 00040001 00000669
> [  551.840169] 7ec0: 00000000 00000001 00000000 00000000 dee87efc dee87ee0 c018ff8c c018fe60
> [  551.848343] 7ee0: c01e39b0 df79844c df798464 00000000 dee87f54 dee87f00 c019af1c c018ed80
> [  551.856517] 7f00: c013a890 c0102448 ffffffff df798000 dee87f58 00000000 dedb88f8 c0107104
> [  551.864690] 7f20: dee87f44 dee87f30 c013a990 df798000 df798000 c0a0a1b4 df432a80 dedb88f8
> [  551.872864] 7f40: df7982a0 00000001 dee87f74 dee87f58 c0121fdc c012b9ac dee87f58 dee87f58
> [  551.881037] 7f60: c01e0000 000000f8 dee87f94 dee87f78 c012226c c01218a8 00000001 0006f42e
> [  551.889211] 7f80: b6ec0774 b6ec0774 dee87fa4 dee87f98 c01222bc c01221d4 00000000 dee87fa8
> [  551.897384] 7fa0: c0106f40 c01222b0 0006f42e b6ec0774 00000001 0006f41a b6de04c0 00000001
> [  551.905558] 7fc0: 0006f42e b6ec0774 b6ec0774 000000f8 00000000 00000000 7f612000 00000000
> [  551.913731] 7fe0: 000000f8 be82cc7c b6e52c73 b6df7f96 60000030 00000001 00000000 00000000
> [  551.921901] Backtrace: 
> [  551.924357] [<c0153724>] (__wake_up_common) from [<c0153a1c>] (__wake_up_locked+0x1c/0x24)
> [  551.932614]  r10:00000000[  551.935056]  r9:00000000
>  r8:00000000[  551.938637]  r7:40000093
>  r6:df7e5800[  551.942217]  r5:df7e5880
> [  551.944746]  r4:00000000[  551.947100]  r3:00000000
> [  551.949629] 
> [  551.951123] [<c0153a00>] (__wake_up_locked) from [<c021f268>] (ep_poll_callback+0x13c/0x188)
> [  551.959558] [<c021f12c>] (ep_poll_callback) from [<c0153770>] (__wake_up_common+0x4c/0x80)
> [  551.967816]  r10:00000000[  551.970257]  r8:00000003
>  r7:00000001[  551.973837]  r6:dec0bf80
>  r5:00000000[  551.977417]  r4:dec0bf8c
> [  551.979951] [<c0153724>] (__wake_up_common) from [<c01539ec>] (__wake_up+0x40/0x54)
> [  551.987601]  r10:00000001[  551.990041]  r9:dee86000
>  r8:00000000[  551.993621]  r7:00000003
>  r6:00000001[  551.997201]  r5:20000093
> [  551.999731]  r4:dec0bf88[  552.002084]  r3:00000000
> [  552.004613] 
> [  552.006107] [<c01539ac>] (__wake_up) from [<c012a7fc>] (__send_signal.constprop.11+0x1d4/0x228)
> [  552.014798]  r8:de4d87e0[  552.017152]  r7:df4a26e4
>  r6:df798540[  552.020733]  r5:00000011
>  r4:dee87eb0[  552.024312] 
> [  552.025803] [<c012a628>] (__send_signal.constprop.11) from [<c012a864>] (__group_send_sig_info+0x14/0x18)
> [  552.035363]  r10:dec0ba80[  552.037803]  r8:60000093
>  r7:dec0bf84[  552.041383]  r6:00000000
>  r5:00000011[  552.044963]  r4:df798000
> [  552.047498] [<c012a850>] (__group_send_sig_info) from [<c012bb40>] (do_notify_parent+0x1a0/0x1d4)
> [  552.056369] [<c012b9a0>] (do_notify_parent) from [<c0121fdc>] (do_exit+0x740/0x8f0)
> [  552.064019]  r10:00000001[  552.066459]  r8:df7982a0
>  r7:dedb88f8[  552.070039]  r6:df432a80
>  r5:c0a0a1b4[  552.073619]  r4:df798000
> [  552.076152] [<c012189c>] (do_exit) from [<c012226c>] (do_group_exit+0xa4/0xdc)
> [  552.083368]  r7:000000f8[  552.085721] 
> [  552.087213] [<c01221c8>] (do_group_exit) from [<c01222bc>] (__wake_up_parent+0x0/0x28)
> [  552.095123]  r6:b6ec0774[  552.097477]  r5:b6ec0774
>  r4:0006f42e[  552.101057]  r3:00000001
> [  552.103585] 
> [  552.105078] [<c01222a4>] (SyS_exit_group) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [  552.113079] Code: e1a08001 e1a07002 e59b9004 e243000c (e5936000) 
> [  552.119171] ---[ end trace cfb3b2a0c087658f ]---
> [  552.123783] Fixing recursive fault but reboot is needed!
> 
> board: gose
> config: shmobile_defconfig; VIDEO_RCAR_VIN not set
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-11. Master: 1:/i2c-9 (1)
> [   49.817290] i2c-gpio i2c-9: using pins 871 (SDA) and 870 (SCL)
> [   49.825956] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [   49.839765] i2c i2c-9: sendbytes: NAK bailout.
> I2C Demux: i2c-11. Master: 0:/i2c@e6518000 (0)
> [   55.906915] i2c-rcar e6518000.i2c: probed
> [   55.915331] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-1))
> I2C Demux: i2c-14. Master: 1:/i2c-10 (1)
> [   62.006474] i2c-gpio i2c-10: using pins 879 (SDA) and 878 (SCL)
> I2C Demux: i2c-14. Master: 0:/i2c@e6520000 (0)
> [   68.057683] i2c-rcar e6520000.i2c: probed
> 
> board: alt
> config: shmobile_defconfig
> # ./exercise-i2c-demux.sh 
> I2C Demux: i2c-11. Master: 1:/i2c-9 (1)
> [   61.260098] rcar-vin e6ef0000.video: Removing video17
> [   61.280808] i2c-gpio i2c-9: using pins 871 (SDA) and 870 (SCL)
> [   61.288914] adv7180 11-0020: chip found @ 0x20 (i2c-demux (master i2c-9))
> [   61.302768] i2c i2c-9: sendbytes: NAK bailout.
> [   61.333307] kobject (eeac0918): tried to init an initialized object, something is seriously wrong.
> [   61.342369] CPU: 0 PID: 1534 Comm: exercise-i2c-de Not tainted 4.9.0-rc2-00312-g11ee7f001b13 #148
> [   61.351239] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [   61.357678] Backtrace: 
> [   61.360155] [<c010a094>] (dump_backtrace) from [<c010a234>] (show_stack+0x18/0x1c)
> [   61.367721]  r6:c08360fc[   61.370076]  r5:00000000
>  r4:60000013[   61.373660]  r3:00400000
> [   61.376191] 
> [   61.377690] [<c010a21c>] (show_stack) from [<c02df780>] (dump_stack+0x80/0xa0)
> [   61.384917] [<c02df700>] (dump_stack) from [<c02e1668>] (kobject_init+0x3c/0x98)
> [   61.392309]  r5:c0a2c900[   61.394665]  r4:eeac0918
> [   61.397195] 
> [   61.398696] [<c02e162c>] (kobject_init) from [<c03baab0>] (device_initialize+0x28/0x94)
> [   61.406695]  r5:c0a7db24[   61.409051]  r4:eeac0910
> [   61.411581] 
> [   61.413078] [<c03baa88>] (device_initialize) from [<c03bc4e0>] (device_register+0x14/0x20)
> [   61.421337]  r5:00000011[   61.423693]  r4:eeac0910
> [   61.426223] 
> [   61.427723] [<c03bc4cc>] (device_register) from [<c04a02c4>] (__video_register_device+0xf4c/0x123c)
> [   61.436764]  r4:eeac0820[   61.439120]  r3:00000011
> [   61.441650] 
> [   61.443147] [<c049f378>] (__video_register_device) from [<c04cd124>] (rvin_v4l2_probe+0x204/0x268)
> [   61.452102]  r10:c0a3330c[   61.454544]  r9:00000000
>  r8:c0a34338[   61.458129]  r7:c077d784
>  r6:eeac0b88[   61.461712]  r5:eeae8654
> [   61.464244]  r4:eeac0810[   61.466598] 
> [   61.468095] [<c04ccf20>] (rvin_v4l2_probe) from [<c04cac5c>] (rvin_digital_notify_complete+0xe8/0x11c)
> [   61.477396]  r7:00002006[   61.479752]  r6:eeac0810
>  r5:00000000[   61.483335]  r4:eeac0bcc
> [   61.485866] 
> [   61.487363] [<c04cab74>] (rvin_digital_notify_complete) from [<c04af7d8>] (v4l2_async_test_notify+0xe0/0xec)
> [   61.497185]  r7:c04cab74[   61.499541]  r6:eeac0bfc
>  r5:eeae8654[   61.503124]  r4:eeac0bcc
> [   61.505655] 
> [   61.507150] [<c04af6f8>] (v4l2_async_test_notify) from [<c04afb34>] (v4l2_async_register_subdev+0x6c/0xc4)
> [   61.516799]  r7:eeae8700[   61.519154]  r6:eeac0bcc
>  r5:eeae8654[   61.522738]  r4:c0a34320
> [   61.525268] 
> [   61.526767] [<c04afac8>] (v4l2_async_register_subdev) from [<c049ba04>] (adv7180_probe+0x31c/0x3cc)
> [   61.535808]  r8:00000001[   61.538164]  r7:eeae8654
>  r6:00000000[   61.541747]  r5:ef33c600
>  r4:eeae8610[   61.545331]  r3:00000000
> [   61.547873] [<c049b6e8>] (adv7180_probe) from [<c0491854>] (i2c_device_probe+0x1a0/0x1f4)
> [   61.556046]  r9:ef1f0000[   61.558402]  r8:c049b6e8
>  r7:ef33c600[   61.561986]  r6:ef33c604
>  r5:c077508c[   61.565570]  r4:ef33c620
> [   61.568111] [<c04916b4>] (i2c_device_probe) from [<c03be600>] (driver_probe_device+0x134/0x2b0)
> [   61.576805]  r8:ee8d9c60[   61.579161]  r7:0000000a
>  r6:c0a337d4[   61.582744]  r5:00000000
>  r4:ef33c620[   61.586328]  r3:c04916b4
> [   61.588867] [<c03be4cc>] (driver_probe_device) from [<c03bea0c>] (__device_attach_driver+0xa4/0xb0)
> [   61.597907]  r7:00000000[   61.600263]  r6:ef1f1ca8
>  r5:c0a337d4[   61.603846]  r4:ef33c620
> [   61.606377] 
> [   61.607873] [<c03be968>] (__device_attach_driver) from [<c03bd0ec>] (bus_for_each_drv+0x58/0x94)
> [   61.616654]  r6:c03be968[   61.619010]  r5:ef1f1c80
>  r4:ef1f1ca8[   61.622594]  r3:ef10ce70
> [   61.625124] 
> [   61.626620] [<c03bd094>] (bus_for_each_drv) from [<c03be384>] (__device_attach+0x8c/0x104)
> [   61.634880]  r7:00000000[   61.637235]  r6:00000001
>  r5:ef33c654[   61.640820]  r4:ef33c620
> [   61.643350] 
> [   61.644845] [<c03be2f8>] (__device_attach) from [<c03bea44>] (device_initial_probe+0x14/0x18)
> [   61.653365]  r7:00000000[   61.655720]  r6:ef33c620
>  r5:c0a33358[   61.659304]  r4:ef33c620
> [   61.661835] 
> [   61.663331] [<c03bea30>] (device_initial_probe) from [<c03bd2a0>] (bus_probe_device+0x30/0x88)
> [   61.671946] [<c03bd270>] (bus_probe_device) from [<c03bc1dc>] (device_add+0x38c/0x514)
> [   61.679858]  r6:00000000[   61.682213]  r5:ef33c628
>  r4:ef33c620[   61.685797]  r3:00000000
> [   61.688328] 
> [   61.689824] [<c03bbe50>] (device_add) from [<c03bc4e8>] (device_register+0x1c/0x20)
> [   61.697476]  r10:ffffffed[   61.699919]  r8:ef7f5928
>  r7:ef33c604[   61.703503]  r6:ef33c620
>  r5:ee8d9c20[   61.707087]  r4:ef33c620
> [   61.709628] [<c03bc4cc>] (device_register) from [<c0491e84>] (i2c_new_device+0x114/0x184)
> [   61.717801]  r4:ef33c600[   61.720157]  r3:00000020
> [   61.722687] 
> [   61.724185] [<c0491d70>] (i2c_new_device) from [<c04921dc>] (of_i2c_register_device+0x160/0x184)
> [   61.732965]  r7:ef7f5ac8[   61.735321]  r6:ee8d9c60
>  r5:ee8d9c20[   61.738905]  r4:ef7f5ac8
> [   61.741436] 
> [   61.742933] [<c049207c>] (of_i2c_register_device) from [<c0492454>] (i2c_register_adapter+0x254/0x398)
> [   61.752235]  r5:ee8d9c20[   61.754590]  r4:00000000
> [   61.757121] 
> [   61.758618] [<c0492200>] (i2c_register_adapter) from [<c0492608>] (__i2c_add_numbered_adapter+0x70/0x94)
> [   61.768093]  r8:ee8d9e6c[   61.770449]  r7:00000000
>  r6:00000001[   61.774033]  r5:0000000b
>  r4:ee8d9c20[   61.777616]  r3:00000001
> [   61.780157] [<c0492598>] (__i2c_add_numbered_adapter) from [<c0492c58>] (i2c_add_adapter+0x3c/0xc8)
> [   61.789198]  r5:ee8d9810[   61.791554]  r4:ee8d9c20
> [   61.794084] 
> [   61.795581] [<c0492c1c>] (i2c_add_adapter) from [<c0499f84>] (i2c_demux_activate_master+0x104/0x15c)
> [   61.804709]  r5:ee8d9810[   61.807065]  r4:ee8d9c10
> [   61.809595] 
> [   61.811091] [<c0499e80>] (i2c_demux_activate_master) from [<c049a178>] (current_master_store+0xa0/0xb4)
> [   61.820480]  r10:ef1f1f80[   61.822922]  r8:ee8d9e50
>  r7:00000001[   61.826505]  r6:00000000
>  r5:00000002[   61.830088]  r4:ee8d9c10
> [   61.832628] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   61.841061]  r8:00000051[   61.843417]  r7:eebc1c8c
>  r6:eeae2b80[   61.847000]  r5:00000002
>  r4:eeae2b80[   61.850582] 
> [   61.852083] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   61.860003] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   61.868263]  r4:eebc1c80[   61.870619]  r3:c0240140
> [   61.873149] 
> [   61.874647] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   61.882559]  r10:00000000[   61.885002]  r8:00022900
>  r7:00000002[   61.888585]  r6:ef1f1f80
>  r5:c023f658[   61.892169]  r4:ee9409c0
> [   61.894706] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   61.902011]  r8:ef1f1f80[   61.904367]  r7:00022900
>  r6:00000002[   61.907950]  r5:00000000
>  r4:ee9409c0[   61.911532] 
> [   61.913027] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   61.920072]  r10:00000000[   61.922515]  r8:c0107104
>  r7:00022900[   61.926098]  r6:00000002
>  r5:ee9409c0[   61.929682]  r4:ee9409c0
> [   61.932221] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   61.939786]  r7:00000004[   61.942142]  r6:000217bc
>  r5:00000002[   61.945725]  r4:00022900
> [   61.948256] 
> [   61.964248] rcar-vin e6ef0000.video: Device registered as video17
> [   61.971575] Unable to handle kernel paging request at virtual address ef180c38
> [   61.978804] pgd = ee4a4000
> [   61.981510] [ef180c38] *pgd=6f01141e(bad)
> [   61.985543] Internal error: Oops: 8000000d [#1] SMP ARM
> [   61.990775] CPU: 0 PID: 1540 Comm: udevd Not tainted 4.9.0-rc2-00312-g11ee7f001b13 #148
> [   61.998775] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [   62.005213] task: ef37c540 task.stack: ef24a000
> [   62.009744] PC is at 0xef180c38
> [   62.012892] LR is at ep_send_events_proc+0x9c/0x1c4
> [   62.017771] pc : [<ef180c38>]    lr : [<c021e818>]    psr: 60000013
> [   62.017771] sp : ef24be80  ip : ef24bec8  fp : ef24bec4
> [   62.029246] r10: ef24bf60  r9 : 00000000  r8 : bec41d00
> [   62.034469] r7 : 00000000  r6 : eeac148c  r5 : eeac1e00  r4 : ef24bec8
> [   62.040994] r3 : ef180c38  r2 : ef24bec8  r1 : ef24be90  r0 : ef180d04
> [   62.047522] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   62.054655] Control: 10c5387d  Table: 6e4a406a  DAC: 00000051
> [   62.060399] Process udevd (pid: 1540, stack limit = 0xef24a210)
> [   62.066317] Stack: (0xef24be80 to 0xef24c000)
> [   62.070678] be80: ef24a000 2ee74000 ef24bf2c ef24be98 00000000 00000019 c0544cf0 eeac1e00
> [   62.078858] bea0: eeac1e34 00000000 c021e77c ef24bf60 ffffffff eebd6240 ef24befc ef24bec8
> [   62.087037] bec0: c021efe0 c021e788 ef24bec8 ef24bec8 00000000 00000000 eeac1e00 00000000
> [   62.095216] bee0: 00000000 00000001 00000004 eebd6240 ef24bfa4 ef24bf00 c0220124 c021ef48
> [   62.103395] bf00: 00000000 ef37c540 ef7c8780 ef311a80 ee4bf540 eeb4cc40 00000000 00000000
> [   62.111575] bf20: bec41d00 eebd6240 c06505d4 00000001 ef37c540 c0140b94 00000100 00000200
> [   62.119754] bf40: ef24bf60 00000000 00000000 c0650714 00000000 00000000 bec41d60 ef24bfb0
> [   62.127934] bf60: 00000004 bec41d00 00000121 c0107104 ef24a000 00000000 ef24bf94 0003a270
> [   62.136113] bf80: 0002a0a8 00029268 000000fc c0107104 ef24a000 00000000 00000000 ef24bfa8
> [   62.144293] bfa0: c0106f40 c021fe4c 0003a270 0002a0a8 00000004 bec41d00 00000004 ffffffff
> [   62.152471] bfc0: 0003a270 0002a0a8 00029268 000000fc 00000000 0002fb30 0000000b 0002926c
> [   62.160650] bfe0: 0002a008 bec41c68 00015941 b6ee8d2c 60000010 00000004 00000000 00000000
> [   62.168822] Backtrace: 
> [   62.171285] [<c021e77c>] (ep_send_events_proc) from [<c021efe0>] (ep_scan_ready_list+0xa4/0x1b8)
> [   62.180066]  r10:eebd6240[   62.182509]  r9:ffffffff
>  r8:ef24bf60[   62.186093]  r7:c021e77c
>  r6:00000000[   62.189676]  r5:eeac1e34
> [   62.192207]  r4:eeac1e00[   62.194562] 
> [   62.196059] [<c021ef3c>] (ep_scan_ready_list) from [<c0220124>] (SyS_epoll_wait+0x2e4/0x380)
> [   62.204492]  r10:eebd6240[   62.206935]  r9:00000004
>  r8:00000001[   62.210518]  r7:00000000
>  r6:00000000[   62.214101]  r5:eeac1e00
> [   62.216633]  r4:00000000[   62.218987] 
> [   62.220487] [<c021fe40>] (SyS_epoll_wait) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   62.228487]  r10:00000000[   62.230929]  r9:ef24a000
>  r8:c0107104[   62.234513]  r7:000000fc
>  r6:00029268[   62.238096]  r5:0002a0a8
> [   62.240627]  r4:0003a270[   62.242981] 
> [   62.244477] Code: ef20f528 ef180ca8 00000001 ef00665c (ef180b38) 
> [   62.250573] ---[ end trace 2d55ad213b142958 ]---
> I2C Demux: i2c-11. Master: 0:/i2c@e6518000 (0)
> [   68.290086] rcar-vin e6ef0000.video: Removing video17
> [   68.296630] Unable to handle kernel NULL pointer dereference at virtual address 00000004
> [   68.304812] pgd = ef24c000
> [   68.307519] [00000004] *pgd=7fc89835
> [   68.311133] Internal error: Oops: 817 [#2] SMP ARM
> [   68.315932] CPU: 0 PID: 1534 Comm: exercise-i2c-de Tainted: G      D         4.9.0-rc2-00312-g11ee7f001b13 #148
> [   68.326015] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [   68.332454] task: ef380000 task.stack: ef1f0000
> [   68.336994] PC is at driver_deferred_probe_del+0x34/0x54
> [   68.342305] LR is at driver_deferred_probe_del+0x18/0x54
> [   68.347618] pc : [<c03be1ac>]    lr : [<c03be190>]    psr: a0000013
> [   68.347618] sp : ef1f1c48  ip : ef1f1c48  fp : ef1f1c5c
> [   68.359093] r10: ef1f1f80  r9 : ef1f0000  r8 : 00000100
> [   68.364316] r7 : 00000000  r6 : ef182610  r5 : ee8a6e38  r4 : eeac0910
> [   68.370841] r3 : eeac1480  r2 : eeac14c4  r1 : 0000000b  r0 : 00000000
> [   68.377368] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   68.384501] Control: 10c5387d  Table: 6f24c06a  DAC: 00000051
> [   68.390245] Process exercise-i2c-de (pid: 1534, stack limit = 0xef1f0210)
> [   68.397031] Stack: (0xef1f1c48 to 0xef1f2000)
> [   68.401390] 1c40:                   00000040 eeac0910 ef1f1c8c ef1f1c60 c03baf54 c03be184
> [   68.409570] 1c60: 3a313800 00003734 ef1f0000 ef1f1f80 eeac0910 eeac0bcc ef33c600 00000000
> [   68.417749] 1c80: ef1f1ca4 ef1f1c90 c03baff0 c03bae00 00000001 eeac0820 ef1f1cbc ef1f1ca8
> [   68.425929] 1ca0: c04a05f8 c03bafe8 c094f360 eeac0810 ef1f1cd4 ef1f1cc0 c04ccf18 c04a05c0
> [   68.434109] 1cc0: eeae8654 eeac0bcc ef1f1cec ef1f1cd8 c04cab00 c04cceec c04caad8 eeae8654
> [   68.442289] 1ce0: ef1f1d04 ef1f1cf0 c04afc0c c04caae4 eeae8654 eeae8610 ef1f1d24 ef1f1d08
> [   68.450469] 1d00: c049aa14 c04afb98 c049a9f4 ef33c620 c0a337d4 c0a33358 ef1f1d3c ef1f1d28
> [   68.458648] 1d20: c0491684 c049aa00 ef33c620 c0a337d4 ef1f1d54 ef1f1d40 c03be8f4 c049163c
> [   68.466828] 1d40: ef33c654 ef33c620 ef1f1d6c ef1f1d58 c03bea94 c03be864 ef33c620 ef10ce30
> [   68.475008] 1d60: ef1f1d8c ef1f1d70 c03bd3d8 c03bea7c 0000000a ef33c620 ef1f1e08 ee8d9c60
> [   68.483187] 1d80: ef1f1dbc ef1f1d90 c03baf44 c03bd304 ef1f1db4 00000000 00000044 10b0761e
> [   68.491366] 1da0: ef33c620 ef1f1e08 c04928a4 00000000 ef1f1dd4 ef1f1dc0 c03baff0 c03bae00
> [   68.499546] 1dc0: 00000008 ef33c600 ef1f1dec ef1f1dd8 c049265c c03bafe8 00000061 ef33c600
> [   68.507726] 1de0: ef1f1e04 ef1f1df0 c04928e4 c0492638 ee8d7380 00000000 ef1f1e2c ef1f1e08
> [   68.515906] 1e00: c03bb2ec c04928b0 ee8d7380 ee426b14 ee8d9c20 ee8d9c60 c0a7f848 ee8d9c20
> [   68.524085] 1e20: ef1f1e54 ef1f1e30 c0492e18 c03bb2b4 00000002 ee8d9c10 00000002 00000001
> [   68.532264] 1e40: 00000000 00000025 ef1f1e84 ef1f1e58 c049a13c c0492d18 00000000 00000000
> [   68.540444] 1e60: ef1f1e5c eeb27800 00000002 eeb27800 eebc130c 00000051 ef1f1e94 ef1f1e88
> [   68.548624] 1e80: c03ba1ac c049a0e4 ef1f1eac ef1f1e98 c0240184 c03ba198 c0240140 eebc1300
> [   68.556803] 1ea0: ef1f1edc ef1f1eb0 c023f7a8 c024014c 00000000 00000000 eebd8180 c023f658
> [   68.564982] 1ec0: ef1f1f80 00000002 00022900 00000000 ef1f1f4c ef1f1ee0 c01e2124 c023f664
> [   68.573161] 1ee0: 00000000 ef10f000 ef10f000 ee476b00 0000000a 0000000b ee4d32c0 0000000a
> [   68.581340] 1f00: ef1f1f3c ef1f1f10 c01fe1b8 ee90d780 0000000b ee90d780 0000000a 00000001
> [   68.589520] 1f20: ef1f1f3c ef1f1f30 eebd8180 eebd8180 00000000 00000002 00022900 ef1f1f80
> [   68.597699] 1f40: ef1f1f7c ef1f1f50 c01e238c c01e20fc c01fe64c c01fdc5c eebd8180 eebd8180
> [   68.605879] 1f60: 00000002 00022900 c0107104 00000000 ef1f1fa4 ef1f1f80 c01e24e4 c01e22d4
> [   68.614057] 1f80: 00000000 00000000 00022900 00000002 000217bc 00000004 00000000 ef1f1fa8
> [   68.622236] 1fa0: c0106f40 c01e24a8 00022900 00000002 00000001 00022900 00000002 00022902
> [   68.630415] 1fc0: 00022900 00000002 000217bc 00000004 00000002 00000000 000226f0 000219cc
> [   68.638594] 1fe0: 00000001 be8db770 00012db1 b6f2fb9c 60000010 00000001 00000000 00000000
> [   68.646765] Backtrace: 
> [   68.649229] [<c03be178>] (driver_deferred_probe_del) from [<c03baf54>] (device_del+0x160/0x1e8)
> [   68.657924]  r4:eeac0910[   68.660280]  r3:00000040
> [   68.662810] 
> [   68.664307] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   68.672132]  r7:00000000[   68.674488]  r6:ef33c600
>  r5:eeac0bcc[   68.678071]  r4:eeac0910
> [   68.680601] 
> [   68.682099] [<c03bafdc>] (device_unregister) from [<c04a05f8>] (video_unregister_device+0x44/0x4c)
> [   68.691053]  r4:eeac0820[   68.693408]  r3:00000001
> [   68.695939] 
> [   68.697436] [<c04a05b4>] (video_unregister_device) from [<c04ccf18>] (rvin_v4l2_remove+0x38/0x40)
> [   68.706303]  r4:eeac0810[   68.708659]  r3:c094f360
> [   68.711189] 
> [   68.712684] [<c04ccee0>] (rvin_v4l2_remove) from [<c04cab00>] (rvin_digital_notify_unbind+0x28/0x4c)
> [   68.721812]  r4:eeac0bcc[   68.724168]  r3:eeae8654
> [   68.726698] 
> [   68.728194] [<c04caad8>] (rvin_digital_notify_unbind) from [<c04afc0c>] (v4l2_async_unregister_subdev+0x80/0x90)
> [   68.738363]  r4:eeae8654[   68.740719]  r3:c04caad8
> [   68.743249] 
> [   68.744747] [<c04afb8c>] (v4l2_async_unregister_subdev) from [<c049aa14>] (adv7180_remove+0x20/0x8c)
> [   68.753875]  r5:eeae8610[   68.756231]  r4:eeae8654
> [   68.758760] 
> [   68.760259] [<c049a9f4>] (adv7180_remove) from [<c0491684>] (i2c_device_remove+0x54/0x84)
> [   68.768432]  r6:c0a33358[   68.770787]  r5:c0a337d4
>  r4:ef33c620[   68.774371]  r3:c049a9f4
> [   68.776901] 
> [   68.778397] [<c0491630>] (i2c_device_remove) from [<c03be8f4>] (__device_release_driver+0x9c/0x110)
> [   68.787438]  r5:c0a337d4[   68.789793]  r4:ef33c620
> [   68.792323] 
> [   68.793818] [<c03be858>] (__device_release_driver) from [<c03bea94>] (device_release_driver+0x24/0x30)
> [   68.803119]  r5:ef33c620[   68.805475]  r4:ef33c654
> [   68.808005] 
> [   68.809502] [<c03bea70>] (device_release_driver) from [<c03bd3d8>] (bus_remove_device+0xe0/0xf0)
> [   68.818283]  r5:ef10ce30[   68.820638]  r4:ef33c620
> [   68.823168] 
> [   68.824664] [<c03bd2f8>] (bus_remove_device) from [<c03baf44>] (device_del+0x150/0x1e8)
> [   68.832663]  r6:ee8d9c60[   68.835019]  r5:ef1f1e08
>  r4:ef33c620[   68.838602]  r3:0000000a
> [   68.841132] 
> [   68.842628] [<c03badf4>] (device_del) from [<c03baff0>] (device_unregister+0x14/0x20)
> [   68.850453]  r7:00000000[   68.852809]  r6:c04928a4
>  r5:ef1f1e08[   68.856392]  r4:ef33c620
> [   68.858923] 
> [   68.860420] [<c03bafdc>] (device_unregister) from [<c049265c>] (i2c_unregister_device+0x30/0x34)
> [   68.869200]  r4:ef33c600[   68.871555]  r3:00000008
> [   68.874085] 
> [   68.875583] [<c049262c>] (i2c_unregister_device) from [<c04928e4>] (__unregister_client+0x40/0x50)
> [   68.884537]  r4:ef33c600[   68.886893]  r3:00000061
> [   68.889423] 
> [   68.890919] [<c04928a4>] (__unregister_client) from [<c03bb2ec>] (device_for_each_child+0x44/0x80)
> [   68.899873]  r4:00000000[   68.902229]  r3:ee8d7380
> [   68.904759] 
> [   68.906256] [<c03bb2a8>] (device_for_each_child) from [<c0492e18>] (i2c_del_adapter+0x10c/0x1ac)
> [   68.915037]  r7:ee8d9c20[   68.917392]  r6:c0a7f848
>  r5:ee8d9c60[   68.920976]  r4:ee8d9c20
> [   68.923506] 
> [   68.925002] [<c0492d0c>] (i2c_del_adapter) from [<c049a13c>] (current_master_store+0x64/0xb4)
> [   68.933522]  r8:00000025[   68.935878]  r7:00000000
>  r6:00000001[   68.939461]  r5:00000002
>  r4:ee8d9c10[   68.943044]  r3:00000002
> [   68.945583] [<c049a0d8>] (current_master_store) from [<c03ba1ac>] (dev_attr_store+0x20/0x2c)
> [   68.954015]  r8:00000051[   68.956372]  r7:eebc130c
>  r6:eeb27800[   68.959955]  r5:00000002
>  r4:eeb27800[   68.963537] 
> [   68.965038] [<c03ba18c>] (dev_attr_store) from [<c0240184>] (sysfs_kf_write+0x44/0x50)
> [   68.972958] [<c0240140>] (sysfs_kf_write) from [<c023f7a8>] (kernfs_fop_write+0x150/0x1b4)
> [   68.981217]  r4:eebc1300[   68.983573]  r3:c0240140
> [   68.986104] 
> [   68.987601] [<c023f658>] (kernfs_fop_write) from [<c01e2124>] (__vfs_write+0x34/0x110)
> [   68.995513]  r10:00000000[   68.997956]  r8:00022900
>  r7:00000002[   69.001540]  r6:ef1f1f80
>  r5:c023f658[   69.005123]  r4:eebd8180
> [   69.007660] [<c01e20f0>] (__vfs_write) from [<c01e238c>] (vfs_write+0xc4/0x150)
> [   69.014964]  r8:ef1f1f80[   69.017320]  r7:00022900
>  r6:00000002[   69.020903]  r5:00000000
>  r4:eebd8180[   69.024485] 
> [   69.025981] [<c01e22c8>] (vfs_write) from [<c01e24e4>] (SyS_write+0x48/0x84)
> [   69.033025]  r10:00000000[   69.035467]  r8:c0107104
>  r7:00022900[   69.039051]  r6:00000002
>  r5:eebd8180[   69.042634]  r4:eebd8180
> [   69.045175] [<c01e249c>] (SyS_write) from [<c0106f40>] (ret_fast_syscall+0x0/0x3c)
> [   69.052740]  r7:00000004[   69.055096]  r6:000217bc
>  r5:00000002[   69.058679]  r4:00022900
> [   69.061209] 
> [   69.062704] Code: e1520001 0a000005 e5931048 e5930044 (e5801004) 
> [   69.068853] ---[ end trace 2d55ad213b142959 ]---
> Segmentation fault

-- 
Regards,
Niklas Söderlund
