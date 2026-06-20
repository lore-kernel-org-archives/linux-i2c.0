Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603527467F
	for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781966499; cv=none; b=YELh3n5dxl84CEJs5VMTfVUTriPaTTkMsv1ixUVMkJ+Icah9Re2DBy6jcGshpKyd+v7kk79XBQ5rZfP5CAdle82IQS4x/RKXCE6IbF3NMkRpAu4hT4LbFjjqVZHfEBuwZKVeBL8omEyb/w/zrRLwyEyz39wCv4tyRPHcFx1GH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781966499; c=relaxed/simple;
	bh=k/p3YK68+dwwFuyabTyk4/LMpHUE7A4QHwhNhNm2f/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eDbAxfALWKZwKv5A3+L3gtWDUIkOlVhL0bC+T5z1X96/PTteUawm26mAKx8ItiY2v9/Bc9qeXlz9Li8qzqyG+NUdxDRJ+8AKvyhrhlU2ZI8l8ctbc+JnQRsKdwpBdjFlGNiMrh3+OjE4lKm8Eh9IgtHOcdQLwXeThLnEuEoYEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVoxhVS3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVoxhVS3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-462cdb88d01so2006261f8f.0
        for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781966496; x=1782571296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJs5rIL4YzidcoYqbwnERNj7G7JVPIhzvLfE7LZZYDc=;
        b=YVoxhVS3L8+ZPpXh+YfhB66A1wYO5O3dShfjmZ+1BSTWgwhIE31bdjMDfzC2Opbv4x
         njRwLqH+9a670dsR6bnh6f0VbDqI1VrU0Rwv4IxmeTJiJ+sXcOGcEmqELFLaSkxpJO4c
         gRMFrrS2K7zZ/W6R7BEdMUub2p7w7MqSZ3fGDBZ0mzGFYI/6rNT8IdJrArD1Z47FkHd9
         P3K2tCQ7Bfx6k+WsxASHUOOoY0qGwpMCBgPdKJNh7TdD36dV/2oBCQ/en8y7TSwayfKj
         yb1k+ry+VygNzn0gbh7ijN63wCKKtvv4q+QHsRcvDWU7jsv/iWh/uc3dDa+8XqbVM4eN
         Tq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781966496; x=1782571296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJs5rIL4YzidcoYqbwnERNj7G7JVPIhzvLfE7LZZYDc=;
        b=AkAvkWLQx8frbdWDGgcIdOB6bGkjGlpNK0m4mcp/syN2ttM3N3Lk6uNgJ6fFCCmxH3
         IgN8dqBFUgp9sEZubgteRQ8iG0XT+/G16oxZ6fF8OQq+Athfma5nRUWUq4txrSlR6ZXq
         5fPIHyLrJISCC743QNGeuaDueCsABMqjGHlyNI+t/9Pdri99IeArVH36cTSrGiw8Ev6o
         mPEGDYxWDtRjceSLlx1HKUIx401/djEAl37krHApm+Ib6/Pbnt7kgaYqYbPkPIZPMvDf
         NlPa+BDGmnVVbwtjl6/Hxwz+3zFUO01dhMdrqzlWPATzSetQ9WycD1HddONZxn0tW+mI
         tVVw==
X-Gm-Message-State: AOJu0Yzv1pxlFORyJ6KmHsF7saJsi+XwdUrJf61OUyWnkIduacLxR2GA
	5bXoB6TtZcoZhQdNiuXJJDCapwU/eNqn079WZ0yYQxDNYJBqurbJp1bnLGAZd6EGI5ISyA==
X-Gm-Gg: AfdE7cnXWV2zxUzjFQWZ+WC7V8vDnsbUMVpL1iAMURRhwsMFrUQcF1336tBjqbl949h
	E4xsAUci5WSQiRJ2prz9PJfTAD3kh6PP3q2gHAWogwuCEKrPaFsN45eH+37Orb9txP6Q36TjzTg
	Sy4eyvyjoEnJZT3IbmaLJFNGTSAQ/fbUqQJjQnQdySXBiuZR29Wbj42UkrePYtRToPoaiWtd3Qo
	yKbVyUgT89tyZNu+hKkvKPu5tOkmO39K3BVAkqzSa5g9ePxM1Gm1lDna8BBmFxcsid7OCO33OxD
	nFsGnW4E0Ju3cVbvseXxjkRsXnpWNnt349UgaXakkOjJVwHBE815Ei/sOPBJsfyeaLyc4jy92I+
	KUD2pS1hGFZvpNigEXR+zLBO4iBS4+mISDTOSR3StVeAoeU/6Vv9QPcQlxvvAIxpFB8mKSTKq7F
	OkbCDQkwZn/Hav44XYYlaZACGxZgfyk2b4E1tzvqs3OZSgejuud7VgjcT3JxtykFQbV3r1TF5sX
	5tBw0gzdcw=
X-Received: by 2002:a05:6000:4615:b0:460:1378:7b0 with SMTP id ffacd0b85a97d-4651bf5be56mr10271033f8f.5.1781966495854;
        Sat, 20 Jun 2026 07:41:35 -0700 (PDT)
Received: from ws1-mint.. (host125-33-78-130.dimensionesrl.eu. [130.78.33.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm8964357f8f.31.2026.06.20.07.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 07:41:35 -0700 (PDT)
From: Simone Chifari <simone.chifari@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Simone Chifari <simone.chifari@gmail.com>
Subject: [PATCH v2 0/1] i2c: imc-x299: add Intel X299 iMC SMBus adapter
Date: Sat, 20 Jun 2026 16:41:28 +0200
Message-ID: <20260620144131.415559-1-simone.chifari@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a driver for the integrated memory controller (iMC) SMBus
engine on Intel Skylake-X / Cascade Lake-X processors (socket LGA 2066,
platform X299, PCU function 8086:2085).

The engine provides two SMBus channels — one per pair of DIMM slots — over
which SPD EEPROMs, DDR4 thermal sensors and third-party LED controllers
(e.g. ENE KB9012 at 0x27) are accessible.  Exposing it as a pair of standard
Linux I2C adapters lets existing tools (i2c-tools, lm-sensors) use
it without bespoke sysfs hacks.

Why ECAM MMIO instead of pci_{read,write}_config_dword
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
On X299 the kernel selects "configuration type 1" (CF8/CFC port I/O) for PCI
config space access, as reported by boot-time dmesg:

  PCI: Using configuration type 1 for base access

System Management Mode traps writes to those ports for this device, so a
standard pci_write_config_dword() targeting the SMBus DATA register never
reaches the hardware — the transaction hangs at status bit 0x08 indefinitely.
The Windows NTIOLib (used by Kingston FURY) reaches the same registers via the
ECAM (MMIO) window, which is not trapped.  This driver follows the same path:
ioremap() of the ECAM page for the target function and driving the registers
by MMIO read/write.

Note that pci_mmcfg_* helpers are arch-internal and not exported to modules,
so a manual walk of the ACPI MCFG table is used to locate mmcfg_base at probe
time (no module parameter, no hardcoding).

Relation to prior iMC SMBus work
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Two previous attempts to upstream an iMC SMBus driver exist:

  - Lutomirski 2013–2016 (Sandy Bridge-EP 8086:3ca8): used CF8/CFC
    pci_read/write_config_dword — correct on that platform since SMM does not
    trap those ports on Sandy Bridge-EP.  Not merged due to missing bus
    arbitration (BMC / CLTT sharing) and a required allow_unsafe_access flag.

  - schaecsn 2020 (Broadwell-E 8086:6fa8): added TSOD arbitration using the
    Broadwell-documented tsod_polling_interval quiesce procedure.  Not merged
    (no reviewer response); register layout differs from X299.

This driver is for a different device ID (0x2085), different register layout
(DATA/STATUS/CTRL at 0x9C-0xB8 vs 0x180-0x188), and a fundamentally different
access method (ECAM ioremap).  Combining it with the Lutomirski/schaecsn code
would require a large per-generation hw_data table with mutually incompatible
access methods; a separate file is cleaner.

The X299 HEDT (High-End Desktop) platform has no BMC and no CLTT firmware
polling, so the arbitration safety concern of the Lutomirski patch does not
apply.  No allow_unsafe_access flag is needed.

Testing
~~~~~~~
Tested on: ASUS TUF X299 Mark 1, Intel Core i9-10900X, 4× Kingston FURY
HyperX DDR4-3000 16 GB, kernel 7.0.0-14-generic (Linux Mint 22.3).

  $ i2cdetect -l | grep iMC
  i2c-7   smbus   iMC SMBus X299 channel 0   SMBus adapter
  i2c-8   smbus   iMC SMBus X299 channel 1   SMBus adapter

Since the hardware only supports register-offset transactions (SMBus BYTE_DATA),
zero-length writes (QUICK) and offset-less transactions (BYTE) are not supported
(returning -EOPNOTSUPP), so standard i2cdetect scans do not list devices.
However, standard kernel drivers such as ee1004 (for DDR4 SPD) load and bind
successfully, accessing the EEPROMs via standard BYTE_DATA reads.

udev autoloads the module on PCI add event (MODULE_DEVICE_TABLE present).
20 rmmod/modprobe cycles: no oops, no warnings, no resource leaks in dmesg.

Simone Chifari (1):
  i2c: imc-x299: add driver for Intel X299/Skylake-X iMC SMBus engine

 MAINTAINERS                       |   6 +
 drivers/i2c/busses/Kconfig        |  19 ++
 drivers/i2c/busses/Makefile       |   1 +
 drivers/i2c/busses/i2c-imc-x299.c | 435 ++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-imc-x299.c

-- 
2.43.0

