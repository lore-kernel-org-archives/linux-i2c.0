From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC v2 1/4] of: make of_mutex public
Date: Wed,  6 Jan 2016 14:51:22 +0100
Message-ID: <1452088285-6427-2-git-send-email-wsa@the-dreams.de>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we want to use OF_DYNAMIC features outside the of framework, we need
to access this lock.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/of/of_private.h | 1 -
 include/linux/of.h      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 8e882e706cd8c6..f92ec41efb5dfd 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -31,7 +31,6 @@ struct alias_prop {
 	char stem[0];
 };
 
-extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index dd10626a615fb1..acac979063f067 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -32,6 +32,8 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+extern struct mutex of_mutex;
+
 struct property {
 	char	*name;
 	int	length;
-- 
2.1.4

