From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH] i2c: Storage class should be before const qualifier
Date: Sun, 17 Feb 2008 15:39:07 +0100
Message-ID: <20080217143907.GA9270@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the
beginning of the declaration specifiers in a declaration is an
obsolescent feature.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c |    4 ++--
 include/linux/i2c.h             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index be99c02..b03af56 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -122,7 +122,7 @@ struct pmcmsptwi_data {
 };
 
 /* The default settings */
-const static struct pmcmsptwi_clockcfg pmcmsptwi_defclockcfg = {
+static const struct pmcmsptwi_clockcfg pmcmsptwi_defclockcfg = {
 	.standard = {
 		.filter	= 0x3,
 		.clock	= 0x1f,
@@ -133,7 +133,7 @@ const static struct pmcmsptwi_clockcfg pmcmsptwi_defclockcfg = {
 	},
 };
 
-const static struct pmcmsptwi_cfg pmcmsptwi_defcfg = {
+static const struct pmcmsptwi_cfg pmcmsptwi_defcfg = {
 	.arbf		= 0x03,
 	.nak		= 0x03,
 	.add10		= 0x00,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 76014f8..2d1c608 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -598,7 +598,7 @@ I2C_CLIENT_MODULE_PARM(probe, "List of adapter,address pairs to scan "	\
 		       "additionally");					\
 I2C_CLIENT_MODULE_PARM(ignore, "List of adapter,address pairs not to "	\
 		       "scan");						\
-const static struct i2c_client_address_data addr_data = {		\
+static const struct i2c_client_address_data addr_data = {		\
 	.normal_i2c	= normal_i2c,					\
 	.probe		= probe,					\
 	.ignore		= ignore,					\
-- 
1.5.4.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
