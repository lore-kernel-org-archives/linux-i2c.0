From: Austin Boyle <Austin.Boyle@aviatnet.com>
Subject: Zarlink ZL30143 DPLL Driver
Date: Wed, 26 Oct 2011 11:21:51 +1300
Message-ID: <1319581311.3172.48.camel@pc786-ubu.gnet.global.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I have written a driver for the Zarlink ZL30143 DPLL. It would typically
be used in an embedded system as part of Sync-E support. The device is
accessed via an I2C interface. In general the driver just exports
register read/write functions, but I have also added some ioctl's to
get/set various settings that require multiple register writes (e.g.
selecting references, setting up priorities) and interrupt support.

I can't find any similar drivers, but I can see that most of the
configuration for this device could just be done using i2c-tools in user
space. I would imagine there are too many generic I2C devices to include
a separate driver for each of them in the kernel. Is there any point
submitting a patch for this? In what system would this kind of device
belong?

Kind regards,
Austin

....................................................................

Austin Boyle
Software Engineer
AVIAT NETWORKS
Direct: + 64 577 8711
Mobile: + 64 27 488 0221
Email:  Austin.Boyle@aviatnet.com
Web:    www.aviatnetworks.com 
Skype:  boyle.austin
