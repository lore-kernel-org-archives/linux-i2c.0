From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] char/tpm: Convert struct i2c_msg initialization to C99 format
Date: Wed, 10 Oct 2012 17:01:52 +0530
Message-ID: <CAM=Q2cv2-85S7NoVEpcuCohQs=CFxKcyVdm62g4d5q7pJzcpXg@mail.gmail.com>
References: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
	<20121010110638.498f0a50@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121010110638.498f0a50-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, tpmdd-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org, tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 10, 2012 at 2:36 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, 9 Oct 2012 17:12:31 +0530, Shubhrajyoti D wrote:
Thanks for review updated patch below
>From f3786807bbaafe1f0dfcf2d94e3bee1c273296a4 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Date: Mon, 17 Sep 2012 19:34:37 +0530
Subject: [PATCHv2] char/tpm: Convert struct i2c_msg initialization to C99
 format

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
v2: removed zero initialisation of flags.

 drivers/char/tpm/tpm_i2c_infineon.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c
b/drivers/char/tpm/tpm_i2c_infineon.c
index 5a831ae..cbf72e1 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -90,8 +90,17 @@ static struct i2c_driver tpm_tis_i2c_driver;
 static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 {

-	struct i2c_msg msg1 = { tpm_dev.client->addr, 0, 1, &addr };
-	struct i2c_msg msg2 = { tpm_dev.client->addr, I2C_M_RD, len, buffer };
+	struct i2c_msg msg1 = {
+		.addr = tpm_dev.client->addr,
+		.len = 1,
+		.buf = &addr
+	};
+	struct i2c_msg msg2 = {
+		.addr = tpm_dev.client->addr,
+		.flags = I2C_M_RD,
+		.len = len,
+		.buf = buffer
+	};

 	int rc;
 	int count;
@@ -138,7 +147,11 @@ static int iic_tpm_write_generic(u8 addr, u8
*buffer, size_t len,
 	int rc = -EIO;
 	int count;

-	struct i2c_msg msg1 = { tpm_dev.client->addr, 0, len + 1, tpm_dev.buf };
+	struct i2c_msg msg1 = {
+			.addr = tpm_dev.client->addr,
+			.len = len + 1,
+			.buf = tpm_dev.buf
+	};

 	if (len > TPM_BUFSIZE)
 		return -EINVAL;
-- 
1.7.5.4
