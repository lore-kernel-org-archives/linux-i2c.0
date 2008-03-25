From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c fixes for 2.6.25
Date: Tue, 25 Mar 2008 11:43:39 +0100
Message-ID: <20080325114339.296e9712@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754637AbYCYKoT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem fixes for Linux 2.6.25 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/i2c/busses/Kconfig     |    2 +-
 drivers/i2c/busses/i2c-omap.c  |   36 ++++++++++++++++++++++++++++--------
 drivers/i2c/i2c-core.c         |    4 ++--
 sound/soc/codecs/tlv320aic3x.c |    2 --
 4 files changed, 31 insertions(+), 13 deletions(-)

---------------

Bryan Wu (1):
      i2c-bfin-twi: Disable BF54x support for now

Jean Delvare (1):
      ASoC/TLV320AIC3X: Stop I2C driver ID abuse

Randy Dunlap (1):
      i2c: Fix docbook problem

Tony Lindgren (1):
      i2c-omap: Fix unhandled fault

Thanks,
-- 
Jean Delvare
