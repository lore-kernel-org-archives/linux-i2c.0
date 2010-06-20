From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c/mips: Fix error return codes from Sibyte i2c bus driver
Date: Sun, 20 Jun 2010 10:57:53 -0700
Message-ID: <1277056673-4305-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sibyte i2c bus driver returns non-descriptive error values.
Update to return error values as defined in Documentation/i2c/fault-codes.

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sibyte.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
index 3d76a18..329cbee 100644
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -94,7 +94,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
 		}
 		break;
 	default:
-		return -1;      /* XXXKW better error code? */
+		return -EOPNOTSUPP;
 	}
 
 	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
@@ -104,7 +104,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
 	if (error & M_SMB_ERROR) {
 		/* Clear error bit by writing a 1 */
 		csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
-		return -1;      /* XXXKW better error code? */
+		return -ENXIO;
 	}
 
 	if (data_bytes == 1)
-- 
1.7.0.87.g0901d
