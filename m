From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 8/8] i2c: img-scb: verify support for requested bit rate
Date: Mon, 27 Jul 2015 12:47:21 +0100
Message-ID: <1437997641-32575-9-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The requested bit rate can be outside the range supported by the driver.
The maximum bit rate this driver supports at the moment is 400Khz.

Return -EINVAL if the bit rate is larger than 400khz.

Maximum speed supported by the driver can be increased to 1Mhz by
adding support for "fast plus mode" in the future.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index bbfee33..07a039c 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1157,6 +1157,12 @@ static int img_i2c_init(struct img_i2c *i2c)
 			break;
 		}
 	}
+	if (i2c->bitrate > timing.max_bitrate) {
+		dev_err(i2c->adap.dev.parent,
+			"requested bitrate (%d) is higher than the max bitrate supported (%d)\n",
+			 i2c->bitrate, timing.max_bitrate);
+		return -EINVAL;
+	}
 
 	/* Find the prescale that would give us that inc (approx delay = 0) */
 	prescale = SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
-- 
1.7.9.5
