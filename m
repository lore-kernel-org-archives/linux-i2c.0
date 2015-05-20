From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/6] paride: use new parport device model
Date: Wed, 20 May 2015 20:57:01 +0530
Message-ID: <1432135622-8288-6-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Modify paride driver to use the new parallel port device model.

Tested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

One change after testing by Alan, par_cb is made a local variable
instead of a global one.

 drivers/block/paride/paride.c | 57 ++++++++++++++++++++++++++++++++++++++-----
 drivers/block/paride/paride.h |  2 ++
 drivers/block/paride/pcd.c    |  9 +++++++
 drivers/block/paride/pd.c     | 12 ++++++++-
 drivers/block/paride/pf.c     |  7 ++++++
 drivers/block/paride/pg.c     |  8 ++++++
 drivers/block/paride/pt.c     |  8 ++++++
 7 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/block/paride/paride.c b/drivers/block/paride/paride.c
index 48c50f1..0e28799 100644
--- a/drivers/block/paride/paride.c
+++ b/drivers/block/paride/paride.c
@@ -30,6 +30,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>	/* TASK_* */
 #include <linux/parport.h>
+#include <linux/slab.h>
 
 #include "paride.h"
 
@@ -244,17 +245,19 @@ void paride_unregister(PIP * pr)
 
 EXPORT_SYMBOL(paride_unregister);
 
-static int pi_register_parport(PIA * pi, int verbose)
+static int pi_register_parport(PIA *pi, int verbose, int unit)
 {
 	struct parport *port;
+	struct pardev_cb par_cb;
 
 	port = parport_find_base(pi->port);
 	if (!port)
 		return 0;
-
-	pi->pardev = parport_register_device(port,
-					     pi->device, NULL,
-					     pi_wake_up, NULL, 0, (void *) pi);
+	memset(&par_cb, 0, sizeof(par_cb));
+	par_cb.wakeup = pi_wake_up;
+	par_cb.private = (void *)pi;
+	pi->pardev = parport_register_dev_model(port, pi->device, &par_cb,
+						unit);
 	parport_put_port(port);
 	if (!pi->pardev)
 		return 0;
@@ -311,7 +314,7 @@ static int pi_probe_unit(PIA * pi, int unit, char *scratch, int verbose)
 		e = pi->proto->max_units;
 	}
 
-	if (!pi_register_parport(pi, verbose))
+	if (!pi_register_parport(pi, verbose, s))
 		return 0;
 
 	if (pi->proto->test_port) {
@@ -432,3 +435,45 @@ int pi_init(PIA * pi, int autoprobe, int port, int mode,
 }
 
 EXPORT_SYMBOL(pi_init);
+
+static int pi_probe(struct pardevice *par_dev)
+{
+	struct device_driver *drv = par_dev->dev.driver;
+	int len = strlen(drv->name);
+
+	if (strncmp(par_dev->name, drv->name, len))
+		return -ENODEV;
+
+	return 0;
+}
+
+void *pi_register_driver(char *name)
+{
+	struct parport_driver *parp_drv;
+	int ret;
+
+	parp_drv = kzalloc(sizeof(*parp_drv), GFP_KERNEL);
+	if (!parp_drv)
+		return NULL;
+
+	parp_drv->name = name;
+	parp_drv->probe = pi_probe;
+	parp_drv->devmodel = true;
+
+	ret = parport_register_driver(parp_drv);
+	if (ret) {
+		kfree(parp_drv);
+		return NULL;
+	}
+	return (void *)parp_drv;
+}
+EXPORT_SYMBOL(pi_register_driver);
+
+void pi_unregister_driver(void *_drv)
+{
+	struct parport_driver *drv = _drv;
+
+	parport_unregister_driver(drv);
+	kfree(drv);
+}
+EXPORT_SYMBOL(pi_unregister_driver);
diff --git a/drivers/block/paride/paride.h b/drivers/block/paride/paride.h
index 2bddbf4..ddb9e58 100644
--- a/drivers/block/paride/paride.h
+++ b/drivers/block/paride/paride.h
@@ -165,6 +165,8 @@ typedef struct pi_protocol PIP;
 
 extern int paride_register( PIP * );
 extern void paride_unregister ( PIP * );
+void *pi_register_driver(char *);
+void pi_unregister_driver(void *);
 
 #endif /* __DRIVERS_PARIDE_H__ */
 /* end of paride.h */
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 3b7c9f1..9336236 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -221,6 +221,7 @@ static int pcd_busy;		/* request being processed ? */
 static int pcd_sector;		/* address of next requested sector */
 static int pcd_count;		/* number of blocks still to do */
 static char *pcd_buf;		/* buffer for request in progress */
+static void *par_drv;		/* reference of parport driver */
 
 /* kernel glue structures */
 
@@ -690,6 +691,12 @@ static int pcd_detect(void)
 	printk("%s: %s version %s, major %d, nice %d\n",
 	       name, name, PCD_VERSION, major, nice);
 
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		return -1;
+	}
+
 	k = 0;
 	if (pcd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
 		cd = pcd;
@@ -723,6 +730,7 @@ static int pcd_detect(void)
 	printk("%s: No CD-ROM drive found\n", name);
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
 		put_disk(cd->disk);
+	pi_unregister_driver(par_drv);
 	return -1;
 }
 
@@ -984,6 +992,7 @@ static void __exit pcd_exit(void)
 	}
 	blk_cleanup_queue(pcd_queue);
 	unregister_blkdev(major, name);
+	pi_unregister_driver(par_drv);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index dbb4da1..b9242d7 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -247,6 +247,8 @@ static char *pd_errs[17] = { "ERR", "INDEX", "ECC", "DRQ", "SEEK", "WRERR",
 	"IDNF", "MC", "UNC", "???", "TMO"
 };
 
+static void *par_drv;		/* reference of parport driver */
+
 static inline int status_reg(struct pd_unit *disk)
 {
 	return pi_read_regr(disk->pi, 1, 6);
@@ -872,6 +874,12 @@ static int pd_detect(void)
 			pd_drive_count++;
 	}
 
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		return -1;
+	}
+
 	if (pd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
 		disk = pd;
 		if (pi_init(disk->pi, 1, -1, -1, -1, -1, -1, pd_scratch,
@@ -902,8 +910,10 @@ static int pd_detect(void)
 			found = 1;
 		}
 	}
-	if (!found)
+	if (!found) {
 		printk("%s: no valid drive found\n", name);
+		pi_unregister_driver(par_drv);
+	}
 	return found;
 }
 
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 9a15fd3..7a7d977 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -264,6 +264,7 @@ static int pf_cmd;		/* current command READ/WRITE */
 static struct pf_unit *pf_current;/* unit of current request */
 static int pf_mask;		/* stopper for pseudo-int */
 static char *pf_buf;		/* buffer for request in progress */
+static void *par_drv;		/* reference of parport driver */
 
 /* kernel glue structures */
 
@@ -703,6 +704,11 @@ static int pf_detect(void)
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 	       name, name, PF_VERSION, major, cluster, nice);
 
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		return -1;
+	}
 	k = 0;
 	if (pf_drive_count == 0) {
 		if (pi_init(pf->pi, 1, -1, -1, -1, -1, -1, pf_scratch, PI_PF,
@@ -735,6 +741,7 @@ static int pf_detect(void)
 	printk("%s: No ATAPI disk detected\n", name);
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
 		put_disk(pf->disk);
+	pi_unregister_driver(par_drv);
 	return -1;
 }
 
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
index 876d0c3..bfbd4c8 100644
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -227,6 +227,7 @@ static int pg_identify(struct pg *dev, int log);
 static char pg_scratch[512];	/* scratch block buffer */
 
 static struct class *pg_class;
+static void *par_drv;		/* reference of parport driver */
 
 /* kernel glue structures */
 
@@ -481,6 +482,12 @@ static int pg_detect(void)
 
 	printk("%s: %s version %s, major %d\n", name, name, PG_VERSION, major);
 
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		return -1;
+	}
+
 	k = 0;
 	if (pg_drive_count == 0) {
 		if (pi_init(dev->pi, 1, -1, -1, -1, -1, -1, pg_scratch,
@@ -511,6 +518,7 @@ static int pg_detect(void)
 	if (k)
 		return 0;
 
+	pi_unregister_driver(par_drv);
 	printk("%s: No ATAPI device detected\n", name);
 	return -1;
 }
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
index 2596042..1740d75 100644
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -232,6 +232,7 @@ static int pt_identify(struct pt_unit *tape);
 static struct pt_unit pt[PT_UNITS];
 
 static char pt_scratch[512];	/* scratch block buffer */
+static void *par_drv;		/* reference of parport driver */
 
 /* kernel glue structures */
 
@@ -605,6 +606,12 @@ static int pt_detect(void)
 
 	printk("%s: %s version %s, major %d\n", name, name, PT_VERSION, major);
 
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		return -1;
+	}
+
 	specified = 0;
 	for (unit = 0; unit < PT_UNITS; unit++) {
 		struct pt_unit *tape = &pt[unit];
@@ -644,6 +651,7 @@ static int pt_detect(void)
 	if (found)
 		return 0;
 
+	pi_unregister_driver(par_drv);
 	printk("%s: No ATAPI tape drive detected\n", name);
 	return -1;
 }
-- 
1.8.1.2
