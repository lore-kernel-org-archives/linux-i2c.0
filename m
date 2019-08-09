From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] media: i2c: adv7842: convert to i2c_new_dummy_device
Date: Fri,  9 Aug 2019 21:04:06 +0200
Message-ID: <20190809190407.12616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the to-be-removed i2c_new_dummy() to
i2c_new_dummy_device(). So, we now get an ERRPTR which we use in error
handling by printing the error code. To keep the rest of the driver
logic as is, internally a NULL ptr is still kept.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/media/i2c/adv7842.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 11ab2df02dc7..ffc3d174c4a1 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -3400,9 +3400,12 @@ static struct i2c_client *adv7842_dummy_client(struct v4l2_subdev *sd, const cha
 		return NULL;
 	}
 
-	cp = i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1);
-	if (!cp)
-		v4l2_err(sd, "register %s on i2c addr 0x%x failed\n", desc, addr);
+	cp = i2c_new_dummy_device(client->adapter, io_read(sd, io_reg) >> 1);
+	if (IS_ERR(cp)) {
+		v4l2_err(sd, "register %s on i2c addr 0x%x failed with %ld\n",
+			 desc, addr, PTR_ERR(cp));
+		cp = NULL;
+	}
 
 	return cp;
 }
-- 
2.20.1
