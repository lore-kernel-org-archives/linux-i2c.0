Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239876;
	b=v1nB0GFLm7paPqLltQv1+3xvpgYoJTsDvY9QooSnZ5NhgMbCwwRDHbF8TK3GVUJ7x0rx
	 FFG8Mth7F5WYOuZBr/k6iWzQnYFVpR5e3uIeAFIfV/JiylbmqL8DF9ZYZb5/0JnRqeYTc
	 WxPpdZscqbXz3Nds1sKx/UcHrB8kfCLGjFSydnf0m1wSm01Tl6OPHlwI0gkCtCsGhjFVn
	 G33OnsGNffVo3//DAfuTIdI2mYOROnUXrxUhb6LrIIyi4e2OSuDjg/Wjn9FZw9m/6ndKM
	 g6uBdpKsBIptrHshswiOcpFJsUy6QYY2EO27iUDr9AmiTlyy4Z7GQW+9ZYammvdZ9nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZbCaAvhWgcepykM7cYCVdmIyX9bkP8mLlamURxwhqqk=;
	b=Woin2J9I/oZvELKwu0w2GihP42TaBQfzp0dzvFHWV/dEiMkStlDpwHdHOl2E6X+k3Y44
	 z6GQ9xlRzk/8lymoH/anPg1rMBkl6ITJkXQHI22iMOilVqf9TPhREgwwJTFk4aONb3S48
	 BauhHHdSn2ApmRlGOrhJC7FE3bAWrsPoeI8q7WWV2Z/oe8tQs55azRZ+oPgUrenKep6PX
	 RknBsWxNmrwvIposv0uPd6XwUhfDqOTPYaxnDuScNZ2Otcabv6E5z/MCYKpZuqbJgXndJ
	 kLQN5yMef9Q3dJhrugfFkMaFE8ezvoyMb2VWszSmeTKyzL/FOhu7VOSVt2U8uN39aIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B14uSwoy;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24359606A325
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 15:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24359606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B14uSwoy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so721338c88.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239875; x=1794844675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZbCaAvhWgcepykM7cYCVdmIyX9bkP8mLlamURxwhqqk=;
        b=B14uSwoyg1MXiLAGKW6ufM9e0xwbC3uuMIdAEj7Ip2Zn70YdhLB0A16ZCP6Ujpv5kW
         cehl/8c9UKe/BBMCXp6yALVCXobe4Uyg5uUycaDTXjtIbjU8Stfl2VjpwzWNqoVX9Izo
         aoNjXR7+ySgFOEu0k4QiE+JMnbnlOQ383NBeGzZhsWX743SWiQEkUfmfB6e9OQ09XWjD
         uDfMNJgtnp4aAtPB1MRuEiX6IF/cZQ7HhI9YHdW5+1aQEtyg7gqdWKtd/9iMZ63h7BVg
         xM1hlOu/RaI6R4ho8MdZvGckL7axwGbbYd9S+mf7m/qBzSJBPsmYBauyDB90uNhomKQ9
         2rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239875; x=1794844675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZbCaAvhWgcepykM7cYCVdmIyX9bkP8mLlamURxwhqqk=;
        b=UspMJnwIyddyGl1Gz1QfOxkISQKX7bROC9mGylyHhqCU+J8aRxIjPC07he97whhVQU
         3G1TBWTWu5f3SEvYUMaYoZDYktfNyeRqwe/WUwk4vQ1rha80xCAnj9Y4vd4KR04B1f+Z
         MXesL2J9Pj4JhjNiisccAtDBtmEO6GgbmV9ER5xdCBoNgOJ7KE80Hp1qnvyspmSuWB3D
         l1KesQt6Os3Z5/y2vBgoBj4zgpxAWNho0aVkc/sqauiOtLXm0wt8c5k7Va7OAKC7Idrs
         TPWb89JTHL706JwsH1q2UiHlkbmJOhuWBL6Zo1+W5yo9F0Br2l8euVPpxZWYxGY/0DmB
         fQBQ==
X-Forwarded-Encrypted: i=1; AL+hErGsqglMKtobvHUFtSfqkEY5gQAPGuQAdv5w7k4k+J3MPWeP/1QX46SX+oGGUt0vPFoVRHOYUfB/nvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gX1acQd72zn36GmXAIiZ5Q23QSQL0qRWeO4WdOyhf4vszOYQz
	xm/Oe+NqeR966c8jzSuNINBx04gWZi1LmPmU1PQFkcWDTUWRAMORDMnX
X-Gm-Gg: AYBFou26fIwFHeWgAvDTXCQewxNbU70H6PqOhhmoWJd0td8KcPIXMWuBFOIbTuU1aeb
	OtLPDc/Cn6+vAoQrIMMo4rzfHLmkffK5fEGytbijx75/I11Q9fVokMqLjeZ7zBllc6LzTX722Rg
	npNafxBJWuh0wq3ljjLdFaELElF+FrjmYnqT/R3S99PP5uhnOXoNG5Pn0KByQFOVhydNafs8oZ9
	i9avV+/xBr35Ta8kpR0rr5VSo6YRBYoQwKzRALbkNlOwzK2oJywFoVKFaPdz99WhLqnxDyLIZuK
	3YL0+bAKw7g6W7Jx0dBDQbcxZi1/nlch7TeUYvHn2toIXZaVq0pVn8TRZ5zb1qqVJKNmqKmbNOb
	BsntZqFuf3/z8iTZQgTeVyMAerMpmQ34mYedR9TSFwN22q6px42otDj1FiIery1qgHep0LiVcVW
	GgoqFdOCqr04DtUyKHCw1g8DFkbZ7pfgLmnddY9WZfj7qG3S9XQcbQILJM46PCXqGjyf834IBF7
	JNl/hYNvELHC50cYryFhbYkG5eigMpMgqExfYJJ3Ss9H1eI2eoZDnDJPKPtWRnJ8dyQcThWuF9e
	9dEazI0/p71qUMM8ELGHUBvRfGfOu+XKm27zrpUalbFFmptTxIeAgCubI/Z+GG2e6DQAy1c=
X-Received: by 2002:a05:701b:455a:10b0:177:9a5b:a89 with SMTP id a92af1059eb24-1b3ac6c5edemr3932498c88.29.1794239875103;
        Mon, 09 Nov 2026 07:57:55 -0800 (PST)
Received: from localhost.localdomain ([125.166.179.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm13020828c88.13.2026.11.09.07.57.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 07:57:54 -0800 (PST)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shuai Liu <847807867@qq.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v7 1/4] rust: io: add FallibleIoCapable
Date: Mon,  9 Nov 2026 22:57:40 +0700
Message-ID: <20261109155743.83740-2-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fallible I/O capability for backends whose accesses may fail
independently of address validation.

Route try_read, try_write, try_write_reg, and try_update through the
fallible capability. Provide a blanket implementation for infallible
IoCapable backends so existing users retain their current behavior.

This allows transport-backed implementations such as I2C to expose only
fallible access while keeping infallible operations unavailable.

Link: https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/io.rs | 62 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a877df11a03e..b93a540c28da 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -356,6 +356,31 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// I/O backend capability for operations that may fail independently of address validation.
+///
+/// Infallible backends implementing [`IoCapable`] also support fallible operations. Backends
+/// implementing only this trait cannot use the infallible [`Io`] accessors.
+pub trait FallibleIoCapable<T>: IoBackend {
+    /// Read from `view`, returning a transport error if the operation fails.
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
+
+    /// Write `value` to `view`, returning a transport error if the operation fails.
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result;
+}
+
+impl<B: IoCapable<T>, T> FallibleIoCapable<T> for B {
+    #[inline(always)]
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T> {
+        Ok(Self::io_read(view))
+    }
+
+    #[inline(always)]
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result {
+        Self::io_write(view, value);
+        Ok(())
+    }
+}
+
 /// Trait indicating that an I/O backend supports memory copy operations.
 pub trait IoCopyable: IoBackend {
     /// Copy contents of `view` to `buffer`.
@@ -759,7 +784,7 @@ fn copy_to_slice(self, data: &mut [u8])
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -769,7 +794,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -779,7 +804,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -789,7 +814,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -799,7 +824,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -809,7 +834,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -819,7 +844,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -829,7 +854,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -958,9 +983,12 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: FallibleIoCapable<<T as AsRepr>::Repr>,
     {
-        Ok(io_read!(self, try: location))
+        let view = io_project!(self, try: location);
+        Ok(T::from_repr(Self::Backend::io_try_read(io_view_as_repr(
+            view,
+        ))?))
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -991,10 +1019,10 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: FallibleIoCapable<<T as AsRepr>::Repr>,
     {
-        io_write!(self, try: location, value);
-        Ok(())
+        let view = io_project!(self, try: location);
+        Self::Backend::io_try_write(io_view_as_repr(view), T::into_repr(value))
     }
 
     /// Generic fallible write of a fully-located register value.
@@ -1037,7 +1065,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: FallibleIoCapable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1071,12 +1099,12 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: FallibleIoCapable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
         let view = io_project!(self, try: location);
-        view.write_val(f(view.read_val()));
-        Ok(())
+        let value = T::from_repr(Self::Backend::io_try_read(io_view_as_repr(view))?);
+        Self::Backend::io_try_write(io_view_as_repr(view), T::into_repr(f(value)))
     }
 
     /// Generic infallible read with compile-time bounds check.
