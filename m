From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/3] i2c: octeon: Missing AAK flag in case of I2C_M_RECV_LEN
Date: Wed,  8 Jun 2016 08:51:17 +0200
Message-ID: <d16b9cde449b0f6bad954c7ac1db2ac941231601.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34034 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbcFHGvv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Jun 2016 02:51:51 -0400
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>

During receive the controller requires the AAK flag for all
bytes but the final one. This was wrong in case of I2C_M_RECV_LEN,
where the decision if the final byte is to be transmitted
happened before adding the additional received length byte.

Set the AAK flag if additional bytes are to be received.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index aa5f01e..1922e4a 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -934,8 +934,15 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 		return result;
 
 	for (i = 0; i < length; i++) {
-		/* for the last byte TWSI_CTL_AAK must not be set */
-		if (i + 1 == length)
+		/*
+		 * For the last byte to receive TWSI_CTL_AAK must not be set.
+		 *
+		 * A special case is I2C_M_RECV_LEN where we don't know the
+		 * additional length yet. If recv_len is set we assume we're
+		 * not reading the final byte and therefore need to set
+		 * TWSI_CTL_AAK.
+		 */
+		if ((i + 1 == length) && !(recv_len && i == 0))
 			final_read = true;
 
 		/* clear iflg to allow next event */
-- 
2.9.0.rc0.21.g7777322
