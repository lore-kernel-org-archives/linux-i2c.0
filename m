Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391034;
	b=GY36k7u0rIMvK5kAlOdIMPTqPo84R2fvfX9QhnEXtQsq4+Aeu2Aq8BH1HYq+SHQW4gho
	 Qd2ss1tswsO+iKMK+xnqf0EPcfT01/VjiZ9fndkHQykkN1p17iacMRdppcgcCinzd+SKm
	 Dk3TjSBq32s90sA8umTAXrTJO1tcS6mtsYWWRUDX1a7pM0Q2aM008gKoSrMIp4Q1XabvF
	 rDIK9MjfVBMqfrj+Dqc3Zsm8Mdv/I6fF+GBFdkvFgKfhBDAbL5fNnS8tCJu0z/KUbn/nB
	 dXqgnKKRXdQ1Yj4wmUFDJvv7kdb7cv+uSmAUaGrbz7xpiedWtsr2bnSa7X7ga15a8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6aFkanhQlnp82wVBFfiT10ETE24BakWSqyttCKRsnY4=;
	b=BvTm+jh6LfyGMEPSZu8kas/rxtMcX22WnwiJU/tz5vY3JGzq3l5XSOZvLFZo8IID9CZU
	 6yhxkjkZib6mBJjcP0BLfzgwuWTqFXk5FyyMfJ6WPDi3mlBQziNsGPbDgZSQBTLEDVybg
	 mHSHDD0JxWN782C3o+rVtrCX64PmtCh2ulS91rkjSQzUpufRDwkFaWjbVg2352FS21U6N
	 R0avXre9bVvwTHdjsnm7vhWMP2bzODnherm347nbulti/KxEScsLr++cnTegOgQUIU4d+
	 6XxSWrfD7g8rKaoRKj5zJg+9gSOCcuxd7DgECGykzLrLsDJHrgHDrxON0gihVjdTd9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SNpwpAm6;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F2606A31A
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 23:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 878F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SNpwpAm6
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so18525065e9.2
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795391032; x=1795995832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6aFkanhQlnp82wVBFfiT10ETE24BakWSqyttCKRsnY4=;
        b=SNpwpAm6vntIrXbOXcUQWctAaye6LDXHxnTdEmvvsm84UcgaHbmSwPn4o9KGuypsU7
         Bm2+u2XINzlueCNYoB4bbqmR6crPMOnz3CV7eCBpElWV9O6J7D5iuITitwkWV88eloEw
         Nl8OZVdYPZKoiQecAK1q+EjTemaV9vSqbPp0KLSbLO9BhXSt/lysUDoG5UKOH01qvDeF
         2+utcMyCXwNufahNaTJGxOhNI/HO5EYeKkrUnleQl6zI7s+n+l98sCwqMS1fCaUFNRj7
         2y9yycqmMqf0sBF/S5tpGdAhMycVSVn2hIJ8NMy+7TFA4exxuKPhiLRSF75BT45Wc6ys
         rdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795391032; x=1795995832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aFkanhQlnp82wVBFfiT10ETE24BakWSqyttCKRsnY4=;
        b=JK6RT6xGtrfP3dz+LT4/VYDEVbo0WfT0EO1CdfD9uTsftX6uYRxagFv/V6oTuUAYzW
         vTuAdse1s7bxL6ZCW1xUQDOBOwAYrGVdI5dFxgAG5LXdaUtmmmlCwSRfF4BFxKEyFxAf
         eEN5wVVwFptGlUkr8nfBdCxSNX/90FqQFGaaMmt+A7gOPb5kqb67Yw4HYmyOZzvOZBTT
         KEJ85qYnheyYqmNJo5fzFN+aZNSYq0D7fjW6QhX3Xnv7uODgl/YDsm6w9sqAuLK08hmC
         NqwzgAprrwdlFalIF85C5IeY7zmN7vN5S8KdkM3/TTEyoRwEsA1CU7V8YNUpc4Ls45BO
         xQjA==
X-Gm-Message-State: APuU4Z/lwb+l9Gz/ZjEFGoDkxcn2TXlU5ib9boPTZKtkSCBDEHDkS91m
	S7pZz3oQuxFtxo61OaY6MV2+ejlC5/nf1nsRXUcLRA1q4plAkbDs2K2b
X-Gm-Gg: AZFdTZdjY1lf8Y30yJKp8HMnMQuJsVcSq9wZp7N8W93jU6LBFtjw4jyTT8QNOrty0wW
	ZxrH5329dER/6WUO6PIJ5V1ir1ms57TYm7M4MfIzU+/oNcMSRVzvIzsOLduqrw0Iozzdu97ES3T
	NfhmFCskDzQtwTMGqbHZ+tkERDNjtBZSHMcT/Kdrv3PRbugCCCdQuyYev2WYX2i+2099taSi8FG
	41fdGAYl//qygeOSPV0v8PKeqkqfEhZ3gK0mAFe4RpsecwzaCebAzHS2c+QY1/5qzeJ79iM8Zga
	yI/NpiElG+JM3Pko+X5t5ox28rmPtY0kul4MnUZ2x2ozhsqrORpLysgZ/R8q3cpY5lhE0v6JdXj
	GUK9Kv4H9DIo21DZh5b89b/46l3a+gv5IP74ubfn3xFBgSvfxA1gwgSuHZ/4SsXFKuPfqGIh2I4
	D/+0WtMbykPElGt+QiEGKfzBlTVEobLa5t0cEEEm6A9zCQnBRPxQ2aoQL4PpjD00V1IQWuAcuLg
	ManYY6NvzJBwED8ioMaKNm+8TQIcfGnIc1wom9/2nrYhKZO9p9+12VvcWD4NHqAnywvAm4EcBn2
	c4iNIQXPssIo9dJXsclKNYlkr6IKj8HmsfKqkt8zl+8diK4hgDcLXP8jfiEzk96pSo9EoHf/Sw=
	=
X-Received: by 2002:a05:600c:4f4c:b0:4bb:8503:69f4 with SMTP id 5b1f17b1804b1-4bb888097a2mr251650815e9.5.1795391031529;
        Sun, 22 Nov 2026 15:43:51 -0800 (PST)
Received: from ws1-mint.emulab.it ([2a01:b600:90d3:0:bbd5:603a:8842:4c16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm297640285e9.7.2026.11.22.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 15:43:51 -0800 (PST)
From: Simone Chifari <simone.chifari@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Stefan Schaeckeler <schaecsn@gmx.net>,
	Simone Chifari <simone.chifari@gmail.com>
Subject: [PATCH v5 0/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
Date: Mon, 23 Nov 2026 00:43:49 +0100
Message-ID: <20261122234350.3257104-1-simone.chifari@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The integrated memory controller of Intel Skylake-X and Cascade Lake-X
processors contains an SMBus engine wired to the DDR4 DIMMs.  This driver
exposes its two channels as standard Linux I2C adapters, so that DDR4 SPD
EEPROMs and DIMM thermal sensors can be read with i2c-tools, decode-dimms
and lm-sensors.

v2 was posted as i2c-imc-x299 and received no replies:

  https://lore.kernel.org/linux-i2c/20260620144131.415559-1-simone.chifari@gmail.com/

v3:

  https://lore.kernel.org/linux-i2c/20260728122423.358416-1-simone.chifari@gmail.com/

v4:

  https://lore.kernel.org/linux-i2c/20260808212414.217511-1-simone.chifari@gmail.com/

Correction to v2
~~~~~~~~~~~~~~~~
v2 claimed that firmware filters CF8/CFC config writes to this function and
that the registers can only be reached through the ECAM window.  That claim
was wrong and I am retracting it.

It was never tested directly.  The only evidence behind it was the boot log
line "PCI: Using configuration type 1", which says which accessor the kernel
uses and nothing about a write failing.  Measured on the same board:

  # setpci -s 16:1e.5 9c.L=20085002    # read SPD 0x50, register 0x02
  # setpci -s 16:1e.5 9c.L
  20005002                             # GO consumed
  # setpci -s 16:1e.5 a8.L
  0000500c                             # READ_DONE, no error
  # setpci -s 16:1e.5 b4.L
  0000000c                             # SPD byte 2: DDR4 type code

The command written through CF8/CFC is executed and returns correct data,
and MSR_SMI_COUNT does not move across it.  This driver therefore uses
pci_read_config_dword() and pci_write_config_dword() like any other driver.
There is no ECAM mapping, no MCFG parsing and no PCI-core change in this
series any more.

Firmware arbitration
~~~~~~~~~~~~~~~~~~~~
This is the reason no iMC SMBus driver has ever been merged, and this patch
does not solve it either.  It does make the condition detectable.

Andy Lutomirski's original i2c_imc put it plainly: a BMC, the memory
controller's power management, and possibly SMM all like to touch this bus,
and Intel defined no way to arbitrate between them.  That driver already had
a module parameter called allow_unsafe_access.  Stefan Schaeckeler's 2020
Broadwell rewrite went further and stopped the PCU's TSOD polling for the
duration of a transfer (write 0 to TSODCNTL, wait 10 ms for in-flight
transactions to drain, restore afterwards), because on Broadwell the
original driver's consistency check tripped about every 30 minutes.

  https://lwn.net/Articles/635898/
  https://lore.kernel.org/linux-i2c/1582498270-50674-1-git-send-email-schaecsn@gmx.net/

So this driver:

  - keeps the default-off allow_unsafe_access gate, deliberately the same
    name as the original;
  - serializes both channels under one mutex and waits for the whole engine
    to be idle before touching any register;
  - saves the command state of both channels, clears TSOD_ACTIVE for the
    duration of the transfer, and restores both afterwards;
  - after every transfer compares the command registers against what it
    left in them and fails the transfer with -EAGAIN if anything else
    changed.  This is the check the original driver had, and it is what
    makes an unarbitrated system detectable rather than silently wrong.
    The transfer is not retried: by then it has been on the bus;
  - reads the command word back and requires it to be the one just
    written, because the done bits are latched.  With the driver unloaded
    and nothing running, STATUS on the test system reads 0x0000300c:
    READ_DONE and WRITE_DONE both still set from an earlier transaction.
    Without the check, a command word that never reaches the register is
    indistinguishable from a completed transfer and the caller receives the
    previous transaction's data.  The comparison covers the bits the
    driver produces, minus GO, which the engine clears itself;
  - documents the one case the read-back check cannot see: two
    consecutive, identical commands - the shape of an ee1004 Receive Byte
    stream - leave the same word in the register, so a command write
    dropped between them is invisible.  Bit 29 would be the natural
    per-command nonce, but the engine refuses it: measured on this
    system, a command with bit 29 clear consumes GO and completes with
    the error bit set, on reads that succeed with the bit set.  Every
    dropped write between commands that differ in address, register,
    direction or size is caught.

  - refuses to bind when the memory controller is polling the DIMM thermal
    sensors itself, or when that cannot be checked.  Intel documents SMBCNTL on the iMC channel function
    (device 10 and 12, function 0, offsets 0xe88 and 0xe98) in the Xeon
    Processor Scalable Family datasheet volume 2, reference 614073, section
    3.1.9.  Its SMB_TSOD_POLL_EN bit is documented as mutually exclusive
    with SPD command access, so it answers directly whether the engine is
    in use.  On the test system all four channels read 0xac000000: polling
    disabled, TSOD_PRESENT mask empty, which also explains why no jc42
    device appears at 0x18-0x1f.

This is deliberately weaker than what the Broadwell-E driver did.  That one
switched the polling off for the duration of a transfer.  Reading the bit
and declining is a smaller claim on hardware the driver does not own, and
it needs no write to a firmware-configured register.  It covers the memory
controller only; SMM and a BMC remain out of reach, which is what the
opt-in is for.

Relation to prior work
~~~~~~~~~~~~~~~~~~~~~~
There is no iMC I2C driver in mainline.  Lutomirski's i2c-imc was an RFC;
the 2020 resend and github.com/Linux4/i2c-imc are out of tree.  Neither can
be extended to cover this part: the device ID (0x2085 vs 0x3ca8/0x6fa8) and
the register layout (0x9C-0xB8 vs 0x180-0x188) differ.  A separate file is
cleaner than a hw_data table.

The register encoding was cross-checked against an independent Windows
implementation for the same engine, which predates this work:

  https://github.com/namazso/PawnIO.Modules/blob/c975ca1d1b8a9c7473a175fa1ca24d83b6cbc8f3/SmbusIntelSkylakeIMC.p

It also implements SMBus BYTE through a pointer-select bit, without saying
which bit.  That bit is 18 here.  The datasheet gave it away: SMBCMD on the
iMC channel functions places PNTR_SEL immediately above WORD_ACCESS, and
word access on the PCU function is bit 17.

Bit 18 is the only part of this driver that rests on an undocumented
encoding, so it is worth saying exactly what was measured rather than
asserting it works.  With the bit set on a read, eight consecutive
transfers to an SPD EEPROM returned bytes 0x01 through 0x08 in order,
matching an ordinary dump of the same range.  That is the auto-increment
of a Receive Byte; a transfer that still named a register would have
returned the same byte eight times.  With the bit set on a write, a Send
Byte to the DDR4 page-select addresses moves the 256-byte window: byte
0x00 stops reading as the JEDEC 0x23 after selecting page 1 and returns
to it after selecting page 0.

ee1004 consequently binds, and decode-dimms reads all four DIMMs on this
system with both SPD CRCs valid on each.  i2cdetect scans in read mode.
jc42 needs only BYTE_DATA and WORD_DATA reads, which are implemented and
validated against the SPDs; jc42 itself has not been exercised, because no
DIMM on the test system populates a thermal sensor (TSOD_PRESENT reads
0x00).

With Receive Byte in place the driver can also do what the other SMBus
host drivers do and call i2c_register_spd() per adapter, so the SPD
EEPROMs are instantiated at probe rather than by hand.  The helper counts
the populated slots from DMI and probes upwards from 0x50, leaving alone
any address that does not answer; each channel carries half the DIMMs and
the scan is per adapter, so each finds its own.  Nothing else is
instantiated, jc42 included: there is no firmware description of these
buses and this driver does not scan for anything but the SPDs.

I used the write_disable variant.  This part is DDR4 only, where the two
are equivalent - the distinction gates spd5118 on DDR5 - and between two
equivalent calls the one that does not read as "this driver enables SPD
writes" seemed the better thing to leave in a memory-bus driver.  Happy
to switch to write_enable for consistency with i801 and piix4 if you
prefer the convention.

SMBus Quick is still not implemented, and not only because the engine has
no obvious encoding for it.  A write to the 0x30-0x37 range is how an
EE1004 SPD is write-protected, permanently on many modules.  An adapter
whose bus is the memory bus should not advertise a probe that writes.

The driver does not filter writes by address, following i801 and piix4.
On a bus that carries nothing but memory a filter would be a few lines -
reject writes to 0x30-0x35 and 0x50-0x57 - and I left it out only so as
not to put policy in a bus driver.  I will add it if you would rather
have it.

The question is not theoretical here.  i801 can sit behind the chipset's
SPD Write Disable; I found nothing equivalent in front of this engine.
On the development system a userspace tool probing for DDR5 wrote one
byte into three DDR4 SPDs through an earlier build of this driver, and
the firmware then refused those modules.  The bug was in the tool, but
this bus offers it no second line of defence.

Changes since v4
~~~~~~~~~~~~~~~~
All of these came out of a second review of the transfer path, done before
anyone had to point them out.  None changes what the driver supports.

  - The interference check could not see another master on the channel
    being driven.  It compared only the bits this driver does not produce,
    and a foreign command differs in exactly the others: address, register,
    direction.  It now compares every bit but GO against the read-back.
    Rerun on hardware with four concurrent readers: no false positive.
  - Drop the command-toggle recovery added in v3.  It required BUSY set
    and no done bit, and the done bits are latched, so it could not run;
    had it run, a late completion would have been reported as success.
    A timeout is now only a timeout.
  - Drop retries = 1.  The only -EAGAIN this driver returns is raised
    after the transaction has been on the bus, so the retry sent a write
    twice and made a Receive Byte return the following byte.
  - Refuse to bind, and stay disabled after resume, when SMBCNTL cannot
    be read or no iMC channel function is found.  v4 warned and went on.
  - Mask GO when clearing TSOD_ACTIVE before a transfer, as the restore
    path already did.
  - Stop before the transfer when the last config access of the
    preparation failed.
  - Return -EBUSY rather than -ETIMEDOUT when the engine never becomes
    idle, as Documentation/i2c/fault-codes.rst prescribes.
  - The source no longer claims that closed-loop thermal throttling would
    trip the interference check.  That was never measured.
  - Documentation: 0x36 and 0x37 are reserved by ee1004, not by
    i2c_register_spd(); the page-select example needs ee1004 unbound;
    which DIMM slots sit on which channel depends on the board.
  - State that the driver does not filter writes by address (see above).
  - Measured, no change needed: whether BUSY can rise after GO has been
    consumed, which would let a transfer complete on the latched done
    bits of the previous one.  Sampling CMD and STATUS in a tight loop
    after 5190 commands, BUSY was already set at the first read every
    time.

Changes since v3
~~~~~~~~~~~~~~~~
All of these came out of a self-review of v3; none changes what the driver
supports.

  - Self-review found the read-back check blind for two identical
    commands in a row - precisely the shape of an ee1004 Receive Byte
    stream.  The obvious fix, alternating bit 29 per command, was
    implemented and then reverted after measurement: the engine consumes
    GO but sets the error bit for every command with bit 29 clear, so
    the bit cannot serve as a nonce.  The limitation is now documented
    at the check instead of silently present.
  - Compare only the bits the driver produces in the read-back check, and
    use the post-write read-back, not the pre-transfer word, as the
    baseline for the interference check on the driven channel.  v3
    implicitly required every undocumented bit of the command register to
    read as zero, which held on the test system but is not something to
    assume across steppings.
  - Read the result before the interference check, not after, so the check
    also covers the window in which the data latch is read.
  - Re-run the TSOD-polling check on resume and keep the adapters
    suspended if firmware enabled it across suspend; the probe-time
    refusal alone cannot see that.  The S3 observation below is exactly
    the scenario that motivates this.
  - Stop before writing a saved command word back if the config read that
    fetched it had already failed.
  - Rename the register accessors: the command register is now CMD and
    the data latch DATA.  v3 called the command register DATA and the
    data latch CTRL, which read backwards.
  - State plainly that jc42 itself has not been run (no TSOD populated
    here), only the transactions it needs.
  - Note that PCI ID 8086:2085 also matches Skylake-SP/Cascade Lake-SP
    servers, where a BMC is far more likely to own the engine; the gate,
    the SMBCNTL refusal and the interference detection are the same, but
    the audience of the warning is different.
  - Correct a stale function name in the v3 cover letter:
    imc_engine_responded() is imc_command_landed() in the code as posted.
  - Cast ~COMMAND_OUR_BITS to u32 in the interference check; BIT() and
    GENMASK() are unsigned long, so the complement was computed in 64
    bits and truncated on assignment.  The truncated value was already
    correct; this silences a clang W=1 -Wconstant-conversion warning.
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202607291626.TnSyWh0f-lkp@intel.com/

Changes since v2
~~~~~~~~~~~~~~~~
  - Retract the CF8/CFC claim; use the ordinary config accessors.  The
    driver no longer maps anything.
  - Rename i2c-imc-x299 to i2c-imc-skylake; the engine is in the CPU, not
    the chipset.
  - Add the default-off allow_unsafe_access gate.
  - Wait for both channels to be idle before touching the data latch.
  - Preserve and restore command and TSOD state for both channels.
  - Validate READ_DONE, WRITE_DONE and the hardware error state.
  - Detect interference from another master and report it as -EAGAIN.
  - Read the command word back and require it to be the one written.
  - Add bounded command-toggle recovery for a stuck BUSY state.
  - Add WORD_DATA support with the hardware byte ordering.
  - Reject I2C_M_TEN explicitly and validate transfer direction.
  - Use the i2c core's suspended-adapter mechanism instead of a private
    flag and a non-standard errno.
  - Use devm_mutex_init() and devm-managed adapters; drop the unnecessary
    pci_enable_device(); return -ENODEV rather than -EPERM from the
    default-off gate, which was logging a driver-core error on every boot.
  - Add Documentation/i2c/busses/i2c-imc-skylake.rst.
  - Drop the ACPI dependency.
  - Refuse to bind when the iMC reports TSOD polling enabled.
  - Correct the claim that BYTE_DATA and WORD_DATA cover ee1004: they do
    not, ee1004 also needs Receive Byte and Send Byte.
  - Implement both, on the pointer-select bit, so ee1004 binds and
    decode-dimms works.
  - Instantiate the SPD EEPROMs with i2c_register_spd() instead of
    leaving it to the user.

Validation
~~~~~~~~~~
  - In-tree build, W=1, x86_64 GCC and arm64 Clang COMPILE_TEST: no
    diagnostics.
  - checkpatch.pl --strict: clean.
  - Sparse with __CHECK_ENDIAN__: clean.
  - Hardware test on one Intel Core i9-10900X (Cascade Lake-X) system with
    four DDR4 DIMMs: both adapters, four SPD EEPROMs, BYTE_DATA, WORD_DATA
    byte order, Receive Byte tracking the EEPROM pointer, Send Byte moving
    the SPD page and putting it back, ENXIO for an absent device, 100
    concurrent reads per channel, the default-off gate, and 20
    unload/reload cycles: 19 checks, 0 failures, no kernel warning or oops,
    no interference reported, every command word confirmed in the register.
  - i2c_register_spd() instantiated ee1004 on all four populated SPD
    addresses at probe, two per channel, and claimed none of the empty
    ones.  decode-dimms then decoded all four modules, each with the CRC
    of bytes 0-125 and of bytes 128-253 valid.  The part number reads out
    of page 1, so the page select is exercised end to end.  The four
    module serial numbers were identical before and after every
    experiment in this series.
  - Engine registers sampled every 2 s for one hour with the driver
    unloaded: 1791 samples, 0 changes.  No firmware activity while the
    system is up.
  - Suspend and resume, s2idle and S3, with continuous traffic on both
    adapters: transfers recover and nothing complains.  Across S3 the
    firmware demonstrably drives the engine.  Both channels, sampled
    immediately before suspend and immediately after resume:

      DATA   0x2000b600 -> 0x20005000
      STATUS 0x0000500c -> 0x00005004

    The command word came back addressing SPD 0x50 for a read, and the
    status went from both done bits latched to READ_DONE alone.  Nothing in
    Linux issued that: the adapter was marked suspended and userspace was
    frozen.  This is consistent with firmware reading SPD during memory
    training on resume.  It is the only direct observation of a second
    master on this engine I have, and it is the concrete reason the driver
    restores command state per transfer and compares it afterwards.
  - SMBCNTL on all four iMC channels reads 0xac000000: TSOD polling
    disabled, TSOD_PRESENT empty.
  - Writes validated end to end against a populated device: a 12-write
    frame to an LED controller at 0x27, across both channels, every write
    acknowledged, no NACK, and the device applied the result.  A byte
    write to an unpopulated address returns -ENXIO with the engine
    reporting the address NACK.  No SPD was written at any point, and the
    four SPD EEPROMs were verified present with valid CRCs before and
    after.

The checks above were run on v4.  On v5 I reran the SPD reads through
ee1004 - all four modules, identical to the v4 driver's output - and 240
full reads from four concurrent readers, with no error and no warning
from the driver.  The write frame and the suspend cycles were not rerun.

Adamyno tested v4 on a second board and reported on the v3 thread: ROG
STRIX X299-XE, i9-7980XE (Skylake-X), eight DIMMs, ee1004 bound on
0x50-0x53 of both adapters, SMBCNTL reading 0 where mine reads
0xac000000, and an LED controller driven through both adapters.  Thank
you.  I am not carrying his Tested-by: the transfer path changed after
his test, in the ways listed under "Changes since v4".

One note on the register interface, since a reader with the datasheet will
ask.  That document describes an SMBus interface on the iMC channel
function at 0xe80-0xe9c, with a different encoding from the one this driver
uses on PCU function 5 at 0x9c-0xb8; it does not describe function 5 at all,
covering device 30 functions 0 and 2 only.  I tried the documented path on
this system: issuing SMBCMD with CMD_TRIGGER sets SMB_RDO and clears
SMB_BUSY, but returns 0x00 for a populated DIMM at 0x50, for a second one
at 0x52, and for an empty slot at 0x57 alike, with SMB_SBE never set.  An
interface that cannot tell a populated slot from an empty one is not
reaching the bus here, while the path this driver uses returns the correct
SPD contents and a NACK for the empty slot.  I may well be missing a setup
step; if someone knows what it is, I would rather use the documented
interface.

Tool assistance
~~~~~~~~~~~~~~~
Per Documentation/process/generated-content.rst: this work was developed
with an AI coding assistant, run interactively rather than autonomously.

  - What: Claude Code, model claude-opus-5 up to v4 and
    claude-mythos-5-2 for v5.
  - Where: it contributed to the transaction state machine, the .rst
    documentation, the commit message and this cover letter.  The register
    decoding is mine.
  - How it was used: iteratively, one reviewed change at a time, in
    response to specific requests, not from a single generating prompt.  A
    representative request is "the done bits are latched; show me how a
    command that is never accepted can be mistaken for a completed one, and
    make that case detectable", which produced imc_command_landed().  It
    also designed the measurement that retracted the CF8/CFC claim above,
    after asking why that claim had never been tested directly.  For v5 it
    reviewed the v4 driver adversarially; the fixes that came out of that
    are the ones listed under "Changes since v4".
  - Testing: every revision was built with W=1 (gcc and clang), checked
    with checkpatch --strict and sparse, and tested on the hardware by me;
    what was and was not rerun on the hardware for v5 is stated above.

I have reviewed all of it, I understand it, and I take responsibility for
it.

Simone Chifari (1):
  i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter

 Documentation/i2c/busses/i2c-imc-skylake.rst | 205 +++++
 Documentation/i2c/busses/index.rst           |   1 +
 MAINTAINERS                                  |   7 +
 drivers/i2c/busses/Kconfig                   |  30 +
 drivers/i2c/busses/Makefile                  |   1 +
 drivers/i2c/busses/i2c-imc-skylake.c         | 769 +++++++++++++++++++
 6 files changed, 1013 insertions(+)
 create mode 100644 Documentation/i2c/busses/i2c-imc-skylake.rst
 create mode 100644 drivers/i2c/busses/i2c-imc-skylake.c


base-commit: 04e9bf1648f846976b543e91c1838a712433772a
-- 
2.43.0

