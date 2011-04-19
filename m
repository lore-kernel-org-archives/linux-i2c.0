From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: Warning with gpio-i2cmux
Date: Tue, 19 Apr 2011 17:51:24 +0200
Message-ID: <87d3kitf2b.fsf@thor.barco.com>
References: <20110419172501.5f37e46f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20110419172501.5f37e46f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare'smessage of "Tue, 19 Apr 2011 17:25:01 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

JD> I presume you are using gpio-i2cmux on some of your systems? I tried to
JD> use it and I get the following warning when I rmmod the underlying I2C
JD> controller driver:

Pulling the rug under the driver is not something I normally do, but it
should work.

JD> WARNING: at drivers/base/core.c:143 device_release+0x82/0x90()
JD> Hardware name: System Product Name
JD> Device 'gpio-i2cmux.0' does not have a release() function, it is broken and must be fixed.
JD> Modules linked in: i2c_mux i2c_i801(-) jc42 snd_pcm_oss
JD> snd_mixer_oss snd_seq w83795 snd_seq_device coretemp edd nfsd lockd
JD> nfs_acl auth_rpcgss sunrpc cpufreq_conservative cpufreq_userspace
JD> cpufreq_powersave acpi_cpufreq mperf fuse nls_utf8 loop dm_mod
JD> mt2060 dvb_usb_dib0700 snd_hda_codec_hdmi dib7000p
JD> snd_hda_codec_realtek dib0090 dib7000m dib0070 snd_hda_intel
JD> ir_lirc_codec dvb_usb snd_hda_codec lirc_dev dib8000 ir_sony_decoder
JD> ir_jvc_decoder dvb_core snd_hwdep ir_rc6_decoder ir_rc5_decoder
JD> snd_pcm dib3000mc ir_nec_decoder rc_core snd_timer ioatdma e1000e
JD> snd iTCO_wdt dibx000_common sg iTCO_vendor_support i7core_edac
JD> soundcore i2c_tiny_usb i801_gpio edac_core snd_page_alloc dca pcspkr
JD> button radeon ttm sd_mod drm_kms_helper drm i2c_algo_bit fan
JD> processor ata_generic ata_piix ahci libahci libata sym53c8xx
JD> scsi_transport_spi scsi_mod thermal thermal_sys [last unloaded:
JD> gpio_i2cmux]
JD> Pid: 29946, comm: rmmod Not tainted 2.6.39-rc3-git8 #77
JD> Call Trace:
JD>  [<ffffffff8105052a>] warn_slowpath_common+0x7a/0xb0
JD>  [<ffffffff81050601>] warn_slowpath_fmt+0x41/0x50
JD>  [<ffffffff8119f6a6>] ? remove_dir+0x36/0x40
JD>  [<ffffffff812ee3c2>] device_release+0x82/0x90
JD>  [<ffffffff81231e8d>] kobject_release+0x8d/0x1d0
JD>  [<ffffffff81231e00>] ? kobject_del+0x80/0x80
JD>  [<ffffffff81233817>] kref_put+0x37/0x70
JD>  [<ffffffff81231d27>] kobject_put+0x27/0x60
JD>  [<ffffffff812ee0f2>] put_device+0x12/0x20
JD>  [<ffffffff812f42f2>] platform_device_put+0x12/0x20
JD>  [<ffffffff812f44a9>] platform_device_unregister+0x19/0x20

So you tweaked the i801 driver to create and register a platform device
for gpio-i2cmux which you then forcibly unregister in the i801 remove
handler without providing a release() function on the platform device?

That's afaik wrong as the platform_device might be in use (E.G. someone
has the sysfs entry open or similar, and you need to use
platform_device_alloc() which ensures that the device only gets freed
when nobody is using it anymore.

-- 
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
