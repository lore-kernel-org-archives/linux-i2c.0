From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH 3/5] gpu: drm: msm: hdmi: hdmi_i2c: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:30:29 +0200
Message-ID: <1470742232-12559-4-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55463 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbcHILao (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 07:30:44 -0400
In-Reply-To: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index de9007e72f4e85..73e20219d431a7 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -243,7 +243,6 @@ void msm_hdmi_i2c_destroy(struct i2c_adapter *i2c)
 
 struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
 {
-	struct drm_device *dev = hdmi->dev;
 	struct hdmi_i2c_adapter *hdmi_i2c;
 	struct i2c_adapter *i2c = NULL;
 	int ret;
@@ -267,10 +266,8 @@ struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
 	i2c->algo = &msm_hdmi_i2c_algorithm;
 
 	ret = i2c_add_adapter(i2c);
-	if (ret) {
-		dev_err(dev->dev, "failed to register hdmi i2c: %d\n", ret);
+	if (ret)
 		goto fail;
-	}
 
 	return i2c;
 
-- 
2.8.1
