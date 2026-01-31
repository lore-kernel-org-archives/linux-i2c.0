Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105123BCEE;
	Sat, 31 Jan 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769868773; cv=none; b=rlOJjM3Ha3BWJL6/mK2G0opurc4pOv8lEo778BgzYKh5V2B0DaYQ8QjCUjAjpSytma8v8+rubwa1LZlAMF/I1hzXJ6FuCgdVTFhHgzzqmLSlbkc2gVNM2124vpcUx+zVZgwkTnOsls7Vv06fLD1kVR291cTUxchEapbkv5qjx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769868773; c=relaxed/simple;
	bh=079AUMoHViksAspHbH7ag8128A6gK7HVSqZMHGf8rkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUZPJO7/aO8fBhL43HGWUa0a/6ij/VS4TCCMaE345fudNaJmhoNkYpY7mBrsdccMBRiakZS6eQ4O5o1/stPdjfbwk9IDpwZXWV2Qaefgf0WwAwUIWj/p8Tu6Qdk3+E96u43laCj/MTVjmPPFkddkJZzxlpSQSir8YZB7sQgs+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC0M0ObH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC0M0ObH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F22ABC19422;
	Sat, 31 Jan 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769868773;
	bh=079AUMoHViksAspHbH7ag8128A6gK7HVSqZMHGf8rkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mC0M0ObHTpYVumFwFJM/9fz5UywXHOZKJDgkIVjMwHyfD96hT12bTdzFvrT6IwU9R
	 /3jabASYniGatpDg0tPYnBhPhFC4cCM8nyAnNvzsVPd/5lKlNT0tfHIYTyUpNqw4BF
	 WoIjY8MxTWej0RC3kVB+LpMB6gC1FEF+Q3CF1OmsVvCUP4a84fcc6tCIScRIXX2tLt
	 qeTPy6NL/ReBCAANuFqlKMw36EVwmGLOiUm9ob4PzDYziiskfb30+lO4X3+ED775ap
	 7Tw1sTS6F95/DG9R9VUzi6Lpw70hmYvMtAgown7MiQbHGBeLUfx04cMwO7OU+5hXRW
	 bxGKkMGNhcYdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD6D79774;
	Sat, 31 Jan 2026 14:12:52 +0000 (UTC)
From: Igor Korotin via B4 Relay <devnull+igor.korotin.linux.gmail.com@kernel.org>
Date: Sat, 31 Jan 2026 14:12:44 +0000
Subject: [PATCH 2/5] rust: bits: add define_flags macro
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-i2c-adapter-v1-2-5a436e34cd1a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769868772; l=2311;
 i=igor.korotin.linux@gmail.com; s=20260125; h=from:subject:message-id;
 bh=sn8tyhgAOXgu5sl9ZR6vPMjhDT98q30bKO29ZzpI3ac=;
 b=yEMAIEqB8thmwTAB8YbWq5ph+DxUCzWFu6c9XkTqwOAGPvGImN/YzflWGoHFNqjokbugMGrXA
 tOVxoF2cyRiApPT1aIc7zoqf5nUuZTZRBRKaHXq/FBe13LhUl20XPdX
X-Developer-Key: i=igor.korotin.linux@gmail.com; a=ed25519;
 pk=SjZ//wxnynZgJJgTqANyU10A7hdQQdDXLvXIr+zWroE=
X-Endpoint-Received: by B4 Relay for igor.korotin.linux@gmail.com/20260125
 with auth_id=615
X-Original-From: Igor Korotin <igor.korotin.linux@gmail.com>
Reply-To: igor.korotin.linux@gmail.com

From: Igor Korotin <igor.korotin.linux@gmail.com>

introduce define_flags macro that incorporates BitOr BitAnd and Not
implementations.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/bits.rs | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
index 553d50265883..6750aef18708 100644
--- a/rust/kernel/bits.rs
+++ b/rust/kernel/bits.rs
@@ -201,3 +201,60 @@ pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
     /// assert_eq!(genmask_u8(0..=7), u8::MAX);
     /// ```
 );
+
+/// defines flags
+#[macro_export]
+macro_rules! define_flags {
+    (
+        $gen_name:ident($gen_type:ident),
+        $($variant:ident = $binding:expr,)+
+    ) => {
+        /// Flags that can be combined with the operators `|`, `&`, and `!`.
+        ///
+        /// Values can be used from the [`flags`] module.
+        #[derive(Clone, Copy, PartialEq)]
+        pub struct $gen_name($gen_type);
+
+        impl $gen_name {
+            /// Get the raw representation of this flag.
+            pub(crate) fn as_raw(self) -> $gen_type {
+                self.0
+            }
+
+            /// Check whether `flags` is contained in `self`.
+            pub fn contains(self, flags: $gen_name) -> bool {
+                (self & flags) == flags
+            }
+        }
+
+        impl core::ops::BitOr for $gen_name {
+            type Output = $gen_name;
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
+            }
+        }
+
+        impl core::ops::BitAnd for $gen_name {
+            type Output = $gen_name;
+            fn bitand(self, rhs: Self) -> Self::Output {
+                Self(self.0 & rhs.0)
+            }
+        }
+
+        impl core::ops::Not for $gen_name {
+            type Output = $gen_name;
+            fn not(self) -> Self::Output {
+                Self(!self.0)
+            }
+        }
+
+        #[allow(missing_docs)]
+        pub mod flags {
+            use super::$gen_name;
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: $gen_name = $gen_name($binding as $gen_type);
+            )+
+        }
+    }
+}

-- 
2.43.0


