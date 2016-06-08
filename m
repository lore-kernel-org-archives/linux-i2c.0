From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/3] Bug fixes for octeon driver
Date: Wed,  8 Jun 2016 08:51:16 +0200
Message-ID: <cover.1465304877.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36036 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbcFHGvu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Jun 2016 02:51:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>

Testing ipmi_ssif on ThunderX several bugs were found that also
apply to the Octeon i2c driver changes coming with 4.7.

I'll need to rebase the pending ThunderX driver series after this
fixes which I'll do shortly.

Please consider for 4.7.

thanks,
Jan

Jan Glauber (3):
  i2c: octeon: Missing AAK flag in case of I2C_M_RECV_LEN
  i2c: octeon: Add retry logic after receiving STAT_RXADDR_NAK
  i2c: octeon: Avoid printk after too long SMBUS message

 drivers/i2c/busses/i2c-octeon.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

-- 
2.9.0.rc0.21.g7777322
