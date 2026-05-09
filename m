Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A11E1DE5;
	Sat,  9 May 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307129; cv=none; b=FNruYT6jPFIILhMiK2nx/wpsE527u5FlyiaSRXtmGQXSxAKvg0nxJUyjNmF3rRjeYJREa0TaKBiRuJ5Sxbs5e4JC/KSRIrhhUItAxwzotBzmxkzpGnuPXBMCNc7H8ZvJ1lOPfYA/xefwGr6mZxelo+L8dE+8ABfxcyOhBpZXA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307129; c=relaxed/simple;
	bh=MweMaBMBWCNpZAQjgPNpQq2yrFk6hKEc1Gm+qqM/ylw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uJU+OJ80PBwi3WeHKEbEQpFZfmSVbiOWkXXiiSWeu4KGkwJtnNfxvQPUjcWDSicrTR3Ln0JhY17OzAbmS/xocoJyLplUILHTqKWjQn5JJiOjjPL1UGz6QRCR8WbhWXyw5N/ekohsG4gsK8fK/r2h3pfwZxxv8ie8dWLVvKK+7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXzyR+Et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXzyR+Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D9DC2BCB2;
	Sat,  9 May 2026 06:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778307129;
	bh=MweMaBMBWCNpZAQjgPNpQq2yrFk6hKEc1Gm+qqM/ylw=;
	h=Date:From:To:Cc:Subject:From;
	b=ZXzyR+EtjYr7i1ZBCB5hYZDKhIy5fqu989nCu6jnI0thYq/w1F/o5Ll5G27Z1fnN6
	 I5XUeijwA0KqP1U2OKpW/oWVb7CPoXcs2TDh4okn81bB40FzQfUFEgbVQYgXFP7pUb
	 dWO/MgeryueAyfUIVMHJIsQkmj+sKbHVJ1bkdTjIc6TG+s6wHXsbjM/5uqNPUz6AQF
	 KLvliaz30A7SOzir+/FeqnRowOgcK+cayECYpvcPlemCao7eCwMKQCkOYiSyqQ1OKT
	 nzQ+tDKz8XcH8OsN43AZKzVjkI2NMEU+/aPdGIS5eeHVfKzjxKPbll4CnstFkIm1M6
	 kbdCDj1FX1bfw==
Date: Sat, 9 May 2026 08:12:05 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.1-rc3
Message-ID: <af7QNdBvNvwQSuYI@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9WOs7vt6FxJKfDiy"
Content-Disposition: inline


--9WOs7vt6FxJKfDiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc3

for you to fetch changes up to 3051cd060fa496df42954291fa2306ed2eab4ecc:

  i2c: smbus: reject oversized block transfers in the common path (2026-05-07 10:59:07 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc3

- sanitize more input parameters in the core (found by syzkaller)
- usual set of driver fixes (proper completion handling, applying
  quirks, correct workqueue selection...)
- ID additions to simplify dependency handling
- new email address for Peter Rosin

----------------------------------------------------------------
Janne Grunau (1):
      dt-bindings: i2c: apple,i2c: Add t8122 compatible

Marco Crivellari (1):
      i2c: testunit: Replace system_long_wq with system_dfl_long_wq

Marek Vasut (1):
      i2c: stm32f7: reinit_completion() per transfer not per msg

Mingyu Wang (1):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl

Niels Franke (1):
      i2c: acpi: Add ELAN0678 to i2c_acpi_force_100khz_device_ids

Nikola Z. Ivanov (1):
      i2c: Compare the return value of gpiod_get_direction against GPIO_LINE_DIRECTION_OUT

Peter Rosin (1):
      MAINTAINERS: Update mail for Peter Rosin

Ronald Claveau (1):
      dt-bindings: i2c: amlogic: Add compatible for T7 SOC

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      i2c: smbus: reject oversized block transfers in the common path


with much appreciated quality assurance from
----------------------------------------------------------------
Jean Delvare (1):
      (Rev.) i2c: stub: Reject I2C block transfers with invalid length

 .mailmap                                           |  1 +
 .../bindings/i2c/amlogic,meson6-i2c.yaml           | 13 ++++++++----
 .../devicetree/bindings/i2c/apple,i2c.yaml         |  4 +++-
 MAINTAINERS                                        | 24 ++++++++++------------
 drivers/i2c/busses/i2c-stm32f7.c                   |  6 +++---
 drivers/i2c/i2c-core-acpi.c                        |  1 +
 drivers/i2c/i2c-core-base.c                        |  3 +--
 drivers/i2c/i2c-core-smbus.c                       | 12 +++++++++++
 drivers/i2c/i2c-dev.c                              |  9 ++++----
 drivers/i2c/i2c-slave-testunit.c                   |  4 ++--
 drivers/i2c/i2c-stub.c                             |  5 +++++
 11 files changed, 53 insertions(+), 29 deletions(-)

--9WOs7vt6FxJKfDiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn+0DUACgkQFA3kzBSg
KbYzvQ/7BWe+SVWXbbLck8vsGVv6kUP6C+o/JBCYVsDthzmpeNraabqqPDradxQi
jtvhXOI6sKfcEJlhEsBJg/JL+oQZ8tZSWhbG7w+iyybvb/95aXP8RVo+wZ3XiKLM
8FVGrlaj05rwROKIE+AkNeor9Wwr9UKgEbd2PDXZ93VyOyaDh1WNNRX6QwJicndf
0YEMfiN5MjKVOqC0fZmlCyVo8LQaOjcGFPyghvEI0PuGXmd9BlcyRvtCLbQximhv
1CAxTZmvdk3o+cdK8WdkykaMXpp+heUocB/jTu3Ex/mQ6a+0K91uYnrlQEYlsopJ
gZLw8BOne7eiD2udsxQUosTaAnhvxgedYd2iz92o6hK5X+nfLMwrzhs2ID974BaD
jMZvxvo63xWIP9Eq+RJP14hpaeaVFnd77PpU1DWveQHToqujjf227Fy11IlBifi1
l4K3FWvy3E5Z7aiy3xLWxxQAPr42gPnM0CCfKCIQFQpvyN7muv64HW8ZRoOq8bKz
l0b/19kBwtGDE2Qn/YWCEvTpR9y86uL0nKIaJppCsnTSHSPulzMKKEkKl8wxxKz6
GSo7YSuTW0GkLfySwUzwjBCskBP1rniWwD1VirBbalA8C0D2SZCSjF2yLm5gnVPt
9WvvEgrXN0dn5HAugvY3FoUkZuNvlia+WLzVY0xGNQfo5vjxIms=
=DHxp
-----END PGP SIGNATURE-----

--9WOs7vt6FxJKfDiy--
