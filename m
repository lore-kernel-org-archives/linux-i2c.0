From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] i2c-dev: Improve another size determination in
 i2cdev_ioctl_rdwr()
Date: Fri, 23 Sep 2016 21:45:25 +0200
Message-ID: <9b43145c-7666-c4bb-37de-7d1a9ebea72a@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:60910 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758556AbcIWTpb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 15:45:31 -0400
In-Reply-To: <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 23 Sep 2016 20:45:40 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 6d8226d..a6e35ce 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -256,7 +256,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		return -EINVAL;
 
 	rdwr_pa = memdup_user(rdwr_arg.msgs,
-			      rdwr_arg.nmsgs * sizeof(struct i2c_msg));
+			      rdwr_arg.nmsgs * sizeof(*rdwr_pa));
 	if (IS_ERR(rdwr_pa))
 		return PTR_ERR(rdwr_pa);
 
-- 
2.10.0
