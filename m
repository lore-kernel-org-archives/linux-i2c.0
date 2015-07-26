From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/8] misc: remove boundary checks from bin attr users
Date: Mon, 27 Jul 2015 00:18:22 +0300
Message-ID: <1437945502-27944-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This change removes a number of redundant checks on bin attribute
client's side, the same checks are done by sysfs_kf_bin_read() or
sysfs_kf_bin_write() caller from fs/sysfs/file.c.

Note, drivers/misc/pch_phub.c and drivers/misc/c2port/core.c may be
updated in a similar way, however this task is not done due to more
complicated read()/write() callbacks.

No functional change, hopefully.

Vladimir Zapolskiy (8):
  misc: cxl: clean up afu_read_config()
  misc: ds1682: clean up ds1682_eeprom_read() and ds1682_eeprom_write()
  misc: eeprom: 93xx46: clean up eeprom_93xx46_bin_read/write
  misc: eeprom: clean up eeprom_read()
  misc: eeprom: max6875: clean up max6875_read()
  misc: eeprom: at24: clean up at24_bin_write()
  misc: eeprom: at25: move eeprom boundary checks to mem_read/mem_write
  misc: eeprom: sunxi_sid: clean up sid_read()

 drivers/misc/cxl/sysfs.c            |  7 +------
 drivers/misc/ds1682.c               | 12 ------------
 drivers/misc/eeprom/at24.c          |  3 ---
 drivers/misc/eeprom/at25.c          | 28 ++++++++++++++--------------
 drivers/misc/eeprom/eeprom.c        |  5 -----
 drivers/misc/eeprom/eeprom_93xx46.c | 14 --------------
 drivers/misc/eeprom/max6875.c       |  6 ------
 drivers/misc/eeprom/sunxi_sid.c     |  5 -----
 8 files changed, 15 insertions(+), 65 deletions(-)

-- 
2.1.4
