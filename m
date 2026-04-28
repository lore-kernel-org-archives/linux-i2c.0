Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4D1EF39E;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335490; cv=none; b=Q4CWJASBFjMrprK4N7xSKJ4TMhtekMt45vVdHGjvS6cq1Z7MafYBYH96C0DHpDEzzWlGM4MZASl/szyin0BOYdVnyNf1R3aiiaGPe59pTsUjG7H7ijAx8bQQDkKtzc0zbOh0IpzPKOZ7ESnCCAx4R0UzuXQ/HXt9UFmYhlzAlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335490; c=relaxed/simple;
	bh=CsiHZ5vb7Sf7aVyvtEGZ7+CNeUx8W/SFG7JbsXLjEQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQ32AdrzY3WQfSHC3EvMvyJPF63o5M08ujPPIe2hJ20R3bEXlF7pjXfvbcfSVHndrUlIOSL8Y/0coAAp2maZuPw6hCL7oMibAtnz2j7Iq0XlJrYs4F/ffvVi2L2alWjMAk37lDx9UpZ/znU5XnDbGDd1ZD0cp5fHTkdkgzxxK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou9HWgAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou9HWgAW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C828C19425;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335490;
	bh=CsiHZ5vb7Sf7aVyvtEGZ7+CNeUx8W/SFG7JbsXLjEQE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ou9HWgAWpBeePErzoQtCce8S3PWmyMP2WhR/V0s0A9Bod3jf+PusGVYD18z0QfjlN
	 6UD5FuWmiylBa4vWydKoWnn/Xf0ZsJCjqsfDKPqLERYppyfBpPF2/r7m7bJ8kh5P2Y
	 Ojligkc0ohRUwKmvLgVgW8SbJbNzeZ0NSqDsUSA+/avOqr8hovXDpglsOP+KJJTkIG
	 B65esENZh7ozi9GZ+kOi4FMfmZqge7b4en7vO+qJgjBffKeo6joPP+zqwD9LgR1wcV
	 Pqkg7kjjS2t3fkNncxrIk+cS8SGcljGuxfLyc46HYw9hCyn7mIw1e0wZA8AwBcOiRB
	 hNOW+bqH/k6dQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E22FF886D;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Mon, 27 Apr 2026 17:18:05 -0700
Message-Id: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3872kC/yXMSwqAMAxF0a1IxhZq8ANuRRzUGDUOqrQqQuner
 To8cN8L4NkJe2izAI4v8bLZhCLPgBZjZ1YyJgNqrHWJjRIkdYuQQsNDpQsmjQZSvjue5P6uuv6
 3P4eV6Xj3EOMD+w3U4mwAAAA=
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226;
 i=abdurrahman@nexthop.ai; h=from:subject:message-id;
 bh=CsiHZ5vb7Sf7aVyvtEGZ7+CNeUx8W/SFG7JbsXLjEQE=;
 b=owJ4nJvAy8zAJbYltPXv6rsCXxhPqyUxZL7/c1CCcemG8lNB+zimTlrSqKJ59d31H1dZVm4w5
 98clSr9LMigo5SFQYyLQVZMkWXOI/83bR1tERtiDtnDzGFlAhnCwMUpABOZspaRYfvjn5c6/q7r
 K/zJrHWW7Wi07ZYaD+d7W91UKkJ+MvtfMWBkuPRz4joViehXlfpOOT+yFizSF1rYPEfR2m31H6k
 rynYrmQAl5VAE
X-Developer-Key: i=abdurrahman@nexthop.ai; a=openpgp;
 fpr=9CE24FEC86888658B05CC23FB45585FDABDD10F4
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/default with
 auth_id=756
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

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
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


