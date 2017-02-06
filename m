From: Qi Hou <qi.hou@windriver.com>
Subject: [PATCH 1/3] of: fix of_node leak caused in of_find_node_opts_by_path
Date: Mon, 6 Feb 2017 12:55:19 +0800
Message-ID: <1486356919-97176-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: peda@axentia.se, stable@vger.kernel.org, robh@kernel.org, linux-i2c@vger.kernel.org
Cc: leif.lindholm@linaro.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, bruce.ashfield@windriver.com, paul.gortmaker@windriver.com, xiao.zhang@windriver.com
List-Id: linux-i2c@vger.kernel.org

During stepping down the tree, parent node is gotten first and its refcount is
increased with of_node_get() in __of_get_next_child(). Since it just being used
as tmp node, its refcount must be decreased with of_node_put() after traversing
its child nodes.

Or, its refcount will never be descreased to ZERO, then it will never be freed,
as well as other related memory blocks.

To fix this, decrease refcount of parent with of_node_put() after
__of_find_node_by_path().

Signed-off-by: Qi Hou <qi.hou@windriver.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4bea3c..ce8206f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -842,8 +842,11 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 	if (!np)
 		np = of_node_get(of_root);
 	while (np && *path == '/') {
+		struct device_node *tmp = np;
+
 		path++; /* Increment past '/' delimiter */
 		np = __of_find_node_by_path(np, path);
+		of_node_put(tmp);
 		path = strchrnul(path, '/');
 		if (separator && separator < path)
 			break;
-- 
1.9.1
