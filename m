Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92FC43217
	for <linux-i2c@archiver.kernel.org>; Sat, 19 Nov 2022 00:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiKSAgL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Nov 2022 19:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiKSAff (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Nov 2022 19:35:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1111605B
        for <linux-i2c@vger.kernel.org>; Fri, 18 Nov 2022 15:43:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA9o-0005Xg-RK; Fri, 18 Nov 2022 23:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA9k-0058uB-Uo; Fri, 18 Nov 2022 23:48:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA9j-0000Vx-NI; Fri, 18 Nov 2022 23:48:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
        Ryan Lee <ryan.lee.analog@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Hui Tang <tanghui20@huawei.com>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 602/606] ASoC: max98396: Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:45:36 +0100
Message-Id: <20221118224540.619276-603-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118224540.619276-1-uwe@kleine-koenig.org>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-i2c@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/soc/codecs/max98396.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98396.c b/sound/soc/codecs/max98396.c
index a7b6a23f2cd8..db3de41f10e0 100644
--- a/sound/soc/codecs/max98396.c
+++ b/sound/soc/codecs/max98396.c
@@ -1731,9 +1731,9 @@ static void max98396_supply_disable(void *r)
 	regulator_disable((struct regulator *) r);
 }
 
-static int max98396_i2c_probe(struct i2c_client *i2c,
-			      const struct i2c_device_id *id)
+static int max98396_i2c_probe(struct i2c_client *i2c)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct max98396_priv *max98396 = NULL;
 	int i, ret, reg;
 
@@ -1907,7 +1907,7 @@ static struct i2c_driver max98396_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(max98396_acpi_match),
 		.pm = &max98396_pm,
 	},
-	.probe = max98396_i2c_probe,
+	.probe_new = max98396_i2c_probe,
 	.id_table = max98396_i2c_id,
 };
 
-- 
2.38.1

