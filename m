From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 5/8]drm:drm_gem Fix  warning: variable 'dev' set but not used
Date: Mon, 14 Jun 2010 13:26:45 -0700
Message-ID: <1276547208-26569-6-git-send-email-justinmattock@gmail.com>
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

Probably not even a fix for this warning:

  CC [M]  drivers/gpu/drm/drm_gem.o
drivers/gpu/drm/drm_gem.c: In function 'drm_gem_handle_delete':
drivers/gpu/drm/drm_gem.c:188:21: warning: variable 'dev' set but not used

 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/gpu/drm/drm_gem.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 33dad3f..e8180c9 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -206,6 +206,8 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 		return -EINVAL;
 	}
 	dev = obj->dev;
+	if (!dev)
+		dev = 0;
 
 	/* Release reference and decrement refcount. */
 	idr_remove(&filp->object_idr, handle);
-- 
1.7.1.rc1.21.gf3bd6


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
