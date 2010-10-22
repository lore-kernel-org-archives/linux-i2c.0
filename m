From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 12/12] hwmon: lis3: Release resources is case
	of failure
Date: Fri, 22 Oct 2010 14:57:34 +0300
Message-ID: <1287748654-2626-13-git-send-email-samu.p.onkalo@nokia.com>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lm-sensors-bounces@lm-sensors.org>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/options/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors/>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: eric.piel@tremplin-utc.net, khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

If lis3lv02d_init_device fails, HW resources were not released
properly. In case of failure call release_resources if available.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d_i2c.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 61c109b..94d5bde 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -161,7 +161,12 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
 
 	if (lis3_dev.reg_ctrl)
 		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
+
+	if (ret == 0)
+		return 0;
 fail:
+	if (pdata && pdata->release_resources)
+		pdata->release_resources();
 	return ret;
 }
 
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
