Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452774BC00B
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602328; cv=none; b=sx+jTCXplCgFu4fq7g9lNYBcWKykGpfEFOpDeUPTwYksVQgFzaUcySvQII0IvtS0awsE/92byJ3ARsAODTb8iOjCkAb9f/d0bOdcICC9v43ibUBaF7XKxMn2x7n4OX3Jkf+mo6QwUfENXVBmOJYC7E2d2eGkTE1FwvVWHrZqGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602328; c=relaxed/simple;
	bh=3ZsrBmJWxI9XEX8i4E6D2tiR2icQxb4pfztZc/mfE4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXM7NoK2Nd+4xKu1Cl+oFxpp/eEw3sSvqGl+D4bxrurRootFXf4HXej8EmTOQEw0MtcmHq7j3OiSNYtqBvqRjATwWkDp5WeFZgelRlGuaRDxCETSCH3kavxXAcIT46SS34kQ00OqMgmcLCzaX3CYDhGHAD1FhwtBkUFPQ2u27GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b=F1pQjspB; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b="F1pQjspB"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260928133156898514646f00020748
        for <linux-i2c@vger.kernel.org>;
        Mon, 28 Sep 2026 15:31:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7dI/WOGmOh6sP851eK+jcTgsWXsLD+vKceVePSXqapE=;
 b=F1pQjspBt3BSAToeiTO0klYTy+wJ4cbyj9Ks1NTHmwurq4fEtrN1ybEoGqY11hLvA7N/ZS
 hcjFeeHh4ZSYl+uKR2SdqeWRAggqr4gAIdvcps0A8vTT0KuykfyAW7oqNZcMyjw73udrOujo
 OKoHm3FdYjIlScVex/6gTyf+cKsa1R4WvRBHXoq/GZ95smzhRFhNKWGim0tXtdFU4UNLImMH
 vtgFGx66YM2/v0B0SpWqSZtXHhTXul64xdGnKEL+OEKutdNq7aB+CA9czk0uLDPLxDF3H5cp
 Mdx9a81jQfu/a0o9lR9qSsBqVATiAXrTmy/bNW0QlJw7vln4qOaGNdTw==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/1] Enable fan monitoring support for Simatic IPC BX-59A
Date: Mon, 28 Sep 2026 15:31:54 +0200
Message-ID: <20260928133156.817479-1-benedikt.niedermayr@siemens.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

Changes since v1:

- Refactored commit message of Patch 1/2 (Removed "TODO:")
- Use SZ_32 and include required header
- Use include for BIT() (linux/bits.h)
- Fix inconsistent spacing all over the code and use reverse xmas
  tree ordering
- Replaced BIT(0) with appropriate and meaningful define
- Check via IS_ALIGNED for smbus master base address
- Remove verbose info message (success path should be quiet)
- Use iopoll.h instead of own polling implementation
- Simplify struct nct6126_pdev pointer assignment (just use a simple
  single pointer)

Regarding the write access during initialization I would like to add what I
already answered in the original submission:

Regarding this specific point, I'm not entirely sure. I wasn't considering
that during implementation because I was leaning heavily on the
gpio-f7188x.c driver, which implements the GPIO part of this chip.
It performs the probing/init in a very similar way.
Since the driver **must be loaded explicitly** by the user or by other platform
detection mechanisms (like the simatic-ipc.c detection driver in this case),
I felt safe copying this logic.

I'm not sure if using DMI_MATCH tables would be the right choice here?

While it would restrict write access to only whitelisted platforms,
it wouldn't scale well as the number of supported platforms increases.

The request_muxed_region() call at least helps by locking against other drivers
already using this region.
The critical scenario would be if no other driver has gained access to the
region yet, but that would generally only happen if the user intentionally
loaded the driver.

Using ACPI-based detection seems impossible on this platform
(no proper ACPI table support for this chip).

IIRC, these Super I/O chips generally aren't suitable for probing via ACPI if
they need to be shared across different drivers, as ACPI detection would
exclusively occupy the I/O port region [1].

How should I proceed here?
And in case this is a no-go, what about the *gpio-f7188x.c* approach, which is
mainline?

[1] https://lore.kernel.org/linux-watchdog/df8d53db-0056-434d-953b-991025e6cd34@roeck-us.net/

Benedikt Niedermayr (2):
  i2c: i2c-nct6126: add support for NCT6126D Super I/O
  platform/x86/siemens: simatic-ipc: add fan monitoring support for
    BX-59A

 MAINTAINERS                                |   5 +
 drivers/i2c/busses/Kconfig                 |  11 +
 drivers/i2c/busses/Makefile                |   1 +
 drivers/i2c/busses/i2c-nct6126.c           | 441 +++++++++++++++++++++
 drivers/platform/x86/siemens/simatic-ipc.c |  14 +-
 5 files changed, 465 insertions(+), 7 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-nct6126.c

--
2.43.0
