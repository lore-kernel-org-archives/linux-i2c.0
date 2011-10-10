From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH] i2c: boilerplate function for byte swapped smbus_write/read_word_data
Date: Mon, 10 Oct 2011 10:07:43 +0100
Message-ID: <1318237663-13937-2-git-send-email-jic23@cam.ac.uk>
References: <20111009094118.44b616bf@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111009094118.44b616bf-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reimplemented at least 17 times discounting error mangling cases
where it could be used.

Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
---
 Documentation/i2c/smbus-protocol |    8 ++++++++
 include/linux/i2c.h              |   17 +++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
index 7c19d1a..5003539 100644
--- a/Documentation/i2c/smbus-protocol
+++ b/Documentation/i2c/smbus-protocol
@@ -88,6 +88,10 @@ byte. But this time, the data is a complete word (16 bits).
 
 S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
 
+Note the convenience function i2c_smbus_read_word_swapped is
+available for reads where the two data bytes are the other way
+around. (not smbus compliant)
+
 
 SMBus Write Byte:  i2c_smbus_write_byte_data()
 ==============================================
@@ -108,6 +112,10 @@ specified through the Comm byte.
 
 S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] P
 
+Note the convenience function i2c_smbus_write_word_swapped is
+available for writes where the two data bytes are the other way
+around. (not smbus compliant)
+
 
 SMBus Process Call:  i2c_smbus_process_call()
 =============================================
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index a6c652e..38a21c3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,7 @@
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
 #include <linux/of.h>		/* for struct device_node */
+#include <linux/swab.h>		/* for swab16 */
 
 extern struct bus_type i2c_bus_type;
 extern struct device_type i2c_adapter_type;
@@ -88,6 +89,22 @@ extern s32 i2c_smbus_read_word_data(const struct i2c_client *client,
 				    u8 command);
 extern s32 i2c_smbus_write_word_data(const struct i2c_client *client,
 				     u8 command, u16 value);
+
+static inline s32
+i2c_smbus_read_word_swapped(const struct i2c_client *client, u8 command)
+{
+	s32 value = i2c_smbus_read_word_data(client, command);
+
+	return (value < 0) ? value : swab16(value);
+}
+
+static inline s32
+i2c_smbus_write_word_swapped(const struct i2c_client *client,
+			     u8 command, u16 value)
+{
+	return i2c_smbus_write_word_data(client, command, swab16(value));
+}
+
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_block_data(const struct i2c_client *client,
 				     u8 command, u8 *values);
-- 
1.7.3.4
