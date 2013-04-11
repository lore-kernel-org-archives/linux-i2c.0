From: Mattias Helsing <helsing72-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Having problems with i2c on an embedded EG20t
Date: Thu, 11 Apr 2013 13:28:56 +0200
Message-ID: <CAOPUD5C8T3LnzNeqSfm1ECQj9fD5rfgMM2BAv+FoyJgb_+XfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

I have a COM Express board (Atom e660 and EG20t platform controller).
I have installed an ubuntu distribution with the 3.2.0-29 kernel and
everything is working fine except the i2c stuff. Whatever I throw
(i2cdetect i2cget etc) I get :
i2c_eg20t 0000:05:0c.2: pch_i2c_getack :return-71
in my dmesg. The -71 seems to be EPROTO from reading i2c-eg20t.c but
I'm far from being a kernel hacker so this doesn't mean anything to
me.

Could someone give me a hint on what might be wrong with my setup?

cheers
Mattias

lspci:
00:00.0 Host bridge: Intel Corporation Atom Processor E6xx PCI Host
Bridge #1 (rev 05)
00:01.0 Host bridge: Intel Corporation Atom Processor E6xx
Configuration Unit (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor
E6xx Integrated Graphics Controller (rev 05)
00:03.0 Multimedia video controller: Intel Corporation Atom Processor
E6xx Integrated Graphics Controller (rev 02)
00:17.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express
Port 1 (rev 02)
00:18.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express
Port 2 (rev 02)
00:19.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express
Port 3 (rev 02)
00:1a.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express
Port 4 (rev 02)
00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH
Poulsbo) HD Audio Controller (rev 02)
00:1f.0 ISA bridge: Intel Corporation Atom Processor E6xx LPC Bridge (rev 02)
04:00.0 PCI bridge: Intel Corporation Platform Controller Hub EG20T
PCI Express Port (rev 01)
05:00.0 Unassigned class [ff00]: Intel Corporation Platform Controller
Hub EG20T Packet Hub (rev 01)
05:00.1 Ethernet controller: Intel Corporation Platform Controller Hub
EG20T Gigabit Ethernet Controller (rev 02)
05:00.2 Unassigned class [ff00]: Intel Corporation Platform Controller
Hub EG20T General Purpose IO Controller (rev 01)
05:02.0 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #4 (rev 02)
05:02.1 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #5 (rev 02)
05:02.2 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #6 (rev 02)
05:02.3 USB controller: Intel Corporation Platform Controller Hub
EG20T USB2 EHCI Controller #2 (rev 02)
05:02.4 USB controller: Intel Corporation Platform Controller Hub
EG20T USB Client Controller (rev 02)
05:04.0 SD Host controller: Intel Corporation Platform Controller Hub
EG20T SDIO Controller #1 (rev 01)
05:04.1 SD Host controller: Intel Corporation Platform Controller Hub
EG20T SDIO Controller #2 (rev 01)
05:06.0 SATA controller: Intel Corporation Platform Controller Hub
EG20T SATA AHCI Controller (rev 02)
05:08.0 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #1 (rev 02)
05:08.1 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #2 (rev 02)
05:08.2 USB controller: Intel Corporation Platform Controller Hub
EG20T USB OHCI Controller #3 (rev 02)
05:08.3 USB controller: Intel Corporation Platform Controller Hub
EG20T USB2 EHCI Controller #1 (rev 02)
05:0a.0 Unassigned class [ff00]: Intel Corporation Platform Controller
Hub EG20T DMA Controller #1
05:0a.1 Serial controller: Intel Corporation Platform Controller Hub
EG20T UART Controller 0 (rev 01)
05:0a.2 Serial controller: Intel Corporation Platform Controller Hub
EG20T UART Controller 1
05:0a.3 Serial controller: Intel Corporation Platform Controller Hub
EG20T UART Controller 2
05:0a.4 Serial controller: Intel Corporation Platform Controller Hub
EG20T UART Controller 3
05:0c.0 Unassigned class [ff00]: Intel Corporation Platform Controller
Hub EG20T DMA Controller #2
05:0c.1 Serial bus controller [0c80]: Intel Corporation Platform
Controller Hub EG20T Serial Peripheral Interface Bus
05:0c.2 Serial bus controller [0c80]: Intel Corporation Platform
Controller Hub EG20T I2C Controller
05:0c.3 CANBUS: Intel Corporation Platform Controller Hub EG20T
Controller Area Network (CAN) Controller
05:0c.4 Unassigned class [ff00]: Intel Corporation Platform Controller
Hub EG20T IEEE 1588 Hardware Assist (rev 01)

lsmod:
Module                  Size  Used by
i2c_dev                13199  0
i2c_smbus              13016  0
i2c_eg20t              17739  0
vesafb                 13516  1
snd_hda_codec_analog    75395  1
usbhid                 41906  0
hid                    77367  1 usbhid
pch_can                17878  0
can_dev                14748  1 pch_can
snd_hda_intel          32765  0
snd_hda_codec         109562  2 snd_hda_codec_analog,snd_hda_intel
snd_hwdep              13276  1 snd_hda_codec
pch_phub               13207  0
gpio_pch               13126  0
snd_pcm                80845  2 snd_hda_intel,snd_hda_codec
snd_timer              28931  1 snd_pcm
snd                    62064  6
snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
soundcore              14635  1 snd
snd_page_alloc         14108  2 snd_hda_intel,snd_pcm
lpc_sch                12720  0
shpchp                 32325  0
mac_hid                13077  0
lp                     17455  0
parport                40930  1 lp
sdhci_pci              18324  0
sdhci                  28241  1 sdhci_pci
pch_gbe                38415  0

relevant dmesg messages (imho):
...
[    0.342340] i2c-core: driver [aat2870] using legacy suspend method
[    0.342360] i2c-core: driver [aat2870] using legacy resume method
...
[  209.289290] i2c_eg20t 0000:05:0c.2: PCI INT C -> GSI 17 (level,
low) -> IRQ 17   #modprobe i2c-eg20t
[  255.881124] i2c /dev entries driver
                                    #modprobe i2c-dev
[  294.250132] i2c_eg20t 0000:05:0c.2: pch_i2c_getack :return-71
                   #i2cdetect 0
... more than 100 of these
[  294.704387] i2c_eg20t 0000:05:0c.2: pch_i2c_getack :return-71
