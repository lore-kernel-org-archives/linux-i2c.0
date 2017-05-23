From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] docs: driver-api: i2c: remove some outdated information
Date: Tue, 23 May 2017 15:46:54 +0200
Message-ID: <20170523134654.11892-1-wsa@the-dreams.de>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

a) Linux can be an I2C slave meanwhile
b) all drivers except one use the driver model currently

Update the documentation.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/driver-api/i2c.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/i2c.rst b/Documentation/driver-api/i2c.rst
index f3939f7852bd59..0bf86a445d0135 100644
--- a/Documentation/driver-api/i2c.rst
+++ b/Documentation/driver-api/i2c.rst
@@ -13,8 +13,8 @@ I2C is a multi-master bus; open drain signaling is used to arbitrate
 between masters, as well as to handshake and to synchronize clocks from
 slower clients.
 
-The Linux I2C programming interfaces support only the master side of bus
-interactions, not the slave side. The programming interface is
+The Linux I2C programming interfaces support the master side of bus
+interactions and the slave side. The programming interface is
 structured around two kinds of driver, and two kinds of device. An I2C
 "Adapter Driver" abstracts the controller hardware; it binds to a
 physical device (perhaps a PCI device or platform_device) and exposes a
@@ -22,9 +22,8 @@ physical device (perhaps a PCI device or platform_device) and exposes a
 I2C bus segment it manages. On each I2C bus segment will be I2C devices
 represented by a :c:type:`struct i2c_client <i2c_client>`.
 Those devices will be bound to a :c:type:`struct i2c_driver
-<i2c_driver>`, which should follow the standard Linux driver
-model. (At this writing, a legacy model is more widely used.) There are
-functions to perform various I2C protocol operations; at this writing
+<i2c_driver>`, which should follow the standard Linux driver model. There
+are functions to perform various I2C protocol operations; at this writing
 all such functions are usable only from task context.
 
 The System Management Bus (SMBus) is a sibling protocol. Most SMBus
-- 
2.11.0

