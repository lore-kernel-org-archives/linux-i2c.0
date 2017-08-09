From: Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH 0/2] Add i2c dt-binding and compatible for Mediatek MT7622 SoC
Date: Wed, 9 Aug 2017 15:43:49 +0800
Message-ID: <1502264631-12572-1-git-send-email-jun.gao@mediatek.com>
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
To: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch series based on v4.13-rc1, include MT7622 i2c dt-binding
and compatible.

Jun Gao (2):
  dt-bindings: i2c: Add MediaTek MT7622 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT7622

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
 drivers/i2c/busses/i2c-mt65xx.c                   | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

--
1.8.1.1
