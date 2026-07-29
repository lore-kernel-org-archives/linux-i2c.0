Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E34BA20
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785304831; cv=none; b=JLTdYAAynE1NvixqQegRisQScyU1ZqHfIr8x/M2wViPxwm4ydtmSf4Wcr+xMSv1S9F+vvhRput6F0E5CTtAkKD4fUZodwFfUBkGqynzsGbT+xDtuWNfZP8Sg9cJcx9CpyjZ/Qmed5AVBvzKvK9wf+qvHdfW5fuAxKauu1D6KaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785304831; c=relaxed/simple;
	bh=3uOFEjPnMnUccJZMetPT3Gaw/TbJJKA+mh1hwKmYbz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZipPPif8UKW1CPlyyd9RNxqOHlxjLr0S4eB9td5NaxHVmLoDB68qzIfkDMjTzQOL2BngH0IlbLo5U2ZPxgVL8+QOd8NABVkpd5A2W7J352mZUEj8D9eoAdrJRxO4i/7zRr41GMFRkoQFGDFiITBhoNHvmRdnLv3zj+vo0SVRv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtiTONOW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtiTONOW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso376021a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785304827; x=1785909627; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3U12xTMjb/SxJ8KmAFJLEVtQeA5qw3lxjMjThYvljA=;
        b=BtiTONOWATUdjuFHZZ/86ez5oNfTXiR/6o0o506HwXQcVzmrU163DWKHE57OjQtSWf
         m42KvYqkOv3cV1WpQtWBdkw/gvMc73COxUD9Xkhs/PxbH+Sej01+BQG3g+VPYXEbB0FV
         Y2mvimOVNxyqvJeDWY0vOoY7Yk9TKfgurIg9FGt3TgnFC72Uu5BTlG04tjQ15OtTnjj5
         9hR9stCkZ8Qzqc4jo5rEXltqmvBQl2863YuFNyRVXluRxN/JgL4MnPK//RsTCWk2nUWJ
         ZdMeM2fqx9nBC/m4XdmW/lyfDA6oFEv82v+pCM4oIKgquuROYO2O0cA3t60DXwKARq0Q
         0LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785304827; x=1785909627;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3U12xTMjb/SxJ8KmAFJLEVtQeA5qw3lxjMjThYvljA=;
        b=STKaYz5C3J26qjY+8Z5n5uA9e6kU6uoPn6IIpOTa6ysH2A6gFlMDLfrzjxFrnHjaUU
         O9xI4MYAdLlbzamCa/vbr1DQcNhjtNd7jaTfzTEBtgmCwZd8h10OxivLGq+t57C+VQiX
         3/D6DF+OEwUZX9i3xj4sxU/f06HsfXiWIxrar6uDBRgpcpMtYUMqrNhO0OY0F8cVbxSS
         VqUElAyyYOkLCPSuFvgUPtaID7mIaWjlEWLgd84u9S8fwBrrRzQkqw3oOY7dQT4qdyNy
         YzdQ3EadV6eRlTQxcmND7sr2TzglCuDJviPy0S2DxFS9Y4BGJR+Dj4BMa+C7oSKfFt4U
         40Mg==
X-Forwarded-Encrypted: i=1; AHgh+RrgYkm2B2IW+h7a+V0HrlwYruTVWJN+uuQ17xtPcc9oZl5feygSKvAY3O5EOW7dG04Die6a86BKYVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ucLR7xSh9MKQPa0EVPRmU9T1VOhDvT/iaLZSaqjJoJ8f8vFU
	th5YcD+s9Ejnpu6z9PyJkORWtt/H8Sn7DIlHl62dHK7KMTmRB7SVm2TE
X-Gm-Gg: AR+sD11Ss4ADTOCvcyTUgvnA9v5vn36YWkjOIBtl51+gaGIcSYavPCD2WF2yjvhPBcH
	GqWEucjSsgwvP6F+n0yTc6qfCRPzqG1Gat7fJ0tbORmdkfAiIMuh4D8u6IHEBl/fmfllMOShTnX
	o5QZAIAzDby+s+6G/rcZq0D1uQk983uBE4gfas3UXcokjqU5Jbuco3SyEILIwUC1LjdlohtFP+w
	78/Kfi/g69+SZhspAhLsF77ZcJMmUjigHqqIEmxUGgRp5zwSRgsZ+v0Rus4xzpdrPnNWOXHXMlH
	6SbLwJoSdb12xhNHhWH4JntW7LzUGyxJYL+ps7KSwodz8u8YnC5exI8QYEVQOZtxg+Jpwwiv1F1
	o6fc2FPTq8aCJppez3OvYM2Sdkj8/kVc7rxS69CxQEzRjzd7NAP+2OeTnpC1K+R1DxSTJ+BzcR3
	CAKDm5uTjw00IU14dBegQTBmeeRs1ljdWTxlKMwWSLgO7JmnQgWTc2axOG/SsuPPXn2wRh3BvSj
	t4lXARFFNyW/3upbBY9P9kffZLGFg==
X-Received: by 2002:a05:6a21:4685:b0:3c3:f5ff:8c9b with SMTP id adf61e73a8af0-3c8ba70c0bbmr6325745637.71.1785304827393;
        Tue, 28 Jul 2026 23:00:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3062:3727:f62a:314c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b67063sm6302046eec.9.2026.07.28.23.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 23:00:26 -0700 (PDT)
Date: Tue, 28 Jul 2026 23:00:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <ammWUROtUGeriY8G@google.com>
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
that it will not copy more data than the size of the buffer. Signal
oversized responses with -EMSGSIZE.

To allow users to gradually transition to the new API employ some
macro trickery allowing calling i2c_smbus_read_block_data() with either
3 or 4 arguments. When called with 3 arguments it is assumed that
the buffer size is I2C_SMBUS_BLOCK_MAX bytes. Once everyone is
transitioned to the 4 argument form the macros should be removed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2:
- dropped incorrect changes to Documentation (Andi)
- signal oversized responses with -EMSGSIZE (Andi)

 drivers/i2c/i2c-core-smbus.c | 24 ++++++++++++++++--------
 include/linux/i2c.h          | 19 +++++++++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index fa63bee0b345..57f55bbab8a1 100644
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
@@ -222,22 +222,30 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
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
+	ret_len = data.block[0];
+	if (ret_len > length)
+		return -EMSGSIZE;
+
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
2.55.0.487.gaf234c4eb3-goog


-- 
Dmitry
