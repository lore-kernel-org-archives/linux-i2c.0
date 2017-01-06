From: John Garry <john.garry@huawei.com>
Subject: [PATCH] i2c: print correct device invalid address
Date: Fri, 6 Jan 2017 19:02:57 +0800
Message-ID: <1483700577-60130-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52007 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933821AbdAFKeZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Jan 2017 05:34:25 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>

In of_i2c_register_device(), when the check for
device address validity fails we print the info.addr,
which has not been assigned properly.

Fix this by printing the actual invalid address.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf9e396..03cfcdd 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1708,7 +1708,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 
 	if (i2c_check_addr_validity(addr, info.flags)) {
 		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-			info.addr, node->full_name);
+			addr, node->full_name);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
1.9.1
