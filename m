From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 16/16] i2c: scx200_acb: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:32:51 +0900
Message-ID: <019401cf69ad$67eb3440$37c19cc0$%han@samsung.com>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/scx200_acb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index cb66f95..ff3f574 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -431,10 +431,8 @@ static struct scx200_acb_iface *scx200_create_iface(const char *text,
 	struct i2c_adapter *adapter;
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
-	if (!iface) {
-		pr_err("can't allocate memory\n");
+	if (!iface)
 		return NULL;
-	}
 
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
-- 
1.7.10.4
