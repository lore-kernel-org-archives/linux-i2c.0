From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mux: demux-pinctrl: Update docs to new sysfs-attributes
Date: Sun,  3 Apr 2016 16:42:16 +0200
Message-ID: <1459694536-23144-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Update the docs according to the recent code changes, too.

Fixes: c0c508a418f9da ("i2c: mux: demux-pinctrl: Clean up sysfs attributes")
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   | 29 +++++++++-------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl b/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
index 7ac7d7262bb718..3c3514815cd53b 100644
--- a/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
+++ b/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
@@ -1,23 +1,18 @@
-What:		/sys/devices/platform/<i2c-demux-name>/cur_master
+What:		/sys/devices/platform/<i2c-demux-name>/available_masters
 Date:		January 2016
 KernelVersion:	4.6
 Contact:	Wolfram Sang <wsa@the-dreams.de>
 Description:
+		Reading the file will give you a list of masters which can be
+		selected for a demultiplexed bus. The format is
+		"<index>:<name>". Example from a Renesas Lager board:
 
-This file selects the active I2C master for a demultiplexed bus.
+		0:/i2c@e6500000 1:/i2c@e6508000
 
-Write 0 there for the first master, 1 for the second etc. Reading the file will
-give you a list with the active master marked. Example from a Renesas Lager
-board:
-
-root@Lager:~# cat /sys/devices/platform/i2c@8/cur_master
-* 0 - /i2c@9
-  1 - /i2c@e6520000
-  2 - /i2c@e6530000
-
-root@Lager:~# echo 2 > /sys/devices/platform/i2c@8/cur_master
-
-root@Lager:~# cat /sys/devices/platform/i2c@8/cur_master
-  0 - /i2c@9
-  1 - /i2c@e6520000
-* 2 - /i2c@e6530000
+What:		/sys/devices/platform/<i2c-demux-name>/current_master
+Date:		January 2016
+KernelVersion:	4.6
+Contact:	Wolfram Sang <wsa@the-dreams.de>
+Description:
+		This file selects/shows the active I2C master for a demultiplexed
+		bus. It uses the <index> value from the file 'available_masters'.
-- 
2.7.0
