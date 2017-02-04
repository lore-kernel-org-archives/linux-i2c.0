From: Hrvoje T <hrvooje@jankovci.net>
Subject: Re: SMBus not found
Date: Sat, 4 Feb 2017 02:55:02 +0100
Message-ID: <CANE=DpWWeKNRGhCQciS4aqi9+FXLOmZJabZiuO8FbNq8YP65mw@mail.gmail.com>
References: <CANE=DpU===GBGNY0+QJCKuw295kkYSEPN-oeaT7cG6DRcNdjiA@mail.gmail.com>
 <1486119208.4299.11.camel@suse.de> <CANE=DpWovf4BO31Dqzj72hN=8etRLwFbyrDMZMzqzFNFtRe2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:34689 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbdBDBzD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Feb 2017 20:55:03 -0500
Received: by mail-yb0-f170.google.com with SMTP id j82so11334180ybg.1
        for <linux-i2c@vger.kernel.org>; Fri, 03 Feb 2017 17:55:03 -0800 (PST)
In-Reply-To: <CANE=DpWovf4BO31Dqzj72hN=8etRLwFbyrDMZMzqzFNFtRe2cg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org

Hi Jean,

thank you for a quick reply.

My hardware is HP Probook 6470b laptop, kernel 4.8.0-37-generic,
lm-sensors version 1:3.4.0-3. I did

# modprobe i2c-dev
# i2cdetect -l

and got this:

i2c-3   i2c     i915 gmbus dpc       I2C adapter
i2c-1   i2c     i915 gmbus vga       I2C adapter
i2c-8   i2c     DPDDC-D              I2C adapter
i2c-6   i2c     DPDDC-B              I2C adapter
i2c-4   i2c     i915 gmbus dpb       I2C adapter
i2c-2   i2c     i915 gmbus panel     I2C adapter
i2c-0   i2c     i915 gmbus ssc       I2C adapter
i2c-7   i2c     DPDDC-C              I2C adapter
i2c-5   i2c     i915 gmbus dpd       I2C adapter


I would like to find out CAS latency times of my RAM memory modules
without opening the laptop. I guess those are on DIMM slots. dmidecode
-t memory gives:

Handle 0x0008, DMI type 17, 34 bytes
Memory Device
       Array Handle: 0x0005
       Error Information Handle: Not Provided
       Total Width: 64 bits
       Data Width: 64 bits
       Size: 4096 MB
       Form Factor: SODIMM
       Set: None
       Locator: Bottom-Slot 2(under)
       Bank Locator: BANK 2
       Type: DDR3
       Type Detail: Synchronous
       Speed: 1600 MHz
       Manufacturer: Ramaxel
       Serial Number: 44BBE80E
       Asset Tag: 9876543210
       Part Number: RMT3160ED58E9W1600
       Rank: Unknown
       Configured Clock Speed: Unknown


and lspci:

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04)
00:16.0 Communication controller: Intel Corporation 7 Series/C210
Series Chipset Family MEI Controller #1 (rev 04)
00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network
Connection (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 1 (rev c4)
00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 2 (rev c4)
00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 3 (rev c4)
00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 4 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC
Controller (rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
6-port SATA Controller [AHCI mode] (rev 04)
23:00.0 FireWire (IEEE 1394): JMicron Technology Corp. IEEE 1394 Host
Controller (rev 30)
23:00.1 System peripheral: JMicron Technology Corp. SD/MMC Host
Controller (rev 30)
23:00.2 SD Host controller: JMicron Technology Corp. Standard SD Host
Controller (rev 30)
24:00.0 Network controller: Broadcom Limited BCM43228 802.11a/b/g/n


I know I could find out latency times on the manufacturer's web page,
but I would like to know is it possible via i2c? I'm noob in Linux and
bad at english, sorry for my mistakes and thanks for your help in
advance.

BR
Hrvoje

*trying without html from gmail one more time
