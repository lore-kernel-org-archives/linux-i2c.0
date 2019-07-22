From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/8] media: i2c: ad9389b: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:25:59 +0200
Message-ID: <20190722172604.3572-6-wsa+renesas@sang-engineering.com>
References: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/media/i2c/ad9389b.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ad9389b.c b/drivers/media/i2c/ad9389b.c
index aa8b04cfed0f..1b92048a4a67 100644
--- a/drivers/media/i2c/ad9389b.c
+++ b/drivers/media/i2c/ad9389b.c
@@ -1148,10 +1148,10 @@ static int ad9389b_probe(struct i2c_client *client, const struct i2c_device_id *
 	v4l2_dbg(1, debug, sd, "reg 0x41 0x%x, chip version (reg 0x00) 0x%x\n",
 		 ad9389b_rd(sd, 0x41), state->chip_revision);
 
-	state->edid_i2c_client = i2c_new_dummy(client->adapter, (0x7e>>1));
-	if (state->edid_i2c_client == NULL) {
+	state->edid_i2c_client = i2c_new_dummy_device(client->adapter, (0x7e >> 1));
+	if (IS_ERR(state->edid_i2c_client)) {
 		v4l2_err(sd, "failed to register edid i2c client\n");
-		err = -ENOMEM;
+		err = PTR_ERR(state->edid_i2c_client);
 		goto err_entity;
 	}
 
-- 
2.20.1
