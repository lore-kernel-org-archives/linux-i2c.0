From: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Subject: [PATCH 044/199] Documentation/i2c/busses/i2c-ali15x3: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:12 +0200
Message-ID: <1274644605-25181-16-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/busses/i2c-ali15x3:9: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:10: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:43: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:44: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:46: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:80: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:90: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-ali15x3:91: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-ali15x3 |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-ali15x3 b/Documentation/i2c/busses/i2c-ali15x3
index ff28d38..600da90 100644
--- a/Documentation/i2c/busses/i2c-ali15x3
+++ b/Documentation/i2c/busses/i2c-ali15x3
@@ -6,8 +6,8 @@ Supported adapters:
 	http://www.ali.com.tw/eng/support/datasheet_request.php
 
 Authors:
-	Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, 
-	Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, 
+	Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
+	Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
 	Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
 
 Module Parameters
@@ -40,10 +40,10 @@ M1541 and M1543C South Bridges.
 The M1543C is a South bridge for desktop systems.
 The M1541 is a South bridge for portable systems.
 They are part of the following ALI chipsets:
-   
- * "Aladdin Pro 2" includes the M1621 Slot 1 North bridge with AGP and 
+
+ * "Aladdin Pro 2" includes the M1621 Slot 1 North bridge with AGP and
  		100MHz CPU Front Side bus
- * "Aladdin V" includes the M1541 Socket 7 North bridge with AGP and 100MHz 
+ * "Aladdin V" includes the M1541 Socket 7 North bridge with AGP and 100MHz
  		CPU Front Side bus
    Some Aladdin V motherboards:
 	Asus P5A
@@ -77,7 +77,7 @@ output of lspci will show something similar to the following:
 ** then run lspci.
 ** If you see the 1533 and 5229 devices but NOT the 7101 device,
 ** then you must enable ACPI, the PMU, SMB, or something similar
-** in the BIOS. 
+** in the BIOS.
 ** The driver won't work if it can't find the M7101 device.
 
 The SMB controller is part of the M7101 device, which is an ACPI-compliant
@@ -87,8 +87,8 @@ The whole M7101 device has to be enabled for the SMB to work. You can't
 just enable the SMB alone. The SMB and the ACPI have separate I/O spaces.
 We make sure that the SMB is enabled. We leave the ACPI alone.
 
-Features 
--------- 
+Features
+--------
 
 This driver controls the SMB Host only. The SMB Slave
 controller on the M15X3 is not enabled. This driver does not use
-- 
1.7.1.251.gf80a2
