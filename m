From: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPF in i2cdev_release with i2c_tiny_usb
Date: Sat, 9 Nov 2013 13:52:00 +0100
Message-ID: <CAOE8yMBDtvcXMVqWatrSaW+873-ezF2GYt4ttvd-8oQbuYgYvg@mail.gmail.com>
References: <CAOE8yMAKrU3zFe9VU7sFdjRK_0_Kj4gT6_APptabsJ4t+w=U1w@mail.gmail.com>
Reply-To: mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOE8yMAKrU3zFe9VU7sFdjRK_0_Kj4gT6_APptabsJ4t+w=U1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Sat, Nov 9, 2013 at 1:02 PM, Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The device seems to work, but when I  disconnect/reconncet the USB
> connection I get occasionally a kernel GPF, which needs a reboot.

No. I think the GPF only happens if an application has an open
file descriptor.
Just tested ~5 dis/reconnect USB without problem,
started an application which opens i2c-7 USB disconnect->crash.

regards,

Martin



>
> It happens usually in around ~5 tries.
>
> regards,
>
> Martin
>
>
> [ 4651.614201] usb 2-1.6: USB disconnect, device number 22
> [ 4651.619197] general protection fault: 0000 [#1] PREEMPT SMP
> [ 4651.619203] Modules linked in: i2c_tiny_usb i2c_dev cdc_acm
> binfmt_misc fuse af_packet rfcomm bnep btusb bluetooth
> snd_hda_codec_hdmi nvidia(PO) snd_hda_codec_realtek acpi_cpufreq mperf
> coretemp kvm_intel kvm crc32c_intel ghash_clmulni_intel iTCO_wdt
> iTCO_vendor_support aesni_intel ablk_helper cryptd lrw aes_x86_64 xts
> gf128mul snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq
> snd_timer snd_seq_device microcode snd sg sr_mod cdrom r8169 pcspkr
> eeepc_wmi i2c_i801 serio_raw asus_wmi sparse_keymap rfkill mxm_wmi
> lpc_ich mfd_core shpchp soundcore snd_page_alloc mei pci_hotplug video
> wmi button joydev autofs4 dm_mod linear thermal fan processor
> thermal_sys scsi_dh_alua scsi_dh_hp_sw scsi_dh_rdac scsi_dh_emc
> scsi_dh [last unloaded: osif]
> [ 4651.619270] CPU 2
> [ 4651.619276] Pid: 24398, comm: texplorer Tainted: P           O
> 3.7.10-1.16-desktop #1 System manufacturer System Product Name/P8Z77-M
> PRO
> [ 4651.619280] RIP: 0010:[<ffffffff810a4e0c>]  [<ffffffff810a4e0c>]
> module_put+0x1c/0xe0
> [ 4651.619347] Call Trace:
> [ 4651.619361]  [<ffffffffa0264021>] i2cdev_release+0x21/0x50 [i2c_dev]
> [ 4651.619379]  [<ffffffff8117074d>] __fput+0xcd/0x230
> [ 4651.619388]  [<ffffffff81064f74>] task_work_run+0xb4/0xd0
> [ 4651.619398]  [<ffffffff8104aaa9>] do_exit+0x199/0x960
> [ 4651.619404]  [<ffffffff8104b598>] do_group_exit+0x38/0xa0
> [ 4651.619412]  [<ffffffff8105a3e2>] get_signal_to_deliver+0x2a2/0x620
> [ 4651.619421]  [<ffffffff8100239e>] do_signal+0x4e/0x990
> [ 4651.619430]  [<ffffffff81002d98>] do_notify_resume+0x98/0xc0
> [ 4651.619439]  [<ffffffff8159ed6a>] int_signal+0x12/0x17
> [ 4651.619453]  [<00007f0915eb73d5>] 0x7f0915eb73d4
> [ 4651.619455] Code: 5e 41 5f c3 66 66 2e 0f 1f 84 00 00 00 00 00 41
> 54 48 85 ff 55 48 89 fd 53 74 4b 65 48 8b 04 25 30 b9 00 00 83 80 44
> e0 ff ff 01 <48> 8b 87 50 02 00 00 65 48 ff 40 08 4c 8b 64 24 18 0f 1f
> 44 00
> [ 4651.619503] RIP  [<ffffffff810a4e0c>] module_put+0x1c/0xe0
> [ 4651.619508]  RSP <ffff88020e837c58>
> [ 4651.619512] ---[ end trace 64acf5bd4c614347 ]---
> [ 4651.619514] Fixing recursive fault but reboot is needed!
> [ 4651.619517] BUG: scheduling while atomic: texplorer/24398/0x00000002
> [ 4651.619519] Modules linked in: i2c_tiny_usb i2c_dev cdc_acm
> binfmt_misc fuse af_packet rfcomm bnep btusb bluetooth
> snd_hda_codec_hdmi nvidia(PO) snd_hda_codec_realtek acpi_cpufreq mperf
> coretemp kvm_intel kvm crc32c_intel ghash_clmulni_intel iTCO_wdt
> iTCO_vendor_support aesni_intel ablk_helper cryptd lrw aes_x86_64 xts
> gf128mul snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq
> snd_timer snd_seq_device microcode snd sg sr_mod cdrom r8169 pcspkr
> eeepc_wmi i2c_i801 serio_raw asus_wmi sparse_keymap rfkill mxm_wmi
> lpc_ich mfd_core shpchp soundcore snd_page_alloc mei pci_hotplug video
> wmi button joydev autofs4 dm_mod linear thermal fan processor
> thermal_sys scsi_dh_alua scsi_dh_hp_sw scsi_dh_rdac scsi_dh_emc
> scsi_dh [last unloaded: osif]
> [ 4651.619580] Pid: 24398, comm: texplorer Tainted: P      D    O
> 3.7.10-1.16-desktop #1
> sktop #1
> [ 4651.619582] Call Trace:
> [ 4651.619592]  [<ffffffff81004818>] dump_trace+0x88/0x300
> [ 4651.619600]  [<ffffffff8158af33>] dump_stack+0x69/0x6f
> [ 4651.619609]  [<ffffffff8158ce34>] __schedule_bug+0x48/0x54
> [ 4651.619618]  [<ffffffff81596714>] thread_return+0x450/0x45c
> [ 4651.619628]  [<ffffffff8104b260>] do_exit+0x950/0x960
> [ 4651.619635]  [<ffffffff81598de9>] oops_end+0x99/0xe0
> [ 4651.619642]  [<ffffffff815981c8>] general_protection+0x28/0x30
> [ 4651.619650]  [<ffffffff810a4e0c>] module_put+0x1c/0xe0
> [ 4651.619658]  [<ffffffffa0264021>] i2cdev_release+0x21/0x50 [i2c_dev]
> [ 4651.619668]  [<ffffffff8117074d>] __fput+0xcd/0x230
> [ 4651.619675]  [<ffffffff81064f74>] task_work_run+0xb4/0xd0
> [ 4651.619683]  [<ffffffff8104aaa9>] do_exit+0x199/0x960
> [ 4651.619690]  [<ffffffff8104b598>] do_group_exit+0x38/0xa0
> [ 4651.619698]  [<ffffffff8105a3e2>] get_signal_to_deliver+0x2a2/0x620
> [ 4651.619708]  [<ffffffff8100239e>] do_signal+0x4e/0x990
> [ 4651.619714]  [<ffffffff81002d98>] do_notify_resume+0x98/0xc0
> [ 4651.619719]  [<ffffffff8159ed6a>] int_signal+0x12/0x17
> [ 4651.619728]  [<00007f0915eb73d5>] 0x7f0915eb73d4
