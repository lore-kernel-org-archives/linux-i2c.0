Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DF39D3D9;
	Sat, 13 Jun 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344652; cv=none; b=lWQjBwZ05a5/z2BIPAJNEaCRUq05DWMWiBwqUuGF3Ktzv54/cB4cB6MhaXcHqx801R7YXSK+A5GkdgGKrRJQfmUFFUbhAuwcwvHffLJkI7hag50aWHtcyi8bvxU24UWzDMkyVqSOML+ilswzbFVxsg518XSJLwq10vMXObpv7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344652; c=relaxed/simple;
	bh=e0KKAQMRWVD4N9u9Q1sbWIEA2pk1krUP6bJcAkfA5Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p9a7cgpDLJszqbgBizxRJ9jhN9bEU4SMFk+GuFvvseILoxemJonfKWA+10/wSQq8wm34AylFYlpqHWYcfaJDR1fCozIVSAezOG1I7P0yGoqitmF4y9mXeuYZEA9RDaQTRVDy38nqDrc8gK3zVf9DP/PhoQvgt+NyD7+NoxsMNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSibgvfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSibgvfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702511F000E9;
	Sat, 13 Jun 2026 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781344650;
	bh=7JP+kU/aASsLKZ0eIOIFitvv2MddlmYKNoGb2a6WTBw=;
	h=Date:From:To:Cc:Subject;
	b=gSibgvfbVuXcjELk9sJBOcCcGoR7XF61GHPcGCBbf7G51DvmoBZOYpBIVNg0gFRGr
	 kzSn24Kx1UiivKvBTa77S7z9MPyyVtm6mFxbkajtS8K9Xleu6iWYgUVt1pyBBSipXh
	 pKOTseu/G1PRzmZi6aK4e1FmR3H2UlFwpE4HEKP9jzZd9M+qbZHIB23Yd1AXIn5T5h
	 jcn2wVooUTF7qm6alvsxxcsXIBz28n6nR6LGIDFGGWuoqAxrmH5jNPOouhQEjQC71e
	 vAPuFdj66mdkAQDm7lfePPWA72dsHokqkXmXJJ//OJ0yUw0rNdZUjWfOMLjTAD9xJ4
	 Suk3koxjMK3Hw==
Date: Sat, 13 Jun 2026 11:57:25 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.1-rc8
Message-ID: <ai0phU8FZ9uDcm7M@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jEOOdZ10+au+do1t"
Content-Disposition: inline


--jEOOdZ10+au+do1t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

biggest news here is that this is my last pull request as I2C maintainer
after 13.5 years. Starting with the 7.2 cycle, Andi Shyti is taking over
who helped me greatly maintaining the host drivers for a while now.
Thank you, Andi, and good luck with the subsystem. I'll be around for
help, of course.

Technically, there are two patches which might be a tad large for this
late cycle, but most of them is explaining comments, so I think they are
suitable.

Please pull. And thanks a lot to you and everyone for the collaboration!


The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-=
7.1-rc8

for you to fetch changes up to 35ebcfcc9ef29afcf258db854ccf25572c75baef:

  Merge tag 'i2c-host-fixes-7.1-rc8' of git://git.kernel.org/pub/scm/linux/=
kernel/git/andi.shyti/linux into i2c/for-current (2026-06-12 17:05:44 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc8

- rust: fix I2cAdapter refcount double increment
- MAINTAINERS: minor updates
- imx: keep clock and pinctrl states consistent in runtime PM
- imx-lpi2c: fix DMA resource leaks on PIO fallback
- qcom-cci: fix NULL pointer dereference on remove
- riic: fix reset refcount leak on resume_noirq error path
- stm32f7: account for analog filter in timing computation
- tegra: fix suspend/resume handling in NOIRQ phase
- tegra: update Tegra410 I2C timings to match hardware specs
- MAINTAINERS: hand over I2C maintainership to Andi

----------------------------------------------------------------
Akhil R (2):
      i2c: tegra: Update Tegra410 I2C timing parameters
      i2c: tegra: Fix NOIRQ suspend/resume

Andi Shyti (1):
      MAINTAINERS: i2c: designware: Remove inactive reviewer

Carlos Song (2):
      i2c: imx: fix clock and pinctrl state inconsistency in runtime PM
      i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan=
()

Guillermo Rodr=C3=ADguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

Nicol=C3=A1s Antinori (1):
      rust: i2c: fix I2cAdapter refcounts double increment

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Wentao Liang (1):
      i2c: riic: fix refcount leak in riic_i2c_resume_noirq()

Wolfram Sang (4):
      Merge tag 'rust-i2c-7.1-rc7' of https://github.com/ikrtn/linux into i=
2c/for-current
      MAINTAINERS: hand over I2C to Andi Shyti
      dt-bindings: i2c: mux-gpio: name correct maintainer
      Merge tag 'i2c-host-fixes-7.1-rc8' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/andi.shyti/linux into i2c/for-current


with much appreciated quality assurance from
----------------------------------------------------------------
Frank Li (2):
      (Rev.) i2c: imx-lpi2c: fix resource leaks switching to devm_dma_reque=
st_chan()
      (Rev.) i2c: imx: fix clock and pinctrl state inconsistency in runtime=
 PM

Geert Uytterhoeven (1):
      (Rev.) i2c: riic: fix refcount leak in riic_i2c_resume_noirq()

Igor Korotin (1):
      (Rev.) rust: i2c: fix I2cAdapter refcounts double increment

Jon Hunter (2):
      (Rev.) i2c: tegra: Fix NOIRQ suspend/resume
      (Rev.) i2c: tegra: Update Tegra410 I2C timing parameters

Konrad Dybcio (1):
      (Rev.) i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

 .../devicetree/bindings/i2c/i2c-mux-gpio.yaml      |  2 +-
 MAINTAINERS                                        |  6 +--
 drivers/i2c/busses/i2c-imx-lpi2c.c                 | 53 +++++++++++--------
 drivers/i2c/busses/i2c-imx.c                       | 15 ++++--
 drivers/i2c/busses/i2c-qcom-cci.c                  |  2 +-
 drivers/i2c/busses/i2c-riic.c                      |  4 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |  6 +--
 drivers/i2c/busses/i2c-tegra.c                     | 61 ++++++++++++------=
----
 rust/kernel/i2c.rs                                 |  4 +-
 9 files changed, 92 insertions(+), 61 deletions(-)

--jEOOdZ10+au+do1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmotKYUACgkQFA3kzBSg
KbYa+hAAn2a5/JbB+2lO5+tGCHmZW3P5DgzSK1kQFdNPHEGmhd4YNdzQvkJXeuf0
TrmAheQqAqn4NNtRz8T5ZIlvNtBFBiirpOAs/OZZST55VFI/lBqp3XItF0mJCzlR
5DyJXooS2Kca/MmSzhAvDWLZB1KgCbyfV8ekcWb0k0K3hPOH1ylbzUIqLpyCu0ao
bO1zAKf09w5LqTKuFDPayd9QShymAlLdnz91bSXR080lFgEZkVkXS5aWZKma7zRh
lZ52A/Cm7r0e8Kesp1gf+nMl87V8CXnG2nEhLo8Kb+D3jY7l5xZ8fDh0L9EgypYM
SkkMBn9KqEdlwGo4CsWEZnhCcbvQTCerkdPY8CQemBCeY9Lpu4Wes9MYFZii5uWZ
NQtJyIHKnX2cpefz4Lt5HyzzEYoQN7rhgXtu5rvL6BBWnDNtpTbw6jXGjPRvu2sl
nrRfKlqDcdKBC/a4/+Ln8T6N0N4Iv1S00+FbxKQsFaN/esPDRKSsX5U667Yw9j3Q
mnn6qJoIkfje0FhB/GKu6dIj7tuI3UZls8UzBWr0MmKGZmm2bJrXtKZhPHuWpnJ9
3vPwDGyX3V6J2xilrpxB6osiYY0mRe1yOAVuorhwpkEpFT/C+ciZbnBZbvztgHEz
ad3plAx9LX79N0jPL+5voVEWexFZwpu/6k+nqKHOEslmhIV9XF0=
=M+H1
-----END PGP SIGNATURE-----

--jEOOdZ10+au+do1t--
