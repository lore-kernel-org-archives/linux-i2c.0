From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/3] i2c: bcm2835: Add bcm2711 support
Date: Tue, 27 Aug 2019 19:04:13 +0200
Message-ID: <1566925456-5928-1-git-send-email-wahrenst@gmx.net>
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
To: Wolfram Sang <wsa@the-dreams.de>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-i2c@vger.kernel.org

This series has been split out of the recent Raspberry Pi 4 support
series [1]. I hope patch 1 and 2 have a chance to get into Linux 5.4.

Changes since split:
- add Rob's and Eric's Reviewed-by
- address Wolfram's comment regarding of_device_get_match_data
- add patch to distinguish the many interfaces on bcm2711

[1] - https://marc.info/?linux-arm-kernel&m=3D156571347332483

Stefan Wahren (3):
  dt-bindings: i2c: bcm2835: Add brcm,bcm2711 compatible
  i2c: bcm2835: Avoid clk stretch quirk for BCM2711
  i2c: bcm2835: Add full name of devicetree node to adapter name

 Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt |  4 +++-
 drivers/i2c/busses/i2c-bcm2835.c                           | 11 +++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

--
2.7.4
