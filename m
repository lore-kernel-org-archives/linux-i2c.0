Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745152;
	b=qwGEVUjpJ59sKpPk64KuIzd2p2Ng8uOb5xeXA6t/JlzbicCahOWa1KKjKrxUBS6P0d9j
	 TxqYI45cfi4hCi9U5AUeuDaTQd/ylBckbS/XcRVVoL0yXqg/PmsGXio0eaqVFKpRpEU1T
	 Zvp4+KTwbUwlLzMvkU2D+8PbwpwNu8De4uAFQqf4UW05+esBzOiNgyd4v5P2LY3A01L0E
	 0++MmbICts2XHLTw7MO1vjRqNEAFjZXOA4sBEAHYIEVLif0GvHteuUo1sC4vAsuQfU0Uy
	 AYZXvl36IW8rrYH1qiIG9nz+HLSdRxQByL5/m97Hf3RSEx01M1NRW7clqmiRcyMdHOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745152;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=Rm+8cuVfU4vLjGjzIoq38H8TGsPzpS50Zs25hBzyev4=;
	b=ahw6LepIQ4dfqczS2VqK7gun/aFjQMcJAtEZQLbF/TL73NAzi2OprR7AM4bCfcgxI/o8
	 zeruCiGSsgwkdR6LOuHwMVnu5kVaibAPy2JgCMC/qydtjabKNgv4D75UzN8R8OSM/hxdD
	 Ei9/Le/eEdTXdloNMEANMX2rdhXHj0oy2xIHVhziRm2zmoaI5q6ggn5g1pCTXSbBplDKS
	 FeQ07wY3JV3CGgwZbwh5DLupksxuhucRcmDAVzTwUOBWcxKtVnDfmY+IM1uD2jDcg1uSG
	 d+I43kofHjHLB5ic8uDLb0oN3DA7l4VoYRSS2nZcy0Mx4PFtQsOoOQGSNx65bZwblFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNkxTg9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CA606A31A
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNkxTg9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E81F000C4;
	Sun, 15 Nov 2026 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745152;
	bh=Rm+8cuVfU4vLjGjzIoq38H8TGsPzpS50Zs25hBzyev4=;
	h=Date:From:To:Cc:Subject;
	b=TNkxTg9LRf2fEJWGBwJcK8y89TzejS+coH6XpAVjqdOjwi363uacAda5djHLOun2d
	 pQ8lQRoat3PqbR9lb+RKSF5/dZn4n+JTBB4qX8EG8sRuqkiSGnGwmyqoHPx2I0WO6Q
	 36x1PgWLZjYX7QdDTtvCe7PD7Fv7B5tyJ3lk+VjGbME+4EBxbcL6tQwLeuhZIsqVT2
	 6lkOya1iPLXVmjWmYj4zAwXmGCYFKFB2DImdoV7CqQsLN6QdnLxZn1/hXsjZQ7eno1
	 F3PdmCQhK2gG7KAX9ydkD4quRTF8e5rTZyDd2Gma823YBUlw6CdBbIRLUomHSnQYJl
	 w+vp5M+2UKIGg==
Date: Sun, 15 Nov 2026 13:19:08 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Subject: [PULL REQUEST] i2c-andi-for-7.5-part1
Message-ID: <avmjPNGM-m-glmTq@shikoro>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zSnaKzCwJyA3EGlh"
Content-Disposition: inline

--zSnaKzCwJyA3EGlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-andi-for-7.5-part1

for you to fetch changes up to e9b207e83347eaa99491a6ee6c2623019d506bbc:

  i2c: dev: clean up registration (2026-11-12 12:01:34 +0100)

----------------------------------------------------------------
i2c-andi-for-7.5-part1

Hi Andi,

here are some patches I reviewed and think are good to go. Feel free to
pull this branch or pick the patches individually or whatever.

Happy hacking,

   Wolfram

----------------------------------------------------------------
Aniket Randive (1):
      i2c: qcom-geni: Clear stale TX/RX buffer pointers after GPI cleanup

Christian Marangi (2):
      dt-bindings: i2c: mt7621: Document an7581 compatible
      i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC

Dmitry Guzman (9):
      i2c: nomadik: optimize struct layout, change unsigned char into u8
      i2c: nomadik: do not try to retransmit I2C message series on errors
      i2c: nomadik: return proper fault codes
      i2c: nomadik: change print level for fault messages to debug
      i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
      i2c: nomadik: handle pm_runtime errors
      i2c: nomadik: fix race condition with interrupt handler
      i2c: nomadik: reduce FIFO flush timeout to avoid long interrupt handling
      i2c: designware: return proper fault codes

Frank Li (1):
      i2c: use dmaengine_desc_set_callback()

Guangshuo Li (1):
      i2c: designware: amdisp: balance genpd on probe failure

Hongliang Wang (2):
      dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
      i2c: ls2x: Add clocks property parsing and adjust bus speed

Jean Delvare (2):
      i2c: designware: Use msgs[0] to validate the slave address
      i2c: designware: Turn models back to enumerated values

Johan Hovold (3):
      i2c: dev: fix blocked adapter deregistration
      i2c: dev: drop unnecessary sysfs device lookup
      i2c: dev: clean up registration

Tommaso Merciai (1):
      dt-bindings: i2c: renesas,riic: Drop clock-frequency from required

Umesh Kumar (1):
      i2c: designware: Enable SAR in slave mode for Multiple SAR controllers

Wolfram Sang (1):
      MAINTAINERS: add i2c-algo-bit to i2c-gpio driver


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: designware: Enable SAR in slave mode for Multiple SAR controllers

Bartosz Golaszewski (1):
      (Rev.) i2c: dev: drop unnecessary sysfs device lookup

Bin Du (1):
      (Test) i2c: designware: amdisp: balance genpd on probe failure

Binbin Zhou (2):
      (Rev.) i2c: ls2x: Add clocks property parsing and adjust bus speed
      (Rev.) dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties

Geert Uytterhoeven (1):
      (Rev.) dt-bindings: i2c: renesas,riic: Drop clock-frequency from required

Huacai Chen (2):
      (Rev.) i2c: ls2x: Add clocks property parsing and adjust bus speed
      (Rev.) dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties

Jarkko Nikula (2):
      (Test) i2c: designware: Turn models back to enumerated values
      (Test) i2c: designware: Use msgs[0] to validate the slave address

Linus Walleij (7):
      (Rev.) i2c: nomadik: reduce FIFO flush timeout to avoid long interrupt handling
      (Rev.) i2c: nomadik: fix race condition with interrupt handler
      (Rev.) i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
      (Rev.) i2c: nomadik: change print level for fault messages to debug
      (Rev.) i2c: nomadik: return proper fault codes
      (Rev.) i2c: nomadik: do not try to retransmit I2C message series on errors
      (Rev.) i2c: nomadik: optimize struct layout, change unsigned char into u8

Mukesh Kumar Savaliya (1):
      (Rev.) i2c: use dmaengine_desc_set_callback()

Praveen Talari (1):
      (Rev.) i2c: qcom-geni: Clear stale TX/RX buffer pointers after GPI cleanup

Wolfram Sang (9):
      (Rev.) i2c: dev: clean up registration
      (Rev.) i2c: dev: drop unnecessary sysfs device lookup
      (Rev.) i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
      (Rev.) dt-bindings: i2c: mt7621: Document an7581 compatible
      (Rev.) i2c: designware: Turn models back to enumerated values
      (Rev.) i2c: designware: Use msgs[0] to validate the slave address
      (Rev.) i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
      (Rev.) dt-bindings: i2c: renesas,riic: Drop clock-frequency from required
      (Rev.) i2c: use dmaengine_desc_set_callback()

Xi Ruoyao (1):
      (Test) i2c: ls2x: Add clocks property parsing and adjust bus speed

 .../devicetree/bindings/i2c/loongson,ls2x-i2c.yaml |   3 +
 .../bindings/i2c/mediatek,mt7621-i2c.yaml          |   4 +-
 .../devicetree/bindings/i2c/renesas,riic.yaml      |   1 -
 MAINTAINERS                                        |   2 +
 drivers/i2c/busses/i2c-at91-master.c               |   6 +-
 drivers/i2c/busses/i2c-designware-amdisp.c         |   6 +-
 drivers/i2c/busses/i2c-designware-common.c         |  18 ++-
 drivers/i2c/busses/i2c-designware-core.h           |   7 +-
 drivers/i2c/busses/i2c-designware-master.c         |   8 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   3 +-
 drivers/i2c/busses/i2c-imx.c                       |   3 +-
 drivers/i2c/busses/i2c-ls2x.c                      |  44 +++++-
 drivers/i2c/busses/i2c-mt7621.c                    |  25 +++-
 drivers/i2c/busses/i2c-mxs.c                       |   3 +-
 drivers/i2c/busses/i2c-nomadik.c                   | 108 ++++++++------
 drivers/i2c/busses/i2c-qcom-geni.c                 |  10 +-
 drivers/i2c/busses/i2c-qup.c                       |   6 +-
 drivers/i2c/busses/i2c-rcar.c                      |   3 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   3 +-
 drivers/i2c/busses/i2c-stm32.c                     |   3 +-
 drivers/i2c/busses/i2c-tegra.c                     |   3 +-
 drivers/i2c/i2c-dev.c                              | 166 +++++++++++++--------
 include/linux/designware_i2c.h                     |   1 +
 23 files changed, 283 insertions(+), 153 deletions(-)

--zSnaKzCwJyA3EGlh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr5ozwACgkQFA3kzBSg
KbZyJg/+MH2cDXal8x6CH+ogvH+dLgWBCJFaF9h3ZcVyxcba41ouwG/JhK+Zwrk1
t9hGxTS6bm7tgC8X+YvlmCEn7M2oBc8fOtsXVfkqgjjhlSiYqIMLt8Pv/Li/N3BH
eBPS9IPj7rZ/LnqdlpN3iF28o5LT6NL8nhs4NVrpjsk5oZ2a0rq834RsY50DESvb
6lHRisHjEuoupnXa0VoTrBIlP1FnIeyeEYDOhWv23vMpk3Fy7iw+WAxwdGMK3Kri
rBvI+oEnu7sqCy50WYkEHjP1yEAmAed8Ar2L8g20Nj7BhewK6YFezdZ7Dvn434o/
k3vVf7ndPJAj2Icu1Iid8xwJK7aEiMGlkMlQWTVd7FDISbHqBVfhhCfPZyMLaNt5
n2rIfNDypi3vF5qH9HEAkjzP1rSo+r3mZNSW11gmbUDHHXdscFyVnjrrzooY7Xcv
YAl0gxLFM2CPZoZYTX/LLmNSmmV4o2kYSmIbrILeKxowMCTxEfNsTB9h/dsux9OM
lhebCxwybs6l4Kigyqo22BXbM7GJdub//wl8t7yB26jl538HRBD2GjzPqM6M9C7I
Dw6KDXVm4uXFzUC1g4Gkf8F4WWtFdh183lwIYSMJzl2ZDc4aBHcJqJn77Vq5OTfR
0EJNCSsYfDEpEcn6yeZgPKGZXomOYRC/10uTH+SPtkgbRuBxW6U=
=CfMx
-----END PGP SIGNATURE-----

--zSnaKzCwJyA3EGlh--
