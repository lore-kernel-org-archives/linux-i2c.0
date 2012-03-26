From: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Subject: i801_smbus: ... you should use it instead of the native driver
Date: Mon, 26 Mar 2012 17:06:05 +0200
Message-ID: <4F7085DD.7050303@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
  I have the following message logged through syslog on a 2.6.32.59 kernel:

Mar 26 11:21:55 vostro kernel: i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Mar 26 11:21:55 vostro kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver


And here the relevant line from lspci:
00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller (rev 05)

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller (rev 05)
        Subsystem: Dell Device 04b3
        Flags: medium devsel, IRQ 18
        Memory at f7f05000 (64-bit, non-prefetchable) [size=256]
        I/O ports at f040 [size=32]
        Kernel modules: i2c-i801


  So what driver should I use instead? This is a Dell Vostro 3550 laptop with Core i7 on
a SandyBridge.
Thanks,
Martin
