Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC72DAFB4
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505963; cv=none; b=Hn/QUVo+KptDpEIbTvPv6K2NJJXpZhIX61D62oY7hR/N7WtYo4jO626hKjQiKpqTcsb9cDzp3USJMTuud2NGT97NX7FlFa3vXXQ5L6JfIOJ358SQKqdqcCzgM2PJAoMxbqFoSqkfkqyTkbAn1dLJMa1xuZRSjErRcks17x6LTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505963; c=relaxed/simple;
	bh=hcopO1d3SJrViJzYteVjx3lBnB399Uiwv+D3Nq7nnws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jnh0q/7X6YKCJVYSnOHUjrACdWttrG9WiHRS+9zg3KZsISpokPRdNfmyha2aDDVOm8mukvJNBp0AxGgHGwKSoz9q9BB6J5juVxbm8xRuxPT8rOeIHyChyj4fR/mDzqvuAcl7Ow9QktAxk1Q7zjtkkZz7AghJkDA+GSLbADnI2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZ+rDNVK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZ+rDNVK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 16B7C4E422CC;
	Tue, 27 Jan 2026 09:26:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA41B606F5;
	Tue, 27 Jan 2026 09:25:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3869119A8637;
	Tue, 27 Jan 2026 10:25:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769505959; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KkexMX23x627uEo3IXWwe/phxMeEBwRBD406Tvg95Io=;
	b=ZZ+rDNVKz9fRyC2YiBqWibUX/abVuSqkb9D0ZjWcgZCmnM6IZ7k9gJIkxWe9ctX7MnUGa7
	TOq3v8gJz6qXLNh/ThL+0UarRbx4+nma5GFMVTr/2d3sVZ6cjJQg7ochF3KtshEGH9i0nQ
	F16eeYPGNSA065zb74zBvM61hOYaIUDJ3VGnIS+UtyP0Y3+TFg6WBEKatdTpWo0UUode+H
	fylmY2g1SpBhEDkzz2NXv7iw5PZW0AQa2uxa6hwMMH6sUeeL4VxMYjASAhcoR3BFnuuj4S
	RSuL8QGKJPkFd1UkEOjoOcb58V574oxRQmeyQWjyDmWZ2DdGBMIiuucbj2U+UQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH i2c-tools v3 0/2] Add support for message modifier flags
Date: Tue, 27 Jan 2026 10:25:56 +0100
Message-Id: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKSEeGkC/1WNywqDMBREf0XuuinmRlPtqv9Ruoh56AU1JRFpE
 f+9IRRql8PMObNBtIFshGuxQbArRfJzCuJUgB7U3FtGJmXAEmvO8cKm2DM3qj4yYbBDo1plsYG
 0fwbr6JVddyDUbPF+jPBI1UBx8eGdX1aeB19hcxCunJVMilo4lE7JTt8675eR5rP2U/as+GMRx
 ZHFxDamFZWqhJQW/9l93z9AR92G6wAAAA==
X-Change-ID: 20251127-msg-flags-3d2b2da9ae28
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I2C messages can be modified with a set of flags covered by the protocol
mangling and the skip repeated start functionalities. This series add
support for such flags to i2cdetect and i2ctransfer.

The first patch shows the support of protocol mangling and repeated
start skipping in the output of 'i2cdetect -F'.

The second patch adds the parsing of optional flags to i2ctransfer
message description. Those command-line flags then set the i2c message
flags alongside the read/write flag.

I wrote these changes to test the insertion of I2C_M_STOP flag in
multi-message transactions with i2ctransfer, but the other flags may be
useful for various test scenarios. 

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Changes in v3:
- Use ifdefs to check that the flags and functionalities are known
  at compile-time.
- Check that the adapter supports the requested flags before using them
  in i2ctransfer.
- Add a warning in i2ctransfer man page about the risk of using these
  flags.
- Link to v2: https://lore.kernel.org/r/20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com

Changes in v2:
- Document the flags in i2ctransfer.8 man page.
- Link to v1: https://lore.kernel.org/r/20251128-msg-flags-v1-0-6353f26fa6bc@bootlin.com

---
Benoît Monin (2):
      i2cdetect: Display mangling and nostart support
      i2ctransfer: Add optional message modifier flags

 tools/i2cdetect.c   |   8 ++++
 tools/i2ctransfer.8 |  28 ++++++++++++-
 tools/i2ctransfer.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 141 insertions(+), 14 deletions(-)
---
base-commit: c1b0305972e89aae048068a3b228f35ef0206243
change-id: 20251127-msg-flags-3d2b2da9ae28

Best regards,
-- 
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

