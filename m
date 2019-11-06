From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 05/12] video: fbdev: matrox: convert to i2c_new_scanned_device
Date: Wed,  6 Nov 2019 10:50:23 +0100
Message-ID: <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. RFC, please comment and/or ack, but don't apply yet.

 drivers/video/fbdev/matrox/i2c-matroxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/matrox/i2c-matroxfb.c b/drivers/video/fbdev/matrox/i2c-matroxfb.c
index 34e2659c3189..e2e4705e3fe0 100644
--- a/drivers/video/fbdev/matrox/i2c-matroxfb.c
+++ b/drivers/video/fbdev/matrox/i2c-matroxfb.c
@@ -191,8 +191,8 @@ static void* i2c_matroxfb_probe(struct matrox_fb_info* minfo) {
 				0x1b, I2C_CLIENT_END
 			};
 
-			i2c_new_probed_device(&m2info->maven.adapter,
-					      &maven_info, addr_list, NULL);
+			i2c_new_scanned_device(&m2info->maven.adapter,
+					       &maven_info, addr_list, NULL);
 		}
 	}
 	return m2info;
-- 
2.20.1
