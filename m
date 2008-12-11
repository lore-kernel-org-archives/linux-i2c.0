From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.28
Date: Thu, 11 Dec 2008 12:13:49 +0100
Message-ID: <20081211121349.70acb47b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.28 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/i2c/busses/i2c-highlander.c |    4 ++--
 drivers/i2c/busses/i2c-pmcmsp.c     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

---------------

Harvey Harrison (2):
      i2c-pmcmsp: Fix endianness misannotation
      i2c-highlander: Trivial endian casting fixes

Thanks,
-- 
Jean Delvare
