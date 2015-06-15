From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: slave: fix the example how to instantiate from userspace
Date: Mon, 15 Jun 2015 19:51:46 +0200
Message-ID: <1434390706-19364-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

I copied the wrong shell code into the documentation. Sorry to all who
tried to get sense out of this current example :/ Slight rewording while
we are here.

Reported-by: Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 Documentation/i2c/slave-interface | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index 02b086510b6c10..2dee4e2d62df19 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -31,10 +31,10 @@ User manual
 ===========
 
 I2C slave backends behave like standard I2C clients. So, you can instantiate
-them like described in the document 'instantiating-devices'. A quick example
-for instantiating the slave-eeprom driver from userspace:
+them as described in the document 'instantiating-devices'. A quick example for
+instantiating the slave-eeprom driver from userspace at address 0x64 on bus 1:
 
-  # echo 0-0064 > /sys/bus/i2c/drivers/i2c-slave-eeprom/bind
+  # echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-1/new_device
 
 Each backend should come with separate documentation to describe its specific
 behaviour and setup.
-- 
2.1.4
