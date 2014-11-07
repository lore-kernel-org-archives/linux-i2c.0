From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2] i2c: remove FSF address
Date: Fri,  7 Nov 2014 12:22:08 +0100
Message-ID: <1415359328-3521-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

We have a central copy of the GPL for that. Some addresses were already
outdated.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---

Change since V1: Close comments properly in case '*/' got deleted, too.

 drivers/i2c/algos/i2c-algo-bit.c            | 5 -----
 drivers/i2c/algos/i2c-algo-pca.c            | 5 -----
 drivers/i2c/algos/i2c-algo-pcf.c            | 5 -----
 drivers/i2c/algos/i2c-algo-pcf.h            | 7 +------
 drivers/i2c/busses/i2c-ali1535.c            | 4 ----
 drivers/i2c/busses/i2c-ali15x3.c            | 4 ----
 drivers/i2c/busses/i2c-amd756-s4882.c       | 4 ----
 drivers/i2c/busses/i2c-amd756.c             | 4 ----
 drivers/i2c/busses/i2c-au1550.c             | 4 ----
 drivers/i2c/busses/i2c-cpm.c                | 4 ----
 drivers/i2c/busses/i2c-davinci.c            | 4 ----
 drivers/i2c/busses/i2c-designware-core.c    | 4 ----
 drivers/i2c/busses/i2c-designware-core.h    | 4 ----
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 4 ----
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 ----
 drivers/i2c/busses/i2c-eg20t.c              | 4 ----
 drivers/i2c/busses/i2c-elektor.c            | 6 +-----
 drivers/i2c/busses/i2c-hydra.c              | 4 ----
 drivers/i2c/busses/i2c-i801.c               | 4 ----
 drivers/i2c/busses/i2c-imx.c                | 5 -----
 drivers/i2c/busses/i2c-iop3xx.h             | 6 +-----
 drivers/i2c/busses/i2c-isch.c               | 4 ----
 drivers/i2c/busses/i2c-ismt.c               | 4 ----
 drivers/i2c/busses/i2c-nforce2-s4985.c      | 4 ----
 drivers/i2c/busses/i2c-nforce2.c            | 4 ----
 drivers/i2c/busses/i2c-omap.c               | 4 ----
 drivers/i2c/busses/i2c-parport-light.c      | 4 ----
 drivers/i2c/busses/i2c-parport.c            | 4 ----
 drivers/i2c/busses/i2c-parport.h            | 4 ----
 drivers/i2c/busses/i2c-pasemi.c             | 4 ----
 drivers/i2c/busses/i2c-pca-isa.c            | 4 ----
 drivers/i2c/busses/i2c-piix4.c              | 4 ----
 drivers/i2c/busses/i2c-pmcmsp.c             | 4 ----
 drivers/i2c/busses/i2c-powermac.c           | 4 ----
 drivers/i2c/busses/i2c-s3c2410.c            | 4 ----
 drivers/i2c/busses/i2c-sh_mobile.c          | 4 ----
 drivers/i2c/busses/i2c-sibyte.c             | 4 ----
 drivers/i2c/busses/i2c-simtec.c             | 4 ----
 drivers/i2c/busses/i2c-sis5595.c            | 4 ----
 drivers/i2c/busses/i2c-sis630.c             | 4 ----
 drivers/i2c/busses/i2c-sis96x.c             | 4 ----
 drivers/i2c/busses/i2c-taos-evm.c           | 4 ----
 drivers/i2c/busses/i2c-via.c                | 4 ----
 drivers/i2c/busses/i2c-viapro.c             | 4 ----
 drivers/i2c/busses/i2c-xiic.c               | 4 ----
 drivers/i2c/busses/scx200_acb.c             | 4 ----
 drivers/i2c/i2c-boardinfo.c                 | 5 -----
 drivers/i2c/i2c-core.c                      | 7 +------
 drivers/i2c/i2c-core.h                      | 5 -----
 drivers/i2c/i2c-dev.c                       | 5 -----
 drivers/i2c/i2c-smbus.c                     | 5 -----
 drivers/i2c/i2c-stub.c                      | 4 ----
 52 files changed, 4 insertions(+), 222 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-a=
lgo-bit.c
index 65ef9664d5da..899bede81b31 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -12,11 +12,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-    MA 02110-1301 USA.
  * -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, Ky=C3=B6sti=
 M=C3=A4lkki
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-a=
lgo-pca.c
index 8b10f88b13d9..580dbf05c148 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -12,11 +12,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- *  MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-a=
lgo-pcf.c
index 34370090b753..270d84bfc2c6 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -14,11 +14,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- *  MA 02110-1301 USA.
- *
  * With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and
  * Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and also from Martin Bailey
  * <mbailey-0IcqLCOdkweesDZOCDqTHtBPR1lH4CV8@public.gmane.org>
diff --git a/drivers/i2c/algos/i2c-algo-pcf.h b/drivers/i2c/algos/i2c-a=
lgo-pcf.h
index 1ec703ee788d..262ee801975b 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.h
+++ b/drivers/i2c/algos/i2c-algo-pcf.h
@@ -12,12 +12,7 @@
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-    MA 02110-1301 USA.							*/
+    GNU General Public License for more details.			*/
 /* -------------------------------------------------------------------=
-	*/
=20
 /* With some changes from Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> */
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-=
ali1535.c
index 451e305f7971..4f2d78868281 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -14,10 +14,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-=
ali15x3.c
index 2fa21ce9682b..45c5c4883022 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -12,10 +12,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-amd756-s4882.c b/drivers/i2c/busses=
/i2c-amd756-s4882.c
index 41fc6837fb8b..65e324054970 100644
--- a/drivers/i2c/busses/i2c-amd756-s4882.c
+++ b/drivers/i2c/busses/i2c-amd756-s4882.c
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 =20
 /*
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-a=
md756.c
index a16f72891358..6c7113d990f8 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -15,10 +15,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-a=
u1550.c
index 8762458ca7da..6f8c0756e350 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -21,10 +21,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-13=
07, USA.
  */
=20
 #include <linux/delay.h>
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.=
c
index f3b89a4698b6..5bdbc71698d0 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -23,10 +23,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-=
davinci.c
index 4d9614719128..d15b7c9b9219 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -17,10 +17,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
---------
  *
  */
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/bus=
ses/i2c-designware-core.c
index 3c20e4bd6dd1..edca99dbba23 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -18,10 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
---------
  *
  */
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/bus=
ses/i2c-designware-core.h
index d66b6cbc9edc..5a410ef17abd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -18,10 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
---------
  *
  */
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/b=
usses/i2c-designware-pcidrv.c
index d31d313ab4f7..acb40f95db78 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -19,10 +19,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
---------
  *
  */
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/=
busses/i2c-designware-platdrv.c
index a7431150acf7..373dd4d47765 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -18,10 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
---------
  *
  */
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg=
20t.c
index a44ea13d1434..76e699f9ed97 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -9,10 +9,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7, USA.
  */
=20
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-=
elektor.c
index 485497066ed7..92e8c0ce1625 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -12,11 +12,7 @@
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+    GNU General Public License for more details.			     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and even
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hy=
dra.c
index 14d2b76de25f..b7864cf42a72 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -15,10 +15,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i80=
1.c
index 7cfc183b3d63..6ab4f1cb21f3 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -15,10 +15,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index c48e46af670a..e9fb7cf78612 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -11,11 +11,6 @@
  *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *	GNU General Public License for more details.
  *
- *	You should have received a copy of the GNU General Public License
- *	along with this program; if not, write to the Free Software
- *	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-13=
07,
- *	USA.
- *
  * Author:
  *	Darius Augulis, Teltonika Inc.
  *
diff --git a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-i=
op3xx.h
index 097e270955d0..2d6929c2bd92 100644
--- a/drivers/i2c/busses/i2c-iop3xx.h
+++ b/drivers/i2c/busses/i2c-iop3xx.h
@@ -11,11 +11,7 @@
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.         =
       */
+    GNU General Public License for more details.			     */
 /* -------------------------------------------------------------------=
------ */
=20
=20
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isc=
h.c
index cf99dbf21fd1..113293d275f6 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -14,10 +14,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ism=
t.c
index 3f6ecbfb9a56..f2b0ff011631 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -14,10 +14,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-13=
01 USA.
  * The full GNU General Public License is included in this distributio=
n
  * in the file called LICENSE.GPL.
  *
diff --git a/drivers/i2c/busses/i2c-nforce2-s4985.c b/drivers/i2c/busse=
s/i2c-nforce2-s4985.c
index b170bdffb5de..88eda09e73c0 100644
--- a/drivers/i2c/busses/i2c-nforce2-s4985.c
+++ b/drivers/i2c/busses/i2c-nforce2-s4985.c
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-=
nforce2.c
index ee3a76c7ae97..70b3c9158509 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -17,10 +17,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 0dffb0e62c3b..26942c159de1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -22,10 +22,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
=20
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busse=
s/i2c-parport-light.c
index 62f55fe624cb..d1f625f923c7 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -18,10 +18,6 @@
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
----- */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-=
parport.c
index a27aae2d6757..a1fac5aa9bae 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -18,10 +18,6 @@
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
----- */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-=
parport.h
index e572f3aac0f7..4e1294536805 100644
--- a/drivers/i2c/busses/i2c-parport.h
+++ b/drivers/i2c/busses/i2c-parport.h
@@ -12,10 +12,6 @@
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
----- */
=20
 #define PORT_DATA	0
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-p=
asemi.c
index 7a9dce43e115..df1dbc92a024 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -11,10 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7 USA
  */
=20
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-=
pca-isa.c
index 323f061a3163..e0eb4ca0102e 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -12,10 +12,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-pi=
ix4.c
index a6f54ba27e2a..67cbec6796a0 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -11,10 +11,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-p=
mcmsp.c
index 8564768fee32..177834e2d841 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -18,10 +18,6 @@
  *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, O=
R TORT
  *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF
  *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License=
 along
- *  with this program; if not, write  to the Free Software Foundation,=
 Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c=
-powermac.c
index 01e967763c2a..60a53c169ed2 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -14,10 +14,6 @@
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
=20
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
 */
=20
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-=
s3c2410.c
index e3b0337faeb7..65244774bfa3 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -14,10 +14,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
 */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2=
c-sh_mobile.c
index 61b7d7a5a3b2..e887d7a8d209 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -16,10 +16,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
  */
=20
 #include <linux/clk.h>
diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-s=
ibyte.c
index 0fe505d7abe9..2b6219d86b0f 100644
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-13=
07, USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-simtec.c b/drivers/i2c/busses/i2c-s=
imtec.c
index 964e5c6f84ab..15ac8395dcd3 100644
--- a/drivers/i2c/busses/i2c-simtec.c
+++ b/drivers/i2c/busses/i2c-simtec.c
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
 */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-=
sis5595.c
index ac9bc33acef4..7d58a40faf2d 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -11,10 +11,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /* Note: we assume there can only be one SIS5595 with one SMBus interf=
ace */
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index c6366733008d..1e6805b5cef2 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -10,10 +10,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-s=
is96x.c
index 8dc2fc5f74ff..44b904426073 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -10,10 +10,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c=
-taos-evm.c
index 10855a0b7e7f..4c7fc2d47014 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
  */
=20
 #include <linux/delay.h>
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.=
c
index f4a1ed757612..59b1d233ca7b 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -12,10 +12,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-v=
iapro.c
index 6841200b6e50..0ee2646f3b00 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -13,10 +13,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /*
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xii=
c.c
index ade9223912d3..cc65ea0b818f 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  *
  * This code was implemented by Mocean Laboratories AB when porting li=
nux
  * to the automotive development board Russellville. The copyright hol=
der
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx20=
0_acb.c
index ff3f5747e43b..5153354b1a6b 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -17,10 +17,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index f24cc64e2e8c..90e322959303 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -10,11 +10,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6a7f79..17a1853c6c2f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -10,12 +10,7 @@
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-    MA 02110-1301 USA.							     */
+    GNU General Public License for more details.			     */
 /* -------------------------------------------------------------------=
------ */
=20
 /* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>.
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 18a8fd21d2c2..17700bfddcf5 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -10,11 +10,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301 USA.
  */
=20
 #include <linux/rwsem.h>
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 80b47e8ce030..71c7a3975b62 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -14,11 +14,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-    MA 02110-1301 USA.
 */
=20
 /* Note that this is a complete rewrite of Simon Vogl's i2c-dev module=
=2E
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index fc99f0d6b4a5..9ebf9cb4ad7a 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -13,11 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301 USA.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index d241aa295d96..af2a94e1140b 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -13,10 +13,6 @@
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 #define DEBUG 1
--=20
2.1.1
