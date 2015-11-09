From: Liguo Zhang <liguo.zhang@mediatek.com>
Subject: [PATCH v2 0/2] Mediatek I2C Fixup
Date: Mon, 9 Nov 2015 13:43:57 +0800
Message-ID: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:49057 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751273AbbKIFoP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Nov 2015 00:44:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

This series contain two patches, first is to optimize Mediatek I2C driver to use WRRD
if hardware support auto restart. Because auto restart will issue auto restart
interrupt, change to use WRRD can reduce interrupt latency. The second is to fix
multi transfer error in high speed mode. If hardware support auto restart, need driver
to send master code first.

Change in v2:
fix i2c checkpatch error.

Liguo Zhang (2):
  i2c: mediatek: add i2c first write then read optimization
  i2c: mediatek: fix i2c multi transfer issue in high speed mode

 drivers/i2c/busses/i2c-mt65xx.c | 78 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

--
1.8.1.1.dirty
