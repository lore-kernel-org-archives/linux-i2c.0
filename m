From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH 5/5] gpu: drm: rockchip: inno_hdmi: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:30:31 +0200
Message-ID: <1470742232-12559-6-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Mark Yao <mark.yao@rock-chips.com>, David Airlie <airlied@linux.ie>, Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 006260de9dbd22..566b5634644f82 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -800,7 +800,6 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 
 	ret = i2c_add_adapter(adap);
 	if (ret) {
-		dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
 		devm_kfree(hdmi->dev, i2c);
 		return ERR_PTR(ret);
 	}
-- 
2.8.1
