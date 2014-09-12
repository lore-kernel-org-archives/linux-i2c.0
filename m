From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Subject: Re: [PATCH] [REGRESSION] i2c-acpi: Fix NULL Pointer dereference
Date: Fri, 12 Sep 2014 21:12:24 +0200
Message-ID: <201409122112.25118.PeterHuewe@gmx.de>
References: <1410548987-3558-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1410548987-3558-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Am Freitag, 12. September 2014, 21:09:47 schrieb Peter Huewe:
> If adapter->dev.parent == NULL there is a NULL pointer dereference in
> acpi_i2c_install_space_handler and acpi_i2c_remove_space_handler.
> 
> This is present since introduction of this code:
> 366047515c6e "i2c: rework kernel config I2C_ACPI" or even
> da3c6647ee08 "I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI"
> 
> The adapter->dev.parent == NULL case is valid for the i2c_stub,
> so loading i2c_stub with ACPI_I2C_OPREGION enabled results in an oops.
> This is also valid at least for i2c_tiny_usb and i2c_robotfuzz_osif.
> 
> Fix by checking whether it is null before calling ACPI_HANDLE.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---

Patch against current i2c/master.

For those who care - here's the oops:
# modprobe i2c_stub chip_addr=0x20
# dmesg

[   39.315090] i2c-stub: Virtual chip at 0x20
[   39.315149] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000240
[   39.317716] IP: [<ffffffff8248ed65>] acpi_i2c_install_space_handler+0x16/0xb2
[   39.320261] PGD 40db4b067 PUD 40d2bf067 PMD 0 
[   39.322848] Oops: 0000 [#1] PREEMPT SMP 
[   39.325360] Modules linked in: i2c_stub(+) w83627ehf hwmon_vid ipv6 usbhid 
snd_hda_codec_hdmi x86_pkg_temp_thermal snd_hda_codec_realtek coretemp 
snd_hda_codec_generic kvm_intel kvm crc32_pclmul ghash_clmulni_intel snd_hda_intel 
snd_hda_controller pcspkr snd_hda_codec i2c_i801 snd_hwdep snd_pcm snd_timer snd 
battery tpm_tis tpm
[   39.330770] CPU: 0 PID: 2783 Comm: modprobe Not tainted 3.17.0-rc4-00131-gd030671 
#151
[   39.333451] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z77 Pro4, 
BIOS P1.70 01/17/2013
[   39.336153] task: ffff88040e4bd7d0 ti: ffff88040e60c000 task.ti: ffff88040e60c000
[   39.338876] RIP: 0010:[<ffffffff8248ed65>]  [<ffffffff8248ed65>] 
acpi_i2c_install_space_handler+0x16/0xb2
[   39.341657] RSP: 0018:ffff88040e60fca8  EFLAGS: 00010296
[   39.344421] RAX: 0000000000000000 RBX: ffffffffc099db30 RCX: ffff88040d8def40
[   39.347193] RDX: 00000000ffffffed RSI: ffff8800bff975e0 RDI: ffffffffc099db30
[   39.349965] RBP: ffff88040e60fcc8 R08: ffff8800bff975e0 R09: ffff8800bff975e0
[   39.352742] R10: ffffffffc099db78 R11: ffff88040b51c028 R12: ffffffffc099db78
[   39.355510] R13: ffffffffc099db30 R14: 0000000000000000 R15: ffffffffc099ded0
[   39.358275] FS:  00007f638fd52700(0000) GS:ffff88041f200000(0000) 
knlGS:0000000000000000
[   39.361008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.363681] CR2: 0000000000000240 CR3: 000000040dbba000 CR4: 00000000001407f0
[   39.366332] Stack:
[   39.368924]  ffff88040d8def40 ffffffffc099db30 ffffffffc099db78 0000000000000000
[   39.371576]  ffff88040e60fcf8 ffffffff8248e2ee ffffffffc099db30 0000000000000001
[   39.374216]  0000000000000000 ffffffff82782250 ffff88040e60fd28 ffffffff8248e424
[   39.376840] Call Trace:
[   39.379424]  [<ffffffff8248e2ee>] i2c_register_adapter+0x1bc/0x299
[   39.382044]  [<ffffffff8248e424>] i2c_add_adapter+0x59/0x60
[   39.384650]  [<ffffffffc09a01b6>] i2c_stub_init+0x1b6/0x1d4 [i2c_stub]
[   39.387277]  [<ffffffffc09a0000>] ? 0xffffffffc09a0000
[   39.389896]  [<ffffffffc09a0000>] ? 0xffffffffc09a0000
[   39.392504]  [<ffffffff8200030e>] do_one_initcall+0xea/0x184
[   39.395128]  [<ffffffff82172a63>] ? vfree+0x74/0x7b
[   39.397763]  [<ffffffff82109550>] load_module+0x1b0f/0x1e11
[   39.397768]  [<ffffffff82106d13>] ? module_unload_free+0xd2/0xd2
[   39.397773]  [<ffffffff82109943>] SyS_finit_module+0x56/0x6c
[   39.397779]  [<ffffffff8255fdcb>] tracesys+0xdd/0xe2
[   39.397822] Code: 48 c7 c6 37 37 70 82 31 c0 e8 56 66 f5 ff 48 83 c4 18 5b 5d c3 
55 ba ed ff ff ff 48 89 e5 41 55 49 89 fd 41 54 53 51 48 8b 47 48 <48> 8b 80 40 02 00 
00 48 85 c0 0f 84 82 00 00 00 4c 8b 60 08 4d 
[   39.397827] RIP  [<ffffffff8248ed65>] acpi_i2c_install_space_handler+0x16/0xb2
[   39.397828]  RSP <ffff88040e60fca8>
[   39.397829] CR2: 0000000000000240
[   39.397863] ---[ end trace 9f55e6ce67aaaafb ]---

