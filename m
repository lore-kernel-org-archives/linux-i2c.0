From: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Subject: [PATCH 047/199] Documentation/i2c/busses/i2c-sis630: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:15 +0200
Message-ID: <1274644605-25181-19-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/busses/i2c-sis630:17: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis630:18: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis630:19: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-sis630:47: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-sis630 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/busses/i2c-sis630
index 9aca688..629ea2c 100644
--- a/Documentation/i2c/busses/i2c-sis630
+++ b/Documentation/i2c/busses/i2c-sis630
@@ -14,9 +14,9 @@ Module Parameters
 * force = [1|0] Forcibly enable the SIS630. DANGEROUS!
 		This can be interesting for chipsets not named
 		above to check if it works for you chipset, but DANGEROUS!
-		
-* high_clock = [1|0] Forcibly set Host Master Clock to 56KHz (default, 
-			what your BIOS use). DANGEROUS! This should be a bit 
+
+* high_clock = [1|0] Forcibly set Host Master Clock to 56KHz (default,
+			what your BIOS use). DANGEROUS! This should be a bit
 			faster, but freeze some systems (i.e. my Laptop).
 
 
@@ -44,6 +44,6 @@ Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
 - testing SiS730 support
 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
 - bug fixes
- 
+
 To anyone else which I forgot here ;), thanks!
 
-- 
1.7.1.251.gf80a2
