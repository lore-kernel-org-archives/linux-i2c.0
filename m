From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/4] UniPhier I2C fixes
Date: Thu,  6 Dec 2018 12:55:24 +0900
Message-ID: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Masahiro Yamada (4):
  i2c: uniphier-f: fix timeout error after reading 8 bytes
  i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
  i2c: uniphier: fix violation of tLOW requirement for Fast-mode
  i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

 drivers/i2c/busses/i2c-uniphier-f.c | 49 +++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-uniphier.c   |  8 +++++-
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.7.4
