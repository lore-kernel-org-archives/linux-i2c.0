Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607823F88A3
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547323; cv=none; b=sp6s+cWUn3N/N7CEZZfi0GH0SGZWfcjpzV82K3xXJT54HRZXFMDCimnntuIrC01LJg9ZOk+WbA4xg9umRWsxDkV9pLFLS5G3YfhKboDpc4oxeDRqjY2by5rmVU6IxS+1vx4pf1zu5sBTsbgb0+8Ih96fedpWE0ETJO4EuHSXlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547323; c=relaxed/simple;
	bh=snvtzj0+nm9vqyOkQt/DWFJKiD2vSRrYc4+FQvMkhLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVcbhIJs2MGSWkho1dz73nt8Asd5jwNcACyl0UoCchXlg8CGOiyirNqKb/83xfviCPVrwKxPIkAX9BUPe0G8CtO8+wimWKi2rMyXqn2jE5+7i2/bz7vmzwPE2xTvmXxm2iwk6hHqF8kMUD6aaDC53rZkKgcjx9bsADwRZBwjeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWSWYk13; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWSWYk13"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caf4496889so2197075ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547321; x=1784152121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0OETwA789YFBsCa88ZqhHy8r7H6SJQt922F4ot6BHlQ=;
        b=VWSWYk13lWHDAvE9faunh3IEy7spPZXS30LCa8lanDSLUckzGBMEVxjsTO4Kt3Ghnj
         VAJ9EnvgMW6U+kzYT5TCiqf7heJ5Pv3sybi81Tmt+CuQH9NF5fbDPbnK6w7NtOYqxE09
         sqWxBs+OxySO/h/IfQNuPxpit3tUDSeC5idw8pkUk+t4GWKjLQYwsQWHS5xs6wohJRXN
         IOcH/BPpxxIcR7il1y4rVx1GacIpJHpsq6e9gTd8htDWwzAJCrQrnhN9lm2zWfYsNkkJ
         zdgMNPZEUpEzbjdMacHArO7Ytsdu/apGGaZ6hQjqjL4aEw7VUBCBH26dirr0jZfhvnJX
         BKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547321; x=1784152121;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OETwA789YFBsCa88ZqhHy8r7H6SJQt922F4ot6BHlQ=;
        b=iKD1esSHA52terYKSJDA8WHeqYSYGQrsUW3PZvagn1s02mqtWZJ7UizG51N3OYNCaW
         3v2a1EEIS4FMiMvWUJDPWRQx9XDZxUrbNinQkly2ioTu1ItsUCHmdBvkCX52wSOsXXzN
         Ng0ZPFI9CA5DTCgkrlVh00PC/KktVgCRiBpiWrpcTrUFTghAbuQOSo57LWCQBXnsm3qU
         TjHv9wkkg33Ghb6jmbuJgIQGqdqwIXe625QqRCw77goxFg+aMmadlpUOde2KJwxrTWHe
         3VUzRJgQHGdt/hLxzSzHjGInWTWVbMlVHvPVJgntk0WtiyUlDGNXo8xlzg3e7KIyImrx
         Lzmg==
X-Forwarded-Encrypted: i=1; AHgh+RrfLKsDblC7n9fBBXv7q1cjQL5UTo3NUt43vRSnfEw1UH08+kqanOKdSI5xRYIGmTQcm+Lx0Gsn5p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4N6wh70PxkyGsPBy4hIIDspIiznbNMvOtT4o91InrV3YUX1+
	/Gl+vJcbPAmgyBMUtI9tc5idFlSKiiQmolSrqZd0kNsA04BGGek4Wry2MC1SPOLetqM=
X-Gm-Gg: AfdE7ckpjNgSDZHAFYyOqJDhBwJM8/PNUkZOgVzfWCY4MiXuAmdhYaPO3XD+UPPvVgn
	9ogOvEIDd7FH8X3MsuXAQ/alT7KvLoAqMaAh/aGktioN/Q2I3uODzflYzqaZwxx6ffb1j/N2K2U
	L9o42T/+MtWYmPr4qs9VyMK/g4Lmzg/Iu4xIPD1FnjxUu4lSHzyabEXk63dyoC75YVET7YR6V/u
	19o0nUtlrNLBVSJl+VP1+ep+rV1V6wrT5PODrGaPLubw86VGBspiZo3YB3Nh7EDorQ11ybBz1Hr
	O7olV+ros/yF8MICEGS/EJPfPfjR2OJOjB6lF4ygzBm7oanzHVWI/GU0rRQZuk8wkzhO7UmdhjJ
	M5d+ByMe3H4dXHgNRtDyCZM2lOPRpJ0EwtlZngeCYH5oNnRLHdzybNZ2rA/wglw97p30zM6dq5T
	ZuvrQJP3cN3noIKIyTeDcKRAb2x5bo68hFGsXyLfTQLwuiu9yGC4yjbD0eNIIO66WivHMG8DfdD
	3q63ldWFyvLmuoFyuDON3cgKtbMVglH8FMk9RtgEo7Bf/tn6Pmn1zKRj5LKuGxcaPb5LwuZtKfx
	CDVVW8dnVFSbwYOPSLTha25iBTIj2ADuUM9/gyJus+CZrTduq1/QOzn35pLbBuNeQ7fJ+nfs
X-Received: by 2002:a17:903:2f48:b0:2ca:5023:f983 with SMTP id d9443c01a7336-2cdebdc448emr742115ad.29.1783547320621;
        Wed, 08 Jul 2026 14:48:40 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-35-85-29-74.us-west-2.compute.amazonaws.com. [35.85.29.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d946sm33733855ad.66.2026.07.08.14.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:48:40 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Tamir Duberstein <tamird@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	Bruce Robertson <brucer42@gmail.com>
Subject: [RFC PATCH 3/3] power: supply: add Rust SMB347 charger driver
Date: Wed,  8 Jul 2026 21:47:38 +0000
Message-ID: <20260708214738.25008-4-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708214738.25008-1-brucer42@gmail.com>
References: <20260708214738.25008-1-brucer42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a Rust port of the Summit SMB347 battery charger driver, built on
the Rust i2c and power_supply abstractions. The driver binds over I2C,
reads the charger's status registers, and registers a power supply that
reports STATUS, ONLINE and CHARGE_TYPE to sysfs.

It is the first in-tree consumer of the new power_supply abstraction.

Signed-off-by: Bruce Robertson <brucer42@gmail.com>
---
 drivers/power/supply/Kconfig                |  14 ++
 drivers/power/supply/Makefile               |   1 +
 drivers/power/supply/smb347-charger_rust.rs | 180 ++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/power/supply/smb347-charger_rust.rs

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f0ede1cecb6a..b6521c86b47c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -875,6 +875,20 @@ config CHARGER_SMB347
 	  Say Y to include support for Summit Microelectronics SMB345,
 	  SMB347 or SMB358 Battery Charger.
 
+config CHARGER_SMB347_RUST
+	tristate "Summit Microelectronics SMB3XX Battery Charger RUST"
+	depends on I2C
+	depends on RUST
+	help
+    Say Y to include support for the Summit Microelectronics SMB347
+    battery charger, implemented in Rust. The driver binds over I2C
+    and reports charging status, online state and charge type through
+    the power supply class. It is a Rust port demonstrating the
+    in-tree i2c and power_supply Rust abstractions.
+
+    To compile as a module, choose M here; the module will be called
+    smb347-charger_rust.
+
 config CHARGER_TPS65090
 	tristate "TPS65090 battery charger driver"
 	depends on MFD_TPS65090
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 31fe4a145929..96616fb381a9 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_CHARGER_BQ256XX)	+= bq256xx_charger.o
 obj-$(CONFIG_CHARGER_RK817)	+= rk817_charger.o
 obj-$(CONFIG_CHARGER_S2M)	+= s2m-charger.o
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
+obj-$(CONFIG_CHARGER_SMB347_RUST) += smb347-charger_rust.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
diff --git a/drivers/power/supply/smb347-charger_rust.rs b/drivers/power/supply/smb347-charger_rust.rs
new file mode 100644
index 000000000000..c8286956a7a8
--- /dev/null
+++ b/drivers/power/supply/smb347-charger_rust.rs
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SMB347 i2c driver
+
+use kernel::{
+    device::Core,
+    i2c,
+    of,
+    prelude::*, //
+    sync::aref::ARef,
+};
+
+/// SMB347 register map. Ported from drivers/power/supply/smb347-charger.c.
+#[allow(dead_code)]
+mod reg {
+    // Configuration registers (0x00–0x0e, write-protected; unlock via CMD_A bit 7)
+    pub(crate) const CFG_CHARGE_CURRENT: u8 = 0x00;
+    pub(crate) const CFG_CURRENT_LIMIT: u8 = 0x01;
+    pub(crate) const CFG_FLOAT_VOLTAGE: u8 = 0x03;
+    pub(crate) const CFG_STAT: u8 = 0x05;
+    pub(crate) const CFG_PIN: u8 = 0x06;
+    pub(crate) const CFG_THERM: u8 = 0x07;
+    pub(crate) const CFG_SYSOK: u8 = 0x08;
+    pub(crate) const CFG_OTHER: u8 = 0x09;
+    pub(crate) const CFG_OTG: u8 = 0x0a;
+    pub(crate) const CFG_TEMP_LIMIT: u8 = 0x0b;
+    pub(crate) const CFG_FAULT_IRQ: u8 = 0x0c;
+    pub(crate) const CFG_STATUS_IRQ: u8 = 0x0d;
+    pub(crate) const CFG_ADDRESS: u8 = 0x0e;
+
+    // Command registers
+    pub(crate) const CMD_A: u8 = 0x30;
+    pub(crate) const CMD_A_ALLOW_WRITE: u8 = 1 << 7;
+
+    pub(crate) const CMD_B: u8 = 0x31;
+    pub(crate) const CMD_C: u8 = 0x33;
+
+    // Interrupt-status registers
+    pub(crate) const IRQSTAT_A: u8 = 0x35;
+    pub(crate) const IRQSTAT_C: u8 = 0x37;
+    pub(crate) const IRQSTAT_D: u8 = 0x38;
+    pub(crate) const IRQSTAT_E: u8 = 0x39;
+    pub(crate) const IRQSTAT_E_DCIN_UV_STAT: u8 = 1 << 4;
+
+    pub(crate) const IRQSTAT_F: u8 = 0x3a;
+
+    // Status registers
+    pub(crate) const STAT_A: u8 = 0x3b;
+    pub(crate) const STAT_B: u8 = 0x3c;
+    pub(crate) const STAT_C: u8 = 0x3d;
+    pub(crate) const STAT_C_CHG_SHIFT: u8 = 1;
+    pub(crate) const STAT_C_CHG_MASK: u8 = 0x06;
+
+    pub(crate) const STAT_E: u8 = 0x3f;
+
+    pub(crate) const MAX_REGISTER: u8 = 0x3f;
+}
+
+// Declared before `client` so it drops first: the supply is
+// unregistered (no further get_property callbacks) before the I2C
+// client it reads through is released.
+struct Smb347 {
+    _registration: kernel::power_supply::Registration,
+    client: ARef<i2c::I2cClient>,
+}
+
+kernel::i2c_device_table! {
+    I2C_TABLE,
+    MODULE_I2C_TABLE,
+    <Smb347 as i2c::Driver>::IdInfo,
+    [(i2c::DeviceId::new(c"smb347"), 0)]
+}
+
+kernel::of_device_table! {
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <Smb347 as i2c::Driver>::IdInfo,
+    [(of::DeviceId::new(c"summit,smb347"), 0)]
+}
+
+impl Smb347 {
+    /// Enable/disable writes to the non-volatile config registers (0x00–0x0e)
+    /// by toggling CMD_A.ALLOW_WRITE. Other CMD_A bits are preserved.
+    #[expect(dead_code)] // TODO: remove once a config-write path calls this (Phase 3)
+    fn set_writable(idev: &i2c::I2cClient<Core<'_>>, writable: bool) -> Result {
+        let bits = if writable { reg::CMD_A_ALLOW_WRITE } else { 0 };
+        idev.smbus_update_bits(reg::CMD_A, reg::CMD_A_ALLOW_WRITE, bits)
+    }
+}
+
+impl kernel::power_supply::Driver for Smb347 {
+    const NAME: &'static CStr = c"smb347-mains";
+    const TYPE: kernel::power_supply::Type = kernel::power_supply::TYPE_MAINS;
+    const PROPERTIES: &'static [kernel::power_supply::Property] = &[
+        kernel::power_supply::PROP_STATUS,
+        kernel::power_supply::PROP_ONLINE,
+        kernel::power_supply::PROP_CHARGE_TYPE,
+    ];
+
+    fn get_property(
+        self: Pin<&Self>,
+        psp: kernel::power_supply::Property,
+        val: &mut kernel::power_supply::PropertyValue,
+    ) -> Result {
+        if psp == kernel::power_supply::PROP_ONLINE {
+            let irqstat_e = self.client.smbus_read_byte_data(reg::IRQSTAT_E)?;
+            val.intval = if irqstat_e & reg::IRQSTAT_E_DCIN_UV_STAT == 0 {
+                1
+            } else {
+                0
+            };
+            Ok(())
+        } else if psp == kernel::power_supply::PROP_STATUS {
+            let stat_c = self.client.smbus_read_byte_data(reg::STAT_C)?;
+            val.intval = if stat_c & reg::STAT_C_CHG_MASK != 0 {
+                kernel::power_supply::STATUS_CHARGING
+            } else {
+                kernel::power_supply::STATUS_NOT_CHARGING
+            };
+            Ok(())
+        } else if psp == kernel::power_supply::PROP_CHARGE_TYPE {
+            let stat_c = self.client.smbus_read_byte_data(reg::STAT_C)?;
+            let cs = (stat_c & reg::STAT_C_CHG_MASK) >> reg::STAT_C_CHG_SHIFT;
+            val.intval = match cs {
+                1 => kernel::power_supply::CHARGE_TYPE_TRICKLE,
+                2 => kernel::power_supply::CHARGE_TYPE_FAST,
+                _ => kernel::power_supply::CHARGE_TYPE_NONE,
+            };
+            Ok(())
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
+impl i2c::Driver for Smb347 {
+    type IdInfo = u32;
+    type Data<'bound> = Self;
+
+    const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(
+        idev: &i2c::I2cClient<Core<'_>>,
+        info: Option<&Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> {
+        let dev = idev.as_ref();
+
+        dev_info!(dev, "Probe Rust SMB347 driver.\n");
+
+        if let Some(info) = info {
+            dev_info!(dev, "Probed with info: '{}'.\n", info);
+            let v = idev.smbus_read_byte_data(reg::STAT_A)?;
+            dev_info!(dev, "STAT_A = {:#04x}\n", v);
+        }
+        let client: ARef<i2c::I2cClient> = idev.into();
+        let registration = kernel::power_supply::register::<Smb347>(dev)?;
+        dev_info!(dev, "registered power_supply\n");
+        Ok(Self {
+            _registration: registration,
+            client,
+        })
+    }
+
+    fn shutdown(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(idev.as_ref(), "Shutdown Rust SMB347 driver.\n");
+    }
+
+    fn unbind(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(idev.as_ref(), "Unbind Rust SMB347 driver.\n");
+    }
+}
+
+kernel::module_i2c_driver! {
+    type: Smb347,
+    name: "smb347_rust",
+    authors: ["Bruce Robertson"],
+    description: "Rust SMB347 driver",
+    license: "GPL v2",
+}
-- 
2.43.0

