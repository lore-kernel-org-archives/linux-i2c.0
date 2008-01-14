From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] more i2c fixes for 2.6.24
Date: Mon, 14 Jan 2008 22:01:38 +0100
Message-ID: <20080114220138.65ef803a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753403AbYANVBw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.24 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus


 drivers/i2c/busses/i2c-at91.c     |    2 +-
 drivers/i2c/busses/i2c-omap.c     |    2 +-
 drivers/i2c/busses/i2c-powermac.c |    2 +-
 drivers/i2c/busses/i2c-sibyte.c   |    7 +++++--
 drivers/i2c/i2c-dev.c             |    2 +-
 include/linux/i2c-id.h            |    4 ++++
 6 files changed, 13 insertions(+), 6 deletions(-)

---------------

Jean Delvare (2):
      i2c: Driver IDs are optional
      i2c-sibyte: Fix an error path

Joe Perches (1):
      i2c: Spelling fixes

Tony Lindgren (1):
      i2c-omap: Fix NULL pointer dereferencing


Thanks,
-- 
Jean Delvare
