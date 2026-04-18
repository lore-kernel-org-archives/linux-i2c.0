Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80D1A6800;
	Sat, 18 Apr 2026 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492461; cv=none; b=bOUKkU8dqG4H1TxyNVZStP5Ey2fV5whqEgkx8LDEv4763lwp6xM9fp8PqUTDG3luLzjaoOFbnk8eI+cNsImBWNbTiLNr550j85F6SDclJlz/WiXeFnqIGMDPLMTzSqeGqk0rhpNX6xuyuR5cV5TN+s96RbzY2zKg1R8MpLWeOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492461; c=relaxed/simple;
	bh=yztPhDPclF5AO+5EfRyPwhinIu4IccXYyrEw36Ile2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=exD2DLQXk9jra3ENsmaPrx19vdUvnUjHvyL+uANU8dpYfqgZ33+oEN2tqpAsPPOrQXBjNnNqTbTmVhQ3iCDiub0VmqfrWHbN8WrYk5luJsApRmo20NYIZ/QSOMjMVUKfhtUT1BRklFJKMEpXZ3hN4l7fZFdjyOal7x58+hDr1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE7SSq+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE7SSq+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC28C19424;
	Sat, 18 Apr 2026 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492460;
	bh=yztPhDPclF5AO+5EfRyPwhinIu4IccXYyrEw36Ile2g=;
	h=Date:From:To:Cc:Subject:From;
	b=LE7SSq+OVK9UOJ7NE/s4qfjQznNNPRkWpFqq9negKi+ahj7iqlGJb9sLHV5vmPbZq
	 H9LxRvT6CeSKLIa5HNdK9VaJfy3NNle5+3mRgibZR4hwW1M0pf2EoodpMKzO5tg7qS
	 5wVhFoLce+hWCcij5+SSQ8xXbPtMgOoeLjgYbdxXf26u5oooQAxNFWIne00cXJUj9Z
	 AZ7nGRWuEHnyVCC2F6pOFcxM98aHhPcd2RsIakwtwqe1vHbW2yDu9BCsdZoK3NHGN6
	 b1lVbQ8TNpIwHUkbWV3jzbRBG5luPPeBSjMZ+w8PrY43n8Y7KqwQutQjonx2HlgNhj
	 tc4X1nMdgaZLw==
Date: Sat, 18 Apr 2026 08:07:37 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.1-rc1-part1
Message-ID: <aeMfqTRgtRkxSBMd@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzOkz4aCNeQaQfiQ"
Content-Disposition: inline


--mzOkz4aCNeQaQfiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

the biggest news in this pull request is that it will start the last
cycle of me handling the I2C subsystem. From 7.2. on, I will pass
maintainership to Andi Shyti who has been maintaining the I2C drivers
for a while now and who has done a great job in doing so. We will use
this cycle for a hopefully smooth transition, Thanks must go to Andi for
stepping up! I will still be around for guidance.

Thanks and please pull!


The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part1

for you to fetch changes up to e336aa3c396ba41fd5a3b818df917a70f39594a5:

  Merge tag 'i2c-host-7.1-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-mergewindow (2026-04-14 21:48:38 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc1-part1

- generic cleanups in npcm7xx, qcom-cci, xiic and designware DT
  bindings
- atr: use kzalloc_flex for alias pool allocation
- ixp4xx: convert bindings to DT schema
- ocores: use read_poll_timeout_atomic() for polling waits
- qcom-geni: skip extra TX DMA TRE for single read messages
- s3c24xx: validate SMBus block length before using it
- spacemit: refactor xfer path and add K1 PIO support
- tegra: identify DVC and VI with SoC data variants
- tegra: support SoC-specific register offsets
- xiic: switch to devres and generic fw properties
- xiic: skip input clock setup on non-OF systems
- various minor improvements in other drivers

rtl9300:
- add per-SoC callbacks and clock support for RTL9607C
- add support for new 50 kHz and 2.5 MHz bus speeds
- general refactoring in preparation for RTL9607C support

New support:
- DesignWare GOOG5000 (ACPI HID)
- Intel Nova Lake (ACPI ID)
- Realtek RTL9607C
- SpacemiT K3 binding
- Tegra410 register layout support

----------------------------------------------------------------
Abdurrahman Hussain (7):
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c: xiic: cosmetic: use resource format specifier in debug log
      i2c: xiic: use numbered adapter registration
      i2c: xiic: skip input clock setup on non-OF systems

Andy Shevchenko (1):
      dt-bindings: i2c: dw: Remove unused bindings

Aniket Randive (1):
      i2c: qcom-geni: Avoid extra TX DMA TRE for single read message in GPI mode

Arun T (1):
      i2c: usbio: Add ACPI device-id for NVL platforms

Biju Das (1):
      dt-bindings: i2c: renesas,riic: Document the R9A08G046 support

Greg Kroah-Hartman (1):
      i2c: s3c24xx: check the size of the SMBUS message before using it

Jan Kantert (1):
      i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus speeds

Johan Hovold (5):
      i2c: robotfuzz-osif: drop redundant device reference
      i2c: diolan-u2c: drop redundant device reference
      i2c: tiny-usb: drop redundant device reference
      i2c: cp2615: rename disconnect callback
      i2c: tegra: enable compile testing on all archs

Kartik Rajput (3):
      i2c: tegra: Introduce tegra_i2c_variant to identify DVC and VI
      i2c: tegra: Add logic to support different register offsets
      i2c: tegra: Add support for Tegra410

Krzysztof Kozlowski (1):
      i2c: npcm7xx: Use NULL instead of 0 for pointer

Luca Weiss (1):
      dt-bindings: i2c: qcom-cci: Document Milos compatible

Martin Aberer (1):
      i2c: ocores: Use read_poll_timeout_atomic to avoid false poll timeouts

Moritz Fischer (1):
      i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller

Rosen Penev (1):
      i2c: atr: use kzalloc_flex

Rustam Adilov (8):
      i2c: rtl9300: split data_reg into read and write reg
      i2c: rtl9300: introduce max length property to driver data
      i2c: rtl9300: introduce F_BUSY to the reg_fields struct
      i2c: rtl9300: introduce a property for 8 bit width reg address
      dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C support
      i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
      i2c: rtl9300: introduce new function properties to driver data
      i2c: rtl9300: add RTL9607C i2c controller support

Shi Hao (1):
      dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT schema

Troy Mitchell (2):
      i2c: spacemit: move i2c_xfer_msg()
      i2c: spacemit: introduce pio for k1

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition

Wenmeng Liu (1):
      dt-bindings: i2c: qcom-cci: Document sm6150 compatible

Wolfram Sang (1):
      Merge tag 'i2c-host-7.1-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-mergewindow

Yixun Lan (1):
      dt-bindings: i2c: spacemit: k3: Add compatible


with much appreciated quality assurance from
----------------------------------------------------------------
Alex Elder (1):
      (Rev.) i2c: spacemit: move i2c_xfer_msg()

Andrew Lunn (2):
      (Rev.) i2c: xiic: remove duplicate error message
      (Rev.) i2c: ocores: Use read_poll_timeout_atomic to avoid false poll timeouts

Andy Shevchenko (7):
      (Rev.) i2c: xiic: use numbered adapter registration
      (Rev.) i2c: xiic: cosmetic: use resource format specifier in debug log
      (Rev.) i2c: xiic: cosmetic cleanup
      (Rev.) i2c: xiic: switch to generic device property accessors
      (Rev.) i2c: xiic: remove duplicate error message
      (Rev.) i2c: xiic: switch to devres managed APIs
      (Rev.) i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller

Aurelien Jarno (4):
      (Test) i2c: spacemit: introduce pio for k1
      (Rev.) i2c: spacemit: introduce pio for k1
      (Rev.) i2c: spacemit: move i2c_xfer_msg()
      (Test) i2c: spacemit: move i2c_xfer_msg()

Chris Packham (7):
      (Rev.) i2c: rtl9300: add RTL9607C i2c controller support
      (Rev.) i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
      (Rev.) i2c: rtl9300: introduce a property for 8 bit width reg address
      (Rev.) i2c: rtl9300: introduce F_BUSY to the reg_fields struct
      (Rev.) i2c: rtl9300: introduce max length property to driver data
      (Rev.) i2c: rtl9300: split data_reg into read and write reg
      (Rev.) i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus speeds

Jon Hunter (6):
      (Rev.) i2c: tegra: Add support for Tegra410
      (Test) i2c: tegra: Add support for Tegra410
      (Rev.) i2c: tegra: Add logic to support different register offsets
      (Test) i2c: tegra: Add logic to support different register offsets
      (Rev.) i2c: tegra: Introduce tegra_i2c_variant to identify DVC and VI
      (Test) i2c: tegra: Introduce tegra_i2c_variant to identify DVC and VI

Jonathan Cameron (1):
      (Rev.) i2c: xiic: remove duplicate error message

Konrad Dybcio (1):
      (Rev.) i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition

Krzysztof Kozlowski (3):
      (Rev.) dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT schema
      (Rev.) dt-bindings: i2c: qcom-cci: Document sm6150 compatible
      (Rev.) dt-bindings: i2c: qcom-cci: Document Milos compatible

Loic Poulain (2):
      (Rev.) i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition
      (Rev.) dt-bindings: i2c: qcom-cci: Document sm6150 compatible

Luca Ceresoli (1):
      (Rev.) i2c: atr: use kzalloc_flex

Mukesh Kumar Savaliya (1):
      (Rev.) i2c: qcom-geni: Avoid extra TX DMA TRE for single read message in GPI mode

Paul Menzel (1):
      (Rev.) i2c: npcm7xx: Use NULL instead of 0 for pointer

Sakari Ailus (1):
      (Rev.) i2c: usbio: Add ACPI device-id for NVL platforms

Tali Perry (1):
      (Rev.) i2c: npcm7xx: Use NULL instead of 0 for pointer

Troy Mitchell (1):
      (Rev.) dt-bindings: i2c: spacemit: k3: Add compatible

Vadillo Miguel (1):
      (Rev.) i2c: usbio: Add ACPI device-id for NVL platforms

Vladimir Zapolskiy (1):
      (Rev.) dt-bindings: i2c: qcom-cci: Document sm6150 compatible

Wolfram Sang (1):
      (Rev.) dt-bindings: i2c: renesas,riic: Document the R9A08G046 support

 .../devicetree/bindings/i2c/i2c-iop3xx.txt         |  20 -
 .../devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml  |  41 ++
 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |  20 +
 .../bindings/i2c/realtek,rtl9301-i2c.yaml          |  15 +
 .../devicetree/bindings/i2c/renesas,riic.yaml      |   1 +
 .../bindings/i2c/snps,designware-i2c.yaml          |   2 -
 .../devicetree/bindings/i2c/spacemit,k1-i2c.yaml   |   6 +-
 drivers/i2c/busses/Kconfig                         |   3 +-
 drivers/i2c/busses/i2c-cp2615.c                    |   5 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   1 +
 drivers/i2c/busses/i2c-diolan-u2c.c                |  12 +-
 drivers/i2c/busses/i2c-k1.c                        | 316 +++++++++---
 drivers/i2c/busses/i2c-npcm7xx.c                   |   2 +-
 drivers/i2c/busses/i2c-ocores.c                    |  24 +-
 drivers/i2c/busses/i2c-qcom-cci.c                  |   3 -
 drivers/i2c/busses/i2c-qcom-geni.c                 |  24 +-
 drivers/i2c/busses/i2c-robotfuzz-osif.c            |   4 +-
 drivers/i2c/busses/i2c-rtl9300.c                   | 195 ++++++--
 drivers/i2c/busses/i2c-s3c2410.c                   |   7 +-
 drivers/i2c/busses/i2c-tegra.c                     | 534 +++++++++++++++------
 drivers/i2c/busses/i2c-tiny-usb.c                  |  13 +-
 drivers/i2c/busses/i2c-usbio.c                     |   1 +
 drivers/i2c/busses/i2c-xiic.c                      |  97 ++--
 drivers/i2c/i2c-atr.c                              |  17 +-
 24 files changed, 970 insertions(+), 393 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml

--mzOkz4aCNeQaQfiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnjH6kACgkQFA3kzBSg
KbYVPQ/+J8CfXnNRq+6O+ipkSLKY7451foUoCGrXzCyyMfOAJMCWUTDEi8U+Uz6z
cI49AEV81u1f68vssq+H9lHj5uX12I2woqcm06yIBbYRdM3D4959TnotYrOz1jfg
tkIRcrGVKdFO2y2OfMlS9yZU46A4Tmo+yWiPbtgzVaX34a3kBGrsME2uZUU70np2
jlFdhWQtn25+f0K7ESASJT9bbtx1FlSoY9oXNCYwMhbOmmQLMCV1e4WZuxXuFWdi
aSfSeq8HCH7jDAW4rtZdQqob74OuPzLZs+U6/ok6hWrZ2tdCf9HBJ2T+ShpAXFUp
hnQdpuiMrGR+VDaC0zpDJNjKGekMETQ6OpcjgoFmpkiEOx2DGi+zm/1ioU0sN+2G
tzQUarZhHYip3G0CpyGNDwd6Sjyx7Gd1hokxgmiJnUflDVSsbz7l/UulgcORHy+E
1MryNqc+fsWlXk0BgnA5h5+o08H2bGmxpooonrK9DVMb3xg4JbD9DaqVQzxQ7K2f
QxoQqO866KjhVnHOSiUUsF0noWCK0XS7FSlcE1VRH5v3ai3Fplws032PGA5u1F2M
XvsY5+yz7Qcr3JKIZYVvNsli6S/0A1ewlHv3dkyY3vnl/6W9nyPPdXqBOhROFrfD
drpZ16BeQAtR5fGLC7RFlfP4T2PiUerwJqV52aF8GHL/Xq41Yow=
=QID8
-----END PGP SIGNATURE-----

--mzOkz4aCNeQaQfiQ--
