From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH RESEND V2 3/4] i2c/au1550: increase timeout waiting for master done
Date: Sat, 22 Oct 2011 13:34:38 +0200
Message-ID: <1319283279-2296-4-git-send-email-manuel.lauss@googlemail.com>
References: <1319283279-2296-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319283279-2296-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Double the timeout in the loop which busy-waits for the "master-done"
bit to be set.  This bit indicates whether an i2c transaction has
completed;  on the DB1300 and DB1550 boards this timeout is slightly
too short and causes transactions to the WM8731 codec to be falsely flagged
as failed.  The timeout itself is necessary since transactions to
non-existant slaves never set this bit in the first place (and cause
i2cdetect to hang).

With this change the WM8731 codec on the DB1300/DB1550 boards is correctly
detected and initialized.

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
V2: changed timeout only for master done bit, updated patch description.

 drivers/i2c/busses/i2c-au1550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 98ee11a..4f5150c 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -101,7 +101,7 @@ static int wait_master_done(struct i2c_au1550_data *adap)
 	int i;
 
 	/* Wait for Master Done. */
-	for (i = 0; i < adap->xfer_timeout; i++) {
+	for (i = 0; i < 2 * adap->xfer_timeout; i++) {
 		if ((RD(adap, PSC_SMBEVNT) & PSC_SMBEVNT_MD) != 0)
 			return 0;
 		udelay(1);
-- 
1.7.6.1
