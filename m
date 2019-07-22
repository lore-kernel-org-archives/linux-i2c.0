From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/4] rtc: s35390a: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:17 +0200
Message-ID: <20190722172618.4061-4-wsa+renesas@sang-engineering.com>
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/rtc/rtc-s35390a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 84806ff763cf..5826209a3f30 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -450,12 +450,12 @@ static int s35390a_probe(struct i2c_client *client,
 
 	/* This chip uses multiple addresses, use dummy devices for them */
 	for (i = 1; i < 8; ++i) {
-		s35390a->client[i] = i2c_new_dummy(client->adapter,
+		s35390a->client[i] = i2c_new_dummy_device(client->adapter,
 					client->addr + i);
-		if (!s35390a->client[i]) {
+		if (IS_ERR(s35390a->client[i])) {
 			dev_err(dev, "Address %02x unavailable\n",
 				client->addr + i);
-			err = -EBUSY;
+			err = PTR_ERR(s35390a->client[i]);
 			goto exit_dummy;
 		}
 	}
-- 
2.20.1
