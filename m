From: Helia Correia <helia.correia-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] Documentation: i2c: Remove obsolete example
Date: Thu, 28 Nov 2013 16:02:41 +0100
Message-ID: <52975B11.2090006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jerome.blin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Correia, Helia" <helia.correia-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/fault-codes illustrates EINVAL error code
as follows:

"One example would be a driver trying an SMBus Block Write
with block size outside the range of 1-32 bytes."

However, the actual implementation of i2c subsystem truncates
data length to be 32 bytes.
Hence this example cannot happen anymore, and since it's obsolete,
let's simply remove it from Documentation/i2c/fault-codes.

Signed-off-by: Helia Correia <helia.correia-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/fault-codes | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
index 045765c0b9b5..47c25abb7d52 100644
--- a/Documentation/i2c/fault-codes
+++ b/Documentation/i2c/fault-codes
@@ -64,9 +64,6 @@ EINVAL
 	detected before any I/O operation was started.  Use a more
 	specific fault code when you can.

-	One example would be a driver trying an SMBus Block Write
-	with block size outside the range of 1-32 bytes.
-
 EIO
 	This rather vague error means something went wrong when
 	performing an I/O operation.  Use a more specific fault
-- 
1.8.1.2
