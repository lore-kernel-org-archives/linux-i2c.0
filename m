From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH] video: limit stack usage of ir-kbd-i2c.c
Date: Mon, 25 Feb 2008 21:51:00 +0100
Message-ID: <20080225205055.GA27455@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759591AbYBYUwX@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org, video4linux-list@redhat.com
List-Id: linux-i2c@vger.kernel.org

ir_probe allocated struct i2c_client on stack;
it's pretty big structure, so allocate it with kzalloc

make checkstack output without this patch:
x059d ir_probe [ir-kbd-i2c]:                           1000

compile tested only

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/ir-kbd-i2c.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
index 9851987..aec122f 100644
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -510,9 +510,9 @@ static int ir_probe(struct i2c_adapter *adap)
 	static const int probe_cx88[] = { 0x18, 0x6b, 0x71, -1 };
 	static const int probe_cx23885[] = { 0x6b, -1 };
 	const int *probe = NULL;
-	struct i2c_client c;
+	struct i2c_client *c;
 	unsigned char buf;
-	int i,rc;
+	int i, rc;
 
 	switch (adap->id) {
 	case I2C_HW_B_BT848:
@@ -537,19 +537,23 @@ static int ir_probe(struct i2c_adapter *adap)
 	if (NULL == probe)
 		return 0;
 
-	memset(&c,0,sizeof(c));
-	c.adapter = adap;
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	c->adapter = adap;
 	for (i = 0; -1 != probe[i]; i++) {
-		c.addr = probe[i];
-		rc = i2c_master_recv(&c,&buf,0);
+		c->addr = probe[i];
+		rc = i2c_master_recv(c, &buf, 0);
 		dprintk(1,"probe 0x%02x @ %s: %s\n",
 			probe[i], adap->name,
 			(0 == rc) ? "yes" : "no");
 		if (0 == rc) {
-			ir_attach(adap,probe[i],0,0);
+			ir_attach(adap, probe[i], 0, 0);
 			break;
 		}
 	}
+	kfree(c);
 	return 0;
 }
 
-- 
1.5.3.7
