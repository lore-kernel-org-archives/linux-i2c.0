From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] media: i2c: adv7842: drop check because i2c_unregister_device() is NULL safe
Date: Tue, 20 Aug 2019 17:34:41 +0200
Message-ID: <20190820153441.7748-2-wsa+renesas@sang-engineering.com>
References: <20190820153441.7748-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820153441.7748-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/media/i2c/adv7842.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index ffc3d174c4a1..885619841719 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -3351,28 +3351,17 @@ static const struct v4l2_ctrl_config adv7842_ctrl_free_run_color = {
 static void adv7842_unregister_clients(struct v4l2_subdev *sd)
 {
 	struct adv7842_state *state = to_state(sd);
-	if (state->i2c_avlink)
-		i2c_unregister_device(state->i2c_avlink);
-	if (state->i2c_cec)
-		i2c_unregister_device(state->i2c_cec);
-	if (state->i2c_infoframe)
-		i2c_unregister_device(state->i2c_infoframe);
-	if (state->i2c_sdp_io)
-		i2c_unregister_device(state->i2c_sdp_io);
-	if (state->i2c_sdp)
-		i2c_unregister_device(state->i2c_sdp);
-	if (state->i2c_afe)
-		i2c_unregister_device(state->i2c_afe);
-	if (state->i2c_repeater)
-		i2c_unregister_device(state->i2c_repeater);
-	if (state->i2c_edid)
-		i2c_unregister_device(state->i2c_edid);
-	if (state->i2c_hdmi)
-		i2c_unregister_device(state->i2c_hdmi);
-	if (state->i2c_cp)
-		i2c_unregister_device(state->i2c_cp);
-	if (state->i2c_vdp)
-		i2c_unregister_device(state->i2c_vdp);
+	i2c_unregister_device(state->i2c_avlink);
+	i2c_unregister_device(state->i2c_cec);
+	i2c_unregister_device(state->i2c_infoframe);
+	i2c_unregister_device(state->i2c_sdp_io);
+	i2c_unregister_device(state->i2c_sdp);
+	i2c_unregister_device(state->i2c_afe);
+	i2c_unregister_device(state->i2c_repeater);
+	i2c_unregister_device(state->i2c_edid);
+	i2c_unregister_device(state->i2c_hdmi);
+	i2c_unregister_device(state->i2c_cp);
+	i2c_unregister_device(state->i2c_vdp);
 
 	state->i2c_avlink = NULL;
 	state->i2c_cec = NULL;
-- 
2.20.1
