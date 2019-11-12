From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 3/3] i2c: smbus: switch from loops to memcpy
Date: Tue, 12 Nov 2019 12:31:32 -0800
Message-ID: <20191112203132.163306-4-dmitry.torokhov@gmail.com>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.orgi, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

When copying memory from one buffer to another, instead of open-coding
loops with byte-by-byte copies let's use memcpy() which might be a bit
faster and makes intent more clear.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Changes in v3:
- new patch using memcpy() for moving data around

 drivers/i2c/i2c-core-smbus.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 7b4e2270eeda1..bbafdd3b1b114 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -397,8 +397,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			}
 
 			i2c_smbus_try_get_dmabuf(&msg[0], command);
-			for (i = 1; i < msg[0].len; i++)
-				msg[0].buf[i] = data->block[i - 1];
+			memcpy(msg[0].buf + 1, data->block, msg[0].len - 1);
 		}
 		break;
 	case I2C_SMBUS_BLOCK_PROC_CALL:
@@ -413,8 +412,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 
 		msg[0].len = data->block[0] + 2;
 		i2c_smbus_try_get_dmabuf(&msg[0], command);
-		for (i = 1; i < msg[0].len; i++)
-			msg[0].buf[i] = data->block[i - 1];
+		memcpy(msg[0].buf + 1, data->block, msg[0].len - 1);
 
 		msg[1].flags |= I2C_M_RECV_LEN;
 		msg[1].len = 1; /* block length will be added by
@@ -436,8 +434,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			msg[0].len = data->block[0] + 1;
 
 			i2c_smbus_try_get_dmabuf(&msg[0], command);
-			for (i = 1; i <= data->block[0]; i++)
-				msg[0].buf[i] = data->block[i];
+			memcpy(msg[0].buf + 1, data->block + 1, data->block[0]);
 		}
 		break;
 	default:
@@ -489,13 +486,11 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			data->word = get_unaligned_le16(msgbuf1);
 			break;
 		case I2C_SMBUS_I2C_BLOCK_DATA:
-			for (i = 0; i < data->block[0]; i++)
-				data->block[i + 1] = msg[1].buf[i];
+			memcpy(data->block + 1, msg[1].buf, data->block[0]);
 			break;
 		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_BLOCK_PROC_CALL:
-			for (i = 0; i < msg[1].buf[0] + 1; i++)
-				data->block[i] = msg[1].buf[i];
+			memcpy(data->block, msg[1].buf, msg[1].buf[0] + 1);
 			break;
 		}
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
