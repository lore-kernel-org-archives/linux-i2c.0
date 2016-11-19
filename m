From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: i2c-mux-pca954x: fix deselect enabling for device-tree
Date: Sat, 19 Nov 2016 10:48:38 +0100
Message-ID: <1479548918-21006-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alex Hemme <ahemme@cisco.com>, Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa-dev@sang-engineering.com>, MakeB <mabnhdev@gmail.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org, Ziyang Wu <ziywu@cisco.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

From: Alex Hemme <ahemme@cisco.com>

Deselect functionality can be ignored for device-trees with
"i2c-mux-idle-disconnect" entries if no platform_data is available.
By enabling the deselect functionality outside the platform_data
block the logic works as it did in previous kernels.

Fixes: 7fcac9807175 ("i2c: i2c-mux-pca954x: convert to use an explicit i2c mux core")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Alex Hemme <ahemme@cisco.com>
Signed-off-by: Ziyang Wu <ziywu@cisco.com>
[touched up a few minor issues /peda]
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi!

I got this regression report and patch off-list, and am now
feeding it on to the appropriate places.

I would like to thank Alex (and team?) for finding the bug and
providing a fix for the bug that I introduced.

Cheers,
Peter

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 1091346f2480..8bc3d36d2837 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -268,9 +268,9 @@ static int pca954x_probe(struct i2c_client *client,
 				/* discard unconfigured channels */
 				break;
 			idle_disconnect_pd = pdata->modes[num].deselect_on_exit;
-			data->deselect |= (idle_disconnect_pd
-					   || idle_disconnect_dt) << num;
 		}
+		data->deselect |= (idle_disconnect_pd ||
+				   idle_disconnect_dt) << num;
 
 		ret = i2c_mux_add_adapter(muxc, force, num, class);
 
-- 
2.1.4
