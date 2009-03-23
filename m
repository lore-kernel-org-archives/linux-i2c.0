From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 5/5] xtensa: enable at24 driver in s6105_defconfig
Date: Mon, 23 Mar 2009 16:05:18 +0100
Message-ID: <1237820718-30607-5-git-send-email-dg@emlix.com>
References: <1237820718-30607-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237820718-30607-1-git-send-email-dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Daniel Gl=C3=B6ckner <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
---
 arch/xtensa/configs/s6105_defconfig |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/configs/s6105_defconfig b/arch/xtensa/configs/=
s6105_defconfig
index a9a0de9..e398710 100644
--- a/arch/xtensa/configs/s6105_defconfig
+++ b/arch/xtensa/configs/s6105_defconfig
@@ -251,7 +251,17 @@ CONFIG_BLK_DEV_RAM_SIZE=3D4096
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_BLK_DEV_HD is not set
-# CONFIG_MISC_DEVICES is not set
+CONFIG_MISC_DEVICES=3Dy
+# CONFIG_ICS932S401 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+CONFIG_EEPROM_AT24=3Dy
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=3Dy
 # CONFIG_IDE is not set
=20
--=20
1.6.2.107.ge47ee
