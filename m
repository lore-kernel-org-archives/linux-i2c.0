Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10FC63697
	for <linux-i2c@archiver.kernel.org>; Tue, 24 Nov 2020 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639F020758
	for <linux-i2c@archiver.kernel.org>; Tue, 24 Nov 2020 00:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8oaOq18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgKXAbx (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgKXAbw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Nov 2020 19:31:52 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4AC0613CF
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2020 16:31:52 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ec16so9849982qvb.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2020 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jkAP25FjStoJGK6M01SST7TUndS2I2dyhF9CMOnR7Ew=;
        b=Q8oaOq18MdRnQKO/8qbIKDxvNl6SF0HMdFz0KyiD2s0vyI5rb3yoe60zm1mMaMoMUE
         tI4FQCAeLfltmuRjioQj9STKuWlOp86kC5VLsenY7SbQ4wZkvFEAW+rv7vPJS0jQFNlz
         nnA9lZWx5EQHOd7kH843qXDPjOLv7mzsGdREIMyiUZVYkKPKCqvN8rIZjMwpRFGX+Gc+
         HwwJrS9DyBlZORulw0YZLwztkANTHv2IQreQex0Nuy13kU97ocgFpHIklDxhJ6YtzuTa
         TEJ89vPO99JtXDgw+198wS/Lh25CYZNHFAgW42/aNg42QRxKU+4QH8PwnGIVQv6H6GxD
         n/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jkAP25FjStoJGK6M01SST7TUndS2I2dyhF9CMOnR7Ew=;
        b=nh/u/GSzj7VCe1ymz7H5q51HCNGf1Lh1HKzbH6dxmkWS7S35P4xvIFak0cfnnZ8qyE
         GO5MMUNPR6U2CF2GXEs/FuPIU7wDMBUxUVGizFJVlJkRO8Q+DwNTyXSXVlivyNA+ydyJ
         XkdcUeXt1n6noWQr40EzCjb9YMoMgFpO0YBGQIRzKHn3zGRXQA0l7eI20+AYt6eJVfmi
         i0Vu3i0eI4sN6YNmMzz6vC2U68svBnigSZtedHlf4r9OB2aasQuWN2Zradu/mTsF1lX1
         vsujfbRZKukw1EO6JAClKQw8BoRHBemgEXQT05nJopqUQCwSLbagP5+MkSzQ/gib8vx2
         ZUnQ==
X-Gm-Message-State: AOAM532V+eZuPdqjxGyd8Y7LkKVcsDAYKGsPiLUxFxFoTXwwe2YhIu26
        r4sPc71haf/24Y8Tl/SovbyJ/eHUh//6+g==
X-Google-Smtp-Source: ABdhPJx8FZ4GZGV0cFsgbVI2U/SSx50mA4XAzjEF6CX7VvlvabIlIWFOyJNVk1HdzrWI64V4Wq6enw==
X-Received: by 2002:a0c:f9c8:: with SMTP id j8mr2257087qvo.17.1606177911733;
        Mon, 23 Nov 2020 16:31:51 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id t56sm10244348qth.27.2020.11.23.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:31:51 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     wsa@kernel.org
Cc:     shawnguo@kernel.org, linux-i2c@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] i2c: mxs: Remove unneeded platform_device_id
Date:   Mon, 23 Nov 2020 21:28:49 -0300
Message-Id: <20201124002849.28397-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The i2c-mxs driver only runs on DT-platform and there is no
need to use the platform_device_id structure to pass the driver
data.

Get rid of it to make the code simpler.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/i2c/busses/i2c-mxs.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index c4b08a924461..f97243f02231 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -781,28 +781,15 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
-static const struct platform_device_id mxs_i2c_devtype[] = {
-	{
-		.name = "imx23-i2c",
-		.driver_data = MXS_I2C_V1,
-	}, {
-		.name = "imx28-i2c",
-		.driver_data = MXS_I2C_V2,
-	}, { /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, mxs_i2c_devtype);
-
 static const struct of_device_id mxs_i2c_dt_ids[] = {
-	{ .compatible = "fsl,imx23-i2c", .data = &mxs_i2c_devtype[0], },
-	{ .compatible = "fsl,imx28-i2c", .data = &mxs_i2c_devtype[1], },
+	{ .compatible = "fsl,imx23-i2c", .data = (void *)MXS_I2C_V1, },
+	{ .compatible = "fsl,imx28-i2c", .data = (void *)MXS_I2C_V2, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
 
 static int mxs_i2c_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-				of_match_device(mxs_i2c_dt_ids, &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
@@ -812,10 +799,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_id) {
-		const struct platform_device_id *device_id = of_id->data;
-		i2c->dev_type = device_id->driver_data;
-	}
+	i2c->dev_type = (enum mxs_i2c_devtype)of_device_get_match_data(&pdev->dev);
 
 	i2c->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c->regs))
-- 
2.17.1

