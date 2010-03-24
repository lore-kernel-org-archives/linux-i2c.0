From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.34
Date: Wed, 24 Mar 2010 17:48:51 +0100
Message-ID: <20100324174851.3520f920@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

This brings back SMBus support on some IBM machines.

 drivers/acpi/scan.c           |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-scmi.c |   32 ++++++++++++++++++++++++--------
 include/acpi/acpi_drivers.h   |    2 ++
 3 files changed, 64 insertions(+), 8 deletions(-)

---------------

Crane Cai (1):
      i2c-scmi: Support IBM SMBus CMI devices

Darrick J. Wong (2):
      acpi: Support IBM SMBus CMI devices
      i2c-scmi: Provide module aliases for automatic loading

Thanks,
-- 
Jean Delvare
