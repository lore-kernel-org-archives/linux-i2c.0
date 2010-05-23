From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 046/199] Documentation/i2c/busses/i2c-sis5595: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:14 +0200
Message-ID: <1274644605-25181-18-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/busses/i2c-sis5595:3: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:6: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:12: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:14: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:15: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:16: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:17: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:18: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:19: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:20: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:21: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:22: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:23: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:24: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:25: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:26: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:27: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:28: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:29: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:30: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:31: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:32: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:33: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:34: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:35: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:36: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:37: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis5595:38: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/i2c/busses/i2c-sis5595 |   58 +++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis5595 b/Documentation/i2c/busses/i2c-sis5595
index cc47db7..ecd21fb 100644
--- a/Documentation/i2c/busses/i2c-sis5595
+++ b/Documentation/i2c/busses/i2c-sis5595
@@ -1,41 +1,41 @@
 Kernel driver i2c-sis5595
 
-Authors: 
+Authors:
 	Frodo Looijaard <frodol@dds.nl>,
         Mark D. Studebaker <mdsxyz123@yahoo.com>,
-	Philip Edelbrock <phil@netroedge.com> 
+	Philip Edelbrock <phil@netroedge.com>
 
 Supported adapters:
   * Silicon Integrated Systems Corp. SiS5595 Southbridge
     Datasheet: Publicly available at the Silicon Integrated Systems Corp. site.
 
-Note: all have mfr. ID 0x1039. 
-
-   SUPPORTED            PCI ID           
-        5595            0008 
- 
-   Note: these chips contain a 0008 device which is incompatible with the 
-         5595. We recognize these by the presence of the listed 
-         "blacklist" PCI ID and refuse to load. 
- 
-   NOT SUPPORTED        PCI ID          BLACKLIST PCI ID         
-         540            0008            0540 
-         550            0008            0550 
-        5513            0008            5511 
-        5581            0008            5597 
-        5582            0008            5597 
-        5597            0008            5597 
-        5598            0008            5597/5598 
-         630            0008            0630 
-         645            0008            0645 
-         646            0008            0646 
-         648            0008            0648 
-         650            0008            0650 
-         651            0008            0651 
-         730            0008            0730 
-         735            0008            0735 
-         745            0008            0745 
-         746            0008            0746 
+Note: all have mfr. ID 0x1039.
+
+   SUPPORTED            PCI ID
+        5595            0008
+
+   Note: these chips contain a 0008 device which is incompatible with the
+         5595. We recognize these by the presence of the listed
+         "blacklist" PCI ID and refuse to load.
+
+   NOT SUPPORTED        PCI ID          BLACKLIST PCI ID
+         540            0008            0540
+         550            0008            0550
+        5513            0008            5511
+        5581            0008            5597
+        5582            0008            5597
+        5597            0008            5597
+        5598            0008            5597/5598
+         630            0008            0630
+         645            0008            0645
+         646            0008            0646
+         648            0008            0648
+         650            0008            0650
+         651            0008            0651
+         730            0008            0730
+         735            0008            0735
+         745            0008            0745
+         746            0008            0746
 
 Module Parameters
 -----------------
-- 
1.7.1.251.gf80a2

