Received: from carlos102.mail.rambler.ru (carlos102.mail.rambler.ru [81.19.78.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3EE7082D
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.78.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787618364; cv=none; b=GFiaXvuOxX+pjIRoPyqmKSQCN3RZQDJwj/TouZuvBAjNBWdQO3NghxpUA/S8E4w7GsI+vkm2a2Mhxi4g+KDt34c2QGGOIQCJLnhlcqRPhPiEs3xarxUwgVlSgjaQH9UANXvahJXvXOAFDdUkLnnLcu9L+OwIhrnfQZkhIHXXQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787618364; c=relaxed/simple;
	bh=0y6g+1l84lt3GnU1+SQGQKMo0gfb5JJ6WAm+4kPmBUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=atcjlYDLG8hMAdfMaKDVuFIbAV3hxJF8RRbtU8BFfmqe3LBO+5k/jD0yedyx0jYz89H2R2pCoJLVs36bZ1g870O6VRQdCgt5wTPhIbPNETT8ymMejVs+l7Pf5K7XBKHD/iVyT3G5BHNOo52Tpdvsv97Im1LpwG5gRtmdyQR8Cm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru; spf=pass smtp.mailfrom=ro.ru; arc=none smtp.client-ip=81.19.78.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ro.ru
Received: from localhost (localhost [127.0.0.1])
	(Authenticated sender: alma0@ro.ru)
	by carlos102.mail.rambler.ru (Postfix) with ESMTPA id A0C2A32F4287;
	Tue, 25 Aug 2026 03:31:47 +0300 (MSK)
Message-ID: <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
Date: Tue, 25 Aug 2026 02:31:45 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?ee1004=3A_DDR4_SPD_cannot_be_read=2C_decode-dimms_fails?=
 =?UTF-8?B?LCDigJxGYWlsZWQgdG8gc2VsZWN0IHBhZ2UgMCAoLTYp4oCd?=
To: 1110749@bugs.debian.org
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
From: Al Ma <AlMa0@ro.ru>
Content-Language: en-US
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
In-Reply-To: <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Control: found 1110749 6.12.101
Control: retitle 1110749 ee1004: DDR4 SPD cannot be read, decode-dimms fails, “Failed to select page 0 (-6)”
Control: X-Debbugs-CC: linux-i2c@vger.kernel.org, jdelvare@suse.de
thanks


Now tested with two equal 32 GB RDIMMs Samsung M393A4K40CB2-CVF installed in DIMM_A1 and DIMM_C1 on ASUS WS C422 PRO/SE with BIOS 4801 with kernel 6.12.101+deb13-amd64. The SPD EEPROM is detected and the ee1004 driver is bound to it, but the driver's attempt to select page 0 fails with -ENXIO. Consequently, the driver's sysfs eeprom attribute cannot be read, and decode-dimms fails. Here is the excerpt from boot time:

[    8.550652] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    8.596883] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    8.608418] ee1004 0-0056: Failed to select page 0 (-6)
[    8.608532] ee1004 0-0056: 512 byte EE1004-compliant SPD EEPROM, read-only
[    8.774836] videodev: Linux video capture interface: v2.00

# decode-dimms
Cannot read /sys/bus/i2c/drivers/ee1004/0-0056/eeprom at /usr/bin/decode-dimms line 2455.

The SPD device is instantiated at 0x56:

# dmesg | grep "i2c"| head -1
[    3.138736] i2c i2c-0: Successfully instantiated SPD at 0x56


The device at 0x56 is claimed by ee1004 (“UU” below):

# i2cdetect -y 0
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- UU UU -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- UU -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Direct access to the page-selection addresses 0x36/0x37 fails:

# i2cget -f -y 0 0x36
Error: Read failed
# i2cget -f -y 0 0x37
Error: Read failed

i2cdump returns 0xff for every byte, although the device is claimed by ee1004:

# i2cdump -f -y 0 0x56
No size specified (using byte-data access)
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................


Could this be related to the way ee1004 attempts to select the SPD page on this particular I2C adapter/controller? In particular, “Failed to select page 0 (-6)” appears to occur before the actual SPD contents can be read.

The SMBus adapter is as follows:

# readlink -f /sys/bus/i2c/devices/i2c-0
/sys/devices/pci0000:00/0000:00:1f.4/i2c-0
# lspci -nn -s 00:1f.4
00:1f.4 SMBus [0c05]: Intel Corporation 200 Series/Z370 Chipset Family SMBus Controller [8086:a2a3]

Gratefully,
Alma
