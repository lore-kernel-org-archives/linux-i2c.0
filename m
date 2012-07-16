From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCHv3]   I2C: MV64XXX: Add Device Tree support
Date: Mon, 16 Jul 2012 11:16:44 +0200
Message-ID: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: w.sang@pengutronix.de
Cc: Andrew Lunn <andrew@lunn.ch>, sebastian.hesselbarth@googlemail.com, linux-i2c@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-i2c@vger.kernel.org

This is one patch out of a larger patchset adding DT support to a
number of Orion drivers. All the other patches have been acked-by,
etc, so i'm only re-posting the one which has been modified.

The I2C driver now uses the clock-frequency property.

Andrew Lunn (1):
  I2C: MV64XXX: Add Device Tree support

 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   21 +++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   11 ++
 arch/arm/mach-kirkwood/board-dt.c                  |    2 +
 arch/arm/mach-kirkwood/common.c                    |    2 +
 arch/arm/plat-orion/common.c                       |    1 +
 drivers/i2c/busses/i2c-mv64xxx.c                   |  107 +++++++++++++++++++-
 6 files changed, 138 insertions(+), 6 deletions(-)

-- 
1.7.10
