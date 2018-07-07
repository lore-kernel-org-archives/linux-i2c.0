From: Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v2 0/3] Register i2c adapter driver earlier and use DMA safe
 buffers
Date: Sat, 7 Jul 2018 17:29:52 +0800
Message-ID: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
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
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch series based on v4.18-rc1, include i2c adapter driver register time
modification, DMA safe buffer free function and DMA safe buffers used for i2c
transactions.

changes since v1:
- Add the initializations for DMA safe buffer pointers

Jun Gao (3):
  i2c: mediatek: Register i2c adapter driver earlier
  i2c: Add helper to ease DMA handling
  i2c: mediatek: Use DMA safe buffers for i2c transactions

 drivers/i2c/busses/i2c-mt65xx.c | 74 ++++++++++++++++++++++++++++++++++++-----
 drivers/i2c/i2c-core-base.c     | 14 ++++++++
 include/linux/i2c.h             |  1 +
 3 files changed, 81 insertions(+), 8 deletions(-)

--
1.8.1.1
