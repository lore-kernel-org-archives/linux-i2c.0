From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mux: pinctrl: fix indentation for better readability
Date: Fri, 22 Apr 2016 15:44:07 +0200
Message-ID: <1461332647-11227-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55463 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbcDVNo4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Apr 2016 09:44:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

smatch rightfully says:

drivers/i2c/muxes/i2c-mux-pinctrl.c:175 i2c_mux_pinctrl_probe() warn: inconsistent indenting

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 1b8dc711815ed3..f4e62f4a50cc42 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -172,13 +172,13 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < mux->pdata->bus_count; i++) {
 		mux->states[i] = pinctrl_lookup_state(mux->pinctrl,
 						mux->pdata->pinctrl_states[i]);
-			if (IS_ERR(mux->states[i])) {
-				ret = PTR_ERR(mux->states[i]);
-				dev_err(&pdev->dev,
-					"Cannot look up pinctrl state %s: %d\n",
-					mux->pdata->pinctrl_states[i], ret);
-				goto err;
-			}
+		if (IS_ERR(mux->states[i])) {
+			ret = PTR_ERR(mux->states[i]);
+			dev_err(&pdev->dev,
+				"Cannot look up pinctrl state %s: %d\n",
+				mux->pdata->pinctrl_states[i], ret);
+			goto err;
+		}
 	}
 	if (mux->pdata->pinctrl_state_idle) {
 		mux->state_idle = pinctrl_lookup_state(mux->pinctrl,
-- 
2.7.0
