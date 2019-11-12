From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 1/3] i2c: use void pointers for supplying data for reads and writes
Date: Tue, 12 Nov 2019 12:31:30 -0800
Message-ID: <20191112203132.163306-2-dmitry.torokhov@gmail.com>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.orgi, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>linux-iio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There is no need to force users of i2c_master_send()/i2c_master_recv()
and other i2c read/write bulk data API to cast everything into u8 pointers.
While everything can be considered byte stream, the drivers are usually
work with more structured data.

Let's switch the APIs to accept [const] void pointers to cut amount of
casting needed.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Changes in v3:
- addressed Luca's comments
- added Jonathan's Acked-by

Changes in v2:
- adjusted max1363 to the new i2c_master_send/recv signatures

 drivers/i2c/i2c-core-base.c  |  2 +-
 drivers/i2c/i2c-core-smbus.c | 17 +++++++++--------
 drivers/iio/adc/max1363.c    | 14 ++++++++------
 include/linux/i2c.h          | 28 +++++++++++++++-------------
 4 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 6a5183cffdfc3..aeb4201ef55e4 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2065,7 +2065,7 @@ EXPORT_SYMBOL(i2c_transfer);
  *
  * Returns negative errno, or else the number of bytes transferred.
  */
-int i2c_transfer_buffer_flags(const struct i2c_client *client, char *buf,
+int i2c_transfer_buffer_flags(const struct i2c_client *client, void *buf,
 			      int count, u16 flags)
 {
 	int ret;
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 3ac426a8ab5ab..f8708409b4dbc 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -213,7 +213,7 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
  * mechanism (I2C_M_RECV_LEN) which may not be implemented.
  */
 s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
-			      u8 *values)
+			      void *values)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -240,7 +240,7 @@ EXPORT_SYMBOL(i2c_smbus_read_block_data);
  * else zero on success.
  */
 s32 i2c_smbus_write_block_data(const struct i2c_client *client, u8 command,
-			       u8 length, const u8 *values)
+			       u8 length, const void *values)
 {
 	union i2c_smbus_data data;
 
@@ -256,7 +256,7 @@ EXPORT_SYMBOL(i2c_smbus_write_block_data);
 
 /* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
-				  u8 length, u8 *values)
+				  u8 length, void *values)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -276,7 +276,7 @@ s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client, u8 command,
-				   u8 length, const u8 *values)
+				   u8 length, const void *values)
 {
 	union i2c_smbus_data data;
 
@@ -628,8 +628,9 @@ EXPORT_SYMBOL(__i2c_smbus_xfer);
  * transfer.
  */
 s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
-					      u8 command, u8 length, u8 *values)
+					      u8 command, u8 length, void *values)
 {
+	u8 *bytes = values;
 	u8 i = 0;
 	int status;
 
@@ -647,8 +648,8 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 			status = i2c_smbus_read_word_data(client, command + i);
 			if (status < 0)
 				return status;
-			values[i] = status & 0xff;
-			values[i + 1] = status >> 8;
+			bytes[i] = status & 0xff;
+			bytes[i + 1] = status >> 8;
 			i += 2;
 		}
 	}
@@ -657,7 +658,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 		status = i2c_smbus_read_byte_data(client, command + i);
 		if (status < 0)
 			return status;
-		values[i] = status;
+		bytes[i] = status;
 		i++;
 	}
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e7..48ed76a0e83d4 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -182,9 +182,9 @@ struct max1363_state {
 	struct regulator		*vref;
 	u32				vref_uv;
 	int				(*send)(const struct i2c_client *client,
-						const char *buf, int count);
+						const void *buf, int count);
 	int				(*recv)(const struct i2c_client *client,
-						char *buf, int count);
+						void *buf, int count);
 };
 
 #define MAX1363_MODE_SINGLE(_num, _mask) {				\
@@ -310,27 +310,29 @@ static const struct max1363_mode
 	return NULL;
 }
 
-static int max1363_smbus_send(const struct i2c_client *client, const char *buf,
+static int max1363_smbus_send(const struct i2c_client *client, const void *buf,
 		int count)
 {
+	const u8 *data = buf;
 	int i, err;
 
 	for (i = err = 0; err == 0 && i < count; ++i)
-		err = i2c_smbus_write_byte(client, buf[i]);
+		err = i2c_smbus_write_byte(client, data[i]);
 
 	return err ? err : count;
 }
 
-static int max1363_smbus_recv(const struct i2c_client *client, char *buf,
+static int max1363_smbus_recv(const struct i2c_client *client, void *buf,
 		int count)
 {
+	u8 *data = buf;
 	int i, ret;
 
 	for (i = 0; i < count; ++i) {
 		ret = i2c_smbus_read_byte(client);
 		if (ret < 0)
 			return ret;
-		buf[i] = ret;
+		data[i] = ret;
 	}
 
 	return count;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index aaf57d9b41dbb..64cf92e191aa8 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -51,7 +51,7 @@ struct property_entry;
  * @count must be be less than 64k since msg.len is u16.
  */
 extern int i2c_transfer_buffer_flags(const struct i2c_client *client,
-				     char *buf, int count, u16 flags);
+				     void *buf, int count, u16 flags);
 
 /**
  * i2c_master_recv - issue a single I2C message in master receive mode
@@ -62,7 +62,7 @@ extern int i2c_transfer_buffer_flags(const struct i2c_client *client,
  * Returns negative errno, or else the number of bytes read.
  */
 static inline int i2c_master_recv(const struct i2c_client *client,
-				  char *buf, int count)
+				  void *buf, int count)
 {
 	return i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
 };
@@ -77,7 +77,7 @@ static inline int i2c_master_recv(const struct i2c_client *client,
  * Returns negative errno, or else the number of bytes read.
  */
 static inline int i2c_master_recv_dmasafe(const struct i2c_client *client,
-					  char *buf, int count)
+					  void *buf, int count)
 {
 	return i2c_transfer_buffer_flags(client, buf, count,
 					 I2C_M_RD | I2C_M_DMA_SAFE);
@@ -92,9 +92,10 @@ static inline int i2c_master_recv_dmasafe(const struct i2c_client *client,
  * Returns negative errno, or else the number of bytes written.
  */
 static inline int i2c_master_send(const struct i2c_client *client,
-				  const char *buf, int count)
+				  const void *buf, int count)
 {
-	return i2c_transfer_buffer_flags(client, (char *)buf, count, 0);
+	return i2c_transfer_buffer_flags(client, (void *)buf /* const cast */,
+					 count, 0);
 };
 
 /**
@@ -107,10 +108,10 @@ static inline int i2c_master_send(const struct i2c_client *client,
  * Returns negative errno, or else the number of bytes written.
  */
 static inline int i2c_master_send_dmasafe(const struct i2c_client *client,
-					  const char *buf, int count)
+					  const void *buf, int count)
 {
-	return i2c_transfer_buffer_flags(client, (char *)buf, count,
-					 I2C_M_DMA_SAFE);
+	return i2c_transfer_buffer_flags(client, (void *)buf /* const cast */,
+					 count, I2C_M_DMA_SAFE);
 };
 
 /* Transfer num messages.
@@ -166,18 +167,19 @@ i2c_smbus_write_word_swapped(const struct i2c_client *client,
 
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_block_data(const struct i2c_client *client,
-				     u8 command, u8 *values);
+				     u8 command, void *values);
 extern s32 i2c_smbus_write_block_data(const struct i2c_client *client,
-				      u8 command, u8 length, const u8 *values);
+				      u8 command, u8 length,
+				      const void *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
-					 u8 command, u8 length, u8 *values);
+					 u8 command, u8 length, void *values);
 extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  u8 command, u8 length,
-					  const u8 *values);
+					  const void *values);
 extern s32
 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
-					  u8 command, u8 length, u8 *values);
+					  u8 command, u8 length, void *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
 #endif /* I2C */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
