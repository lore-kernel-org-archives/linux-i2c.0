From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH] i2c/ocores: Fix pointer type mismatch error
Date: Mon, 28 Feb 2011 13:52:32 -0700
Message-ID: <20110228205232.16329.60773.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ocores_i2c_of_probe needs to use a const __be32 type for handing
device tree property values.  This patch fixed the following build
warning:

 CC      drivers/i2c/busses/i2c-ocores.o
  drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_of_probe':
  drivers/i2c/busses/i2c-ocores.c:254: warning: assignment discards qualifiers from pointer target type
  drivers/i2c/busses/i2c-ocores.c:261: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-ocores.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index c2ef5ce..1b46a9d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -249,7 +249,7 @@ static struct i2c_adapter ocores_adapter = {
 static int ocores_i2c_of_probe(struct platform_device* pdev,
 				struct ocores_i2c* i2c)
 {
-	__be32* val;
+	const __be32* val;
 
 	val = of_get_property(pdev->dev.of_node, "regstep", NULL);
 	if (!val) {
