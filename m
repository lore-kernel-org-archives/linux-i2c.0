From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for Linux 3.7
Date: Sun, 28 Oct 2012 22:09:19 +0100
Message-ID: <20121028220919.1d867e32@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.7 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/Makefile                |    1 +
 drivers/i2c/busses/Kconfig          |    1 -
 drivers/i2c/busses/Makefile         |    1 -
 drivers/i2c/busses/i2c-i801.c       |   11 ++++--
 drivers/i2c/{busses => }/i2c-stub.c |   66 +++++++++++++++++------------------
 5 files changed, 40 insertions(+), 40 deletions(-)
 rename drivers/i2c/{busses => }/i2c-stub.c (75%)

---------------

Jean Delvare (3):
      i2c-stub: Move to drivers/i2c
      i2c-i801: Simplify dependency towards GPIOLIB
      i2c-i801: Fix comment

Thanks,
-- 
Jean Delvare
