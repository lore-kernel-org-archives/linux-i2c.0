Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9E3955F9
	for <linux-i2c@vger.kernel.org>; Thu, 10 Sep 2026 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011610; cv=none; b=ojo9mAJwQ9Vjzbdyx8WUYz4a/91pJnVciKtGR2Kwj4Oe4w09OIVjm6927GXRMUoaftz6dS08JJ9wXDMFT5Tbht227AjnVgEwe/NIEcpjyVnzHJkNFhYzleNxgNCZ8CUCYvt19QrYyGMhM3+wJ8l3Jt66MDsViUsDoRf+Skodsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011610; c=relaxed/simple;
	bh=fbHi+gXipZ3MdJzUzGm17xyICy+psgM5NB9TegAjnbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xx4cJSXFCH0U3Em01TMoy3hw2RIIDKhyp2nFB5bwbSY2zYCKjJwLqzWaXmPfkSSTF9ZY0mcBHEkrYllxr2dRUBNKg1qDxiH7RiAHWThI77i/M7M99WcLBZGRpK7hzdE+WMr+HT4qjNothEVIGwm1OncUXzrUQ7gOuEGM1IEnNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LYNtCinm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LYNtCinm"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so12175585ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 20:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1789011607; x=1789616407; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9tvnuGvnbgY2VToM5oSZ6NV1NviBjBV50tr9v/KS1Rw=;
        b=LYNtCinmjV/y3jO0yR+m2Zw/9vlbc5uZK3jI4PqvC/VX1nKaNClzQnQugNmsmZGMZ1
         hioVGULWRk3Aj8PY0r4jYpCaSKQ3oADmfM1k/aO4SJPtBELhl15JEXcWRwnYepMwo2cJ
         tze0QetOtRYtokDFX3wPvlmoXwmkBDLbRrAHj2ysqCIu/yIL/S85YS4ounh+ufgI2qSF
         egAJoL+mp7i0AcnGHv567KqlePRJrfHQOKMvXI7yPwGoF21tgAenrhwmY7keOK7GKi5h
         W5XH6XvSrHUUqaasY/o+63lkf2jhXByZ+F/JIz1mRnffGvMvpd26TEtRYoPdHGjT5c9O
         7Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011607; x=1789616407;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9tvnuGvnbgY2VToM5oSZ6NV1NviBjBV50tr9v/KS1Rw=;
        b=BNLedt6jRztNxC2pMxgzrTgjj7CWWzE+0TjqWcx9VgQ1RQ8GATWa8Cu6aJDdvMW4Jg
         aXjzFH4bhiojqNVsz0Mww217UK3oFTGHntMkqe4QIn3LrjsVM68fOAYoRyPk1Pk/sRDa
         nz/0ZMgyw1xbqIc4a1cQr1DA7nHFrh2gZbLzmc++xGz8vw5j8IjXZgD7mhvAmCeLMKPl
         sBrCb8nJk+8ID9ZgEH1jWBrxUf/8xUreUo+b0cYvSIgIrt29OH+PkbS3M/WRuX9f7lxp
         Acw+1weVzoeMcBjR+PFwLEQdqC9ZaZda0iTPIBEOLcZoqVWZ8Cw9ymdVM9EJsqzllOL4
         zW0g==
X-Forwarded-Encrypted: i=1; AKwUvBzGmWCHp95ZWelUDxXWbdud5fTSh5xmkXix2ZsZwDcCAl37AZWnCmMu5Jfq11NUA4lxC22bjXsS6ac=@vger.kernel.org
X-Gm-Message-State: AFuF++nVkGRhZMOF1NzhMgYEbMishFU/UCbo14ntPhVS8tp1p1+edzOv
	P2ojTa8/JFbFi57FawO5ODhJDMhcqzDCWr66LQROh9FZenzMNP3ifTl/3BsUnDlpf/I=
X-Gm-Gg: AYBFou3Dnrzad12X3gh7jjfo0/u6HcCBLIu7boWITA5vmnhNTnoDtNDJ+uxVswta73j
	yd0U2ILWxYMx9tK8YsldHGoXifLC2cERRjh5rYp248aGXGP9SkDojLzsTKfFc0cjbclXM+nQZQ2
	8naSWs7mqRid8t6uwByGNKCutbUVTmOF14FPz7E8+93raDU9S0WwA7Hrew2UcPSGqzYuFGJwnrf
	RyW5oV67pqygKddehocFOvoHOZMVkD0NUNK2M5Vte1jWfCZfCcmPVEC0Ija6Z3Hvxla9chJXbns
	F3Q3ZqE4rfuL12LccTtmP/QSwyHQ12XS6wTcmaEajdplDXTYsdNY1rHjXo/Rlh+gRNeQQAwpbUs
	tqGKuZemykxick52Ox1oluoWPbp0gMSnJqtO19DBa9zQ7FNgxzviz8W0Lk/XaUczvUjM1t0abEo
	H5bm6eTA9oRsJcFxkDn7cfQy/8plMR6I9NnOTMNCiZvyvW6vHmPpNRaikIdHNb0qY/4V9VahNZ2
	g==
X-Received: by 2002:a17:90b:4d82:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39d70b1c7demr6759612a91.19.1789011606787;
        Wed, 09 Sep 2026 20:40:06 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm58294850c88.5.2026.09.09.20.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 20:40:06 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v4 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Wed, 09 Sep 2026 20:40:02 -0700
Message-Id: <20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NzQ6CMBAE4FcxPVuz3fKjnnwP46FdF1kPQCgSD
 OHdpXgQo8dJ5psZVeBWOKjjZlQt9xKkruaQbDeKSlfdWMt1zgoBM0gw14KkBxHS6NinYJgAnZr
 rTcuFDMvU+fLO4eHvTF30sVFK6Or2uXz1Jvb+zPZGg+YMIS8OzqXueqp46Mq62TlRcbfHj0yNW
 UmcJZnM7oG8SQ/Jj7RraVfSRkneUpGDd2C/5DRNL/JdYaUnAQAA
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789011605; l=4845;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=fbHi+gXipZ3MdJzUzGm17xyICy+psgM5NB9TegAjnbE=;
 b=eDbI2iJM9vlheW6MkxLftANxs15Q0mkunMHPY+vnwmNkGk9UhcI0COOQSQQkgyjLbZLAg15V4
 WNvZR3kEIlbBURSHHd2H5X8EFDVCg+GZcFxab0YYLifnqs1W+ib0/an
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
Changes in v4:
- No code changes; resend of v3 to collect Michal Simek's Acked-by
  (given on the v3 cover letter) into each patch.
- Shubhrajyoti Datta's Reviewed-by from v1 is not carried over since all
  three patches have changed since then. Shubhrajyoti, if the current
  code still looks good to you, a fresh tag would be appreciated.
- Link to v3: https://patch.msgid.link/20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai

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

---
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 67 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

