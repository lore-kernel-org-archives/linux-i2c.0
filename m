Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4242C516
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790221; cv=none; b=VowjPddMvaY7JxFNT6GslyMvMjF8EvZVDBTnEWTYx+QLRdiTICkwp5+DWjnlC6qeoYh4rXEchw3hqQWhYej2H3Dsg+K3rs1G5nPhyW5zbV1GezoITWJsyfwFR48ersjxmsHaFMcu6UujkYVsIVOBxJeWBgbdvdsFvsNQhcM25CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790221; c=relaxed/simple;
	bh=wZ1N2REpOJJNPxLZ9GguARRcKMAl5kI4U1va3fafSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+mNL8do2OjHeJCSBxeBOViEfhgmkQ66VPg60yiBgDiGQ0mw5q6Iln4q2dpdlsA4VonHjlHiZbYp/n+UCBJsnwL1ru4paINYnhlaptT80L1Sfn4GNP9yUQyGAdphX8+OlqSa6Kvj1pA4x0BPm/9VUwccx3qOB+UJW3/6AbLS/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3Poe6/S; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3Poe6/S"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2928787a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790218; x=1786395018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gsxiDzL0I01ABFBzvuI/N7g4tWws5xrBk47m3Bu1XsM=;
        b=d3Poe6/SCVzVH66b7Ra8rqXkXtBg2L3xIicd6+NbV+9zhx4TRLixENlkFBPUiHp3Wi
         NoRPQice2O5wcxd0Y7sCpubqlu80zrBCK+Qt2Lmt6I/yq3GpoBVZX4Gck3f00ROfRRdl
         ay7MQNZjevt5zOlrqGWsnywXYpuXjz2FzZ5kOYRa9Kvq22eHx+hboqq7bkWWR4Y7rgrz
         kq6RaoUcG8e9UOC+f3vlVaAiK6bkcmC8YsfLkwysD/fVbZKWL4HHLEw6fhSyFzE1P3fF
         istdpNUCUZc5M56AIcBzXSKHpp1tshpRtEIZgZk43cHYgCGh0cbDRhEYoKZZM7XeZjj/
         g/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790218; x=1786395018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsxiDzL0I01ABFBzvuI/N7g4tWws5xrBk47m3Bu1XsM=;
        b=bWu/VtgWULPtDwf32TLi2woL/mWLfQueW15CR1V5RdPBn0l5lIE5LkavLBXnvU95Yp
         36iob+D6RKnSAiBasDbb0Ht7IINmykCj6xERMMFbt0evL0eaIZGQ9ru7zPDiS4lF9qhO
         BJye/Z7QTgyDj2EXnzmxxW1V3PxwLvw6pj/hw0R0B2rlQ8T1+4Ok+fqe8ibcg88xE6Bf
         aY3Xxrh1eceiMin3UR2CUiVPuTl5KyT4X0d3ZOr2c51762zudqczxE2hBfPVl4fCDk92
         sBBPw/r2N2Qo11XCMWzYlxduqnYE4JoBSfjFIK/d5Bz02wH2l+v1J/Aa9zpoHN4w78rO
         stqw==
X-Forwarded-Encrypted: i=1; AHgh+Roe0Y9pewB2dIWoPKz6O9hnv4BQSLYT6tubd7VmqajDIzmLoDEC/hX9EGlDyICBJIZSVbfb1sQHb+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy959cDKo9iRn8d1/897nsp0fHZ9inbdYYaulJqEOxxMTd3WZwj
	Razq6NA6w6/mSzcwb8uiwN5DxW+HhaCrQWdyrnAIR0GqkjEowy+A0ASn
X-Gm-Gg: AR+sD132geWYb7Vb2bVuAE7QmLQ9Mk51UdDpi8zpOcezA7/qg/ukju4sWDacHzsw534
	+nlkLfQ6tx87P6ISi5v+QUGTkOZdMwKq12UsvD/6y+uvzen5GPPqGj5fQ4zm6qDUq7mMq+8C7wD
	ni8LbAg+45vGQ8DN6g1iIxuOBAozqqJImiiv3akuY+selWhO+cI0af1PDO4gFXL87TbFYmo+XmK
	bfEYo/FGkEgHf0xYphEzg3+2Ht2R3pdcPZ7t1O+MiPSp4AlXzJkFoY4XRSgDpTSJbTkTpHZJ18G
	9ttNv0aU/KtzB9MdciuRX6WHs0o5HSn34o8sKWH7SRVhNrQ+3Dq1Ifq4B3DURLNHDvl9jYIoBYZ
	KCIbnkkWVEGM2c+szEPSHgAvyZkqMLCdAUT6XhrxXoXtHdq5E9ojLyZ4hNNL1PhVpSSglrrU6d5
	3Utd6+IIT5Ksd9i1lrewXinfa6JO8/lbVXMjmeUfFvZC0Hbt+sLHCwo/SFZIyODwAu59bQqoOEb
	dYnMdA=
X-Received: by 2002:a17:90b:4a42:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38fbc51610emr9556132a91.30.1785790217545;
        Mon, 03 Aug 2026 13:50:17 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:16 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 0/6] ptp: ocp: Add R4006 and V9 I2C peripheral support
Date: Mon,  3 Aug 2026 13:50:05 -0700
Message-ID: <20260803205011.1249-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R4006 and Time Card V9 place an I2C mux behind the FPGA XIIC
controller. The current ptp_ocp driver exposes the root adapter but does
not describe the peripherals behind the mux.

This series adds the generic infrastructure and board profiles needed
for existing subsystem drivers to bind to those peripherals:

  1. A binding for the Lumissil IS32FL3207 18-channel LED controller.
  2. An IS32FL3207 LED class driver with individual and multicolor LED
     support and per-output current limits.
  3. Software-node propagation from an I2C mux to its channel adapters.
  4. Validation of the fixed-width EEPROM board identifier.
  5. An R4006 profile for its sensors and GNSS/SMA LEDs.
  6. A Time Card V9 profile for its BME280, BNO055, GNSS1, GNSS2, and
     four SMA LEDs.

Profile selection is deliberately fail-closed. PCI IDs are shared by
multiple PCB revisions, so only a validated EEPROM board identifier may
select a topology. Erased, malformed, and unknown identifiers leave the
downstream devices unconfigured. R4006 identifiers are matched by their
R4006 prefix, while Time Card V9 requires the exact "TIMECARD-V9"
identifier.

The R4006 BNO08x is intentionally not instantiated because no upstream
driver exists for it. LED status policy remains in userspace; this
series exposes standard multicolor LED class devices.

The EEPROM validation patch fixes a pre-existing out-of-bounds string
read and carries Fixes and stable trailers. It is included because safe
board identification is a prerequisite for the profiles. That patch can
travel separately through the net tree if preferred.

Validation performed:

  - dt_binding_check, including YAML lint and example compilation
  - x86-64 and arm64 W=1 builds of the modified driver objects
  - strict checkpatch and git diff --check
  - R4006 addresses and LED routing exercised with the downstream
    implementation
  - Time Card V9 BME280, BNO055, mux, and LED-controller addresses
    verified directly on hardware

The complete upstream series has not yet been boot-tested on an R4006.
The V9 test card has an erased EEPROM and was intentionally left
unchanged, so automatic V9 profile selection was not exercised. Its LED
controller responded, but the outputs reported open-load status on that
board, so physical LED illumination could not be validated. The test
distribution also lacked the BME280 and BNO055 modules.

Questions for this RFC:

  - Should IS32FL3207 remain a standalone multicolor driver, or be
    integrated into the existing is31fl32xx driver?
  - Is assigning software-node channel children in the generic I2C mux
    core the preferred representation for PCI-card mux topologies?
  - Should net-next carry the complete series after DT, LED, and I2C
    review, or should the prerequisite patches travel separately?

Changes since RFC v1:

  - Correct the documented PWM resolution and support standard LED
    startup and retained-shutdown state properties.
  - Use a named I2C ID initializer and fix MAINTAINERS ordering.
  - Move EEPROM validation into a separate prerequisite fix.
  - Select profiles only from validated EEPROM identifiers.
  - Rework the R4006 implementation into reusable board profiles.
  - Bound asynchronous retries and serialize topology population with
    controller and mux driver bind/unbind.
  - Avoid repeated managed allocations during retry.
  - Add the Time Card V9 profile, including the second GNSS LED.
  - Leave the I2C mux software-node propagation patch unchanged.

RFC v1:
  https://lore.kernel.org/r/cover.1785684064.git.ahmadexp@gmail.com/

Ahmad Byagowi (6):
  dt-bindings: leds: Add IS32FL3207 controller
  leds: rgb: Add IS32FL3207 controller driver
  i2c: mux: Propagate software nodes to channel adapters
  ptp: ocp: Validate EEPROM board IDs
  ptp: ocp: Add R4006 I2C peripheral topology
  ptp: ocp: Add Time Card V9 I2C peripheral topology

 .../bindings/leds/issi,is32fl3207.yaml        | 208 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/i2c-mux.c                         |  55 ++
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-is32fl3207.c            | 580 ++++++++++++
 drivers/ptp/ptp_ocp.c                         | 871 +++++++++++++++++-
 7 files changed, 1687 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
 create mode 100644 drivers/leds/rgb/leds-is32fl3207.c


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.50.1 (Apple Git-155)
