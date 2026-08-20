Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648942253E
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224791; cv=none; b=gVAW4iRUJ5r7LdNs0WYKGvxhoaYU7gwkSESVnZCS696OYXdoiXSN0e+ELNPNTB1NkVKSr0aZQfdnMwAEh7WIr0dzdGB82YUnaJXhbhH7QgdanMEz3+CB8imkWHDtvCSfg1yqQzffkcBXUYZPHMjJU6SoLwFkSvZR+r6UZrOfxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224791; c=relaxed/simple;
	bh=PBCUBJMFsvBrR7i/w3LSjxgoU1PZ4R3IZGcDKcQ7FdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ebmt2xOQ02vY6TclhInsGvz6zxS87oKqd/j1xAcsDYeD0pItLgSBeXD1Bep6MCHwk0OBGX9qI6Rrb7ZbhnwoWr7/YNMR/+k+NH7zrjthZ6WIhFd9OQVDB/b2e72s+MGQJ5bMBTxZ7lIjr/HxeJLa762JHLCEUbHYIYybctezPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b=FOOfNHPb; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b="FOOfNHPb"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260820111941a77a700639000207e5
        for <linux-i2c@vger.kernel.org>;
        Thu, 20 Aug 2026 13:19:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lUj3JHyd7rtZC18ZgTUnFTO7rZhiDck9H2KCajyEzRg=;
 b=FOOfNHPbTF2xtZ5zW23XFNG/iXcvQRE6zq2s3MbPIgUhz+UjNcuawzATMo8W1x7c8844oE
 mR/nVlLqnCRQlIgFCGNHiHlr+U8nC1C5kHebNJr4GKDW0vTBeijSqkieuJN3qDblxcSxtyIk
 C+BMbBxiJFHx3XfjWZN7NjU+QlHlgQqsj78+avQuLLt2P4nCvTwxkBBLwc0j8LKcgNalwXfq
 R2UShsbvAXDW1K9jfHmbl0Bb4S91D/T5MGKQqcPFUaK2/hrmia+ugj/DUnKbdbDAYIhf7aP4
 mjx0+sx71CyqNUKHqL93s1TOHNpGyz5IUm/9TT1inscobws/QmzrVhvA==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/2] Enable fan monitoring support for Simatic IPC BX-59A
Date: Thu, 20 Aug 2026 13:19:38 +0200
Message-ID: <20260820111940.2434594-1-benedikt.niedermayr@siemens.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

Patch 1 adds the I2C/SMBus driver for the NCT6126D.
Patch 2 enables the driver for the Simatic IPC BX-59A platform.

Some fans are controlled by the ADT7475 controller, which is connected to the
NCT6126D Super I/O via the i2c bus. Other fans are controlled directly by the
NCT6126D hwmon interface block.

To enable communication with the ADT7475, an i2c master driver for the
NCT6126D's SMBus interface is added. The new i2c master driver may support
additional controllers, but so far I have only been able to test it with the
NCT6126D Super I/O.

Findings and decisions made during development:

- The SMBus controller on the NCT6126D resides on the same logical device as
  the hwmon interface block (logical device B) and therefore shares the CR30
  register used to enable the logical device. The nct6775 driver handles the
  entire hwmon interface block on this Super-IO chip and already force-enables
  the domain during probing and resuming, regardless of what the BIOS
  programmed the CR30 register.
  This driver is more defensive and aborts probing if the BIOS has not enabled
  logical device B in the CR30 register.

- The I/O base address of the SMBus domain is discovered dynamically during
  probing. It should have been programmed by the BIOS in the CR62/CR63
  registers. If no address has been programmed in these registers, the
  driver aborts probing.

Cheers,
Benedikt

Benedikt Niedermayr (2):
  i2c: i2c-nct6126: add support for NCT6126D Super I/O
  platform/x86/siemens: simatic-ipc: add fan monitoring support for
    BX-59A

 MAINTAINERS                                |   5 +
 drivers/i2c/busses/Kconfig                 |  11 +
 drivers/i2c/busses/Makefile                |   1 +
 drivers/i2c/busses/i2c-nct6126.c           | 473 +++++++++++++++++++++
 drivers/platform/x86/siemens/simatic-ipc.c |  14 +-
 5 files changed, 497 insertions(+), 7 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-nct6126.c

--
2.43.0
