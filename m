From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/2] i2c: meson: add gxbb compatible string
Date: Wed, 14 Sep 2016 11:49:16 +0200
Message-ID: <1473846557-18123-2-git-send-email-jbrunet@baylibre.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37597 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755834AbcINJt2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Sep 2016 05:49:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id c131so19586607wmh.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Sep 2016 02:49:27 -0700 (PDT)
In-Reply-To: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/i2c/busses/i2c-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 76e28980904f..30977e31cd98 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -473,6 +473,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
 
 static const struct of_device_id meson_i2c_match[] = {
 	{ .compatible = "amlogic,meson6-i2c" },
+	{ .compatible = "amlogic,meson-gxbb-i2c" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, meson_i2c_match);
-- 
2.7.4
