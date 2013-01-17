From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH 1/4] i2c: i2c-sh_mobile.c: cosmetic: trivially simplify 2 functions
Date: Thu, 17 Jan 2013 10:45:54 +0100
Message-ID: <1358415957-8371-2-git-send-email-g.liakhovetski@gmx.de>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reduce 2 boolean functions from "if (condition) return 1; return 0;" to
"return condition;"

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9411c1b..3b08b4e 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -349,20 +349,14 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 	return ret;
 }
 
-static int sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
+static bool sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
 {
-	if (pd->pos == -1)
-		return 1;
-
-	return 0;
+	return pd->pos == -1;
 }
 
-static int sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
+static bool sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
 {
-	if (pd->pos == (pd->msg->len - 1))
-		return 1;
-
-	return 0;
+	return pd->pos == pd->msg->len - 1;
 }
 
 static void sh_mobile_i2c_get_data(struct sh_mobile_i2c_data *pd,
-- 
1.7.2.5
