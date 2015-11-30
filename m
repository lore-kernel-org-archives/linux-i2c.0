From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/4] i2c: uniphier: add minor sanity checks to
 i2c-uniphier/i2c-uniphier-f
Date: Mon, 30 Nov 2015 18:53:32 +0900
Message-ID: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org




Masahiro Yamada (4):
  i2c: uniphier: error out if clock rate is zero
  i2c: uniphier: error out if bus speed is zero
  i2c: uniphier_f: error out if clock rate is zero
  i2c: uniphier_f: error out if bus speed is zero

 drivers/i2c/busses/i2c-uniphier-f.c | 11 ++++++++++-
 drivers/i2c/busses/i2c-uniphier.c   | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
1.9.1
