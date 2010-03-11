From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 30/37] drivers/cdrom: use .of_node instead of
	.archdata.of_node in struct device
Date: Thu, 11 Mar 2010 11:06:33 -0700
Message-ID: <20100311180633.4824.27717.stgit__11419.42139152$1268331153$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade
List-Id: linux-i2c@vger.kernel.org

.archdata.node is being removed from Microblaze, SPARC and PowerPC.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 drivers/cdrom/viocd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index cc435be..451cd70 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -567,7 +567,7 @@ static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	struct disk_info *d;
 	struct cdrom_device_info *c;
 	struct request_queue *q;
-	struct device_node *node = vdev->dev.archdata.of_node;
+	struct device_node *node = vdev->dev.of_node;
 
 	deviceno = vdev->unit_address;
 	if (deviceno >= VIOCD_MAX_CD)
