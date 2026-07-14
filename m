Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051318A92F
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997164; cv=none; b=mDNwI0NNoA9pLtU/Cptnshj6wA4TNktEXi6oSW9Nbu2kENu0XKCwAAFsUHZ9FQjM8Lu86cJn0JkaJJH07Pkd1paWy+Dv8AVxw6g7yUkv1thD4Tyhs2JdyhdW9OgoHAUtFWUsHazwM6Yiy+FtKCGNCRd3IApZENiWX6JJ7KN119Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997164; c=relaxed/simple;
	bh=EeaJNaqRnue1bgIzFqPqf0kMfERKEhuD4YNZ2h33bCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yd6/B3j1uWa0FfM5T+0sj+htB6NK6Z1SjhKKJ9Zvh1w6nqWBVovi49FhE/cPKwDz5s6znAsC8qszP7xzSkMrX8/Pwh2m0VCCIBnCfvDl7K8ik7x0ULEkIIbcpNzFBCZI7DriGvnFBexFi7AUKp1bjeyZnStwxMae2eSaSqRYwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwOiqE3u; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwOiqE3u"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848882fdb18so235750b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783997160; x=1784601960; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5Xzqovkf4r6l1cNh02uht94WcMA18Xgy8viIdBKimo=;
        b=AwOiqE3uAW95SWf0K6zWOR++kb0R040aS3O/Nxo74N7sdlOa3H8nqXyl3WsE2u/2+Y
         iJMU1suPdWUyIEt90spV9+KtXG2PGBVX1tNwHGveNBvI2hKhopGMf7S2BNeATAdSgzvh
         8a5UmbWkuK9HdTMzrmM54stp0YTIrL9E4ADYsD0m0awaSDJy3wwvC64iIGWqz9VBwafd
         Zh1yLx1+63y5xNnN0NtxaCvZwSkdJWbV/bZ6cLS+kseq3ALnFykP7oJ4sSn4apL/F/RF
         TUpsX7fMexGz+bn1f4DhUtGRlVDgtqBSNZFX8CfdP4u5f105s8rDLRamM/7gD9MteP9q
         j2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997160; x=1784601960;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5Xzqovkf4r6l1cNh02uht94WcMA18Xgy8viIdBKimo=;
        b=o2j1LrB4b+K8SpCwElC9+2+Li3ArVA0ZnkLoa6yXOm0DLF5t2fthyfMIwWPQy2SfxY
         athy2lqjVTl/CkFVTC8J/UWItfhroHhV0veo1UjaFBb0hj8a2tVz//cJ585iNINCM5aj
         w3UyAKDUAuwoXftw8FxwHQsH3XBr2XFjve6XtzSex+/HZ5D4JtmpQSRAYlbTZHPw9Bo9
         1MsAgRTMkxQgSGmOxur85debYRzsblXtRNMdL3DQ2/TdCul3zheQ3nlD+BHf9/xKFvZB
         jv5oki/fUA7nN6u3ra0NlQKx0c33ygBkyiAd3d+8C76QFZMvrpOPHGnwZGsjtPUTGa+M
         q40A==
X-Forwarded-Encrypted: i=1; AHgh+RoekRgNZO1Zdg+btdfEqQffZUkWocnHnjhelcY5SiVfa8CxRoFFGpBfBb2RMvttjJmHsXdGf/DWK5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJIraltMUghbeFWKTZU8qcKsR+rN1IFo1t5UOyNnv1TEGD8hD
	tAE76ZX3y3hV4BUS4BVhoFpsFjH6x7y48k9gexjU2scYXEZFm8xW1V2+OB84lQ==
X-Gm-Gg: AfdE7cnafY9XC8U78b49KUKt2wVtOG1gh8iyPhePIgm03PDG4vxn0JYemdLaw/QJT40
	5bYQo8BqPADmIAsrvKM+HQaBYx2igA6NYDZdnseVz4xfntSbNRBD3DoEVUyXNySQ+kL6tuNJG5T
	B9RRqk4qIib8/blLbr+G9ZVpCyvzJIzgIx2OS4avKasIBaUqAxNxVhbhjqyBfcwWaOVMLBnJ1dp
	Y9bvyglCUnbSWhDu4OMsPvVqQxRX9S8Jy4sEA4Mq6KsR3m+BUY+mbOTFR/CpbdB6gi31RP9FDim
	xzTshYTuqvB6Q1Zx7YXCvVwP2D7LPs1RdaugCKRbWpCMNpl0lf/1lrajKEvpnaykVqt3vnOTERy
	YAjAotq/5kxyWBndXLvsh22qPUPJMGVD4ZEMq+KRoQom2URlA9+LEQdfvaR24VWYTwmOYeLNuWa
	pGyK6ZS+VnExMad2ZRp831RSKvfeUgyVkidbjZirK6fhAXQcHxMj5EcomeaXX1XLZo
X-Received: by 2002:a05:6a21:178a:b0:3c0:9c19:65bc with SMTP id adf61e73a8af0-3c110a6f523mr10997986637.68.1783997160047;
        Mon, 13 Jul 2026 19:46:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm40985785eec.15.2026.07.13.19.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:45:59 -0700 (PDT)
Date: Mon, 13 Jul 2026 19:45:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <alWiYfNDrOfo66HM@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i2c_smbus_read_block_data() is dangerous to use because it may deliver
up to I2C_SMBUS_BLOCK_MAX (32) bytes, which may be surprising to the
caller. Callers tend to allocate buffers of sizes big enough to hold
data from a well-behaving device and do not expect that
i2c_smbus_read_block_data() may attempt to write more data than
expected.

To make i2c_smbus_read_block_data() safer to use, change it so that
it accepts size of the supplied buffer as another argument and ensure
that it will not copy more data than the size of the buffer.

To allow users to gradually transition to the new API employ some
macro trickery allowing calling i2c_smbus_read_block_data() with either
3 or 4 arguments. When called with 3 arguments it is assumed that
the buffer size is I2C_SMBUS_BLOCK_MAX bytes. Once everyone is
transitioned to the 4 argument form the macros should be removed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This was sent out in October of '24 but unfortunately I did not get a
reply from Wolfram...

 Documentation/i2c/dev-interface.rst |  5 +++--
 drivers/i2c/i2c-core-smbus.c        | 21 +++++++++++++--------
 include/linux/i2c.h                 | 19 +++++++++++++++++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
index c277a8e1202b..4df5330aca00 100644
--- a/Documentation/i2c/dev-interface.rst
+++ b/Documentation/i2c/dev-interface.rst
@@ -161,9 +161,10 @@ for details) through the following functions::
   __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_block_process_call(int file, __u8 command, __u8 length,
                                      __u8 *values);
-  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
+  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 length,
+                                  __u8 *values);
   __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
-                                   __u8 *values);
+                                   const __u8 *values);
 
 All these transactions return -1 on failure; you can read errno to see
 what happened. The 'write' transactions return 0 on success; the
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index fa63bee0b345..1be0a47c6b30 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -208,11 +208,11 @@ s32 i2c_smbus_write_word_data(const struct i2c_client *client, u8 command,
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 
 /**
- * i2c_smbus_read_block_data - SMBus "block read" protocol
+ * __i2c_smbus_read_block_data - SMBus "block read" protocol
  * @client: Handle to slave device
  * @command: Byte interpreted by slave
- * @values: Byte array into which data will be read; big enough to hold
- *	the data returned by the slave.  SMBus allows at most 32 bytes.
+ * @length: size of the @values array. SMBus allows at most 32 bytes
+ * @values: Byte array into which data will be read
  *
  * This executes the SMBus "block read" protocol, returning negative errno
  * else the number of data bytes in the slave's response.
@@ -222,22 +222,27 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
  * support this; its emulation through I2C messaging relies on a specific
  * mechanism (I2C_M_RECV_LEN) which may not be implemented.
  */
-s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
-			      u8 *values)
+s32 __i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
+				u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
+	int ret_len;
 	int status;
 
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		return -EINVAL;
+
 	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
 				I2C_SMBUS_READ, command,
 				I2C_SMBUS_BLOCK_DATA, &data);
 	if (status)
 		return status;
 
-	memcpy(values, &data.block[1], data.block[0]);
-	return data.block[0];
+	ret_len = min(length, data.block[0]);
+	memcpy(values, &data.block[1], ret_len);
+	return ret_len;
 }
-EXPORT_SYMBOL(i2c_smbus_read_block_data);
+EXPORT_SYMBOL(__i2c_smbus_read_block_data);
 
 /**
  * i2c_smbus_write_block_data - SMBus "block write" protocol
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 14ab4d3055af..3e685476fa15 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -174,8 +174,23 @@ i2c_smbus_write_word_swapped(const struct i2c_client *client,
 }
 
 /* Returns the number of read bytes */
-s32 i2c_smbus_read_block_data(const struct i2c_client *client,
-			      u8 command, u8 *values);
+s32 __i2c_smbus_read_block_data(const struct i2c_client *client,
+				u8 command, u8 length, u8 *values);
+/*
+ * This monstrosity allows to call i2c_smbus_read_block_data() with either
+ * 3 or 4 arguments and will be removed once all users have been switched
+ * to the 4 argument version.
+ */
+#define __i2c_smbus_read_block_data_3arg(client, cmd, values)			\
+	__i2c_smbus_read_block_data(client, cmd, I2C_SMBUS_BLOCK_MAX, values)
+#define __i2c_smbus_read_block_data_4arg(client, cmd, length, values)		\
+	__i2c_smbus_read_block_data(client, cmd, length, values)
+#define __i2c_smbus_read_block_data_impl(_1, _2, _3, _4, impl, ...) impl
+#define i2c_smbus_read_block_data(client, cmd, varargs...)			\
+	__i2c_smbus_read_block_data_impl(client, cmd, varargs,			\
+					 __i2c_smbus_read_block_data_4arg,	\
+					 __i2c_smbus_read_block_data_3arg)	\
+					 (client, cmd, varargs)
 s32 i2c_smbus_write_block_data(const struct i2c_client *client,
 			       u8 command, u8 length, const u8 *values);
 /* Returns the number of read bytes */
-- 
2.55.0.795.g602f6c329a-goog


-- 
Dmitry
