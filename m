From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.38, second round
Date: Fri, 14 Jan 2011 22:47:51 +0100
Message-ID: <20110114224751.2fa55138@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a second round of i2c subsystem updates for Linux 2.6.38
from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/i2c-core.c |   90 ++++++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 49 deletions(-)

---------------

Jean Delvare (1):
      i2c: Unregister dummy devices last on adapter removal

Mark Brown (2):
      i2c: Factor out runtime suspend checks from PM operations
      i2c: Encourage move to dev_pm_ops by warning on use of legacy methods

Thanks,
-- 
Jean Delvare
