From: Chaitanya Lala <clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Subject: [linux-2.6 PATCH 1/1] i2c-i801: Re-read busy bit and wait for
	transaction to complete
Date: Wed, 26 Aug 2009 15:11:05 -0700
Message-ID: <20090826221105.GA19712@clala-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Intel ESB2 SMBus chip seems to have an issue where it momentarily
resets the HOST_BUSY bit in the host status register. This confuses
the driver waiting for an SMBus transaction to complete. This patch
adds a workaround for the same.

Signed-off-by: Chaitanya Lala <clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9d2c5ad..1a04817 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -222,6 +222,7 @@ static int i801_transaction(int xact)
 	int status;
 	int result;
 	int timeout = 0;
+	int counter = 0;
 
 	result = i801_check_pre();
 	if (result < 0)
@@ -231,12 +232,34 @@ static int i801_transaction(int xact)
 	 * INTREN, SMBSCMD are passed in xact */
 	outb_p(xact | I801_START, SMBHSTCNT);
 
+try_again:
 	/* We will always wait for a fraction of a second! */
 	do {
 		msleep(1);
 		status = inb_p(SMBHSTSTS);
 	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
 
+	/* The i801 chip resets the HOST_BUSY bit
+	*  to indicate that it has completed the transaction,
+	*  but a moment later sets it again. Seems like a glitch.
+	*  Changed code to check the value more times if its not a timeout.
+	*/
+	if (timeout < MAX_TIMEOUT) {
+		msleep(1);
+		status = inb_p(SMBHSTSTS);
+		if (status  & SMBHSTSTS_HOST_BUSY) {
+			dev_warn(&I801_dev->dev, "Busy bit set again"
+				"(%02x)\n", status);
+			if (++counter < 3) {
+				dev_info(&I801_dev->dev, "Trying"
+					"again\n");
+				goto try_again;
+			}
+			dev_err(&I801_dev->dev, "No use"
+				" retrying-(%02x)\n", status);
+		}
+	}
+
 	result = i801_check_post(status, timeout > MAX_TIMEOUT);
 	if (result < 0)
 		return result;
-- 
1.6.0.4
