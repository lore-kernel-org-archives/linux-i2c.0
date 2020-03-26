From: Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: About enabling async suspend/resume on i2c devices
Date: Thu, 26 Mar 2020 16:36:10 +0100
Message-ID: <e766f6cc821cfc57246f4b18eac03a29d46641ac.camel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZPgT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 26 Mar 2020 11:36:19 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: hdegoede@redhat.com

Hi all,

I came across this patch: https://marc.info/?l=linux-i2c&m=153270824822381&w=2
and I'm evaluating if it's a good candidate for upstreaming:

----------------------------------------------------------------------
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb2b966..3382bb7e1dcc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -749,6 +749,7 @@  i2c_new_device(struct i2c_adapter *adap, struct
i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
----------------------------------------------------------------------

Was this ever tested on something other than a Chromebook? Reading the thread I
got the impression that the patch was intended for Chromebooks only. Wouldn't
adding that line to i2c_new_device affect all i2c clients in every platform?

Thanks!

Best,
Ricardo
