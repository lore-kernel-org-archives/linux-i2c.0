From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Subject: [PATCH 7/8] drivers/i2c/busses/i2c-amd8111.c: Fix unsigned return
 type
Date: Wed, 8 Sep 2010 07:58:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009080757050.27892@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (em, bedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janit
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

In each case, the function has an unsigned return type, but returns a
negative constant to indicate an error condition.  The result of calling
the function is always stored in a variable of type (signed) int, and thus
unsigned can be dropped from the return type.

A sematic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@exists@
identifier f;
constant C;
@@

 unsigned f(...)
 { <+...
*  return -C;
 ...+> }
// </smpl>

Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

---
 drivers/i2c/busses/i2c-amd8111.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index af1e5e2..02a3726 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -69,7 +69,7 @@ static struct pci_driver amd8111_driver;
  * ACPI 2.0 chapter 13 access of registers of the EC
  */
 
-static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
+static int amd_ec_wait_write(struct amd_smbus *smbus)
 {
 	int timeout = 500;
 
@@ -85,7 +85,7 @@ static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
 	return 0;
 }
 
-static unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
+static int amd_ec_wait_read(struct amd_smbus *smbus)
 {
 	int timeout = 500;
 
