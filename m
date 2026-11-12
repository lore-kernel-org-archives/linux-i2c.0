Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501220;
	b=xjZlnFeDa/U8Z4A1RFRS5n6K0xft8w9frnzKecUjNDJO1a0UV79XzZf6dKQxr6SnFEAX
	 GPeZEXGnML9VmwwtmKb8mdR0BOwTAPeoNdjtmrwU2rOqRqdcIXltBrWmFkYYKieSAxYRm
	 QGU8FD4yL/H8Go/kcY0ld5ckYir/JCqV0imZ6KTHploBQkLcZehg+AjP2yFhzBbpdcs/U
	 1ovn9s4xF/FN7FYFLku/L8fRWKjNDTsOziGRZ5ufr/S1CIJjyZ5FMznojhvGAL6B90uQK
	 SSoEnF77fjuKUsBSo1m7V6tdI1yW0BZbhZUg3SqsBZTJvWg+0+fR7/NdFE0WmeuplNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
	b=xCHnOLKnblzuTNaAyWHRXHjQg8zDofyk5g9hgVIS1oqTGucDNY2wDNvLzrpG5TE3LqyM
	 ufw039bIVXR8jSV+Y21WxlG6ISwQjwBsVAYhnORjRJupqkOIOf5R4AOS+SGEaTT9baJX0
	 zBlddKBHIjtj4ZTAqi+uBR032WH84iG4z51OMG4Zaw+PEhmGUS/qC4/4Cfeq+3E5qT8Gi
	 dARRORwNxwt46AsCFW12NR7F8LhE3yCKK2LUQa5wf7mQKxmYXJi934XvNJXMlRVgCRZlH
	 bUUc+yJhvoGJuB9JsS56Eqaqup8gyyfxDkeWy5ewMEULygxIFWo7fPdw9X4119/jfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOOolabN;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6260A382B
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 16:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA6260A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOOolabN
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3b4944abeso1420475c88.1
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501219; x=1795106019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
        b=bOOolabNHffCQAuwLQ0DkkrmI/0xfrlO3ZGMi4uEqUSA/ruC8Kgzg3IfqETXANiCSc
         nE5XTUMOGB8+pm3D1vOJLl2dghi+dV6+Vf8rRysaZFAcqdtvPVkoe6QXZX87YeIv7qG7
         lfylAT9DyUHn+4Eh7Ynj4HzZCeDttzszv+l+bobVFsJjNhRSkAE3y5pQNLVCbqsXZfvX
         0sFEpdUsLOmCJy7pb/Wb5YJ0zdceVdrQpVM+F7Q5aHZisnn6mlBxmXh9varoskvH9SSU
         ko83HninfW0bnflBqx4NP0nlDvUvEjXEhUVdASmv8xP0a8g+0Ska9Eos+DzE6V4AAGlQ
         ELAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501219; x=1795106019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
        b=JJ60I/O0kMIQ/prIn3tUe7ma6lfYI7PR3Rc/aOTDKwLoi3R3FBGV+YdB1vacE+ciPa
         zFq7aGRLbNowJ91MDKmX6RVJZJ5AjHao3adcUmXh+WPjn4Pgnrg8CndhbWK+2hM5eiaB
         sslZjubPhQm2F081mxpC5LhYqqy755/vc1KL4YzRk61kra2G1foULA9FQXaBzdS7B6WC
         Kk9IuJFRODqdUyi6SzlcOeuKZB25MY5E0vGfEnsqX5jHE3vjoHy2DB6DcQ5dkeVd2Dxm
         kJz90BuVZpHnisH6LFeuATfK9W/SnSjKTeWUZYosUI3qo9qA011HAvVN6DVokfq4RE0l
         Iv3w==
X-Gm-Message-State: APuU4Z/mP9JNbsNRNGzwDIHRYNIw09VR5DuF2c/qTOINu0k/O3GTrjIZ
	3tOXERwWxWUmJJJ8TLw4bt2etRyrRMrGWQnZQWaKyJ6cKp6YVJqfEaMm
X-Gm-Gg: AYBFou1PK9bTPdGB6QAGHDKkB13uEl/1OMbvjZemdc+I9Khq/7XpgNRai3qxq4Yy5o5
	v9RxV9oZWeXW+QsmABmDfI4LW1u0DbrY0uglYwpEweaiGkFg8e53j+sqPObPJtK1Hd+Lz9UUkax
	5W1+Uv9yS5T5EqJxbrriJF0au5fq8umR17EIkC61usrqUFjmwa4KpX4IlMawcxRZeDtJk6ZVI8S
	DsR6qHJ9JQgT+IF3oKNwJ73Zo3CAMppMHLbqzBmVkgqUI+41vHPfYfznefODnYagFdfwIm63HxY
	uDCjf/QiGLv3EGyb6e6q8OPBlcWaQmUsnXegsjLkWT5kadymUPYMZGgt2ixXGNLyCjX2+LMFoQC
	IHHaOqgvFWolgrJG6FegegJ2fcYdTyQ34Te62B8hTneMOY2QukkfQ4qYfR7B8g5Uk1pTrrmctBH
	wv9+dxIIO4e4KfDbtH+b+lpoqqncOxRh5BllUT40h1pdIKabwMhOhQp0j3m3LSHf8bEh6tgAO8/
	vgArC0wOKrERSxiH5IKn6Og5fCtjepNiv5wEVSFJRzt2HR+VFMEG62+5FIqcaNZUBydVlpnt55O
	MoI66qmT3IsYtzut+Inj2mHtQcNFUn63FMRVF6HBixcCwbHmtS3S3IWowIEgr6aiy6FMHzlNG9M
	AxmF03iVmUJp+FE/zRqLR+vwtsRUL8betuH+uSYK7btR6/blki1s4AXIGZC7h37n8LoAajGR/
X-Received: by 2002:a05:7022:409a:b0:1b2:3b5b:b80b with SMTP id a92af1059eb24-1b5030d7a9dmr70385c88.8.1794501218632;
        Thu, 12 Nov 2026 08:33:38 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:37 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michal Simek <michal.simek@amd.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 0/3] ptp: ocp: support the WiWi production Time Card
Date: Thu, 12 Nov 2026 08:33:29 -0800
Message-ID: <20261112163333.12523-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The WiWi Time Card (2163:1008, subsystem 10ee:0007) uses a
Celestica-compatible register map behind LitePCIe. Its bridge does not
support the subword MMIO used by the XIIC driver. Add an opt-in word
access mode, exercise both modes with KUnit, and enable ptp_ocp on the
revision 02 interface. Other cards retain their existing access modes.
The series does not enable WiWi flash updates or change LED policy.

Patch 3 uses the platform-data field from patch 1. Could the I2C
maintainers review patches 1 and 2 for an Ack to take the series
through net-next?

Changes since v1:
 - 1/3: Drop five explicit inline annotations in the C file and
   shorten the platform-data comment. No access semantics change.
 - 2/3: Wrap the offsets and expectations flagged by checkpatch.
   The four test modes, register offsets and expected values are unchanged.
 - 3/3: Follow NetTimeLogic's PCI revision convention. Replace the exact
   image ID and per-core version checks with a revision 02 gate. Reject
   unknown revisions before FPGA MMIO and retain the BAR/MSI-X checks.
   Report the full build ID in devlink; select capabilities by interface
   revision. Update the documentation and wrap overlength lines.

The revision 02 driver was tested on a physical card running build
0x0000800f under Secure Boot. It bound with 64 MSI-X vectors; the PHC
advanced 3.000441080 s over three one-second sleeps. SPI NOR and both
EEPROM clients bound. The PHC was UNSYNCED at probe; this test does not
establish PPS lock or valid UTC. Only that firmware build was tested on
hardware. Subsequent edits to the tested drivers remove inline hints or
change formatting and comments.

On the rebased v2, the XIIC and ptp_ocp objects built on x86-64 with
W=1 under allmodconfig and allyesconfig. Four XIIC KUnit cases passed
in an isolated x86-64 QEMU boot. Fixtures exercised all 256 PCI
revisions, bad PCI layouts and multiple image IDs. These are not
additional hardware tests. No full allmodconfig or allyesconfig build
is claimed for v2.

Codex assisted with the changes, tests and changelogs using the board
layout, machine-check evidence, vendor revision rule and v1 CI reports.

v1: https://lore.kernel.org/netdev/20261111041904.48916-1-ahmadexp@gmail.com/

Ahmad Byagowi (3):
  i2c: xiic: allow platforms to require 32-bit register accesses
  i2c: xiic: add KUnit coverage for register access modes
  ptp: ocp: support the WiWi revision 02 Time Card

 Documentation/networking/devlink/ptp_ocp.rst |  36 +++-
 MAINTAINERS                                  |   1 +
 drivers/i2c/busses/Kconfig                   |  14 ++
 drivers/i2c/busses/i2c-xiic.c                |  60 +++++--
 drivers/i2c/busses/tests/i2c_xiic_kunit.c    |  91 +++++++++++
 drivers/ptp/ptp_ocp.c                        | 163 ++++++++++++++++++-
 include/linux/platform_data/i2c-xiic.h       |   3 +
 7 files changed, 341 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
