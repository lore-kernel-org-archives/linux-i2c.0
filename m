From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Mon, 28 Jul 2008 16:05:02 +0100
Message-ID: <E1KNUHW-0004ZA-EO@kira.home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit c9272c4f9fbe2087beb3392f526dc5b19efaa56b:
  Linus Torvalds (1):
        Merge branch 'hotfixes' of git://git.linux-nfs.org/projects/trondmy/nfs-2.6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-linus

Ben Dooks (4):
      i2c: S3C2410: Pass the I2C bus number via drivers platform data
      i2c: i2c_gpio: keep probe resident for hotplugged devices.
      i2c: S3C24XX I2C frequency scaling support.
      i2c: Documentation: upgrading clients HOWTO

Michael Hennerich (1):
      i2c: Blackfin I2C Driver: Functional power management support

 Documentation/i2c/upgrading-clients |  281 +++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-bfin-twi.c   |   35 +++--
 drivers/i2c/busses/i2c-gpio.c       |    9 +-
 drivers/i2c/busses/i2c-s3c2410.c    |  129 ++++++++++++++--
 include/asm-arm/plat-s3c/iic.h      |    1 +
 5 files changed, 426 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/i2c/upgrading-clients

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
