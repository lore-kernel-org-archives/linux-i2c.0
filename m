From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] i2c: uniphier: updates for v4.9
Date: Thu,  1 Sep 2016 20:46:27 +0900
Message-ID: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org




Masahiro Yamada (3):
  i2c: uniphier: avoid WARN_ON() of clk_disable() in failure path
  i2c: uniphier-f: avoid WARN_ON() of clk_disable() in failure path
  i2c: uniphier-f: set the adapter to master mode when probing

 drivers/i2c/busses/i2c-uniphier-f.c | 85 +++++++++++++++++--------------------
 drivers/i2c/busses/i2c-uniphier.c   | 73 ++++++++++++++-----------------
 2 files changed, 71 insertions(+), 87 deletions(-)

-- 
1.9.1
