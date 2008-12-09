From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/33] i2c: Make static
Date: Tue, 09 Dec 2008 19:41:20 +0100
Message-ID: <493EBBD0.6070201@gmail.com>
References: <493EA286.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <493EA286.7080500-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c6a63f4..1049615 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1699,7 +1699,8 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
  * This executes the SMBus "process call" protocol, returning negative errno
  * else a 16-bit unsigned "word" received from the device.
  */
-s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
+static s32 i2c_smbus_process_call(struct i2c_client *client, u8 command,
+		u16 value)
 {
 	union i2c_smbus_data data;
 	int status;
