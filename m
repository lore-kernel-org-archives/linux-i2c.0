Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEB391E54
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666982; cv=none; b=Iap98CcHnBNnvbOJNkjR/zwUwmtW3Ipoip4TlOs+qsQia/9c1DpS43YY1nXFOi2Wg96PteMFSPQOrdcSSKZtN2J/j11XZNLM9dJPukLQxTbLWVMtUiY2bsW63ct0xhk+iRrfUd9H1Nh4giuQU82N+gWkmt6VUpMFaZucMrgGWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666982; c=relaxed/simple;
	bh=PzxUW1DNjcl44XkB1JuwkIwAKhSKInH4tg3oF/0gwyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A420wNwTYSkxejNnFo7FaLI9JS+csR5uZlZNaMucl83P40nWxZG1tFU4V3S/LU4W36nQVxRIueVipgQYmyqEViglnrel5BvsUdXy5tbfP55XxvchIuANYR5cWtnNjGnjXC0sf0UCnsH8L195wmYb0AHTIuDT51FuVvP+EN2IVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Ce7CBKgO; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Ce7CBKgO"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-133466cf955so545358c88.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778666965; x=1779271765; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+WV/M9sCxg4oVrUwsnl0xElto9Nq++mIAPkSFcaPZo=;
        b=Ce7CBKgOR8aFAUAfOr6S9G/QG41fG2x24VxUi48wNx7PAqfhegzNyR6KJ5UxYJ3Ih3
         kgXRbJR230OaLkzkWfa0V0jQCA2ESoX4psGrhATXOxnteGS3RBXILkVpnZnhfelX+aZa
         3atqKQwbd48mYkFqT77swWAx7T3F/mivgzYJlWEVviE2b/W1PKvILubxredSQDLClTij
         9zpPUbZKHgdMyeD17tlHmBh1rQ2pr0ajhrdUljw3zgTECddWtBLrl8iWL9mddN7OtzJA
         8U9QditDk2VrQEexQ2klop43wALmlTP9/YTuN5sZW+e3KqI/HlyirzZDXA2Mzp5ILV1r
         pa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666965; x=1779271765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+WV/M9sCxg4oVrUwsnl0xElto9Nq++mIAPkSFcaPZo=;
        b=GAXoLwKOfixdq+UPZah0idOybHFh0LwKituVeXrSh74GTXcs6O9BGeb8XRTYwet2o1
         yP61MlY1U1Y5CNbcutkWc+/yX+5HzlZ6+7kLYWuAMnJmZ8Jv3GGgAMP1edbyZPCvTx4J
         HO7tVXVWbYZo5yO4+AepsU7nqaCTF30H7dimEqjn9TPI7gAIsc9MA94N1dtEw5ogbHqZ
         wg9XCm9+35dK3EF526CUq/m4V1GMfrMMwMX/79Uhwe0xeAyAwMvtWvHAXBgQ1k4nds7W
         9947YtTZQc83vu1df3f0wPVgOFiHkqj9L7/l/krYMw/ERq+PAgGry9AYRGiV4QphEX2c
         0Kdg==
X-Forwarded-Encrypted: i=1; AFNElJ+XlLQbqah4/x87zO9tK/XxO2kA0vYXjPVhV2HGzWOKGGdg9tQlnMxnH0wvNukpx6Q+Poyl2PiYCjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAWjy23CHe6DR9XBlNveDBsegxo9oWORGHilXc+vntli2JH97
	8Cu06+JnHqcNYwyoeMNtwsNoQhcbZLas8Pm/WUnYM28tZa2eernHJ0FUyydpPUlAloA=
X-Gm-Gg: Acq92OGSQjhGVAPiEaGpFzUXxHuzsHCw0sbQCRkQurSGqWRULQOjw87sG4a8bz20yZw
	rDg2Spy3/gH3Syg86SqhL9oriMTWclo95UwvkdSySQa5NoBye2tmo3wWj2dkIKJ/0cWWAD57T0S
	ZxA1cBhm6roXOBUMMKgvBjQZtRQB63VHnCOUNOnuZ/sESbCRtbd/rWlwj+kpN1M60UxyeWMBMnw
	UCR8+JwdooaJDtUVxsHkNc3m53huV66VH5iQseBXNmCUQQH/397ao/jTONKI969+RmVVW2DVAfG
	GFtcUV8gz8acEbObgB65cGjN6XHG/PBfc6KKAJSN+haYnd0O/bC0hc6nrwOgFPV6Y/LErs+cZZ0
	J6QtOJTKkIb8fSwYYE5ptgn/Yjw2QwkX9qUyPA5eHWhtkPl60mUtwyIhBBOWRbZGYBf1+hA4hvo
	eZWlkGKN4UqsqCrGZXYRFrHYvR2XtIvtUzc2Fr
X-Received: by 2002:a05:7022:ec8c:b0:12d:ea4f:99de with SMTP id a92af1059eb24-13428b94b05mr1542456c88.0.1778666965091;
        Wed, 13 May 2026 03:09:25 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm29430265c88.15.2026.05.13.03.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:09:24 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v3 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Wed, 13 May 2026 03:09:21 -0700
Message-Id: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFNBGoC/22NQQ6CMBBFr0K6tqYdKKgr72FclGGQcQGkxQZDu
 LstLtTE5Uv+e38RnhyTF6dsEY4Cex76CPkuE9jZ/kaSm8gCFJSqgEoyoJyZUYKl2ihNqMCKOB8
 dtTxvqcv1zf5R3wmn5KdFx34a3HP7Cjrt/mSDlkpSCapqj9Ya25x7mqduGPeWReoG+JhG6y8To
 om6zA8Ka22OxY+5rusLyUL6Ru0AAAA=
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778666964; l=4599;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=PzxUW1DNjcl44XkB1JuwkIwAKhSKInH4tg3oF/0gwyI=;
 b=mJDPH4cweyl0MFWuO5Mf6LeZYckeVb4rLBuXwUD0udCirdUzHfiAMxZfMEAfCH9YxjPJGyLfj
 8GwEDoyPKTWCQS7YXAKT0dF20SRW0uHr66VlE0tH81aReZ7S3NRpLtN
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

This series fixes three independent bugs in the Xilinx AXI IIC driver
that together make SMBus block reads with PEC return -EBADMSG or -EIO
on otherwise clean transfers. They only surface when the client has
I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
turn.

The problems were uncovered driving an adm1266 PMBus device behind a
Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.

Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
The i2c core appends a byte to msg->len when PEC is enabled, so
overwriting the length to "block size + 1" silently drops the PEC byte
and i2c_smbus_check_pec() then reads the last payload byte as the PEC.

Patch 2 raises the RX_FULL threshold so the interrupt only fires once
every remaining byte (payload plus optional PEC) is already buffered in
the FIFO. The previous threshold of rxmsg_len - 2 caused the
bytes_rem == 1 path in xiic_read_rx() to NACK a byte still on the wire.
The chunk-vs-defer guard now also accounts for the PEC byte so a
rxmsg_len == IIC_RX_FIFO_DEPTH PEC-enabled read does not push
XIIC_RFD_REG_OFFSET past its 4-bit range.

Patch 3 stops the BNB handler from forcing tx_msg->len = 1 to signal
completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
so this also clobbered rx_msg->len; and because tx_pos is already at 2
in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
up to msg->len drives tx_space to zero without touching the length.

All three patches are pure bug fixes; non-PEC behaviour is unchanged.
Tested on real hardware -- a Xilinx AXI IIC controller talking to an
adm1266, where 64-byte PEC-checked block reads now complete cleanly.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v3 (addresses the sashiko automated review of v2):
- Patch 1: handle short SMBus block reads where the controller pads
  rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN for its end-of-message
  workaround. In v2 this branch left the PEC byte at the padded
  offset rather than the actual end-of-payload, so the i2c core's
  PEC validator read past the chip data. Track the on-wire length
  in a new smbus_actual_len field populated in the minlen branch
  of xiic_smbus_block_read_setup(), and trim rx_msg->len back at
  RX_FULL completion before passing the message up. Addresses
  sashiko's v2 note about the pec_len adjustment missing the
  rxmsg_len < 3 padding branch; that branch was indeed the cause
  of pmbus_check_block_register() silently failing on zero-length
  MFR_* fields and skipping debugfs auto-discovery on affected
  hardware.
- Patch 3: defensively reset smbus_actual_len in the BNB completion
  handler so a subsequent non-SMBus transfer cannot see a stale
  trim value from a completed short block read.
- Patch 2 is unchanged from v2. sashiko's two other v2 notes were
  investigated and judged not to require code changes: the concern
  about removed padding in the chunked-vs-deferred drain misread
  the patch (the padding survives via the else branch and the new
  PEC-aware guard preserves the original semantics), and the
  flagged unsigned underflow in xiic_tx_space() is unreachable
  because tx_pos is bounded by tx_msg->len at the call site.
- Link to v2: https://patch.msgid.link/20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai

Changes in v2:
- Patch 2: widen the chunk-vs-defer guard in xiic_smbus_block_read_setup()
  to include pec_len, so a 16-byte PEC-enabled block read routes through
  the chunked drain rather than writing 16 into the 4-bit
  XIIC_RFD_REG_OFFSET register. No tree-level change to patches 1 or 3.
- Link to v1: https://patch.msgid.link/20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 67 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

