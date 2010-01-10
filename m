From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] i2c-ali1563: remove sparse warnings
Date: Sun, 10 Jan 2010 15:33:23 +0100
Message-ID: <4B49E533.8050808@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <cocci-bounces@diku.dk>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, cocci@diku.dk, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

Remove the following sparse warnings (see "make C=3D1"):
 * drivers/i2c/busses/i2c-ali1563.c:91:3: warning: do-while statement is =
not a compound statement
 * drivers/i2c/busses/i2c-ali1563.c:161:3: warning: do-while statement is=
 not a compound statement

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
---
--- linux/drivers/i2c/busses/i2c-ali1563.c.orig	2010-01-10 13:40:31.00000=
0000 +0100
+++ linux/drivers/i2c/busses/i2c-ali1563.c	2010-01-10 13:54:16.000000000 =
+0100
@@ -87,9 +87,9 @@
 	outb_p(inb_p(SMB_HST_CNTL2) | HST_CNTL2_START, SMB_HST_CNTL2);

 	timeout =3D ALI1563_MAX_TIMEOUT;
-	do
+	do {
 		msleep(1);
-	while (((data =3D inb_p(SMB_HST_STS)) & HST_STS_BUSY) && --timeout);
+	} while (((data =3D inb_p(SMB_HST_STS)) & HST_STS_BUSY) && --timeout);

 	dev_dbg(&a->dev, "Transaction (post): STS=3D%02x, CNTL1=3D%02x, "
 		"CNTL2=3D%02x, CMD=3D%02x, ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n",
@@ -157,9 +157,9 @@
 	outb_p(inb_p(SMB_HST_CNTL2) | HST_CNTL2_START, SMB_HST_CNTL2);

 	timeout =3D ALI1563_MAX_TIMEOUT;
-	do
+	do {
 		msleep(1);
-	while (!((data =3D inb_p(SMB_HST_STS)) & HST_STS_DONE) && --timeout);
+	} while (!((data =3D inb_p(SMB_HST_STS)) & HST_STS_DONE) && --timeout);

 	dev_dbg(&a->dev, "Block (post): STS=3D%02x, CNTL1=3D%02x, "
 		"CNTL2=3D%02x, CMD=3D%02x, ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n",
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
