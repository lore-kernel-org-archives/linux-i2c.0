From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 1/2] drivers/macintosh: Remove obsolete cleanup for clientdata
Date: Tue, 21 May 2013 20:45:40 +0200
Message-ID: <1369161945-26671-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/macintosh/windfarm_smu_sat.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index d87f5ee..ad6223e 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -343,7 +343,6 @@ static int wf_sat_remove(struct i2c_client *client)
 		wf_unregister_sensor(&sens->sens);
 	}
 	sat->i2c = NULL;
-	i2c_set_clientdata(client, NULL);
 	kref_put(&sat->ref, wf_sat_release);
 
 	return 0;
-- 
1.7.10.4
