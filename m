Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239872;
	b=NZaSYbbjSmWMHSGRcdrLezQwpkU091daMuex8ML6Ghl3BfPDQCiIHb/onJgszqzVgDbl
	 90cB8GmU3V0v2330EtBxoIAdm1ojUTw6My8e/9e+MTRoHqZKkbKFKgPFhvuC+HOC0FHNt
	 5NMJX78wWdyFOcSyz+0K4SGRz0zYYMIctT8VYKMtuNjf6eYfQ7djZeXMxDSfqnHpSrW8Y
	 BZ6ruUP6Ed8P7zGdjVW4Yj1umWVI/G11dDk8lKM9DEMD8tcHo7ACqOwBmyl9XK1sI5WK1
	 azJKaJrVpu0mL2vH+2ItVLVVrzJ/KNg+jnS9CvIxaNUz0f5Rw20TA8BNHPYKwcOjmYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KQFKpRV7NATJKFVseA51zGW96GPsJPPL3A6Ir3znGCk=;
	b=VEfVZfsImwsfs9v3Bqx58SkubpKLyAm6kK9XDptb9Eq9Ab5Lq831c8BDAcQWJ22+JO6H
	 pvVMz72VyQ4ndEE4G3xNM4JP3KBh3ggU6/SDNCWdBN4q11B5EKORGKa8Qn/ehvwL60NMb
	 eekMXxTSjTOgwqZkz6l40XC5hIsQk1WCt43S6KPqLV3O8DnKKHUjcq3HIHAGem25S5d1M
	 miAFbQsZLBGoV2RML/dXC+OkDZt6Sa3blorom6sE2b17w6b/N4VzJ3OlGtNf+yqr78+eO
	 B/jhaj2bazTCntZgxGYSidMlmfEjthWk89trkT9Oxf1Pm+JvzBKhJ902DGu+W4VhaZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLXCDde0;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28A606A330
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 15:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B28A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLXCDde0
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso872586c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239870; x=1794844670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KQFKpRV7NATJKFVseA51zGW96GPsJPPL3A6Ir3znGCk=;
        b=hLXCDde04W5diwbe0GkjBt0uSOoYyhvOqcmGMnNaj7NHl8xd8mikVinjwWXV5VGYDf
         AwY5T+giJ6h0sL3kz0BJcUmrPNgAGEvBEEK9+1Asx13b+O2UEonf7hU/l5SAciNMQT3N
         NYhX6qkHr4zLhUfZy1I19FS+NoRlCkIfkPG3FEgEZx3Wp81xyYYYBuMolTUW+4dhZYbR
         c2/CcY3Pcnx2vJ0tC4uYkDCdmXLy3CxFD/H+7BdHUxwvBmUwihpCZmvYgCKNAm5Lb2tz
         T5GXBDlDSqPkTtPMHZT3ivSrS2qVs3W4VXdaihX5uvLvXeK5o4N/UA8lCEMozXWIaVfq
         nXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239870; x=1794844670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQFKpRV7NATJKFVseA51zGW96GPsJPPL3A6Ir3znGCk=;
        b=hGgUHCaxq3kQtupduLhsX5lc5u2sYLqojAqjJ8jRyodGnKFcrr2jvA4WQvPxWLi439
         b2/MqrSmvjfB8540aOsMXBl8ePX/SbLarx28P9jiDPN3PLG1VoyHFkdDX07Wk12XHSjK
         NsNfJhc3cdqZknx5y5Lg4SzoBgPSjcsBKlrytb4vk+sgtBw+GAaQhL/klx0TVVIbDr/o
         mvFgi+GRFXSHO5CuygA2yC6G5hTSi/SmAkz6cFwlA+QhKgouPg1/TlENyF01C2vvzxin
         DUmcwjsSKGbYm2h8Z9ZlORjaKjDAc78a4cfb5oqKkGM5BD3xAhfXiFM1eEhrFFrEQe0W
         cyBQ==
X-Forwarded-Encrypted: i=1; AL+hErHfSjSo3ysTXsYfYl8sfrDZWqCxuLr1W5NtUtq0jNqx++abkFvVK11smuHqxPxn0iyXYdN62S/O9k8=@vger.kernel.org
X-Gm-Message-State: APuU4Z90H/ELVuk22XpCkTgzr+IDDgq+RgNDfqRYq0NOQq6uD4dMQxEi
	DoU+jfX2HHsbOzO0QeoFEp7gI2uHxhp3TVl2cJdh3fFyf8nlG0qILYUf
X-Gm-Gg: AYBFou3A9vfnD2vmCrtzJr/CVCazsoC7wxtyXr+s+1/ijhsQotw/QpKJPUKvkUIlTGq
	Aa160SKYoPElLaoSkpclwtQTjS1klvh9UkgkJB+BZROj9EpQO2xKfs1ZKoI6w5M+LI7Nn4rxqrK
	NQwkVGAK4kKZegZeDRGOxzso/c5SErRjz3LJ46J2kH5glpNbuO1xE14VY0ynJ52cmGxlorYjzlk
	dAsO5nRGYgHAlmUhr7gql0euULXoKg+dc3mAqIuRjZTPmEJrEk1zn+e65oUH0UGi5TmNbg3qIAU
	hbF/e2pGqJSsHOeAIoUs8QkiS2yuZeJ1BEwJVokPH+7jgc/Fi58ptCHYHvbSD1dY6VNLwm7TsY6
	9s53KPDHtGL+97dh5V2SbsphWVWQY39Y6663spc/kwWyP+/LSOD1lxJRSWHsy9vxWAveNVOpIyp
	Mqlb8dhr53SA1Ez87BbGPY+AP5U1GkUR//Is1uyKSww6ZjKLX4xCe32aOHuG3Xdsqql+AKRx7nO
	zkUl4UFVnMnOgWKgBcFfyCdifIfLxZgTMWdn1DRazEym9UE9qxg5ybgWp5TJ6Bk+FYEoTSbSt7a
	l2KaWIVR/wLVaxa5mrfgCyoRHl6effrf6KRgTbkv6l3Khj+Pcgxqc47458w/AU+iVUYjo64=
X-Received: by 2002:a05:701a:c919:b0:166:af48:a2ba with SMTP id a92af1059eb24-1b39fdaf74fmr6537059c88.0.1794239870114;
        Mon, 09 Nov 2026 07:57:50 -0800 (PST)
Received: from localhost.localdomain ([125.166.179.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm13020828c88.13.2026.11.09.07.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 07:57:49 -0800 (PST)
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
Subject: [RFC PATCH v7 0/4] iio: position: add Rust driver for ams AS5600
Date: Mon,  9 Nov 2026 22:57:39 +0700
Message-ID: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
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

This series adds a Rust driver for the ams AS5600 12-bit magnetic rotary
position sensor. It also adds fallible I/O, SMBus access, and the IIO
abstractions needed by the driver. The driver exposes raw angle and scale
through IIO sysfs.

Feedback on the I2C and IIO lifetimes, locking, and device teardown would
be appreciated.

The Region-based view models byte-addressed registers and is not a
general model for command-indexed 16-bit registers. The standalone
word-read helpers accept any SMBus command byte.

The current interface is intentionally limited while a Rust regmap
abstraction is unavailable. Feedback on whether this is an appropriate
interim approach, or whether the work should wait for regmap, would be
appreciated.

Based on Linux v7.3.

Thanks to Igor Korotin for the device ownership and bound-client lifetime
rework used in patches 3 and 4:
https://lore.kernel.org/all/179286358623.55649.5397316745104390556@linux.dev/

Thanks to Shuai Liu for reviewing v6. This version addresses the Clippy
warnings, replaces the ignored SMBus doctest, and moves repeated unsafe
SMBus calls into safe helpers:
https://lore.kernel.org/all/tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com/

---

Previous versions:

  v6: https://lore.kernel.org/linux-iio/20261004130303.65432-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v6:

- Rebase on top of Linux 7.3.0.
- Make register() return Device<T, Registered>, stored in the driver
  data, so the IIO device is unregistered before its private data is freed.
- Remove the bound parent parameter from IioDriver::read_raw(); the driver
  now stores its bound I2C client reference directly.
- Drop the parent lifetime parameter from UnregisteredDevice.
- Use pin_init::raw_try_init() in Device::build_device().
- Document sign conventions for IioVal::IntPlusMicro and
  IioVal::IntPlusNano.
- Add IIO=y and I2C=y dependencies to CONFIG_AS5600.
- Use typed pointer casts and lossless integer conversion to fix Clippy
  diagnostics reported by Shuai Liu.
- Replace the ignored AS5600 doctest with a generic no_run example.
- Move raw SMBus FFI calls and errno conversion into safe bound-client
  methods, as suggested by Shuai Liu.

Testing:

Clippy and debug builds completed for ARM with Rust enabled, I2C built
in, and AS5600 built as a module.

Runtime testing was performed on a BeagleBone Black with an AS5600 on
i2c-2 at 0x36. Raw angle and scale reads worked with the magnet detected,
and reads returned ENODATA when the magnet-detected bit was clear.

I2C errors were propagated when the bus was disconnected, and reads
recovered after reconnection. Concurrent reads were tested with 10
readers, including during 20 unbind/rebind cycles.

Lifecycle testing covered 50 unbind/rebind cycles, 50 module load/unload
cycles, module removal during active reads, module removal with an open
sysfs file descriptor, and module removal while the I2C bus was in an
error state.

KFENCE, UBSAN, lockdep, and kmemleak reported no issues. KASAN was not
enabled because 32-bit ARM selects HAVE_RUST only when KASAN is disabled.

Muchamad Coirul Anwar (4):
  rust: io: add FallibleIoCapable
  i2c: rust: implement SMBus access via IoBackend
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600

 drivers/iio/position/Kconfig    |  11 +
 drivers/iio/position/Makefile   |   1 +
 drivers/iio/position/as5600.rs  | 186 +++++++++++++
 include/linux/iio/iio.h         |   6 +-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/bits.rs             |  29 ++
 rust/kernel/i2c.rs              | 235 ++++++++++++++++
 rust/kernel/iio.rs              | 463 ++++++++++++++++++++++++++++++++
 rust/kernel/io.rs               |  62 +++--
 rust/kernel/lib.rs              |   2 +
 10 files changed, 978 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

