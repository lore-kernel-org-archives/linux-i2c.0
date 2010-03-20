From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 24/24] w1/masters: fix dangling pointers
Date: Sat, 20 Mar 2010 15:13:05 +0100
Message-ID: <1269094385-16114-25-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/w1/masters/ds2482.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index e5f7441..b92b1c6 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -484,6 +484,7 @@ exit_w1_remove:
 			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
 	}
 exit_free:
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 exit:
 	return err;
@@ -501,6 +502,7 @@ static int ds2482_remove(struct i2c_client *client)
 	}
 
 	/* Free the memory */
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
-- 
1.7.0
