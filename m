Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBD29AAF7;
	Sat, 31 Jan 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769868773; cv=none; b=Mued8wfGHaK8PC89LO4931z97fmdv7N4VWS9qH6DLRWrgFCw2DSroh37JQX31Lfm/NgBdjtGG8388pi1pyre0h7zFXAK39Y13tPzBmzrDUnD8SW/SXtlSFeRqAY2oIhCODIKMSsJbKeAZ5mrL5qNfc2r2Zj6Z4FguWRmaiOzOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769868773; c=relaxed/simple;
	bh=zOg0kfQjDP0HR54Wb/4zXiPTRv5hsERO3K0bsnnYcx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkVTTD2IHvt6QOshF7/PdfHL6iLvEXrS3q+eqngo7ne65faXeHyQbOHz2+ZcQzTIHWh9tUVgOCGBbm5MesIIZ0XqvYNMMUPWpSXiWs09xTPHJuFn6UqfkY7JqZIsEnpdyLr8QZekeZJ4PHxBrZURPNdZRJTyaCJRBmoQ/6Sv1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2/xg7Jg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2/xg7Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 174FBC2BCB2;
	Sat, 31 Jan 2026 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769868773;
	bh=zOg0kfQjDP0HR54Wb/4zXiPTRv5hsERO3K0bsnnYcx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S2/xg7JgBnzjpU/HCU12BcmQgj3EFodwrYj9BS6jr8KjFICixpTcyq2LB9wO2EoXI
	 cRK7AqP94xQ8Kf09DdeMQHapPzViRgBPgyJI4NB0Wcv10mAhUTkTL+yqV8iV7reUw1
	 di8AYwgRJ+XGhFbgaj22/c+b+u9QDyb5DXIB6gdLlaRm1jKw39ZnIMxf4PXXmq8fNb
	 OFKO/LN5UchB2hkWtznCV4pSF2UKSrxWlBGp9Aty1PgYiwWzqpQv4BlcRD6bz1rTm/
	 Ivjc58cXH0mM0PHopGDR7/r0u1ZTBYbuQNfiHk8kvfmNyRC/vhSq6gXghjjVfx6wBw
	 Cckuz9X+pxxpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E7D7976C;
	Sat, 31 Jan 2026 14:12:53 +0000 (UTC)
From: Igor Korotin via B4 Relay <devnull+igor.korotin.linux.gmail.com@kernel.org>
Date: Sat, 31 Jan 2026 14:12:46 +0000
Subject: [PATCH 4/5] rust: i2c: add I2C wrappers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
In-Reply-To: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-i2c@vger.kernel.org, markus.probst@posteo.de, 
 Igor Korotin <igor.korotin.linux@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769868772; l=6310;
 i=igor.korotin.linux@gmail.com; s=20260125; h=from:subject:message-id;
 bh=xiNYPB3pS7P0xBQVQAX6qDtWUnKw7npZg8SdNzhXYa4=;
 b=Ckru9qcxNiYGmCdDkhI5Mp1Q6P6bSRliUUAAG3x2YwBrN/6CsaVzRzwyYvPr8nGcyykkr7P8o
 OVAJmGG4V0cDQMzxLD+rP9JKr9S/AG074vB3APb3xYv9NS8WTiImeKy
X-Developer-Key: i=igor.korotin.linux@gmail.com; a=ed25519;
 pk=SjZ//wxnynZgJJgTqANyU10A7hdQQdDXLvXIr+zWroE=
X-Endpoint-Received: by B4 Relay for igor.korotin.linux@gmail.com/20260125
 with auth_id=615
X-Original-From: Igor Korotin <igor.korotin.linux@gmail.com>
Reply-To: igor.korotin.linux@gmail.com

From: Igor Korotin <igor.korotin.linux@gmail.com>

Add safe Rust wrappers for common I2C/SMbus operations on I2C clients.

These wrappers provide safe abstractions over low-level C API calls:
- SMbus byte operations: read/write byte and byte data
- SMbus word operations: read/write word data
- SMbus block operations: read/write I2C block data
- Master I2C operations: master receive and master send

All operations include proper error handling through the Result type.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/i2c.c        | 15 ++++++++
 rust/kernel/i2c/client.rs | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c72762ad9c..6f6b0ff8713a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -29,6 +29,7 @@
 #include "err.c"
 #include "irq.c"
 #include "fs.c"
+#include "i2c.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/helpers/i2c.c b/rust/helpers/i2c.c
new file mode 100644
index 000000000000..05bbd26eaaf8
--- /dev/null
+++ b/rust/helpers/i2c.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/i2c.h>
+
+__rust_helper int rust_helper_i2c_master_recv(const struct i2c_client *client,
+				  char *buf, int count)
+{
+	return i2c_master_recv(client, buf, count);
+}
+
+__rust_helper int rust_helper_i2c_master_send(const struct i2c_client *client,
+				  const char *buf, int count)
+{
+	return i2c_master_send(client, buf, count);
+}
diff --git a/rust/kernel/i2c/client.rs b/rust/kernel/i2c/client.rs
index a597793ff038..76fa01cb0351 100644
--- a/rust/kernel/i2c/client.rs
+++ b/rust/kernel/i2c/client.rs
@@ -140,6 +140,98 @@ unsafe impl Send for I2cClient {}
 // (i.e. `I2cClient<Normal>) are thread safe.
 unsafe impl Sync for I2cClient {}
 
+impl I2cClient<device::Normal> {
+    /// The C `i2c_smbus_read_byte` function wrapper for SMbus "read byte" protocol
+    pub fn i2c_smbus_read_byte(&self) -> Result<u8> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result = unsafe { bindings::i2c_smbus_read_byte(self.as_raw()) };
+        to_result(result)?;
+        Ok(result as u8)
+    }
+
+    /// The C `i2c_smbus_write_byte` function wrapper for SMbus "write byte" protocol
+    pub fn i2c_smbus_write_byte(&self, value: u8) -> Result {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        to_result(unsafe { bindings::i2c_smbus_write_byte(self.as_raw(), value) })
+    }
+
+    /// The C `i2c_smbus_read_byte_data` function wrapper for SMbus "read byte" protocol
+    pub fn i2c_smbus_read_byte_data(&self, command: u8) -> Result<u8> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), command) };
+        to_result(result)?;
+        Ok(result as u8)
+    }
+
+    /// The C `i2c_smbus_write_byte_data` function wrapper for SMbus "write byte" protocol
+    pub fn i2c_smbus_write_byte_data(&self, command: u8, value: u8) -> Result {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        to_result(unsafe { bindings::i2c_smbus_write_byte_data(self.as_raw(), command, value) })
+    }
+
+    /// The C `i2c_smbus_read_word_data` function wrapper for SMbus "read word" protocol
+    pub fn i2c_smbus_read_word_data(&self, command: u8) -> Result<u16> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), command) };
+        to_result(result)?;
+        Ok(result as u16)
+    }
+
+    /// The C `i2c_smbus_write_word_data` function wrapper for SMbus "write word" protocol
+    pub fn i2c_smbus_write_word_data(&self, command: u8, value: u16) -> Result {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        to_result(unsafe { bindings::i2c_smbus_write_word_data(self.as_raw(), command, value) })
+    }
+
+    /// The C `i2c_smbus_read_i2c_block_data` function wrapper for SMbus "block read" protocol
+    pub fn i2c_smbus_read_i2c_block_data(&self, command: u8, values: &mut [u8]) -> Result<usize> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result = unsafe {
+            bindings::i2c_smbus_read_i2c_block_data(
+                self.as_raw(),
+                command,
+                values.len() as u8,
+                values.as_mut_ptr(),
+            )
+        };
+        to_result(result)?;
+        Ok(result as usize)
+    }
+
+    /// The C `i2c_smbus_write_i2c_block_data` function wrapper for SMbus "block write" protocol
+    pub fn i2c_smbus_write_i2c_block_data(&self, command: u8, values: &[u8]) -> Result {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        to_result(unsafe {
+            bindings::i2c_smbus_write_i2c_block_data(
+                self.as_raw(),
+                command,
+                values.len() as u8,
+                values.as_ptr(),
+            )
+        })
+    }
+
+    /// The C `i2c_master_recv` function wrapper to issue a single I2C message in master
+    /// receive mode
+    pub fn i2c_master_recv(&self, buf: &mut [u8]) -> Result<usize> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result =
+            unsafe { bindings::i2c_master_recv(self.as_raw(), buf.as_mut_ptr(), buf.len() as i32) };
+        to_result(result)?;
+        Ok(result as usize)
+    }
+
+    /// The C `i2c_master_send` function wrapper to issue a single I2C message in master
+    /// transmit mode
+    pub fn i2c_master_send(&self, buf: &[u8]) -> Result<usize> {
+        // SAFETY: self is a valid reference to a I2cClient<Normal>
+        let result =
+            unsafe { bindings::i2c_master_send(self.as_raw(), buf.as_ptr(), buf.len() as i32) };
+        to_result(result)?;
+        Ok(result as usize)
+    }
+}
+
 /// The registration of an i2c client device.
 ///
 /// This type represents the registration of a [`struct i2c_client`]. When an instance of this

-- 
2.43.0


