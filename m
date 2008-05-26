From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c fixes for 2.6.26
Date: Mon, 26 May 2008 19:08:47 +0200
Message-ID: <20080526190847.0574f747@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756560AbYEZRIm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem fixes for Linux 2.6.26 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

(Note to other readers: please do NOT pull the whole kernel tree from
this location, my line wouldn't like it.)

 drivers/media/video/tuner-core.c |   20 +++++++-------------
 include/linux/mod_devicetable.h  |    3 ++-
 2 files changed, 9 insertions(+), 14 deletions(-)

---------------

Jiri Slaby (1):
      i2c: Align i2c_device_id

Michael Krufky (1):
      tuner: Do not alter i2c_client.name

Thanks,
-- 
Jean Delvare
