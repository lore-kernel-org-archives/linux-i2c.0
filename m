From: David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [patch] i2c: fix virtual i2c adapter lockdep warning
Date: Mon, 4 Aug 2008 10:50:42 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808032024130.2365@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

bus_lock for both the virtual adapter and its parent have the same lock
class.  Since both are taken in i2c_virt_master_xfer() and
i2c_virt_smbus_xfer(), lockdep needs an annotation that the nesting is
safe.

Signed-off-by: David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/i2c-virt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-virt.c b/drivers/i2c/i2c-virt.c
--- a/drivers/i2c/i2c-virt.c
+++ b/drivers/i2c/i2c-virt.c
@@ -53,7 +53,7 @@ static int i2c_virt_master_xfer(struct i2c_adapter *adap,
 	 * the transfer.
 	 */
 
-	mutex_lock(&parent->bus_lock);
+	mutex_lock_nested(&parent->bus_lock, SINGLE_DEPTH_NESTING);
 
 	ret = priv->select(parent, priv->client, priv->id);
 	if (ret >= 0)
@@ -79,7 +79,7 @@ static int i2c_virt_smbus_xfer(struct i2c_adapter *adap,
 	 * the transfer.
 	 */
 
-	mutex_lock(&parent->bus_lock);
+	mutex_lock_nested(&parent->bus_lock, SINGLE_DEPTH_NESTING);
 
 	ret = priv->select(parent, priv->client, priv->id);
 	if (ret == 0)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
