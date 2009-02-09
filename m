From: Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Subject: Re: Bug#513894: Oops: f3 with i2c-tiny-usb
Date: Mon, 9 Feb 2009 20:29:04 +0100
Message-ID: <200902092029.05036.till@harbaum.org>
References: <20090209181043.GB19801@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090209181043.GB19801-u+sgIaa8TU6A7rR/f+Zz5kHK5LHFu9C3@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Koch <tom-koch-Mmb7MZpHnFY@public.gmane.org>, 513894-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

this is an unknown problem. In fact it's the first time i ever got an error 
report for the device. And therefore there isn't any patch.

There seems to be a usb write error. This is a diy hardware. There may
be several reasons causing such problems:

Hardware problems on the i2c-tiny-usb:
- Have correct zener diodes (fast ones!) been used?
- Is the PCB home made? If yes is it really reliable?
- How long is the usb cable? 

General problems:
- What is connected to the i2c-tiny-usb?
- How much power does it draw?
- Is the nslu really able to power everything via usb?
  (e.g. what happens if the i2c-tiny-usb is connected 
  through a self powered hub?)

Maybe the arm kernel barfs on i2c/usb transfer problems?

Till

Am Montag 09 Februar 2009 schrieb Martin Michlmayr:
> Hi Till and other I2C developers,
> 
> Thomas Koch, a Debian user, reported the following backtrace with
> 2.6.26 related to i2c and possibly related to the i2c-tiny-usb driver.
> This is on an ARM device.
> 
> Do you know if this is a known issue for which a patch is available in
> newer kernels, or is this a new bug?
> 
> > [42994982.810000] Unable to handle kernel paging request at virtual address 692f7473
> > [42994982.810000] pgd = c1da0000
> > [42994982.810000] [692f7473] *pgd=00000000
> > [42994982.810000] Internal error: Oops: f3 [#2]
> > [42994982.810000] Modules linked in: ipv6 nfsd auth_rpcgss exportfs nfs lockd nfs_acl sunrpc nls_utf8 ntfs nls_base ext2 evdev ftdi_sio usbhid hid i2c_tiny_usb ff_memless usbserial ixp4xx_eth ixp4xx_npe firmware_class ixp4xx_qmgr ixp4xx_beeper ohci_hcd ext3 jbd mbcache sd_mod ehci_hcd usb_storage usbcorescsi_mod
> > [42994982.810000] CPU: 0    Tainted: G      D    (2.6.26-1-ixp4xx #1)
> > [42994982.810000] PC is at module_put+0x20/0x48
> > [42994982.810000] LR is at i2c_put_adapter+0x14/0x18
> > [42994982.810000] pc : [<c0060b00>]    lr : [<c01940f4>]    psr: 20000093
> > [42994982.810000] sp : c0fc3c68  ip : c0fc3c78  fp : c0fc3c74
> > [42994982.810000] r10: c18d3dd8  r9 : c1c0d120  r8 : 00000000
> > [42994982.810000] r7 : c1c1a208  r6 : 00000008  r5 : c1daaac0  r4 : c13fe000
> > [42994982.810000] r3 : 20000093  r2 : 20000013  r1 : c1daaac0  r0 : 692f7373
> > [42994982.810000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > [42994982.810000] Control: 0000397f  Table: 01da0000  DAC: 00000015
> > [42994982.810000] Process hcontrol (pid: 2671, stack limit = 0xc0fc2268)
> > [42994982.810000] Stack: (0xc0fc3c68 to 0xc0fc4000)
> > [42994982.810000] 3c60:                   c0fc3c84 c0fc3c78 c01940f4 c0060aec c0fc3c9c c0fc3c88
> > [42994982.810000] 3c80: c0195d94 c01940ec c1daaac0 c0f0ea60 c0fc3cd4 c0fc3ca0 c009813c c0195d84
> > [42994982.810000] 3ca0: 00000000 c0ef9d30 00000000 c1daaac0 c1c1a200 00000000 c1c1a208 00000000
> > [42994982.810000] 3cc0: 000000f3 00000001 c0fc3ce4 c0fc3cd8 c00984c4 c0098090 c0fc3d04 c0fc3ce8
> > [42994982.810000] 3ce0: c0094dd0 c009849c c0f16e00 c1c1a200 00000003 0000000c c0fc3d2c c0fc3d08
> > [42994982.810000] 3d00: c0040980 c0094d64 c0f16e00 c0fc2000 c1e68060 0000000b c01941f8 00000008
> > [42994982.810000] 3d20: c0fc3d3c c0fc3d30 c0040a00 c0040904 c0fc3d54 c0fc3d40 c0041cf8 c00409e4
> > [42994982.810000] 3d40: c003e550 c003e420 c0fc3d64 c0fc3d58 c0029de4 c0041aec c0fc3d84 c0fc3d68
> > [42994982.810000] 3d60: c002c460 c0029b70 c0fc3ea0 000000f3 692f7265 c0fc3ea0 c0fc3dac c0fc3d88
> > [42994982.810000] 3d80: c002c718 c002c400 e5933000 c021db38 00000013 00000000 e5933000 00000000
> > [42994982.810000] 3da0: c0fc3dec c0fc3db0 c002e584 c002c6b4 00000000 c02c0a68 28841963 0000b229
> > [42994982.810000] 3dc0: c0fc3df4 ffffffff c02bc1bc 000000f3 c0fc3ea0 692f7265 60000013 00000000
> > [42994982.810000] 3de0: c0fc3e9c c0fc3df0 c00251f0 c002e150 c005b76c c02bc4cc c0fc3e24 c0fc3e08
> > [42994982.810000] 3e00: c003080c c00307a8 c02c1680 c02c1680 00000005 00000000 c0fc3e3c c0fc3e28
> > [42994982.810000] 3e20: c0043e2c c0037468 00000005 00000005 c0fc3e5c c0fc3e40 c002504c c0043dd4
> > [42994982.810000] 3e40: c005b878 ffffffff 0000001f 00000020 c0fc3eec c0fc3e60 c00256b0 c002500c
> > [42994982.810000] 3e60: 00000001 c02c0a70 c0f374c0 00000001 2883b65f 0000b229 c0fc3f10 ffffffff
> > [42994982.810000] 3e80: c0fc3ed4 be932b55 c051d360 c0025c48 c0fc3f04 c0fc3ea0 c002566c c00251c0
> > [42994982.810000] 3ea0: c0fc2028 c0fc3f0c 00000001 692f7265 c1c73a08 00000001 be932b55 c051d360
> > [42994982.810000] 3ec0: c0025c48 c0fc2000 00000000 c0fc3f04 c0fc3f08 c0fc3ee8 c0194cd4 c01941f8
> > [42994982.810000] 3ee0: a0000013 ffffffff 00000001 00000001 be932b55 c051d360 c0fc3f2c c0fc3f08
> > [42994982.810000] 3f00: c0194cd4 c01941ec c0fc3f4c 0001004b c13f0001 c051d360 be932b55 fffffff4
> > [42994982.810000] 3f20: c0fc3f4c c0fc3f30 c01961ac c0194c98 c1daaac0 be932b55 c0fc3f78 00000001
> > [42994982.810000] 3f40: c0fc3f74 c0fc3f50 c0097778 c0196170 006d6561 00000a6f c1daaac0 fffffff7
> > [42994982.810000] 3f60: 00000000 00000000 c0fc3fa4 c0fc3f78 c0097c44 c00976d0 00000000 00000000
> > [42994982.810000] 3f80: 00000000 00000000 0000d6fc 00000000 000090a0 00000003 00000000 c0fc3fa8
> > [42994982.810000] 3fa0: c0025aa0 c0097c0c 0000d6fc 00000000 00000003 be932b55 00000001 be932b55
> > [42994982.810000] 3fc0: 0000d6fc 00000000 000090a0 00000003 00000000 00000000 40025000 be932b6c
> > [42994982.810000] 3fe0: 00000000 be932a40 0000b4ac 40209eac 40000010 00000003 0002003d 00000000
> > [42994982.810000] Backtrace:
> > [42994982.810000] [<c0060ae0>] (module_put+0x0/0x48) from [<c01940f4>] (i2c_put_adapter+0x14/0x18)
> > [42994982.810000] [<c01940e0>] (i2c_put_adapter+0x0/0x18) from [<c0195d94>] (i2cdev_release+0x1c/0x30)
> > [42994982.810000] [<c0195d78>] (i2cdev_release+0x0/0x30) from [<c009813c>] (__fput+0xb8/0x178)
> > [42994982.810000]  r5:c0f0ea60 r4:c1daaac0
> > [42994982.810000] [<c0098084>] (__fput+0x0/0x178) from [<c00984c4>] (fput+0x34/0x38)
> > [42994982.810000] [<c0098490>] (fput+0x0/0x38) from [<c0094dd0>] (filp_close+0x78/0x84)
> > [42994982.810000] [<c0094d58>] (filp_close+0x0/0x84) from [<c0040980>] (put_files_struct+0x88/0xe0)
> > [42994982.810000]  r6:0000000c r5:00000003 r4:c1c1a200
> > [42994982.810000] [<c00408f8>] (put_files_struct+0x0/0xe0) from [<c0040a00>] (exit_files+0x28/0x2c)
> > [42994982.810000]  r8:00000008 r7:c01941f8 r6:0000000b r5:c1e68060 r4:c0fc2000
> > [42994982.810000] [<c00409d8>] (exit_files+0x0/0x2c) from [<c0041cf8>] (do_exit+0x218/0x6a4)
> > [42994982.810000] [<c0041ae0>] (do_exit+0x0/0x6a4) from [<c0029de4>] (die+0x280/0x304)
> > [42994982.810000] [<c0029b64>] (die+0x0/0x304) from [<c002c460>] (__do_kernel_fault+0x6c/0x80)
> > [42994982.810000] [<c002c3f4>] (__do_kernel_fault+0x0/0x80) from [<c002c718>] (do_bad_area+0x70/0x7c)
> > [42994982.810000]  r7:c0fc3ea0 r6:692f7265 r5:000000f3 r4:c0fc3ea0
> > [42994982.810000] [<c002c6a8>] (do_bad_area+0x0/0x7c) from [<c002e584>] (do_alignment+0x440/0x59c)
> > [42994982.810000]  r6:00000000 r5:e5933000 r4:00000000
> > [42994982.810000] [<c002e144>] (do_alignment+0x0/0x59c) from [<c00251f0>] (do_DataAbort+0x3c/0xa0)
> > [42994982.810000] [<c00251b4>] (do_DataAbort+0x0/0xa0) from [<c002566c>] (__dabt_svc+0x4c/0x60)
> > [42994982.810000] Exception stack(0xc0fc3ea0 to 0xc0fc3ee8)
> > [42994982.810000] 3ea0: c0fc2028 c0fc3f0c 00000001 692f7265 c1c73a08 00000001 be932b55 c051d360
> > [42994982.810000] 3ec0: c0025c48 c0fc2000 00000000 c0fc3f04 c0fc3f08 c0fc3ee8 c0194cd4 c01941f8
> > [42994982.810000] 3ee0: a0000013 ffffffff
> > [42994982.810000]  r8:c0025c48 r7:c051d360 r6:be932b55 r5:c0fc3ed4 r4:ffffffff
> > [42994982.810000] [<c01941e0>] (i2c_transfer+0x0/0x98) from [<c0194cd4>] (i2c_master_recv+0x48/0x58)
> > [42994982.810000]  r7:c051d360 r6:be932b55 r5:00000001 r4:00000001
> > [42994982.810000] [<c0194c8c>] (i2c_master_recv+0x0/0x58) from [<c01961ac>] (i2cdev_read+0x48/0xa0)
> > [42994982.810000]  r4:fffffff4
> > [42994982.810000] [<c0196164>] (i2cdev_read+0x0/0xa0) from [<c0097778>] (vfs_read+0xb4/0x18c)
> > [42994982.810000]  r7:00000001 r6:c0fc3f78 r5:be932b55 r4:c1daaac0
> > [42994982.810000] [<c00976c4>] (vfs_read+0x0/0x18c) from [<c0097c44>] (sys_read+0x44/0x70)
> > [42994982.810000]  r7:00000000 r6:00000000 r5:fffffff7 r4:c1daaac0
> > [42994982.810000] [<c0097c00>] (sys_read+0x0/0x70) from [<c0025aa0>] (ret_fast_syscall+0x0/0x2c)
> > [42994982.810000]  r7:00000003 r6:000090a0 r5:00000000 r4:0000d6fc
> > [42994982.810000] Code: 0a00000b e10f2000 e3823080 e121f003 (e5903100)
> > [42994983.440000] ---[ end trace 051f259b86cac584 ]---
> 
> and:
> 
> * Thomas Koch <tom-koch-Mmb7MZpHnFY@public.gmane.org> [2009-02-04 05:12]:
> > > Can you please tell us more: when does this happen, how often, how
> > > reliably can you reproduce this problem, etc?
> > 
> > This happens several times a day.
> > The system is  a linksys nslu2.
> > It looks like it has something to do with the i2c-tiny-usb driver.
> > 
> > [43177942.750000] i2c-adapter i2c-1: failure writing data
> > [43177942.880000] hub 1-1:1.0: port 1 disabled by hub (EMI?), re-enabling...
> > [43177942.880000] usb 1-1.1: USB disconnect, address 17
> > [43177942.970000] usb 1-1.1: new low speed USB device using ehci_hcd and 
> > address 18
> > [43177943.090000] usb 1-1.1: configuration #1 chosen from 1 choice
> > [43177943.100000] i2c-tiny-usb 1-1.1:1.0: version 2.05 found at bus 001 
> > address 018
> > [43177943.130000] i2c-adapter i2c-1: connected i2c-tiny-usb device
> > [43177943.140000] usb 1-1.1: New USB device found, idVendor=0403, 
> > idProduct=c631
> > [43177943.140000] usb 1-1.1: New USB device strings: Mfr=1, Product=2, 
> > SerialNumber=0
> > [43177943.150000] usb 1-1.1: Product: i2c-tiny-usb
> > [43177943.160000] usb 1-1.1: Manufacturer: Till Harbaum
> > 
> > Most of the time I can see it after the device is registered again.
> > 
> > Thanks,
> > Thomas
> 



-- 
Dr. Till Harbaum <Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org>
