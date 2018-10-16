From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] i2c: uniphier-f: fix concurrency issues and race
 conditions
Date: Tue, 16 Oct 2018 12:01:46 +0900
Message-ID: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


Currently, this driver has issues that rarely happen.

With this patch series, long-run tests passed.



Masahiro Yamada (3):
  i2c: uniphier-f: make driver robust against concurrency
  i2c: uniphier-f: fix occasional timeout error
  i2c: uniphier-f: fix race condition when IRQ is cleared

 drivers/i2c/busses/i2c-uniphier-f.c | 59 +++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

-- 
2.7.4
