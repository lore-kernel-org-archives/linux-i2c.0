Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839037;
	b=UfvGXisU/T2eSnpNgA2Kuiz1Uq3MlGMdzYKOdimkYA5PpAWKMWlKkzP4CmNxvBB5d0OL
	 UiR+F4I4xFKPIIhhunztxlU9amlXeyotLPUdtAW8gcEyFUd/mnr1Iwh3XGUYhEBbaNr1z
	 TBGAthbKT3YHMM1+GqizcnnuFxsSKry7e3eKoplggbfL5/zWnS3ZRM5GNdiuMQbDQHKn9
	 kxdwA2BepghexyVhTVKl4b5hhJ5QQIj9+l9Ebw8WVT+O9tyAjHIsn6c4Mv6MAqSIhuB9u
	 44zGYiQItKL9wo0D76FMhMRC/Sh7CYKQ/eVJAupaARCgMcwsd2y5vAbgqvAM3PqDN0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839037;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=ddEhTbfvQPyKSOzq6hatj6Y2eqBZl6lG5KHY2ccF3Mk=;
	b=xlZsCKmM8KXggJQc4xYrGNUdu/5p35JlPHNUrX0e7+wytKUF0whlRiVp+7KOaPpUqSiw
	 9U4+WnzezfZ87U0mhJNb+OYyp9KWFFIcn8zWeFp06FMWYLLksFAeD4xCSYPWe9HGHtYhk
	 PXUtCRWGONGK2fR6QtoWF3oWxSd1StM5dkkrkdi/FzPYWVj4a1OG/ocbv2NR1FmK9jIX2
	 eIZPZV1mzXELOf8ykcadHrFnfdRmzjhTjsVLxNpVhX+SJFmyosMag/lWHq8/g+4TXDa+I
	 0EU8o+N30n5zvNt7DhuknCg9ekpLtY/5ynqWWWng6F7GP82ER1QlWv3KgimkPeMAHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=BwtL7XL5;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC0606A32A
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 14:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22EC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=BwtL7XL5
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261116142352a824c770190002077b
        for <linux-i2c@vger.kernel.org>;
        Mon, 16 Nov 2026 15:23:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ddEhTbfvQPyKSOzq6hatj6Y2eqBZl6lG5KHY2ccF3Mk=;
 b=BwtL7XL55IQJXRFPlbiL6Pd19VXP8izD8IwXc3VW8TJxbK4KDmCK3QV21S9XOmWrqaJTge
 ctGrqv+pxAlsiksoUC3k+J9IajFAdbpaMA/SSKnhGKBiGldHTCotSFkjCQ4P/EEZBLMjGkmk
 xdoPCv77NFN8fK0CvpNOZR7G8QAQSjIpPKbxSrdAfLTBoR2vyWaTTNQ+DMwiLMcmFWA0ftLj
 Skf4SCWO0KFghYsMr99ti17bmOZOSjgvZL8GrYvfcXABI/URKiIAlokaul/deKmObrm/2YhA
 i/6KLST6CMnRu6P9jtpj4k5/YfAByKH88+zwyjZPGwBvMnpuVUI+PSfQ==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 0/3] Enable fan monitoring support for Simatic IPC BX-59A
Date: Mon, 16 Nov 2026 15:23:48 +0100
Message-ID: <20261116142351.1228943-1-benedikt.niedermayr@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

Hi,

I need to add this basic platform enablement for Simatic IPC RW-548A. Since a lot
of time went by, this enablemend piled up for a different patchset, which I
currently prepare for the HWMON subsystem, and i would like to route it through this
tree (since it would conflict with it).

I hope this is ok.


Changes since v2:

- Added basic platform enablement for Simatic IPC RW-548A

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

Benedikt Niedermayr (3):
  i2c: i2c-nct6126: add support for NCT6126D Super I/O
  platform/x86/siemens: simatic-ipc: add fan monitoring support for
    BX-59A
  platform/x86/siemens: simatic-ipc: enable support for RW-548A

 MAINTAINERS                                   |   5 +
 drivers/i2c/busses/Kconfig                    |  11 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-nct6126.c              | 441 ++++++++++++++++++
 drivers/platform/x86/siemens/simatic-ipc.c    |  17 +-
 .../platform_data/x86/simatic-ipc-base.h      |   2 +
 include/linux/platform_data/x86/simatic-ipc.h |   1 +
 7 files changed, 471 insertions(+), 7 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-nct6126.c

--
2.43.0
