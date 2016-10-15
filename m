From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/2] i2c: constify i2c_adapter_quirks structures
Date: Sat, 15 Oct 2016 19:32:02 +0200
Message-ID: <1476552722-12352-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Check for i2c_adapter_quirks structures that are only stored in the
quirks field of an i2c_adapter structure.  This field is declared
const, so i2c_adapter_quirks structures that have this property can be
declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct i2c_adapter_quirks i@p = { ... };

@ok@
identifier r.i;
struct i2c_adapter e;
position p;
@@
e.quirks = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct i2c_adapter_quirks e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct i2c_adapter_quirks i = { ... };
// </smpl>

The effect on the layout of the .o files is shown by the following
output of the size command, first before then after the
transformation:

   text    data     bss     dec     hex filename
   3651     472       8    4131    1023 drivers/i2c/busses/i2c-axxia.o
   3683     440       8    4131    1023 drivers/i2c/busses/i2c-axxia.o

   text    data     bss     dec     hex filename
   1069     216       0    1285     505 drivers/i2c/busses/i2c-dln2.o
   1101     192       0    1293     50d drivers/i2c/busses/i2c-dln2.o

   text    data     bss     dec     hex filename
   3211     484       1    3696     e70 drivers/i2c/busses/i2c-viperboard.o
   3243     460       1    3704     e78 drivers/i2c/busses/i2c-viperboard.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/i2c/busses/i2c-axxia.c      |    2 +-
 drivers/i2c/busses/i2c-dln2.c       |    2 +-
 drivers/i2c/busses/i2c-viperboard.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 4351a93..13f0748 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -489,7 +489,7 @@ static u32 axxia_i2c_func(struct i2c_adapter *adap)
 	.functionality = axxia_i2c_func,
 };
 
-static struct i2c_adapter_quirks axxia_i2c_quirks = {
+static const struct i2c_adapter_quirks axxia_i2c_quirks = {
 	.max_read_len = 255,
 	.max_write_len = 255,
 };
diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index 8acda2a..69075a3 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -182,7 +182,7 @@ static u32 dln2_i2c_func(struct i2c_adapter *a)
 	.functionality = dln2_i2c_func,
 };
 
-static struct i2c_adapter_quirks dln2_i2c_quirks = {
+static const struct i2c_adapter_quirks dln2_i2c_quirks = {
 	.max_read_len = DLN2_I2C_MAX_XFER_SIZE,
 	.max_write_len = DLN2_I2C_MAX_XFER_SIZE,
 };
diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 543456a..e4be86b 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -354,7 +354,7 @@ static u32 vprbrd_i2c_func(struct i2c_adapter *i2c)
 	.functionality	= vprbrd_i2c_func,
 };
 
-static struct i2c_adapter_quirks vprbrd_quirks = {
+static const struct i2c_adapter_quirks vprbrd_quirks = {
 	.max_read_len = 2048,
 	.max_write_len = 2048,
 };
