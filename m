From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Warning with gpio-i2cmux
Date: Tue, 19 Apr 2011 17:25:01 +0200
Message-ID: <20110419172501.5f37e46f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

I presume you are using gpio-i2cmux on some of your systems? I tried to
use it and I get the following warning when I rmmod the underlying I2C
controller driver:

WARNING: at drivers/base/core.c:143 device_release+0x82/0x90()
Hardware name: System Product Name
Device 'gpio-i2cmux.0' does not have a release() function, it is broken and must be fixed.
Modules linked in: i2c_mux i2c_i801(-) jc42 snd_pcm_oss snd_mixer_oss snd_seq w83795 snd_seq_device coretemp edd nfsd lockd nfs_acl auth_rpcgss sunrpc cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf fuse nls_utf8 loop dm_mod mt2060 dvb_usb_dib0700 snd_hda_codec_hdmi dib7000p snd_hda_codec_realtek dib0090 dib7000m dib0070 snd_hda_intel ir_lirc_codec dvb_usb snd_hda_codec lirc_dev dib8000 ir_sony_decoder ir_jvc_decoder dvb_core snd_hwdep ir_rc6_decoder ir_rc5_decoder snd_pcm dib3000mc ir_nec_decoder rc_core snd_timer ioatdma e1000e snd iTCO_wdt dibx000_common sg iTCO_vendor_support i7core_edac soundcore i2c_tiny_usb i801_gpio edac_core snd_page_alloc dca pcspkr button radeon ttm sd_mod drm_kms_helper drm i2c_algo_bit fan processor ata_generic ata_piix ahci libahci
  libata sym53c8xx scsi_transport_spi scsi_mod thermal thermal_sys [last unloaded: gpio_i2cmux]
Pid: 29946, comm: rmmod Not tainted 2.6.39-rc3-git8 #77
Call Trace:
 [<ffffffff8105052a>] warn_slowpath_common+0x7a/0xb0
 [<ffffffff81050601>] warn_slowpath_fmt+0x41/0x50
 [<ffffffff8119f6a6>] ? remove_dir+0x36/0x40
 [<ffffffff812ee3c2>] device_release+0x82/0x90
 [<ffffffff81231e8d>] kobject_release+0x8d/0x1d0
 [<ffffffff81231e00>] ? kobject_del+0x80/0x80
 [<ffffffff81233817>] kref_put+0x37/0x70
 [<ffffffff81231d27>] kobject_put+0x27/0x60
 [<ffffffff812ee0f2>] put_device+0x12/0x20
 [<ffffffff812f42f2>] platform_device_put+0x12/0x20
 [<ffffffff812f44a9>] platform_device_unregister+0x19/0x20
 [<ffffffffa05d3f04>] i801_remove+0x38/0x82 [i2c_i801]
 [<ffffffff8125602d>] pci_device_remove+0x4d/0x110
 [<ffffffff812f1c10>] __device_release_driver+0x70/0xe0
 [<ffffffff812f24a0>] driver_detach+0xc0/0xd0
 [<ffffffff812f1a69>] bus_remove_driver+0x89/0x100
 [<ffffffff812f2869>] driver_unregister+0x59/0x90
 [<ffffffff81255c8f>] pci_unregister_driver+0x3f/0xb0
 [<ffffffffa05d45e7>] i2c_i801_exit+0x10/0xa29 [i2c_i801]
 [<ffffffff8108b77b>] sys_delete_module+0x16b/0x250
 [<ffffffff81489712>] system_call_fastpath+0x16/0x1b

Do you see anything similar on your end? Any idea how to fix this?

Thanks,
-- 
Jean Delvare
