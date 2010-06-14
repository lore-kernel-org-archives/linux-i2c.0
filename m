From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 8/8]tuners:tuner-simple Fix warning: variable 'tun' set but
	not used
Date: Mon, 14 Jun 2010 13:26:48 -0700
Message-ID: <1276547208-26569-9-git-send-email-justinmattock@gmail.com>
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

not sure if this is correct or not for 
fixing this warning:
  CC [M]  drivers/media/common/tuners/tuner-simple.o
drivers/media/common/tuners/tuner-simple.c: In function 'simple_set_tv_freq':
drivers/media/common/tuners/tuner-simple.c:548:20: warning: variable 'tun' set but not used

 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/media/common/tuners/tuner-simple.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/tuners/tuner-simple.c b/drivers/media/common/tuners/tuner-simple.c
index 8abbcc5..4465b99 100644
--- a/drivers/media/common/tuners/tuner-simple.c
+++ b/drivers/media/common/tuners/tuner-simple.c
@@ -545,14 +545,12 @@ static int simple_set_tv_freq(struct dvb_frontend *fe,
 	struct tuner_simple_priv *priv = fe->tuner_priv;
 	u8 config, cb;
 	u16 div;
-	struct tunertype *tun;
 	u8 buffer[4];
 	int rc, IFPCoff, i;
 	enum param_type desired_type;
 	struct tuner_params *t_params;
 
-	tun = priv->tun;
-
+	
 	/* IFPCoff = Video Intermediate Frequency - Vif:
 		940  =16*58.75  NTSC/J (Japan)
 		732  =16*45.75  M/N STD
-- 
1.7.1.rc1.21.gf3bd6


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
