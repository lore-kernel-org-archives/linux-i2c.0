Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790334E324D
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165714; cv=none; b=d0Kl9FwcfmdodfAmzxjHaMUed6k1ImN4HmIONkdddiSzfe8iztOdPUlWI8jwEd/6J0sH+i7vrR3LKNUJB/ar9jYKIvNwizK+cfgpX5Ci1/wzyxSANzufMBcKT0mEHaWt5LtipzDHcHI09GYXgh3VBOoMVk5MNb1fbZyzt68J4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165714; c=relaxed/simple;
	bh=V1jRKmCQFL7EqhgtKwrUFCiu8eMFT9qwVk/G17OwXZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np5DJxn1RnK5WycVra5ZqCi+h+pH4avFWsZ7H+3i/TMyElUK+zvQ79w3saMon1mkPWBzcZDlEWOQlSLp6GKWXGmtpqznJjoV2B10yDoFa30ha0srVy5CiYnJ33xm8d22jjcFDWGhQGHBB23HWyhKY2ZhQivAgKgwi95860i+mLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTAQnOHg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTAQnOHg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso453247b3.2
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165708; x=1792770508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ear117DJjn2hMVG10i+yEJqY+WZsqWtPeHsEomSMN0=;
        b=FTAQnOHg8eLnJByhEyrjDiEcwDlm6nNvNCL8gdewgO9cIiTOEYRb8us2E28u1EiDWm
         tKBXafitMx/dHnXFPB262I+sZZo+YaxkwUaaHCDlUYjALYrujT5QDdqLMXsbcvxNzGMp
         5Tp4VbZGrhAv6DS7PlCMCEKobopHQvpJnAFB1+yNt19KNGWdeWhJlHGDIdzr44rI6f5U
         Xi02du8UQDyh/sAy3x6b9xgX+ucwJRyz4bphcdkc+pBkFD6or7uB++IYhn/s1ez8YXxd
         ahfABQsFv4ZrhsauGzvCynP8KfrGKkRxJS+JivmlDevSDfN8rIRSJqhWKFCl/fR6ctFb
         /PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165708; x=1792770508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ear117DJjn2hMVG10i+yEJqY+WZsqWtPeHsEomSMN0=;
        b=As/IdME8Hvp55IMPRZ9cg6EVITfiRjIjpATQXcHXBa391782d1WGG05PPPe+pVvgWk
         sLprLf7Wn1jDThQzRroaz9Qv2Nt6bKAtJrk1/TTJQq3Vw+uvdJdkh3Ga2SRMgVdBQlja
         3hXPhz/ASp2122tYP1z3x9hpo3ntv0Vgwx7YN6KzatnJSQI1H4EigvfW5jcmsrz52Hg5
         hqH023zDZy8DeTU4zIpYhrVX0ZI8PKR96CMPUwU9rlJksCzXdij70RGatxRlIZOHNaDo
         Fl/HHfSu5kSvWWt8q1hJ6D/+ArPiBP1jiOyN70cTNeas2pZn2z0B443ZA65HmMRkBuaa
         HbzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLLVfNUb1y36n10CrSJlqpA/4ceBDFbIsQ0jugU7YL3kQUMznbfLz/E80nYDv2sRKwieh8XJZOH4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4rJUojqk7MOoDq+YswOUHfKTFME5DplbJ/xInZjXGsKsB+13G
	7HzbdGCSKI96disNnBy3CkuIrBTLvWoHv1nJXvcQuOi8mdMzwhAEG1D8
X-Gm-Gg: AYBFou3LnY61OBPhUrHp3x9pKTx5UVRqsz9ceWjeyMQnsbn2EbcXZ4Il8GSRoG0hvJR
	rrej3MUf09ryMYM4BXlrcmEDrbFF/x1aEZoWlyTxLKv7xTyiDEfUJsYGjR4o0e4ZCmIPhBglsTk
	WeZp44t1kf6WtCsQ7HFS23eQvA3J5t9X4AJN0NxDFvQYAyA7TttWpgy/qZ07fLJlNvHJX03PL9h
	VRd49YWQhjoOZHRap9PeURw5sbrThKsmghJ9J8K/ZfatzVvTBpHn20weTfFyxJyZMFHJecE7WH/
	4Nlgy+qlgrLOYSHO46ESlClhmEGQvTQQPGZciIurNwzX1Zvl+ZuWAztOprTk7lOzbgsb8BPeaWZ
	8uCeP8zO7iZw+w3gK0pryZCP2nr0rBDLWedmdEpcwgLBslLmifJ6h1UeahkXmFddr4zrLttWs4b
	/ZelUuYyzPttMACgtHlnQhpZA4mmnqPCHQK16OkSjzbHElyvh9/QhHykxcHL0ZXVDbtnpBAmBGk
	Kbp9kGhuECWy7lgzvkOWWCEzq6/V0V9kWCMHZY=
X-Received: by 2002:a05:690c:581:b0:8b0:ab62:c636 with SMTP id 00721157ae682-8b0f21e9dc9mr1812167b3.45.1792165708302;
        Fri, 16 Oct 2026 08:48:28 -0700 (PDT)
Received: from localhost.localdomain ([180.243.241.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e593c65bsm10882167b3.38.2026.10.16.08.48.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 08:48:27 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Brandon StJohn <branstj@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Fri, 16 Oct 2026 22:48:15 +0700
Message-ID: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor.

The series adds generic fallible I/O support, SMBus access, a minimal
read-only Rust IIO abstraction, and the AS5600 driver. The driver exposes
raw angle and scale through IIO sysfs.

Reviews of the lifetime, concurrency, and teardown contracts in the Rust
I2C and IIO abstractions would be especially helpful. Danilo and Igor, if
you have time, I would appreciate your help reviewing those parts.

The Region-based view models byte-addressed registers and is not a
general model for command-indexed 16-bit registers. The standalone
word-read helpers accept any SMBus command byte.

The current interface is intentionally limited while a Rust regmap
abstraction is unavailable. Feedback on whether this is an appropriate
interim approach, or whether the work should wait for regmap, would be
appreciated.

This series is based on commit 3fadfb9362cf
("rust: firmware: avoid UB in example by passing parameter"), which
contains Gary Guo's io_projection-v6 infrastructure. It also depends on
rust-next commit b93fb6e76ec1
("rust: error: add remaining error codes") for ENODATA; that commit is
not included in this series.

Previous version:

  https://lore.kernel.org/linux-iio/20260822062725.60519-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v5:

- Split FallibleIoCapable and the generic fallible try_* routing into a
  prerequisite patch.
- Require CONFIG_I2C=y because kernel::i2c is currently exported only
  when I2C is built in.
- Keep a bound parent borrow in the unregistered IIO builder and transfer
  registration ownership to parent devres.
- Derive the bound I2C client from the parent during read_raw instead of
  storing an ARef<I2cClient<Bound>> in the driver.
- Make IioDriver unsafe and document the validity requirements for raw
  channel specifications and the unsupported channel features.
- Reject operating modes other than INDIO_DIRECT_MODE.
- Use the external error-code dependency for ENODATA instead of adding
  the error code in this series.
- Clarify the writable-storage contract for read_raw output pointers.
- Replace the stale datasheet URL with the stable document identifier.

---

Testing:

Built for ARM with Rust enabled, I2C built in, and AS5600 built as a
module. Tested on a BeagleBone Black with an AS5600 on i2c-2 at 0x36,
running kernel 7.2.0-rc1-as5600-debug+.

Raw angle and scale reads passed with the magnet detected. With the
magnet-detected bit clear, 10 consecutive reads returned ENODATA. I2C
transport errors were propagated during a physical bus disconnect, and
reads recovered after reconnection.

Concurrency testing used 10 parallel readers and repeated reads during
20 bind/unbind cycles. Lifecycle testing covered 50 bind/unbind cycles,
50 module load/unload cycles, module removal during active reads, module
removal with an open sysfs file descriptor, and module removal while the
I2C bus was in an error state.

KFENCE, UBSAN, lockdep, and kmemleak reported no issues. KASAN was not
enabled because 32-bit ARM currently selects HAVE_RUST only when KASAN
is disabled.

Muchamad Coirul Anwar (4):
  rust: io: add FallibleIoCapable
  i2c: rust: implement SMBus access via IoBackend
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600

 drivers/iio/position/Kconfig    |  11 +
 drivers/iio/position/Makefile   |   1 +
 drivers/iio/position/as5600.rs  | 177 ++++++++++++
 include/linux/iio/iio.h         |   6 +-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/bits.rs             |  29 ++
 rust/kernel/i2c.rs              | 248 +++++++++++++++++
 rust/kernel/iio.rs              | 480 ++++++++++++++++++++++++++++++++
 rust/kernel/io.rs               |  66 +++--
 rust/kernel/lib.rs              |   2 +
 10 files changed, 1000 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

-- 
2.50.0
