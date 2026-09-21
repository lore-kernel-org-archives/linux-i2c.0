Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD454F55C7
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015142; cv=none; b=IhH7fBgrnmNamx5guKH2DIMJNlly5JEulXuAOKHDYM5S9IOmurtSPGOPP8UHexcXa8aAjf67sGDL4kkTCcMV8XivVuuXVTdyOaja8SVnjedzc9hrbzcj36OX/gHCPLl2+MfDy2T9YC7sXXKrfXYQMsRGmS05k5c4LUd1idH8+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015142; c=relaxed/simple;
	bh=z82WFFnTz6orAZijm6PSC8AN4/nvOe4c7HMWdDPok8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dMAr1u0rLnMZBHFKLN/m5eVm00flIxOoBe3WLinYJXIDbJbjAJncUmI+qaL61aF7Rfii4+IjOaFqYZAKrLwLbmSBcS/N4yIp3dI57utXsDQuRnD5DeCyUHILv8V2grGnjMewPSnBT42f0JbNU8P0lCHP2gcmEOuSlzlPcM0TpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=alDwHj3Q; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="alDwHj3Q"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so2775623b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015140; x=1790619940; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7WZ6ucwFbC6JXfCd6WZ/sAB/uQVxlCCUJ68rPn9Ax2o=;
        b=alDwHj3QI/lWhrs4Lg9/4WFb9r+TsgL3igXJI9lbSI0scJZMS/ewePsSDUmCOQ0DOX
         qSFw0R6ZX9LWgrBpyEjctkfi8pwWv36MpBu7gLGJ5ZnmlRg8OIpSw9gCZksFjsYRqqW2
         zF6leilPd9g54fekuIswIk/EO4gORpVc+/BzvbUvqc/hFjMI7JECpDzjmI3bgf6ib3yY
         ddsYWKaxgYO37dj79th2qGogowMWs7yIOm9P5YuK3a0UydP8rOQiZbpXraFMExF6Ke1X
         mfjGSvG0XYUAMdoswAKgeE7gl0+SW6tJediVXeynGkIAePO+btr8TpJQ6PhRgFyBJX/8
         Hxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015140; x=1790619940;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7WZ6ucwFbC6JXfCd6WZ/sAB/uQVxlCCUJ68rPn9Ax2o=;
        b=ooUsge/aDDbUS/z/sKGdpu34xStNkOvHZeQYYkCimnRm6mHbWSTqyLQvDLMhaDH3A/
         gUZxa6UM5fE911Y6cFvBmxbvcOlhjcFW4k/HxaJg0GqWDmAvulHRvl5t/YgyL5dURVIJ
         1EeoGB20CVAdLpDhbP713TW1T2HuRoscsA1irTtImnj0r+E+0fzBTIk5cO6xdPM6tC//
         0NhlVHAiqBeZ63iE4M5Y4DzGYecok84d9IIM+ZBGvZBXhx8UUJsN+dTdwfk7VP8e0tqz
         kU5yTeGdnSmVB8nFwQWWzQ6tml8goA8ugMMbc1wm6Cnmk8MZTs/U8QDXYDdegL7DjarZ
         ytXg==
X-Forwarded-Encrypted: i=1; AKwUvBz0HqgOlExRPh4WFyz2Gz1B6qjh+VoooU/up3LksAj5bSkK4FBRPktaZd+JOFz9jIRJkDoeFIz60JQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kpU9kKEYnwybZpn36mqkA+fLu5eKIo8uh0jVatNYHZNoEzCCWC
	QUAPQ3N0tb5gGc7Ud3xhCJdj5ulRiyJUJV5JHWgxalUeuKunHqlET8NNdmAou8L0Wfw=
X-Gm-Gg: AYBFou1nWcvpuqmFg4p4YDtiQzHFa6A2HmaSWJkD6lsp61jLk6L3Sps+smpaVpdw1mx
	DSCZmvGVpbpME2NwhQcxHk/HOvOrxPKcHg5H+Sw/TPpHgwIUIjpk2cWNZSd8m1hq9KDYf2NIZ7T
	iwr6tDlaK3lCoGEwEJdtDDCsKP2z+HeooUtjLRJ16XcxZvBgAq9uFulO90UqroPeuWyPJA/l0I4
	Ruijrzni8gzMZtaPc899/uH4zCTouvOyoCG4jX1DGTF7qmgQKft75oCFve8p2Lrl8OeHZdgfWXG
	uMZZc6ctIEc7NuOmaOrE/BKMLSxBq7PY0mzaYPYUaPhH0vmwTjhDVP2Y+cDsDLF0RfoC7RpoYm9
	kwYx+5ow2y7MIrWIBHPZhz07QN6bqBJmlJKnFKOxqvzH7X3crLz41S1QrMfA1DBz/7ThYneiaZD
	N7KpgFbRXZ2/Zru8/UzTVib0tXwoNf2aGbEbcU6Znzf6yfoKYKd7rFshATvnK+Yqeas2BkuK59N
	A==
X-Received: by 2002:a05:6a21:4910:b0:3d9:6f0:b42f with SMTP id adf61e73a8af0-3dd8c541c53mr19754832637.17.1790015139867;
        Mon, 21 Sep 2026 11:25:39 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:39 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v5 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Mon, 21 Sep 2026 11:25:35 -0700
Message-Id: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwW6DMBAE0F+JfI6r3TWGuKf+R9WDbZawOUCEK
 aKK+Pfa6SFUyXGkeTM3lXgSTur9cFMTL5JkHHKwx4OKvR/OrKXNWRFQDRU1WijqVSRq8hwsIEc
 gr3L9OnEn633q8+svp+9w4TgXXxq9pHmcfu5fC5bei9kFNWiuCZrOeW99+zHwOvfj9c2LKrsLP
 aRF3EnKMmJtThADWlc9SbOXZidNkTGY2DUQPJgnWT2kA7eTVZaEp7YzyK414Z/ctu0XkELjv2E
 BAAA=
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=6288;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=z82WFFnTz6orAZijm6PSC8AN4/nvOe4c7HMWdDPok8k=;
 b=+f2rZdGD7vVkqwFoaOq3oqWwQUpg6Ned/tAtNmC7pzEDfyE0mRnYln8DBQOhPr8/+ynDQuHaT
 XhH0KjxjZbqD8rf3ceAC/h0Un2+vkGjKUOV9MJtbxCuReI5fg6pLDEy
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
Changes in v5:
- Patch 1: clear smbus_actual_len in xiic_start_recv() so the trim state
  is reset before every receive (Andi). Only the padded branch sets it,
  and a block read aborted by arbitration loss or a TX error returns
  through the error path without reaching the completion site, so a
  stale value could trim the length of an unrelated later read.
- Patch 3: drop the defensive smbus_actual_len reset in the BNB handler,
  now redundant with the reset in patch 1, and the paragraph describing
  it. No other change.
- Patch 2 unchanged.
- All three patches now carry a Fixes: tag and Cc: stable. All three
  bugs were introduced together by e4c1ff772e1a ("i2c: xiic: Add
  smbus_block_read functionality"), first released in v6.3, and a PEC
  block read needs all three to complete, so they should be backported
  as a set.
- Shubhrajyoti Datta's Reviewed-by from v1 is still not carried over.
  Shubhrajyoti, if the current code looks good to you, a fresh tag would
  be appreciated.
- Link to v4: https://patch.msgid.link/20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai

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

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To: Wolfram Sang <wsa@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 54 +++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

