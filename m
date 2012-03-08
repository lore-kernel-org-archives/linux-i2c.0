From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Update the FSF address
Date: Thu, 8 Mar 2012 18:37:33 +0100
Message-ID: <20120308183733.2f99c200@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    3 ++-
 drivers/i2c/algos/i2c-algo-pca.c |    3 ++-
 drivers/i2c/algos/i2c-algo-pcf.c |    3 ++-
 drivers/i2c/algos/i2c-algo-pcf.h |    3 ++-
 drivers/i2c/i2c-boardinfo.c      |    3 ++-
 drivers/i2c/i2c-core.c           |    3 ++-
 drivers/i2c/i2c-core.h           |    3 ++-
 drivers/i2c/i2c-dev.c            |    3 ++-
 drivers/i2c/i2c-smbus.c          |    3 ++-
 include/linux/i2c-algo-bit.h     |    3 ++-
 include/linux/i2c-algo-pcf.h     |    3 ++-
 include/linux/i2c-dev.h          |    3 ++-
 include/linux/i2c-mux.h          |    3 ++-
 include/linux/i2c-smbus.h        |    3 ++-
 include/linux/i2c.h              |    3 ++-
 15 files changed, 30 insertions(+), 15 deletions(-)

--- linux-3.3-rc6.orig/include/linux/i2c-dev.h	2011-07-22 04:17:23.0000=
00000 +0200
+++ linux-3.3-rc6/include/linux/i2c-dev.h	2012-03-08 11:00:55.822926805=
 +0100
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef _LINUX_I2C_DEV_H
--- linux-3.3-rc6.orig/drivers/i2c/i2c-boardinfo.c	2012-01-06 11:21:10.=
000000000 +0100
+++ linux-3.3-rc6/drivers/i2c/i2c-boardinfo.c	2012-03-08 18:03:42.78492=
3280 +0100
@@ -13,7 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
--- linux-3.3-rc6.orig/drivers/i2c/i2c-core.c	2012-03-07 22:49:14.00000=
0000 +0100
+++ linux-3.3-rc6/drivers/i2c/i2c-core.c	2012-03-08 18:03:28.805923073 =
+0100
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.							     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>.
--- linux-3.3-rc6.orig/drivers/i2c/i2c-core.h	2011-07-22 04:17:23.00000=
0000 +0200
+++ linux-3.3-rc6/drivers/i2c/i2c-core.h	2012-03-08 18:02:59.437922634 =
+0100
@@ -13,7 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <linux/rwsem.h>
--- linux-3.3-rc6.orig/drivers/i2c/i2c-dev.c	2012-03-07 22:49:14.000000=
000 +0100
+++ linux-3.3-rc6/drivers/i2c/i2c-dev.c	2012-03-08 18:02:53.493922543 +=
0100
@@ -17,7 +17,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 /* Note that this is a complete rewrite of Simon Vogl's i2c-dev module=
=2E
--- linux-3.3-rc6.orig/drivers/i2c/i2c-smbus.c	2012-02-14 10:16:13.0000=
00000 +0100
+++ linux-3.3-rc6/drivers/i2c/i2c-smbus.c	2012-03-08 18:01:56.636921707=
 +0100
@@ -16,7 +16,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
--- linux-3.3-rc6.orig/include/linux/i2c-algo-bit.h	2011-07-22 04:17:23=
=2E000000000 +0200
+++ linux-3.3-rc6/include/linux/i2c-algo-bit.h	2012-03-08 18:04:21.2749=
23809 +0100
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.         =
       */
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.							     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and even
--- linux-3.3-rc6.orig/include/linux/i2c-algo-pcf.h	2011-07-22 04:17:23=
=2E000000000 +0200
+++ linux-3.3-rc6/include/linux/i2c-algo-pcf.h	2012-03-08 18:04:17.2589=
23771 +0100
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.         =
       */
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.							     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and even
--- linux-3.3-rc6.orig/include/linux/i2c-mux.h	2012-03-07 23:11:31.0000=
00000 +0100
+++ linux-3.3-rc6/include/linux/i2c-mux.h	2012-03-08 18:03:59.350923527=
 +0100
@@ -18,7 +18,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #ifndef _LINUX_I2C_MUX_H
--- linux-3.3-rc6.orig/include/linux/i2c-smbus.h	2011-07-22 04:17:23.00=
0000000 +0200
+++ linux-3.3-rc6/include/linux/i2c-smbus.h	2012-03-08 18:03:54.7189234=
57 +0100
@@ -15,7 +15,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #ifndef _LINUX_I2C_SMBUS_H
--- linux-3.3-rc6.orig/include/linux/i2c.h	2012-01-20 14:06:40.00000000=
0 +0100
+++ linux-3.3-rc6/include/linux/i2c.h	2012-03-08 18:04:11.506923706 +01=
00
@@ -17,7 +17,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.							     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and
--- linux-3.3-rc6.orig/drivers/i2c/algos/i2c-algo-bit.c	2012-01-06 11:2=
1:10.000000000 +0100
+++ linux-3.3-rc6/drivers/i2c/algos/i2c-algo-bit.c	2012-03-08 18:21:38.=
956164440 +0100
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
  * -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, Ky=C3=B6sti=
 M=C3=A4lkki
--- linux-3.3-rc6.orig/drivers/i2c/algos/i2c-algo-pca.c	2012-01-06 11:2=
1:10.000000000 +0100
+++ linux-3.3-rc6/drivers/i2c/algos/i2c-algo-pca.c	2012-03-08 18:19:28.=
591071934 +0100
@@ -15,7 +15,8 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ *  MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
--- linux-3.3-rc6.orig/drivers/i2c/algos/i2c-algo-pcf.c	2011-07-22 04:1=
7:23.000000000 +0200
+++ linux-3.3-rc6/drivers/i2c/algos/i2c-algo-pcf.c	2012-03-08 18:19:20.=
538071798 +0100
@@ -16,7 +16,8 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ *  MA 02110-1301 USA.
  *
  * With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and
  * Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and also from Martin Bailey
--- linux-3.3-rc6.orig/drivers/i2c/algos/i2c-algo-pcf.h	2011-07-22 04:1=
7:23.000000000 +0200
+++ linux-3.3-rc6/drivers/i2c/algos/i2c-algo-pcf.h	2012-03-08 18:18:28.=
953071095 +0100
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		*/
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.							*/
 /* -------------------------------------------------------------------=
-	*/
=20
 /* With some changes from Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> */


--=20
Jean Delvare
