From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c fixes for 2.6.25
Date: Wed, 12 Mar 2008 16:01:42 +0100
Message-ID: <20080312160142.7adce5cc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753357AbYCLPB4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem fixes for Linux 2.6.25 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/i2c/busses/i2c-amd756.c |    2 +-
 drivers/i2c/chips/Makefile      |    7 +++++++
 drivers/i2c/i2c-core.c          |    6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

---------------

Adrian Bunk (1):
      i2c-amd756: Fix off-by-one

Hans Verkuil (1):
      i2c: Keep client->driver and client->dev.driver in sync

Jean Delvare (1):
      i2c: chips subdirectory is deprecated

Thanks,
-- 
Jean Delvare
