Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15050C433EF
	for <linux-i2c@archiver.kernel.org>; Thu,  3 Mar 2022 12:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiCCMod (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiCCMoc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Mar 2022 07:44:32 -0500
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 04:43:46 PST
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD71117C85
        for <linux-i2c@vger.kernel.org>; Thu,  3 Mar 2022 04:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646311422;
        bh=2mTqmg1W9dS0Kv/L7soH7R821Fj9eiYWYXJ3eGCvI9M=;
        h=From:To:Cc:Subject:Date;
        b=mlWvuDcfv4D5VP+9NYeqfBVBk/SDZPzjLBNIWZGVz4xwOKsTA5zQ02dIcSnKT6mas
         vYWbz0sSFUE5ONLlIM5RRqicWVSyJpSOx7qtOVQdVR3jcoXwmDMfsKq2E8GKqNwevk
         mNnY22ZZdlfIVeflR7stUnpvppLtIlCAHkNHzwho=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id A153102B; Thu, 03 Mar 2022 20:40:21 +0800
X-QQ-mid: xmsmtpt1646311221ts9xpavs0
Message-ID: <tencent_190A7366EE04872C45417894D2D33F240806@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieskBkOQTC34GkjTtKFjnqAHbO7jTmPOdIcJoSGaezNK0TEBMRHs
         YYcz+lzJoRrC/rHx5sTHDkeORDBya205PJhtKQFDbxUhGqQlsD640Ck2lA7Lh+F4VNjRTum9MGt9
         zicMXBkOOZ4pYMQddG5lSG3wVyVlVt3ByV5Q7wjXQZkXz+c+ue17Q0GhxAd1iM9oAKGdYPuf3Hg/
         Xi7PVekZsxGTWYbOOnc6oLYo1zAcr6ms4YgL4qnplgaiXdeI5dukTkGgkt4cYGNuvfOdD4D0mk7w
         aYZL/fo55eXSVTBk4ad+Rad13h0J7VMBfEQDDY8J3JbydIHGXZV3/in09S52lndaQXzaom3zb0b2
         gGEGRkzBJxOy67GswFBIKdWG2pMWtnC3P8wHUFziY0h3HmwtjY0KxFPt4wN2pJGS+EcpQW5RfRGd
         zP+eL7DJvCcvyKVLlZg+TvMPBUgJB/Fieb3A/BhUvZrEzPaKkpFtO5fAx6rhUnZp8+iOz097fta6
         UZmt8voNzBTgydJI0S5Aqgqz57F7l12MtU+Fgh5PBQMXa8GkK/3xAtfDZSbKEYhky/3rrXN8gNsA
         wzoPDw7QflYrwtYVu0chHF12+vJZD6UIZRjsZVVxAPDo1RZsTrmJjVsZiBt8e7LAgzYJ1CnJdYbn
         p2cUn1GpRIn/H26Eo5tJGm1fMXtTTpAmR4a/K1OVOISVKqufl9izDxOTfrWQMlJo0VvhaRuElCFY
         aZn2FHEVh/wxbYyguvi+4tzpZQo3BXuq8X/dG4t+7RhY5dgPZI7BdHCZUfyZtR1jKa/uueDmBoaj
         ehcJesVJYM/6zWIFc1z7bkuLD52xdaYE5Awa1TLqObXd2O6iwH0WuclE+tjLZzagMuQQzpHlzC5W
         6rO2xT9GDsvCWlcF8iGPUyPFebI4KcW08/yVQI3LBk/+ojlhQegDSTXz2Mp6jblG9PYUbdWFcX
From:   xkernel.wang@foxmail.com
To:     wsa+renesas@sang-engineering.com, peda@axentia.se
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()
Date:   Thu,  3 Mar 2022 20:39:14 +0800
X-OQ-MSGID: <20220303123914.4469-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kstrdup() returns pointer to allocated string on success,
NULL on failure. So it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 5365199..3203361 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -243,6 +243,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
-- 
