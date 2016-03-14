From: David Wu <wdc@rock-chips.com>
Subject: [PATCH v4 0/3] update some i2c changes for rk3399 soc
Date: Tue, 15 Mar 2016 06:52:27 +0800
Message-ID: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:51837 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbcCOOqu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 10:46:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com

From: David Wu <david.wu@rock-chips.com>

David Wu (3):
  i2c: rk3x: switch to i2c generic dt parsing
  i2c: rk3x: add new method to caculate i2c timings for rk3399
  i2c: rk3x: support I2C Highspeed Mode for rk3399

 drivers/i2c/busses/i2c-rk3x.c | 473 ++++++++++++++++++++++++++++++++----------
 1 file changed, 364 insertions(+), 109 deletions(-)

-- 
1.9.1
