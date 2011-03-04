From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] MAX8997/8966 PMIC: compiler warning removed (incompatible
 pointer)
Date: Fri, 04 Mar 2011 16:16:56 +0900
Message-ID: <1299223016-8655-1-git-send-email-myungjoo.ham@samsung.com>
References: <1299221427-4726-3-git-send-email-myungjoo.ham@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1299221427-4726-3-git-send-email-myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/regulator/max8997.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max8997.c b/drivers/regulator/max8997.c
index 30778c5..957063a 100644
--- a/drivers/regulator/max8997.c
+++ b/drivers/regulator/max8997.c
@@ -790,18 +790,27 @@ static struct regulator_ops max8997_fixedstate_ops = {
 	.set_voltage		= max8997_set_voltage_charger_cv,
 };
 
+static int max8997_set_voltage_ldo_wrap(struct regulator_dev *rdev,
+		int min_uV, int max_uV)
+{
+	unsigned dummy;
+
+	return max8997_set_voltage_ldo(rdev, min_uV, max_uV, &dummy);
+}
+
+
 static struct regulator_ops max8997_charger_ops = {
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
 	.disable		= max8997_reg_disable,
 	.get_current_limit	= max8997_get_voltage,
-	.set_current_limit	= max8997_set_voltage_ldo,
+	.set_current_limit	= max8997_set_voltage_ldo_wrap,
 };
 
 static struct regulator_ops max8997_charger_fixedstate_ops = {
 	.is_enabled		= max8997_reg_is_enabled,
 	.get_current_limit	= max8997_get_voltage,
-	.set_current_limit	= max8997_set_voltage_ldo,
+	.set_current_limit	= max8997_set_voltage_ldo_wrap,
 };
 
 #define regulator_desc_ldo(num)		{	\
-- 
1.7.1
