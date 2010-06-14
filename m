From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 3/8]char/hpet.c Fix variable 'hpet' set but not used
Date: Mon, 14 Jun 2010 13:26:43 -0700
Message-ID: <1276547208-26569-4-git-send-email-justinmattock@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: reiserfs-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, debora@linux.vnet.ibm.com, linux-i2c@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The below fixes this warning:
drivers/char/hpet.c: In function 'hpet_ioctl_common':
drivers/char/hpet.c:559:23: warning: variable 'hpet' set but not used

please have a look.
 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/char/hpet.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index a0a1829..7932858 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -556,7 +556,6 @@ static int
 hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
 {
 	struct hpet_timer __iomem *timer;
-	struct hpet __iomem *hpet;
 	struct hpets *hpetp;
 	int err;
 	unsigned long v;
@@ -568,7 +567,6 @@ hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
 	case HPET_DPI:
 	case HPET_IRQFREQ:
 		timer = devp->hd_timer;
-		hpet = devp->hd_hpet;
 		hpetp = devp->hd_hpets;
 		break;
 	case HPET_IE_ON:
-- 
1.7.1.rc1.21.gf3bd6


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
