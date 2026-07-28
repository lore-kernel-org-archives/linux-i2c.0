Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F299432BFF
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241472; cv=none; b=pvNp5Sdp8m3V+pFKHX1mj61DkeTx/uESJMRHkEkQDBwCg640QTLYiqev2oA5l9pAwZ9x+AzHGmHjay69DH2MegYTnVnYqF0PQjmkc4GwFWXoTKizezxuGNohykqwCpoooYZ20QGi+dDVB/MAKkBjrNJj2R3wwjbxdhgwI/KlrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241472; c=relaxed/simple;
	bh=9SCB16e5zLC8I+jhTalbI8X35cZgoXIJznYjA1CxyBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW/l5Lrf90FqC1ZOYDFZkhpbXKOJKX7SnCENhR8nL3a9jpefFBwkK6zn7TrQ9gtzZpvxggpHCIn3PyQg+6duPzStXLR3ELWQzeFcGQf+TybEsJmFpQqVGjCMSbk5dVvR3zpV8cFcdaHSsjSHfH3smE0SL7Ih3JCjZ2JV9DXYwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmXelSe6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmXelSe6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-496b7622a83so19603735e9.2
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785241467; x=1785846267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHajKhdEBOx+TomCtk6H6h9drveBTE+SHlmHTXMbobQ=;
        b=HmXelSe6C9t20B5UZ+1SPXDLKxTufE4jDx3EgQqyCloalAJmfdzd1ZoZeciTcs4IIv
         CUqE+ZVDyko9Bd2CmX1UheWCFkr+Ej1iV7xfhSrnhhLkynz0kV8kj8/4nG78VI69LqBN
         zjk/CSQDpffJD4j99FRq1JZFnXedEiOjp+HPy2fh6lXebBQZuf66CnP+DFYHDVaVck96
         JFIE+2YuoW+twxr5qYaGIOtyoeixO9oA/KYVXwEKcpMHVZhYnzeK7xrjYhsfE2BFp5qc
         jz+RJ5B4FUdagtFaeNPyG9xT8ic070PPAM/57SgMGU7gHybSUpI/OGgYUksW3I56hlTR
         JiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785241467; x=1785846267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHajKhdEBOx+TomCtk6H6h9drveBTE+SHlmHTXMbobQ=;
        b=MtEnQj9+127jKslduiVDlzDkNZxXJRRg0ETNeHwEIICX2pMxUylj9DayGaHEXwvyP/
         xR52orhfhuQezyRhXjr1ghhPXjTacgagKAhokf1mNIdyPmiqZGm/ZRqYwpC96GX6Wg7x
         YORQr1yBmRv7qWQ57mY3SjF8Gnls7ZcQq75aMK8lPiORCClEpE/I6f2c6Gh1HBmsxSeK
         8EkEVz3BXYUrLYFJotnxgA2iwNHZSIxwcv4bd7BtupMz502PE1Hokuj/HYPaHjkHaIR7
         X0ykfAgzn/E9O8J3sEJ7kDJVzAWUX233gm9lCWhCErN5r6s/YJsNVeUYuiZnib2n0YxL
         gg8Q==
X-Gm-Message-State: AOJu0YzhKVNJybR/e9bzBzQPFSaJOZ7UlpCG/KbHqhpAo2tck4xL11RC
	oZPj/AbNmUojsxMMNEVebe6EuBfypUu9bLzhhaSPIhJbcyR8ALhV+aNLpsrJE9M6lnk=
X-Gm-Gg: AR+sD11rbx8WzCoIribrnfUvxK3gTSmMednp/I7KYfl9b+EEmB31g9dMgGgtykA8CuN
	w/Sn3wu6saAvCecnvSjrzcfW51VuXhQl8xQW/6mc+KCGD2fe+oRH0xOAHCLj5gMvYIp+EutWuCG
	muT37gdzR2xYuUUVP321lWH5p6wLcISK9emQjlzKtsSgeozBvC6R+ev2ddPuqocULIgrbefBFjY
	E7AuWsHy31odGuHEBtwsGiQJpDl23fooPI0OWLQf8tsEpkw/UkkxUq8wC73U8DdBjFQQRz0hb6R
	ESjsGnTPpcdcfbKqLPpzf28m4l+KSWk+NTOina2x+SXmUkY0rfJ2ORmg72ywGQ1ptbcgv1TYfS0
	r9hmVS0C7MesGUm4+y86EVeXeir5A98F7nJpKqWdFuc8wNgsLUJ14Fzq6d9EB4RIe0JJBOUnVsJ
	nYY/AvLjDkNPSBODuTjrk0liwr8M5cqy3BMWhJ7dcdEjbUyAVMnIbQKQ/to1O4iTh0icXqEMWNk
	kVG7IwReCRd
X-Received: by 2002:a05:600c:5486:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-496c6413059mr22352065e9.1.1785241466293;
        Tue, 28 Jul 2026 05:24:26 -0700 (PDT)
Received: from ws1-mint.. (host165-7-217-213.cgnat.broadband.ehiweb.it. [213.217.7.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45e0424sm76427265e9.13.2026.07.28.05.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:24:25 -0700 (PDT)
From: Simone Chifari <simone.chifari@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Stefan Schaeckeler <schaecsn@gmx.net>,
	Simone Chifari <simone.chifari@gmail.com>
Subject: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
Date: Tue, 28 Jul 2026 14:24:23 +0200
Message-ID: <20260728122423.358416-2-simone.chifari@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728122423.358416-1-simone.chifari@gmail.com>
References: <20260728122423.358416-1-simone.chifari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The integrated memory controller of Intel Skylake-X and Cascade Lake-X
processors contains an SMBus engine wired to the DDR4 DIMMs.  It reaches
the SPD EEPROMs at 0x50-0x57 and the thermal sensors at 0x18-0x1f, on
two independent channels.  Expose the two channels as standard I2C
adapters so i2c-tools, decode-dimms and lm-sensors can use them.

The engine is driven through the config space of the PCU function
8086:2085, at offsets 0x9C-0xB8, with the ordinary config accessors.

It has no arbitration mechanism.  SMM, a BMC and the memory controller's
own closed-loop thermal throttling can drive the same registers, and the
PCI ID does not tell the driver whether any of them is active, so keep
the driver default-off behind allow_unsafe_access, as the earlier iMC
drivers for Sandy Bridge-EP and Broadwell-E did.

Refuse to bind outright when the memory controller is polling the DIMM
thermal sensors itself.  The Intel Xeon Processor Scalable Family datasheet
volume 2 (reference 614073, section 3.1.9) documents SMBCNTL on the iMC
channel function, device 10 and 12 function 0, at offsets 0xe88 and 0xe98.
Its SMB_TSOD_POLL_EN bit is documented as mutually exclusive with SPD
command access, so it answers directly whether the engine is already in
use.  Read it on every channel at probe.  This is weaker than the
Broadwell-E driver, which switched the polling off for the duration of a
transfer; declining is a smaller claim on hardware the driver does not own
and needs no write to a firmware-configured register.  It covers the memory
controller only, not SMM or a BMC.

On top of that gate, serialize both channels under one mutex, wait for
the whole engine to be idle before touching any register, save the
command state of both channels and clear TSOD_ACTIVE for the duration of
the transfer, and restore both afterwards.  Then compare the command
registers against what the driver left in them and fail the transfer
with -EAGAIN when anything else changed: without that check a second
master using the engine is silently wrong rather than merely
unsupported.

The completion bits are latched and no way to clear them has been found.
With the driver unloaded and nothing running, STATUS on the test system
reads 0x0000300c, both READ_DONE and WRITE_DONE still set from an
earlier transaction.  A command word that never reaches the register is
therefore indistinguishable from a completed transfer: the stale word
has GO already clear, STATUS already shows a DONE, and the caller
receives the previous transaction's data as valid.  Read the command
word back and require it to be the one just written.  The engine only
ever clears GO, so that is the single permitted difference.

Support SMBus Receive Byte and Send Byte, BYTE_DATA and WORD_DATA, and
reject 10-bit addressing and unsupported protocols explicitly.  That
covers jc42 and ee1004, so decode-dimms reads the whole 512-byte DDR4
SPD including the fields on page 1.

Receive Byte and Send Byte need a command word that puts no register byte
on the bus, which the engine encodes in bit 18.  That bit is not
documented for this function, and it is the only undocumented encoding
this driver relies on, so it was pinned down rather than assumed.  SMBCMD
on the iMC channel function places PNTR_SEL immediately above WORD_ACCESS,
and word access on the PCU function is bit 17.  With bit 18 set on a read,
eight consecutive transfers to an SPD EEPROM returned bytes 0x01 through
0x08 in order, matching an ordinary dump of the same range: that is the
auto-increment of a Receive Byte, and a transfer still naming a register
would have returned the same byte eight times.  With it set on a write, a
Send Byte to the DDR4 page-select addresses moves the 256-byte window and
moves it back.

With Receive Byte available, instantiate the SPD EEPROMs the way the other
SMBus host drivers do, with i2c_register_spd() per adapter, rather than
leaving it to the user.  The helper counts the populated slots from DMI
and probes upwards from 0x50, so it claims no address that does not
answer; each channel carries half the DIMMs and the scan is per adapter,
so each finds its own.  Nothing else is instantiated, jc42 included:
there is no firmware description of these buses and this driver does not
scan for anything but the SPDs.

The write_disable variant is used deliberately.  This part is DDR4 only,
where the two are equivalent - the distinction gates spd5118 on DDR5 -
and of two equivalent calls the one that does not read as "this driver
enables SPD writes" is the better name to leave in a driver whose bus is
the memory bus.

Do not implement SMBus Quick.  Besides having no obvious encoding here, a
write into the 0x30-0x37 range is how an EE1004 SPD is write-protected,
permanently on many modules.  An adapter whose bus is the memory bus
should not advertise a probe that writes; i2cdetect scans these buses in
read mode.

Link: https://lore.kernel.org/linux-i2c/20260620144131.415559-1-simone.chifari@gmail.com/
Assisted-by: Claude-Code:claude-opus-5 checkpatch sparse
Signed-off-by: Simone Chifari <simone.chifari@gmail.com>
---
 Documentation/i2c/busses/i2c-imc-skylake.rst | 178 +++++
 Documentation/i2c/busses/index.rst           |   1 +
 MAINTAINERS                                  |   7 +
 drivers/i2c/busses/Kconfig                   |  27 +
 drivers/i2c/busses/Makefile                  |   1 +
 drivers/i2c/busses/i2c-imc-skylake.c         | 734 +++++++++++++++++++
 6 files changed, 948 insertions(+)
 create mode 100644 Documentation/i2c/busses/i2c-imc-skylake.rst
 create mode 100644 drivers/i2c/busses/i2c-imc-skylake.c

diff --git a/Documentation/i2c/busses/i2c-imc-skylake.rst b/Documentation/i2c/busses/i2c-imc-skylake.rst
new file mode 100644
index 000000000..a1babbb7d
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-imc-skylake.rst
@@ -0,0 +1,178 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Kernel driver i2c-imc-skylake
+=============================
+
+Supported adapters:
+  * Intel Skylake-X / Cascade Lake-X integrated memory controller (iMC)
+    SMBus engine, PCU function 8086:2085 (socket LGA 2066, platform X299)
+
+Author: Simone Chifari <simone.chifari@gmail.com>
+
+
+Description
+-----------
+
+The integrated memory controller of Intel Skylake-X and Cascade Lake-X
+processors contains an SMBus engine wired to the DDR4 DIMMs.  It reaches the
+SPD EEPROMs (0x50-0x57) and the thermal sensors (TSOD, 0x18-0x1f) of the
+installed modules, plus whatever else a particular module carries on those
+lines.
+
+The engine has two independent channels.  DIMM slots 1 and 2 are on channel 0,
+slots 3 and 4 on channel 1, so the driver registers two i2c adapters::
+
+    $ i2cdetect -l | grep iMC
+    i2c-6   smbus   iMC SMBus Skylake-X channel 0   SMBus adapter
+    i2c-7   smbus   iMC SMBus Skylake-X channel 1   SMBus adapter
+
+Both channels share one hardware engine, so the driver serializes every
+transaction across both adapters.
+
+
+This driver is not enabled by default
+-------------------------------------
+
+The SMBus engine has no arbitration mechanism.  System Management Mode, a BMC,
+and the memory controller's own closed-loop thermal throttling (CLTT) can all
+drive the same registers, and nothing in the PCI ID tells the driver whether
+any of them is doing so on a given system.  Two masters using the engine at the
+same time can send a transaction to the wrong address or return the wrong data.
+
+The driver therefore refuses to bind unless the operator opts in::
+
+    modprobe i2c-imc-skylake allow_unsafe_access=1
+
+Do this only on a system where concurrent firmware access has been excluded.
+Desktop and HEDT boards have no BMC, but CLTT may still be enabled by the
+firmware.
+
+The driver reduces, but cannot remove, the risk.
+
+At probe it reads SMBCNTL on every iMC channel function (device 10 and 12,
+function 0; offsets 0xe88 and 0xe98, documented in the Intel Xeon Processor
+Scalable Family datasheet volume 2, reference 614073, section 3.1.9).
+``SMB_TSOD_POLL_EN`` in that register says whether the memory controller is
+polling the DIMM thermal sensors on its own, which Intel documents as mutually
+exclusive with SPD command access.  If the bit is set on any channel the driver
+refuses to bind: the engine is not ours to drive.  This covers the memory
+controller, not SMM or a BMC, which remain the reason for the opt-in.
+
+Per transfer:
+
+  * every transaction waits for both channels to report idle before it
+    touches any register;
+  * the previous command state of both channels is saved, the TSOD-active
+    state is cleared for the duration of the transfer, and both are restored
+    afterwards;
+  * after each transfer the command registers are compared against what the
+    driver left in them.  A difference means another master used the engine,
+    and the transfer is failed with ``-EAGAIN`` rather than reported as
+    successful.
+
+The last check is what makes an unarbitrated system detectable: if the log
+shows
+
+  ``chN command changed under us (...): another master is using the engine``
+
+then firmware is using the engine and the driver should not be loaded on that
+system.
+
+
+Config space access
+-------------------
+
+The engine's registers live at config space offsets 0x9C-0xB8 of the PCU
+function and are reached with the ordinary ``pci_read_config_dword()`` and
+``pci_write_config_dword()``.  Nothing special is required.
+
+Supported transactions
+----------------------
+
+The driver implements SMBus Receive Byte and Send Byte, Read/Write Byte Data
+and Read/Write Word Data.
+
+That covers ``jc42`` (TSOD) and ``ee1004``, so ``decode-dimms`` reads the whole
+512-byte DDR4 SPD, including the manufacturer and part-number fields that live
+on page 1.
+
+Receive Byte and Send Byte need a command word that puts no register byte on
+the bus.  The engine encodes that in bit 18, which is not documented for this
+function.  It was found by noting that the interface Intel does document for
+the iMC channel functions (SMBCMD, datasheet reference 614073, section 3.1.8)
+places ``PNTR_SEL`` immediately above ``WORD_ACCESS``, and that word access
+here is bit 17.  With the bit set, consecutive reads of an SPD EEPROM return
+consecutive bytes, which is the auto-increment behaviour of a Receive Byte and
+cannot be produced by a transfer that names a register.
+
+SMBus Quick is not implemented.  ``i2cdetect`` therefore has to be run in
+read mode::
+
+    $ i2cdetect -y -r 6
+         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
+    20: -- -- -- -- -- -- -- 27 -- -- -- -- -- -- -- --
+    30: 30 31 -- -- 34 35 36 -- -- -- -- -- -- -- -- --
+    50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
+
+Not advertising Quick is deliberate as well as accurate.  A write to the
+0x30-0x37 range is how an EE1004 SPD is write-protected, permanently on many
+modules, so an adapter on a memory bus should not offer probing that writes.
+
+Block transfers are not implemented.  The engine has block primitives, but no
+device on this bus needs them.
+
+Word transfers use the standard SMBus byte order, so ``jc42`` reading through
+``i2c_smbus_read_word_swapped()`` gets the value it expects.
+
+
+Instantiating clients
+---------------------
+
+SPD EEPROMs are instantiated at probe with ``i2c_register_spd()``, like the
+other SMBus host drivers.  It counts the populated slots from DMI and probes
+from 0x50 upwards, so an address that does not answer is left alone.  Each
+channel carries half the DIMMs and the scan runs per adapter, so each finds
+its own::
+
+    i2c i2c-6: Successfully instantiated SPD at 0x50
+    ee1004 6-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
+
+``decode-dimms`` therefore works with no manual step.
+
+Nothing else is instantiated: there is no firmware description of these buses
+and the driver does not scan for anything but the SPDs.  ``jc42`` has to be
+added by hand where a thermal sensor is populated::
+
+    # echo jc42 0x18 > /sys/bus/i2c/devices/i2c-6/new_device
+
+Whether one is populated is visible in ``SMBCNTL.TSOD_PRESENT``; on the
+development system that mask is empty and no ``jc42`` binds.
+
+Two things about the SPDs are worth knowing on this bus.
+
+A DDR4 SPD is a 512-byte array reached through a 256-byte window, and which
+half is visible is a property of the bus, not of the transfer.  ``ee1004``
+selects a page when it needs one and leaves it selected, so a raw ``i2cget``
+issued afterwards may be looking at page 1.  Select page 0 explicitly before
+reading SPD by hand::
+
+    # i2cset -y 6 0x36 0x00 c
+
+And ``ee1004`` owns those addresses once bound, so userspace cannot reach them
+through ``/dev/i2c-*`` any more.  This is ordinary I2C behaviour, but it is
+worth stating here because the userspace tools that motivate this driver share
+the bus with the SPDs.  Read the SPD through the driver instead::
+
+    $ cat /sys/bus/i2c/drivers/ee1004/6-0050/eeprom | hexdump -C
+
+or, if an address really is needed raw, release it::
+
+    # echo 0x50 > /sys/bus/i2c/devices/i2c-6/delete_device
+
+Module parameters
+-----------------
+
+allow_unsafe_access
+  Bool, read-only after load, defaults to false.  The driver does not bind
+  unless this is set.  See the section above.
diff --git a/Documentation/i2c/busses/index.rst b/Documentation/i2c/busses/index.rst
index 5e4077b08..2d503d59d 100644
--- a/Documentation/i2c/busses/index.rst
+++ b/Documentation/i2c/busses/index.rst
@@ -15,6 +15,7 @@ I2C Bus Drivers
    i2c-amd-mp2
    i2c-diolan-u2c
    i2c-i801
+   i2c-imc-skylake
    i2c-ismt
    i2c-mlxcpld
    i2c-nforce2
diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f..17bc737b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13265,6 +13265,13 @@ S:	Maintained
 F:	drivers/platform/x86/intel/int3472/
 F:	include/linux/platform_data/x86/int3472.h
 
+INTEL SKYLAKE-X IMC SMBUS DRIVER
+M:	Simone Chifari <simone.chifari@gmail.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/i2c/busses/i2c-imc-skylake.rst
+F:	drivers/i2c/busses/i2c-imc-skylake.c
+
 INTEL SPEED SELECT TECHNOLOGY
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867..deafd7890 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -180,6 +180,33 @@ config I2C_I801_MUX
 	  Optional support for multiplexed SMBUS on certain systems with
 	  more than 8 memory slots.
 
+config I2C_IMC_SKYLAKE
+	tristate "Intel Skylake-X iMC SMBus adapter"
+	depends on PCI && (X86_64 || COMPILE_TEST)
+	select I2C_SMBUS
+	help
+	  Say Y here if you want kernel support for the integrated memory
+	  controller (iMC) SMBus engine found in Intel Skylake-X / Cascade
+	  Lake-X processors (socket LGA 2066, platform X299, PCU function
+	  8086:2085).
+
+	  Two I2C adapters are registered, one per hardware SMBus channel,
+	  allowing access to DDR4 DIMM SPD EEPROMs (0x50-0x57) and thermal
+	  sensors from userspace via standard i2c-tools and lm-sensors.
+	  SPD EEPROMs are instantiated automatically from DMI, so decode-dimms
+	  works without any manual step.
+
+	  Firmware, SMM, a BMC or CLTT may drive the same engine and no
+	  generic arbitration mechanism is known.  The driver therefore
+	  refuses to bind unless the allow_unsafe_access module parameter
+	  is enabled.  See Documentation/i2c/busses/i2c-imc-skylake.rst.
+
+	  If unsure, say N.  This driver is only useful on Intel X299 desktop
+	  / HEDT systems with the Skylake-X or Cascade Lake-X CPU.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-imc-skylake.
+
 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
 	depends on PCI && HAS_IOPORT
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab3..3f45fb8ca 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_CHT_WC)	+= i2c-cht-wc.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_IMC_SKYLAKE)	+= i2c-imc-skylake.o
 obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
 obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
diff --git a/drivers/i2c/busses/i2c-imc-skylake.c b/drivers/i2c/busses/i2c-imc-skylake.c
new file mode 100644
index 000000000..0c5018e7e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-imc-skylake.c
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Skylake-X iMC SMBus I2C adapter.
+ *
+ * The integrated memory controller (iMC) on Intel Skylake-X / Cascade Lake-X
+ * processors contains an SMBus engine wired to the DDR4 DIMMs.  It reaches the
+ * SPD EEPROMs (0x50-0x57) and the thermal sensors (0x18-0x1f) of the installed
+ * modules.  The engine is driven through the PCI configuration space of the
+ * Sky Lake-E PCU function (8086:2085).  This driver presents it as two standard
+ * Linux I2C adapters - one per hardware SMBus channel - so that i2c-tools,
+ * decode-dimms and lm-sensors can use it without bespoke sysfs hacks.
+ *
+ * Per-channel register triple within the config space of the function:
+ *                  ch0     ch1
+ *     CTRL (data)  0xB4    0xB8   write: data byte in bits[23:16]; read: low byte
+ *     DATA (cmd)   0x9C    0xA0   command toggle | GO | address | register
+ *     STATUS       0xA8    0xAC   bit0 BUSY, bit1 ERROR/NACK,
+ *                                 bit2 READ_DONE, bit3 WRITE_DONE
+ *   SMBus command byte (DATA bits[15:8]) = (rw << 7) | addr7: the 7-bit slave
+ *   address with bit7 = direction (1 write / 0 read).  The register/offset goes
+ *   in DATA[7:0].  So 0x50 reads SPD EEPROM 0x50.  This was decoded and
+ *   confirmed on hardware, and cross-checked against an independent Windows
+ *   implementation of the same engine.
+ *
+ * The two channels are independent SMBus buses (DIMMs 1,2 on ch0; DIMMs 3,4 on
+ * ch1), hence two i2c_adapter instances exposed as separate /dev/i2c-* nodes.
+ *
+ * Bus arbitration / concurrency with firmware:
+ *   The driver cannot coordinate with SMM, a BMC, or the iMC's own closed-loop
+ *   thermal throttling (CLTT), and the PCI ID alone does not prove that none of
+ *   them is active.  Binding is therefore disabled by default and requires
+ *   allow_unsafe_access=1, following the same choice made by the earlier iMC
+ *   drivers for Sandy Bridge-EP and Broadwell-E.  On top of that, transactions
+ *   are serialized across both channels, wait for the complete engine to become
+ *   idle, temporarily clear TSOD_ACTIVE, restore the previous command state,
+ *   and verify afterwards that no other master modified the command registers
+ *   while the transfer was in flight.
+ *
+ *   Not implemented: the Broadwell-E driver additionally stops the PCU's TSOD
+ *   polling for the duration of a transfer (write 0 to the polling interval,
+ *   wait 10 ms for in-flight transactions to drain, restore afterwards).  The
+ *   equivalent register has not been identified on this part, so a system with
+ *   CLTT enabled is expected to trip the interference check below rather than
+ *   to be arbitrated against.
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+/* PCI id of the Sky Lake-E PCU function carrying the SMBus engine */
+#define PCU_DEVICE	0x2085
+
+/*
+ * The iMC channel function, device 10 and 12 function 0, carries the SMBus
+ * control register documented in the Intel Xeon Processor Scalable Family
+ * datasheet volume 2 (reference 614073) section 3.1.9.  Only SMBCNTL is read
+ * here, and only to find out whether the hardware is polling the DIMM thermal
+ * sensors on its own.
+ */
+#define IMC_CHANNEL_DEVICE	0x2040
+#define IMC_SMBCNTL(ch)		(0xE88 + (ch) * 0x10)
+#define SMBCNTL_TSOD_POLL_EN	BIT(8)
+#define SMBCNTL_TSOD_PRESENT	GENMASK(7, 0)
+
+/* per-channel register offsets in the function's config space */
+#define CH0_CTRL	0xB4
+#define CH0_DATA	0x9C
+#define CH0_STAT	0xA8
+#define CH1_CTRL	0xB8
+#define CH1_DATA	0xA0
+#define CH1_STAT	0xAC
+
+/*
+ * Command word written to the DATA register:
+ *   bit29       = command toggle
+ *   bit20       = TSOD active state, preserved across transfers
+ *   bit19       = GO
+ *   bit17       = word transfer
+ *   bits[15:8]  = SMBus command byte = (rw << 7) | addr7
+ *                   rw bit (0x80): 1 = write, 0 = read
+ *                   addr7        : 7-bit SMBus slave address
+ *   bits[7:0]   = register/offset within the addressed device
+ * For a write the data byte is latched into CTRL[23:16] beforehand.  This
+ * encoding was confirmed on hardware: command 0x50 reads SPD EEPROM 0x50
+ * (DDR4 signature).
+ */
+#define COMMAND_TOGGLE	BIT(29)
+#define GO_BIT		BIT(19)		/* start transaction */
+#define TSOD_ACTIVE_BIT	BIT(20)
+#define WORD_BIT	BIT(17)		/* 16-bit word transfer (vs 8-bit byte) */
+/*
+ * Address-only transfer: the register byte in bits[7:0] is not put on the bus.
+ * A read then returns the byte at the device's own pointer (SMBus Receive
+ * Byte) and a write sends the data byte alone (SMBus Send Byte).
+ *
+ * The bit is not documented for this function.  It was found by noting that
+ * the interface Intel does document for the iMC channel functions (SMBCMD,
+ * datasheet ref. 614073 section 3.1.8) places PNTR_SEL immediately above
+ * WORD_ACCESS, and that word access here is bit 17.  Confirmed on hardware:
+ * with the bit set, eight consecutive reads of an SPD EEPROM returned bytes
+ * 0x01 through 0x08 in order, matching an ordinary dump of the same range,
+ * which is the auto-increment behaviour of a Receive Byte and cannot be
+ * produced by a transfer that names a register.
+ */
+#define PNTR_SEL_BIT	BIT(18)
+#define WRITE_OPERATION	BIT(15)
+#define COMMAND_PREFIX	(COMMAND_TOGGLE | GO_BIT)
+#define COMMAND_KEEP_MASK	(~TSOD_ACTIVE_BIT)
+/*
+ * Command bits this driver produces itself.  Everything outside this mask
+ * belongs to whoever else is driving the engine, so a change there during a
+ * transfer means interference.
+ */
+#define COMMAND_OUR_BITS	(COMMAND_TOGGLE | GO_BIT | WORD_BIT | \
+				 PNTR_SEL_BIT | GENMASK(15, 0))
+#define STAT_BUSY	BIT(0)		/* low bit set while transaction in flight */
+#define STAT_ERROR	BIT(1)
+#define STAT_READ_DONE	BIT(2)
+#define STAT_WRITE_DONE	BIT(3)
+#define STAT_ANY_DONE	(STAT_ERROR | STAT_READ_DONE | STAT_WRITE_DONE)
+
+/*
+ * Polling bounds.  Transactions on the tested system complete in a few
+ * milliseconds; these are upper bounds that avoid busy-spinning and cover
+ * device clock stretching, not a measured multi-platform worst case.  The
+ * mutex is held across a whole transfer, so the worst case a caller on the
+ * other channel can wait for is the sum of all of them, roughly 750 ms.
+ */
+#define IMC_POLL_US		10
+#define IMC_IDLE_TIMEOUT_US	50000
+#define IMC_GO_TIMEOUT_US	200000
+#define IMC_DONE_TIMEOUT_US	50000
+
+static bool allow_unsafe_access;
+module_param(allow_unsafe_access, bool, 0444);
+MODULE_PARM_DESC(allow_unsafe_access,
+		 "allow access without firmware/SMM arbitration (unsafe)");
+
+struct imc_chan {
+	unsigned int ctrl, data, stat;
+	int idx;			/* channel index 0 or 1 */
+};
+
+static const struct imc_chan imc_chans[2] = {
+	{ CH0_CTRL, CH0_DATA, CH0_STAT, 0 },
+	{ CH1_CTRL, CH1_DATA, CH1_STAT, 1 },
+};
+
+/* one driver state object, shared by both per-channel adapters */
+struct imc_smbus {
+	struct pci_dev *pdev;		/* config space carrying the engine */
+	struct device *dev;		/* &pdev->dev, for dev_*() logging */
+	struct mutex lock;		/* serialises all SMBus transactions */
+					/* needed: both channels share one engine */
+	struct i2c_adapter adap[2];	/* one per hardware channel */
+	int io_err;			/* sticky config-access error, under lock */
+};
+
+struct imc_xfer_state {
+	u32 command[ARRAY_SIZE(imc_chans)];
+	bool restore[ARRAY_SIZE(imc_chans)];
+};
+
+/*
+ * Register accessors.  A config-space failure is recorded in s->io_err and
+ * reported once, at the end of the transfer, so the transaction logic does not
+ * have to check a return value on every register touch.  A failed read yields
+ * all-ones, which no polling loop mistakes for a completed transaction.
+ */
+static u32 imc_reg(struct imc_smbus *s, unsigned int off)
+{
+	u32 val;
+	int ret;
+
+	ret = pci_read_config_dword(s->pdev, off, &val);
+	if (ret) {
+		s->io_err = pcibios_err_to_errno(ret);
+		return ~0U;
+	}
+
+	return val;
+}
+
+static void imc_set(struct imc_smbus *s, unsigned int off, u32 val)
+{
+	int ret;
+
+	ret = pci_write_config_dword(s->pdev, off, val);
+	if (ret)
+		s->io_err = pcibios_err_to_errno(ret);
+}
+
+static u32 imc_busy_mask(struct imc_smbus *s)
+{
+	u32 busy = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imc_chans); i++)
+		if (imc_reg(s, imc_chans[i].stat) & STAT_BUSY)
+			busy |= BIT(i);
+
+	return busy;
+}
+
+static int imc_wait_engine_idle(struct imc_smbus *s)
+{
+	u32 busy;
+	int ret;
+
+	ret = read_poll_timeout(imc_busy_mask, busy, !busy || s->io_err,
+				IMC_POLL_US, IMC_IDLE_TIMEOUT_US, false, s);
+	if (ret)
+		dev_warn_ratelimited(s->dev,
+				     "engine busy on channel mask 0x%x\n", busy);
+
+	return ret;
+}
+
+static int imc_wait_go_clear(struct imc_smbus *s, const struct imc_chan *c)
+{
+	u32 val;
+
+	return read_poll_timeout(imc_reg, val, !(val & GO_BIT) || s->io_err,
+				 IMC_POLL_US, IMC_GO_TIMEOUT_US, false,
+				 s, c->data);
+}
+
+static int imc_wait_done(struct imc_smbus *s, const struct imc_chan *c,
+			 u32 *status)
+{
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout(imc_reg, val,
+				(!(val & STAT_BUSY) && (val & STAT_ANY_DONE)) ||
+				s->io_err,
+				IMC_POLL_US, IMC_DONE_TIMEOUT_US, false,
+				s, c->stat);
+	*status = val;
+
+	return ret;
+}
+
+static int imc_wait_transfer(struct imc_smbus *s, const struct imc_chan *c,
+			     u32 *status)
+{
+	u32 command;
+	int ret;
+
+	ret = imc_wait_go_clear(s, c);
+	if (ret)
+		*status = imc_reg(s, c->stat);
+	else
+		ret = imc_wait_done(s, c, status);
+	if (!ret)
+		return 0;
+	if (!(*status & STAT_BUSY) || (*status & STAT_ANY_DONE))
+		return ret;
+
+	command = imc_reg(s, c->data);
+	imc_set(s, c->data, command ^ COMMAND_TOGGLE);
+
+	ret = imc_wait_done(s, c, status);
+	if (ret)
+		dev_warn_ratelimited(s->dev,
+				     "ch%d recovery timed out (stat 0x%08x)\n",
+				     c->idx, *status);
+
+	return ret;
+}
+
+static int imc_check_status(struct imc_smbus *s, const struct imc_chan *c,
+			    u32 status, u32 expected, u8 addr, u8 reg)
+{
+	if (status & STAT_ERROR) {
+		dev_dbg(s->dev, "addr 0x%02x reg 0x%02x NACK (stat 0x%08x)\n",
+			addr, reg, status);
+		return -ENXIO;
+	}
+
+	/* Done bits are latched; only the bit for this operation is required. */
+	if (!(status & expected)) {
+		dev_warn_ratelimited(s->dev,
+				     "ch%d unexpected completion for addr 0x%02x reg 0x%02x (stat 0x%08x)\n",
+				     c->idx, addr, reg, status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * The done bits are latched and no way to clear them has been found, so a
+ * command that never reaches the register is indistinguishable from one that
+ * completed: STATUS still shows the previous DONE, the GO bit of the stale
+ * command word is already clear, and the caller would receive the previous
+ * transaction's data as valid.
+ *
+ * Read the command word back and require it to be the one just written.  The
+ * engine only ever clears GO, so that bit is the single permitted difference;
+ * anything else means the write did not land.  Checking the word rather than
+ * a status transition matters because two identical transfers in a row leave
+ * STATUS bit for bit the same.
+ */
+static bool imc_command_landed(u32 command, u32 readback)
+{
+	return !((command ^ readback) & ~GO_BIT);
+}
+
+/*
+ * Detect a second master.  Compare the command registers against what this
+ * driver left in them: for the channel it drove, only the bits it does not own;
+ * for the other channel, all of them.  A difference means firmware, a BMC or
+ * CLTT touched the engine while the transfer was in flight, so the result
+ * cannot be trusted.
+ */
+static int imc_check_interference(struct imc_smbus *s, const struct imc_chan *c,
+				  const struct imc_xfer_state *state)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imc_chans); i++) {
+		u32 mask = i == c->idx ? ~COMMAND_OUR_BITS : ~0U;
+		u32 expect = state->command[i] & COMMAND_KEEP_MASK;
+		u32 now = imc_reg(s, imc_chans[i].data);
+
+		if (!((now ^ expect) & mask))
+			continue;
+
+		dev_warn_ratelimited(s->dev,
+				     "ch%d command changed under us (0x%08x -> 0x%08x): another master is using the engine\n",
+				     i, expect, now);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void imc_restore_xfer(struct imc_smbus *s,
+			     const struct imc_xfer_state *state)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imc_chans); i++) {
+		if (!state->restore[i])
+			continue;
+		/*
+		 * Mask GO: the saved word is only meant to put the previous
+		 * address, register and TSOD state back, never to re-arm a
+		 * transaction that was already in flight when we found it.
+		 */
+		imc_set(s, imc_chans[i].data, state->command[i] & ~GO_BIT);
+	}
+}
+
+static int imc_prepare_xfer(struct imc_smbus *s, const struct imc_chan *c,
+			    struct imc_xfer_state *state)
+{
+	int i, ret;
+
+	ret = imc_wait_engine_idle(s);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(imc_chans); i++) {
+		state->command[i] = imc_reg(s, imc_chans[i].data);
+		state->restore[i] = i == c->idx ||
+				    (state->command[i] & TSOD_ACTIVE_BIT);
+		if (!(state->command[i] & TSOD_ACTIVE_BIT))
+			continue;
+
+		imc_set(s, imc_chans[i].data,
+			state->command[i] & COMMAND_KEEP_MASK);
+		ret = imc_wait_go_clear(s, &imc_chans[i]);
+		if (ret) {
+			imc_restore_xfer(s, state);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int imc_access(struct imc_smbus *s, const struct imc_chan *c, u8 addr,
+		      u8 reg, char read_write, int size, u16 *value)
+{
+	struct imc_xfer_state state = {};
+	u32 command, expected, raw, readback, status = 0;
+	int ret;
+
+	ret = imc_prepare_xfer(s, c, &state);
+	if (ret)
+		return ret;
+
+	command = COMMAND_PREFIX | ((u32)addr << 8) | reg;
+	if (size == I2C_SMBUS_WORD_DATA)
+		command |= WORD_BIT;
+	else if (size == I2C_SMBUS_BYTE)
+		command |= PNTR_SEL_BIT;
+
+	if (read_write == I2C_SMBUS_WRITE) {
+		raw = size == I2C_SMBUS_WORD_DATA ? swab16(*value) : *value;
+		imc_set(s, c->ctrl, raw << 16);
+		command |= WRITE_OPERATION;
+	}
+
+	imc_set(s, c->data, command);
+	readback = imc_reg(s, c->data);
+	if (!imc_command_landed(command, readback)) {
+		dev_warn_ratelimited(s->dev,
+				     "ch%d command 0x%08x did not reach the register (read back 0x%08x)\n",
+				     c->idx, command, readback);
+		ret = -EIO;
+		goto restore_command;
+	}
+
+	ret = imc_wait_transfer(s, c, &status);
+	if (ret)
+		goto restore_command;
+
+	expected = read_write == I2C_SMBUS_WRITE ?
+		   STAT_WRITE_DONE : STAT_READ_DONE;
+	ret = imc_check_status(s, c, status, expected, addr, reg);
+	if (ret)
+		goto restore_command;
+
+	ret = imc_check_interference(s, c, &state);
+	if (ret)
+		goto restore_command;
+
+	if (read_write == I2C_SMBUS_READ) {
+		raw = imc_reg(s, c->ctrl);
+		*value = size == I2C_SMBUS_WORD_DATA ?
+			 swab16(raw & 0xffff) : raw & 0xff;
+	}
+
+restore_command:
+	imc_restore_xfer(s, &state);
+
+	return ret;
+}
+
+/*
+ * Standard SMBus transfer callback.  The per-channel imc_chan is stashed in the
+ * adapter's algo_data.  The command word carries the 7-bit address, so
+ * SPD EEPROMs (0x50-0x57) are reachable on each channel.  BYTE, BYTE_DATA and
+ * WORD_DATA are supported; larger transfers would need the engine's block
+ * primitives, which are not used by the devices on this bus.
+ */
+static s32 imc_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write, u8 command,
+			  int size, union i2c_smbus_data *data)
+{
+	struct imc_smbus *s = i2c_get_adapdata(adap);
+	const struct imc_chan *c = adap->algo_data;
+	u16 val = 0;
+	u8 reg;
+	int ret;
+
+	if (flags & I2C_M_TEN)
+		return -EAFNOSUPPORT;
+	if (addr > 0x7f)
+		return -EINVAL;
+
+	if (size != I2C_SMBUS_BYTE && size != I2C_SMBUS_BYTE_DATA &&
+	    size != I2C_SMBUS_WORD_DATA)
+		return -EOPNOTSUPP;
+	if (read_write != I2C_SMBUS_READ && read_write != I2C_SMBUS_WRITE)
+		return -EINVAL;
+
+	/*
+	 * BYTE puts no register on the bus.  For a write the command parameter
+	 * carries the data byte instead, and data is NULL.
+	 */
+	reg = size == I2C_SMBUS_BYTE ? 0 : command;
+
+	mutex_lock(&s->lock);
+	s->io_err = 0;
+
+	if (read_write == I2C_SMBUS_WRITE) {
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+			val = command;
+			dev_dbg(s->dev, "ch%d W addr=%02x val=%02x (send byte)\n",
+				c->idx, addr, val);
+			break;
+		case I2C_SMBUS_WORD_DATA:
+			val = data->word;
+			dev_dbg(s->dev, "ch%d W addr=%02x reg=%02x val=%04x\n",
+				c->idx, addr, reg, val);
+			break;
+		default:
+			val = data->byte;
+			dev_dbg(s->dev, "ch%d W addr=%02x reg=%02x val=%02x\n",
+				c->idx, addr, reg, val);
+			break;
+		}
+		ret = imc_access(s, c, addr, reg, read_write, size, &val);
+	} else {
+		ret = imc_access(s, c, addr, reg, read_write, size, &val);
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+			if (!ret)
+				data->byte = val;
+			dev_dbg(s->dev, "ch%d R addr=%02x -> %02x (receive byte, ret %d)\n",
+				c->idx, addr, val, ret);
+			break;
+		case I2C_SMBUS_WORD_DATA:
+			if (!ret)
+				data->word = val;
+			dev_dbg(s->dev, "ch%d R addr=%02x reg=%02x -> %04x (ret %d)\n",
+				c->idx, addr, reg, val, ret);
+			break;
+		default:
+			if (!ret)
+				data->byte = val;
+			dev_dbg(s->dev, "ch%d R addr=%02x reg=%02x -> %02x (ret %d)\n",
+				c->idx, addr, reg, val, ret);
+			break;
+		}
+	}
+
+	/*
+	 * A config-space failure invalidates whatever the transaction logic
+	 * concluded, so it wins over any other result.
+	 */
+	if (s->io_err) {
+		dev_warn_ratelimited(s->dev, "config access failed: %d\n",
+				     s->io_err);
+		ret = s->io_err;
+	}
+	mutex_unlock(&s->lock);
+
+	return ret;
+}
+
+static u32 imc_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
+	       I2C_FUNC_SMBUS_WORD_DATA;
+}
+
+static const struct i2c_algorithm imc_algo = {
+	.smbus_xfer	= imc_smbus_xfer,
+	.functionality	= imc_func,
+};
+
+static int imc_suspend(struct device *dev)
+{
+	struct imc_smbus *s = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(s->adap); i++)
+		i2c_mark_adapter_suspended(&s->adap[i]);
+
+	return 0;
+}
+
+static int imc_resume(struct device *dev)
+{
+	struct imc_smbus *s = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(s->adap); i++)
+		i2c_mark_adapter_resumed(&s->adap[i]);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(imc_pm_ops, imc_suspend, imc_resume);
+
+/*
+ * Refuse to share the engine with the memory controller's own thermal
+ * throttling.  SMBCNTL.TSOD_POLL_EN tells us directly whether the iMC is
+ * issuing SMBus transactions of its own; Intel documents that SPD command
+ * access and TSOD polling are mutually exclusive, so a set bit means the
+ * engine is not ours to drive.  This does not cover SMM or a BMC, which
+ * remain the reason for the allow_unsafe_access gate.
+ */
+static int imc_check_firmware_polling(struct pci_dev *pdev)
+{
+	struct pci_dev *imc = NULL;
+	unsigned int found = 0;
+	int i;
+
+	while ((imc = pci_get_device(PCI_VENDOR_ID_INTEL, IMC_CHANNEL_DEVICE,
+				     imc))) {
+		found++;
+		for (i = 0; i < ARRAY_SIZE(imc_chans); i++) {
+			u32 cntl;
+
+			if (pci_read_config_dword(imc, IMC_SMBCNTL(i), &cntl)) {
+				dev_warn(&pdev->dev,
+					 "%s ch%d SMBCNTL unreadable; cannot verify that TSOD polling is disabled\n",
+					 pci_name(imc), i);
+				continue;
+			}
+
+			if (cntl & SMBCNTL_TSOD_POLL_EN) {
+				dev_err(&pdev->dev,
+					"%s ch%d has TSOD polling enabled (SMBCNTL 0x%08x); the memory controller is using the engine\n",
+					pci_name(imc), i, cntl);
+				pci_dev_put(imc);
+				return -EBUSY;
+			}
+
+			dev_dbg(&pdev->dev,
+				"%s ch%d SMBCNTL 0x%08x, TSOD present mask 0x%02lx\n",
+				pci_name(imc), i, cntl,
+				cntl & SMBCNTL_TSOD_PRESENT);
+		}
+	}
+
+	if (!found)
+		dev_warn(&pdev->dev,
+			 "no iMC channel function found; cannot verify that TSOD polling is disabled\n");
+
+	return 0;
+}
+
+static int imc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct imc_smbus *s;
+	int ret, i;
+
+	if (!allow_unsafe_access) {
+		dev_info(&pdev->dev,
+			 "firmware/SMM arbitration is unknown; set allow_unsafe_access=1 to bind\n");
+		return -ENODEV;
+	}
+
+	ret = imc_check_firmware_polling(pdev);
+	if (ret)
+		return ret;
+
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	/*
+	 * No pci_enable_device(): the driver uses no BAR, no interrupt and no
+	 * DMA.  The engine is reached entirely through config space, which does
+	 * not require the function's memory or I/O decoding to be enabled.
+	 */
+	s->pdev = pdev;
+	s->dev = &pdev->dev;
+	pci_set_drvdata(pdev, s);
+	ret = devm_mutex_init(&pdev->dev, &s->lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * Lifetime safety: the I2C core guarantees that smbus_xfer callbacks
+	 * are not invoked after i2c_del_adapter() returns. Since we use
+	 * devm_i2c_add_adapter(), the adapter is automatically removed on
+	 * driver detach, and no concurrent xfer can be in flight at that point.
+	 */
+	for (i = 0; i < ARRAY_SIZE(s->adap); i++) {
+		struct i2c_adapter *a = &s->adap[i];
+
+		a->owner     = THIS_MODULE;
+		a->algo      = &imc_algo;
+		a->algo_data = (void *)&imc_chans[i];
+		a->dev.parent = &pdev->dev;
+		/*
+		 * One retry: interference from another master is reported as
+		 * -EAGAIN and is usually over by the next attempt.
+		 */
+		a->retries = 1;
+		i2c_set_adapdata(a, s);
+		snprintf(a->name, sizeof(a->name),
+			 "iMC SMBus Skylake-X channel %d", i);
+
+		ret = devm_i2c_add_adapter(&pdev->dev, a);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"i2c_add_adapter ch%d failed: %d\n", i, ret);
+			return ret;
+		}
+
+		/*
+		 * Instantiate the SPD EEPROMs the same way the other SMBus
+		 * host drivers do.  This counts the populated slots from DMI
+		 * and probes 0x50 upwards, so no client is created for an
+		 * address that does not answer and userspace keeps the ones
+		 * that stay empty.  Each channel carries half the DIMMs, and
+		 * the scan is per adapter, so each finds its own.
+		 *
+		 * The write_disable variant: this part is DDR4 only, where the
+		 * two differ in nothing (the distinction gates spd5118 on
+		 * DDR5).  Where they are equivalent, the one that does not
+		 * suggest this driver enables SPD writes is the better name to
+		 * leave in a memory-bus driver.
+		 */
+		i2c_register_spd_write_disable(a);
+	}
+
+	dev_dbg(&pdev->dev, "registered 2 SMBus channels\n");
+	return 0;
+}
+
+static const struct pci_device_id imc_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCU_DEVICE) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, imc_pci_ids);
+
+/*
+ * All resources (mutex, i2c adapters) are devm-managed and are released
+ * automatically after probe returns or during device unbinding, so no .remove
+ * callback is needed.  The register state is deliberately left as-is on
+ * unbind: the engine carries no driver-private latched state that needs
+ * teardown, and the SMBus controls we drive are side-band registers the rest
+ * of the kernel does not touch.
+ */
+static struct pci_driver imc_driver = {
+	.name     = "i2c-imc-skylake",
+	.id_table = imc_pci_ids,
+	.probe    = imc_pci_probe,
+	.driver.pm = pm_sleep_ptr(&imc_pm_ops),
+};
+module_pci_driver(imc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Simone Chifari");
+MODULE_DESCRIPTION("Intel Skylake-X iMC SMBus I2C adapter");
-- 
2.43.0

