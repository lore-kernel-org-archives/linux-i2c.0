From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.29
Date: Tue, 24 Feb 2009 19:26:03 +0100
Message-ID: <20090224192603.687d506c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.29 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 arch/arm/mach-rpc/riscpc.c       |    6 ++++++
 drivers/i2c/busses/i2c-acorn.c   |    5 +++--
 drivers/i2c/busses/i2c-amd8111.c |    4 ++--
 drivers/i2c/busses/i2c-ixp2000.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c     |    2 +-
 drivers/i2c/busses/scx200_i2c.c  |    2 +-
 drivers/i2c/i2c-core.c           |    3 ++-
 drivers/i2c/i2c-dev.c            |    6 +++++-
 include/linux/i2c-dev.h          |    2 +-
 include/linux/i2c.h              |    2 +-
 10 files changed, 23 insertions(+), 11 deletions(-)

---------------

Jean Delvare (2):
      i2c-dev: Clarify the unit of ioctl I2C_TIMEOUT
      i2c: Make sure i2c_algo_bit_data.timeout is HZ-independent

Roel Kluin (2):
      i2c: Fix misplaced parentheses
      i2c: Timeouts reach -1

Russell King (1):
      [ARM] Add i2c_board_info for RiscPC PCF8583

Thanks,
-- 
Jean Delvare
