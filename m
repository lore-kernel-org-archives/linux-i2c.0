From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 6/8]i2c:i2c_core Fix warning: variable 'dummy' set but not used
Date: Mon, 14 Jun 2010 13:26:46 -0700
Message-ID: <1276547208-26569-7-git-send-email-justinmattock@gmail.com>
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

could be a right solution, could be wrong
here is the warning:
  CC      drivers/i2c/i2c-core.o
drivers/i2c/i2c-core.c: In function 'i2c_register_adapter':
drivers/i2c/i2c-core.c:757:15: warning: variable 'dummy' set but not used
 
 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/i2c/i2c-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1cca263..79c6c26 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -794,6 +794,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	mutex_lock(&core_lock);
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 				 __process_new_adapter);
+	if(!dummy)
+		dummy = 0;
 	mutex_unlock(&core_lock);
 
 	return 0;
-- 
1.7.1.rc1.21.gf3bd6


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
