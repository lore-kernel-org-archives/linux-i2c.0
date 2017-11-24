From: =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>
Subject: [PATCH] py-smbus: Fix FSF address in smbusmodule.c
Date: Fri, 24 Nov 2017 10:40:01 +0100
Message-ID: <20171124094001.27858-1-olysonek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbdKXJkM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Nov 2017 04:40:12 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>

The Free Software Foundation address was outdated. Discovered by
Fedora's rpmlint. The current address can be found at:
https://www.gnu.org/licenses/old-licenses/gpl-2.0.html#SEC4

Signed-off-by: Ondřej Lysoněk <olysonek@redhat.com>
---
 py-smbus/smbusmodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/py-smbus/smbusmodule.c b/py-smbus/smbusmodule.c
index 48a408b..b189106 100644
--- a/py-smbus/smbusmodule.c
+++ b/py-smbus/smbusmodule.c
@@ -13,7 +13,8 @@
  * 
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
  */
 
 #include <Python.h>
-- 
2.14.3
