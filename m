From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for Linux 3.3
Date: Thu, 15 Mar 2012 21:34:45 +0100
Message-ID: <20120315213445.4ba3fb6b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.3 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/algos/i2c-algo-bit.c |    8 +++++++-
 drivers/i2c/i2c-core.c           |   12 ++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

---------------

Ville Syrjala (1):
      i2c-algo-bit: Fix spurious SCL timeouts under heavy load

Wolfram Sang (1):
      i2c-core: Comment says "transmitted" but means "received"

Thanks,
-- 
Jean Delvare
