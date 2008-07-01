From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c documentation updates for 2.6.26
Date: Tue, 1 Jul 2008 23:03:54 +0200
Message-ID: <20080701230354.4dcce346@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760714AbYGAVEx@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem documentation updates for Linux 2.6.26
from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

(Note to other readers: please do NOT pull the whole kernel tree from
this location, my line wouldn't like it.)


 Documentation/i2c/writing-clients |   18 ++++++++++++++----
 include/linux/i2c.h               |    2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

---------------

Ben Dooks (1):
      i2c: Documentation: fix device matching description

Wolfram Sang (1):
      i2c: Fix bad hint about irqs in i2c.h

Thanks,
-- 
Jean Delvare
