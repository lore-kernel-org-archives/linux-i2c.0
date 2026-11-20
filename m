Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795149138;
	b=fh7F4RWHpDJTysUQgr6X0Rnc6OwGnAlQFDRWaYH9neB9AkxBk+WKwjdeY+tna0iqdLNI
	 oxfrd/wWtOGS9OylLPUM6XDUXlT+OdkPaeueAV2/JI/146wYPl4rQJgr/sPcSAugEgRa9
	 6VQwDJv380bvHGlV13hzVxXGpNqmqxbW3rgIGZgakLwdeMI18jdtHssG5vmFSJo+PQUEe
	 eKEU8CQY9pFstx8g2ErEW4Y2tEZ3MhfN+7kZRC3gRWHpevFYMzH3MHqVV1RJb54ltX7qC
	 T8cZ4x5MUpeSOXfPlz0pU/Fl2WLP7b2lQE+Roff17Teh+YJDf6hcmUur1lycdfkX2fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149138;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wzwrxIVSw5IoaAj9lmQZu1cZ1sojsnfK33zwI9FyuSU=;
	b=3sGjTynMhg7/ft/fXrbb9B65bt+fHBGdjwBnBISx+CsgNGRMP+AGsX1+BpD9FXfiDU8Y
	 9Vvmm+0P3Ptp6khezTjOBIznwZmY2lXBJS7y08wQK7wFgj/OhgjYLVlL6X/7R5l5PL8Od
	 MkzlPTGtp3/H19iJPtkVrbwHpgcJ1eEpIGc84ahD/w0BsYDvodsOKn5C95ZQyBP0/bNeM
	 wqoqNh365D6djv3Yfe8r2PTCkckzMdGU6mutszmui9LB+4uMM+QL7PTtvAH86zWRR5TWz
	 oCJ9WbiudLMkueXgq1X3xCXyzzG2Uun2r/PtPL5VvsbjIT9oTnTvSlateGxfINV7Z2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtT5g9gM;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6E606A325;
	Fri, 20 Nov 2026 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtT5g9gM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795149138;
	b=vwcXIlY0AfzrZjQwoIgb9B8jSizWriNp/AVKZfcXQ2YN/6z4If9hRlKqepcDhdiuAObr
	 fuZ8dJ8X1XzBZZKqbxdzN6vK7defTnn/YnLHEIdU1/ew/A9TzoSK/TLwTJpiG5kDGoFgr
	 bWEHC2rvhezlbTtMhJAr0kwQKGqEs4Z4SrqUG4TwY0r+FNUsiqjBKh8B+7o/ZEQMU6zUz
	 p3UrTNZlJQUJxjmtWmf83fSHgnnVf+IoiRo4yIdogyfB1qY7z3pZKPvQ0LvCN+bFUmXJA
	 EAo5HjdCUj+q96Wht1lesKbAEfmuSZPESvtcSgDjtm40woZaDB9hXt/OS/RaQIe5hnA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795149138;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wzwrxIVSw5IoaAj9lmQZu1cZ1sojsnfK33zwI9FyuSU=;
	b=Cdd0iDI0h3mYk08zMSGmzgQRzlxxRm12H5THlm76yX9Eq8+UED7iTkFASLgbJpPfCh3L
	 DxQIeg45wVoozn0xfyrbO4WpUSvQyA5hxkwTcQKEnogf2LspI6lSnEA+guEJ63vhlty/R
	 FIYTnNylZS6ZjkVoAJfOCqBSe6nmKaQhGwwSTWdNSq+7td5zJAeWSFv4VAQ5aVkGyu837
	 ZHDEsr5XpZ7CMiX4i8ui+2GrOB17K0833CXTgjX006PFPqXaObtwWnwaNi/FuLcW/TDct
	 dOjvQOOFkmpO8NtTIhe4NWx03x4AXMgMeoZ+Q9CaE3nMj9nCNsQVskAbFIsOYZmR9aQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 954B01F000CF;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795149138;
	bh=wzwrxIVSw5IoaAj9lmQZu1cZ1sojsnfK33zwI9FyuSU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=EtT5g9gMoiwnMziOAkgR30Sh2e+B4hPGtqj1fNhBINwSekxJ/csMYayBiKrk8vvI2
	 EI6/1U+454uSqY6/VSIPCIddoYlyQySzdr1Hp9vkXeR1iOElGoSPCj6RPc33RiDj35
	 zkRR4Yajlf7fWfnZPu1p3Dcy+puA13nx3Jkkr8MIWO9jXK0PyB/gfNuoBKlgpiCiPI
	 bR8SHncgk5rcTTo3dHoArnTi1P9dobqeRt90j+mascbN2cmkmTtSz4Vtp1Ky2IZt5s
	 euOqJzD1RXwnMhtMku3+tXHnaADk+46jzfJ3xdAcQvI/nyExEyTM3Q2b04sl3P34Xm
	 fjUFk25qO0ibg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 17C8C495AD;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] i2c: slave-eeprom: DT binding and OF match table
 for module autoload
Date: Fri, 20 Nov 2026 04:32:16 +0000
Message-Id: <20261120-i2c-slave-eeprom-of-match-v2-0-0444790a0b76@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxbY0FX3MOwaMsUxlBKWmw0h
 LsLeAGXL3n//YUljISJ3YuFRcyUKIwbyFPBbK/HDoHajZnkUgkhOJC0kAadERCnGDwEB17Ptge
 jb641qtTVhbNtP0V09D7aj+bH6WWeaOc9uBs9pTnEz3Gexe7985MFCKhcqaRxXEl+rTuvaTjb4
 FmzrusXf+tkpdQAAAA=
X-Change-ID: 20261110-i2c-slave-eeprom-of-match-ba9fdb67a830
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 =?utf-8?q?Bj=C3=B6rn_Ard=C3=B6?= <bjorn.ardo@axis.com>, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795149136; l=2176;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=dzUxAQssdho4tD6qq5wNbGkHdJxPJCqUmcPON/OFUEo=;
 b=6i2g3LrFYRFOlSq5jd163SHJqTJxlY6Znko6UPXGWr1OE+LtpUFSiPn4wYW0AuQ2tsTahBHW7
 s9SvzyKe+JTC7RHJ9W7+spOTH4frNPAKO+VSbknes4rXvCm6Q7fYlNR
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

A slave EEPROM backend described in the device tree binds only when the
driver is built in: the client announces an of: modalias and the module
has only i2c: aliases. Patch 2 adds the OF table.

Patch 1 documents the compatibles. Wolfram Sang asked for a YAML file
when Björn Ardö sent a patch for the same problem in 2021 [1], and on v1
he asked why compatibles without a binding should be added.

The binding keeps the driver's names, without a vendor prefix. Björn's
patch and the old DesignWare binding example (removed in 2020) used
"linux,slave-24c02"; that form binds too, because the I2C core strips
the prefix, but would not autoload with this table. I can switch to it
or list both if preferred.

This series was developed with Claude (Anthropic) as a coding assistant:
it investigated the problem, wrote the code, the binding and the commit
messages. I reviewed it, and it was tested on an Orange Pi Zero2 (H616)
as described in patch 2.

[1] https://lore.kernel.org/r/20210504135209.4757-1-bjorn.ardo@axis.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- New patch 1: DT binding for the compatibles (Wolfram Sang).
- Drop the <linux/mod_devicetable.h> include: <linux/i2c.h> already
  provides of_device_id (Uwe Kleine-König).
- Fix a NULL dereference in v1: a node that matches through a fallback
  compatible has no i2c id. Take the size and flags from
  i2c_get_match_data() and give the OF entries that data.
- Rebase onto i2c/i2c-next, new test results.
- Link to v1: https://patch.msgid.link/20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com

---
Arun Iyengar (2):
      dt-bindings: i2c: Add the slave EEPROM backend
      i2c: slave-eeprom: Add an OF match table for module autoload

 .../devicetree/bindings/i2c/slave-eeprom.yaml      | 59 ++++++++++++++++++++++
 drivers/i2c/i2c-slave-eeprom.c                     | 34 +++++++++++--
 2 files changed, 89 insertions(+), 4 deletions(-)
---
base-commit: 9c19b1c078541841f6b68f815bb4ba5201ab2b65
change-id: 20261110-i2c-slave-eeprom-of-match-ba9fdb67a830

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


