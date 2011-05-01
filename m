From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.39
Date: Sun, 1 May 2011 19:14:14 +0200
Message-ID: <20110501191414.7a4a4988@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/busses/i2c-i801.c    |    5 +++++
 drivers/i2c/busses/i2c-parport.c |   27 ++++++++++++++-------------
 include/linux/pci_ids.h          |    4 ----
 3 files changed, 19 insertions(+), 17 deletions(-)

---------------

Jean Delvare (2):
      i2c-i801: Move device ID definitions to driver
      i2c-parport: Fix adapter list handling

Thanks,
-- 
Jean Delvare
