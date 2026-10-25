Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959630;
	b=ze1XYSLg8GIAAastwvz58rnKXGNm54z2nkbUd2tqmqwKhB770tRsCChI5bUVr74BXSSn
	 +2MhiH9y+iROkQvxgMshwSN8ZVtvgWTEDnqJzslhNTB1ctewQjbBgQeJVfXSJwJkmWYfM
	 l0Q9fkSvt1CoP1sncejGs38CnCbZp13dz3OXxmBQm9dM7sa65Den4fx+q+wI3ryPxnUzO
	 30uw+No7M5A+dEHxKk3gmwJkVx5kBF3GBhygxsnclJPz58Hw+I03e0TRxLi9GwePex592
	 cfpFF6rFtpROYqj2B6Zef6fXyYH0FRSkiQsLCYCd6XYrhLbN/kzx6o+mZo+7HiWn5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=SyaPGIQYi/mFlxDPBVA0otWi9hIvkOWVtC96JGc7v1U=;
	b=41z3BIW4EkRTlC7m3ozmuOgehl0HqdPK6N5/POy5Ce8I0mr1Z596zF0iDt0pSnwi5Rif
	 s1CjxwDHJ4lMSXn4L63bE18uyOQ3QcRK/zWxwE0nDkkEUtsa6+SQmw/MU3SHH53C2/Ofi
	 87fHnTwYPfM6pdH60qQzyjYaSTXM7mHI/Mq2o4Qvy8SQ/UOdN9Vs0yUfnIuOiHMIWwZQt
	 Xc1hhD+DIbaM80c59CcFw7BwGnaEyBcAdY6u/uTJoPeBGvjMapxoEp/g1L1wXHXAgJ8xU
	 3kLBDXi5SBp3SqWYYMGiEv9h8PkIHpmMsil9dlGeFLnNNGpyUBRRFk9+OwpncSk6xgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njlELR10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CF606A31A;
	Sun, 25 Oct 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njlELR10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EFC1F01828;
	Sun, 25 Oct 2026 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792959630;
	bh=SyaPGIQYi/mFlxDPBVA0otWi9hIvkOWVtC96JGc7v1U=;
	h=Date:From:To:Cc:Subject;
	b=njlELR10AqyuTF28+3eZ0sYFZM9gz65ImsBJwjmc3uWJ5B+XOV+m+Li5OobG6t9W6
	 XN+C/WVQ1ksM7Y7Dm1Mun3eBB3Xn28ZvQi0Bsq6ZrLveUYp1FOfdtT+mIllsqw15k2
	 0GfMWWAVHr9+UM2MoDCXSrLZ3xDX0XUnnHah/akmPZrUyDj3b41rGeM4UkKj0APqo/
	 qG3NTd7tfvLbY7PQO+60HxLsKh3bvOz1ygYl9sfYOswJ1a3rwW3h5TxifofzeU0axa
	 ywyMfgaJmyIk4u3y4fmakf+HxkGKsPtd+TvvkKRbbCGW0LNrwgdVLO6tTMLDbD20TU
	 MsFj7OfnS4yww==
Date: Sun, 25 Oct 2026 21:20:26 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.4, part 2
Message-ID: <at5i65e5wjMz2TCA@zenone.zhora.eu>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

as anticipated, here is the second part of the I2C pull request
for v7.4.

This round introduces dynamic transfer timeouts in the I2C core,
already used by qcom-geni. There is also support for additional
transfer modes in imx and a handful of driver fixes.

I've also merged Igor's Rust I2C pull request, which removes an
unsafe conversion.

The branch is rebased on top of your part 1 I2C merge[*].

I'll now start queuing patches for a possible third week of the
merge window. Otherwise, they will go into v7.5.

Thanks and wishing you a good rest of your holidays,
Andi

[*] bb436f2a8568 ("Merge tag 'i2c-7.4-part1' ...")

The following changes since commit bb436f2a8568d14f176475c79b0d5069f0a6f9e3:

  Merge tag 'i2c-7.4-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-10-22 07:36:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part2

for you to fetch changes up to f7b70efba26963bf725f10574cc071f86cd5ee1d:

  i2c: sh_mobile: request IRQs after mapping registers (2026-10-24 00:05:15 +0200)

----------------------------------------------------------------
i2c for v7.4, part 2

This second part introduces dynamic transfer timeouts in the I2C
core, already used by qcom-geni. Alongside some driver
improvements and fixes, it also brings in the Rust I2C pull
request.

Core:

- core, qcom-geni: add and use a dynamic timeout helper
- acpi: fix adapter reference leak when creating I2C clients

Drivers:

- imx: support reversed address direction and no-start transfers
- designware: queue block data reads once length is known
- mt7621: skip the second data register for chunks up to 4 bytes
- sh_mobile: ensure IRQs are freed before unmapping registers

Rust:

- Remove unsound device-to-client reference conversion

----------------------------------------------------------------
Andi Shyti (1):
      Merge tag 'rust-i2c-for-7.4' into i2c/i2c

Aniket Randive (2):
      i2c: core: Add i2c_update_timeout() helper for dynamic transfer timeouts
      i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Ma Ke (1):
      i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()

Myeonghun Pak (1):
      i2c: sh_mobile: request IRQs after mapping registers

Navon John Lukose (1):
      i2c: designware: queue only one read command for block reads

Nicolás Antinori (1):
      rust: i2c: remove TryFrom<&Device> implementation for &I2cClient

Vincent Jardin (1):
      i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART

 drivers/i2c/Kconfig                        |  13 +++++++++++++
 drivers/i2c/busses/i2c-designware-master.c |   8 ++++++++
 drivers/i2c/busses/i2c-imx.c               | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 drivers/i2c/busses/i2c-mt7621.c            |   9 ++++++---
 drivers/i2c/busses/i2c-qcom-geni.c         |  48 +++++++++++++++++++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-sh_mobile.c         |   8 ++++----
 drivers/i2c/i2c-core-acpi.c                |   6 +++++-
 drivers/i2c/i2c-core-base.c                |  43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c                      |   3 +++
 include/linux/i2c.h                        |  13 +++++++++++++
 rust/kernel/i2c.rs                         |  21 ---------------------
 11 files changed, 251 insertions(+), 78 deletions(-)
