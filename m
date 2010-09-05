From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 4/8] drivers/i2c/busses/i2c-pasemi.c: Fix unsigned return type
Date: Sun,  5 Sep 2010 21:00:22 +0200
Message-ID: <1283713226-8429-5-git-send-email-julia@diku.dk>
References: <1283713226-8429-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1283713226-8429-1-git-send-email-julia@diku.dk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Olof Johansson <olof@lixom.net>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

The function has an unsigned return type, but returns a negative constant
to indicate an error condition.  The result of calling the function is
always stored in a variable of type (signed) int, and thus unsigned can be
dropped from the return type.

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

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/i2c/busses/i2c-pasemi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 4174101..837b8c1 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -88,7 +88,7 @@ static void pasemi_smb_clear(struct pasemi_smbus *smbus)
 	reg_write(smbus, REG_SMSTA, status);
 }
 
-static unsigned int pasemi_smb_waitready(struct pasemi_smbus *smbus)
+static int pasemi_smb_waitready(struct pasemi_smbus *smbus)
 {
 	int timeout = 10;
 	unsigned int status;
