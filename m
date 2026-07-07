Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7203E9C2F
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437460; cv=none; b=ioJS+KMgQf3cOD+ok0FRJd8dYk3u+2QXJ6S7tbB2aGCEFf+S6+73W3jm/Sv4uMqxCOeGY2W+3gNou10X8MbymOacJwhU3Wo9TubMGYvOrZDZVV2aoYSmJeIqA/O9Eo8YN6huzwQmyxnaTd/M6Kgs9KWL9Musz7HxYedo7zVjysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437460; c=relaxed/simple;
	bh=Z8LhBsjXItHEMNM4TR044coWHllc6oZ/YAXNQH0osuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o//BqmPANzvQlIAzV/8yuTKtEOm98jueUNYYWB5naAksdtOsp2n5G7wvEVcCJgty2V5mcqgmulLQzTWPv1VAnQfHTVPEVT3UI63R3JfAzCt6mxiyrNWsfAdLkV7gksOtI54tM1a1DBowAdeVHylK+hWAmxgHOjnH5U57G2r4jBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyWWuGpZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyWWuGpZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847a483e344so994430b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437458; x=1784042258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etAGJOjl2S+5CmKbtIQYaUZTk3Wz8jaGhbuGeikcUyQ=;
        b=EyWWuGpZAPFSRo1a12o9SZ9hCZtWtVAvQrnHhxfX6tLi5L16QHHPQl37udCWjER/Yx
         HyW8sJnz26QxTs8TQ5QJaNPtfhcZ+r23smfexk0uDc47i8cwcmiDBa8XpGkBrRPNm1QI
         vF/ilvYlhvGujpE6Ex0h1usOUwxwM5t8pDJnwLdHmJNBPnvKC6aU9AVrn9jRgQOQQ8I6
         HvBSVnuyoUruTs3v1+zmBgwwrEGcr9TfEw+SCiJldkSRJKkaKUlIIliqJy4L52nlhsFN
         Kqh0g+OsQsBMRzs4JJgkNZCzM128eD+IW7XHSA+8yC5xTXoXsSvRX5ImYs4TH7SNenGc
         A/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437458; x=1784042258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=etAGJOjl2S+5CmKbtIQYaUZTk3Wz8jaGhbuGeikcUyQ=;
        b=ZD2MklZyqGrWMSad3C5WPNRCRXRgxShYrAlbkSh7pop9uA2NYjqpWnkuxRAgTLKfpL
         PT35VzGTwmWsJI+TQktauTzjh0f9yqHww2JTRJS1QytHb9tgOlEC6TFdWjWyoj/REXE/
         AUxU8qdYzOLBypeCTB40b0DbVq1roDHyI7e6vKIkEsUImfHvqjh2HYgYmTa637HvXCry
         txki/n8bPCyELnBZPr50C1GSa9Vh8HEmBGixGfZH1dPGmXGvLtNoyXxM1NCSnG4HYXai
         SqoSQ3zdr3X4HmCodfKj4ZC47gFT79y+zEbe05hQZfOodqSWOc/1OAATx5RiJFPoC7Sr
         KPMg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ81Xi46dyiN9enap+AgHmff+mEwE4o/pnZg8FWgLZH9+X0VjLA45cyzvLL7GbbZmlDmQGLg7GZdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+ekhr/EiLyG+gcZllLDPPdhsJJMzaVs0XgbQe3+9wG++AwL3
	owU0AvlzXndv3Dp460vzYSa8TmzKYEy/Qg68h39jyyYbf/wYDPvsLdTj
X-Gm-Gg: AfdE7cnwTwUs6u33WDxKEo+954VhyPnrCHu8FPk4EOfk+ZyGlt9lDCNivRyB057f/vC
	xsGttnNfCue2MEhUydlOsc8F42FQfv+vGeqnUI1/wt6BogjVlDLaIOwz0BlePopvog03Kwkch26
	1Me43XivsUeJ5zqsr5du7Xgt0iMH+L+DjKsRtkXapx2Fpt78sa7YYPuyjxg2M/omlHQQ4nPylo/
	wRg/oiL00npVYo9V0EPHpF198QhVQDpsitFUEvs2QapyM+Sfq3BYAYMLsF0h9xbQvDJZoaNIXpU
	9i9FwnBmIpgiIzBBM0uNE4n3kKVlAI/gKuu7Clb1anJJ3pfw+mduVJDXZeCqoqf6cZLSt9+t4TZ
	tkzBDoa451CyllZ97JdRi3YIFaIGSnDq7Qk6rF8FzR+tVtZntmJFak1zH7YCf1oLg5tLXVPtDQV
	PX4EZiS62shIks1cbTDyUjK8h5xRv6f99i3cocI7s9+j4ARjLH9XqAa2YlCuYrsAcEVQ==
X-Received: by 2002:a05:6a00:1816:b0:845:3033:6cbb with SMTP id d2e1a72fcca58-8482f1f0eecmr3099600b3a.11.1783437458045;
        Tue, 07 Jul 2026 08:17:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2003:63bf:6d1c:a790:1205:96eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm5724397b3a.28.2026.07.07.08.17.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 08:17:37 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com,
	ojeda@kernel.org,
	dakr@kernel.org,
	igor.korotin@linux.dev,
	branstj@gmail.com,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction via kernel::io::Io for I2cClient
Date: Tue,  7 Jul 2026 22:15:40 +0700
Message-ID: <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the Io trait for I2cClient, providing SMBus byte and word
read/write operations with automatic offset validation via io_addr().

I2cClient implements the generic Io trait rather than exposing
standalone SMBus methods, following the direction established in [1]
and [2]. The underlying calls are still i2c_smbus_read_byte_data and
i2c_smbus_read_word_data.

I2cClient now implements IoCapable<u8> and IoCapable<u16> with
maxsize=256 (SMBus command byte range 0x00-0xFF, not the 7-bit
device address which is handled by the I2C core at adapter level).

Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/i2c.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..31c7216d0299 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -14,6 +14,7 @@
     devres::Devres,
     driver,
     error::*,
+    io::{Io, IoCapable},
     of,
     prelude::*,
     sync::aref::{
@@ -601,3 +602,91 @@ unsafe impl Send for Registration {}
 // SAFETY: `Registration` offers no interior mutability (no mutation through &self
 // and no mutable access is exposed)
 unsafe impl Sync for Registration {}
+
+impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
+    unsafe fn io_read(&self, address: usize) -> u8 {
+        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer
+        // (type invariant). `address` was pre-validated by io_addr() before
+        // this function is called (trait contract).
+        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), address as u8) };
+
+        // NOTE: Error is lost here. This is only called via try_read() which
+        // first validates bounds via io_addr(). For I2C, the caller should
+        // always use try_read8() which provides proper error handling.
+        ret as u8
+    }
+
+    unsafe fn io_write(&self, value: u8, address: usize) {
+        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
+        // `address` pre-validated by io_addr().
+        unsafe { bindings::i2c_smbus_write_byte_data(self.as_raw(), address as u8, value) };
+        // NOTE: Return value is ignored. `IoCapable` trait signature does not
+        // support error returns. Use with caution.
+    }
+}
+
+impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {
+    unsafe fn io_read(&self, address: usize) -> u16 {
+        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
+        // `address` pre-validated by io_addr().
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), address as u8) };
+
+        // NOTE: Error is lost here. See u8 implementation note.
+        ret as u16
+    }
+
+    unsafe fn io_write(&self, value: u16, address: usize) {
+        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
+        // `address` pre-validated by io_addr().
+        unsafe { bindings::i2c_smbus_write_word_data(self.as_raw(), address as u8, value) };
+        // NOTE: Return value is ignored.
+    }
+}
+
+impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// SMBus command byte range: 0x00-0xFF (256 possible register addresses).
+    /// This is NOT the 7-bit device address; that is handled by the I2C core.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        256
+    }
+
+    #[inline]
+    fn try_read8(&self, offset: usize) -> Result<u8>
+    where
+        Self: IoCapable<u8>,
+    {
+        let reg = self.io_addr::<u8>(offset)? as u8;
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
+        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
+        // by `io_addr()` above (offset + 1 <= 256).
+        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u8)
+        }
+    }
+
+    #[inline]
+    fn try_read16(&self, offset: usize) -> Result<u16>
+    where
+        Self: IoCapable<u16>,
+    {
+        let reg = self.io_addr::<u16>(offset)? as u8;
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
+        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
+        // by `io_addr()` above (offset + 2 <= 256).
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+}
-- 
2.50.0

