Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795849523;
	b=Tn3YwiGy6DSWQMfgkOaoG2/lPcAHMzWI18MEUIIKBKE3iTPFYVcO/8BWlLWYzUvjFYYA
	 t6f1G0a/eDcpBEfg/9cryFL/zELCbncYTscgUQbRwfJ0d3OReB5/Q6Bzvgu/uzyg7Z68N
	 irKmWYcd1dbsvYaeLHjJJQk46BbPXflx/UllhH7Mvoh4Dm+We/mUhH4bCthw4FJWvIrz+
	 jWRUloBGGc1fOWzaScC6cDY2H/EwGX/X+/eH4yc8MBpwPQIETKTneyPL1kueP1ZPpiI9d
	 arPP0WBj15WETNoq43Er24TOZ75rQ73WqKqCXa9kqQtm7S+zXjEPzx9a48T/fxhtatA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795849523;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PYyfDlpCB31FM4T/6ng0/L023I9fP8F3isxUkXY40tY=;
	b=B4hO45UKFiWjdXIsf64gqZbsBsUoeU63EtZbv8AMtleAEGjmPfVFdlVXFUzzbwirHQ2a
	 s8bY6QfEJNbviLoF3pp3o410N+xaTqKh/MPUmuNd22p2bUsGRe5+AKjMjx83kIhqwpo/6
	 9NJFnPWS/myKzC3xNetC9PdzYqV1zH4VtWkUXn+gLJDgQGweqQUJcZNCTQN2ueVMp1/ks
	 xspYU6f1G+kI2k+hEfW6Ak806nnQySl3kIDVvRgTmnHBZ/Prpsfdbi4AB0luoSHiP1KHQ
	 UD9eCcrpLqMjRxUnslgNAVDbQd+G5sDa+sNqiCIy4Ls2tL7xik4gJdaQ6PDnMv5jKgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ud2hRyPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4637606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 28 Nov 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ud2hRyPX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795849523;
	b=WzWeeiiXP7X3TwExoPNng8KiAT456ngVszwGXND4zHOmaGmCUNDtjtMzzF3T13romTrU
	 R5CfCgeTdT9Pyx/A6iIIWPIpHPkR2FuFHauOrYEhqaWM/OcErIEp8LK8/UfQ783tSVYMD
	 RF4c2aey3ZLKc5WacOEbac/WcMR6BUTn2XUbESmRFsrgGc+KCwjuM4hYw2oroT2bd8Bo4
	 bLkd8aszkWg137YDCkBSUHCGKUJrChOTkROS7Ddaob8IiY8O3x6AzS/gbIKDsKqutJ+M4
	 N2aYyHQtgslQIyfY8IB2j/SzFJLspcr/XzYVkofUnpElvsKUtKJ34pYDYu9+iaUBD/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795849523;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PYyfDlpCB31FM4T/6ng0/L023I9fP8F3isxUkXY40tY=;
	b=W89bYpH8PTYfH8hFn45mXa1ZcmktIz1oVy2ARUvYiVQzk00R9KAEk/sNUMVVlyWc8vkT
	 DBflO2egr2ot/XMFTkarl8DJJGoW44DOT6tTq5jvKzOjjw0RZ4hW8VQk5G5pY5mH3vA+b
	 WCtkfQevjvIQuPVnx2rBvNQsX3hsiUT/tHou7W+T43caZnokLJ57XBzJOiRW66ZLZpwL4
	 S8GQo3CaZe4w8qOlXOYKe2k+6moIT1MMzxkggOHUfnTOd+Topxd2KeMa06seHWWHw5c4O
	 pIDP8A8p2KVTeBWQ+FzwXYOpUGXZghUkj9d18y5gLlwLsb2Z159VnrR3ofrhKZaWt9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2C171F00897;
	Sat, 28 Nov 2026 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795849523;
	bh=PYyfDlpCB31FM4T/6ng0/L023I9fP8F3isxUkXY40tY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ud2hRyPXpYFCedB+/g1ZNNZwNEbkTagm+26biPK8n+XPbg3rotZsbeW2snSRAhLyV
	 0jc584SIoDlPjsFwEmHQi39lYyLJHKFpyIwa1M4MoX5pFNJVzQCRnnoIpYYX+lhsCL
	 fjmAIN+5rY9/nN408nb24jUqXL1iCuUof8i99BAy/qUefgWylyojHYVAiagwS0rot4
	 S0IwaKoM4RcRNyWc6LVXPTKclnThOGDt9/YivoyqSivaWJ7US3H1rLuTx+tnT/BXov
	 8gCLGw5cguRisIf1eiWNovzxTvGbvBEfbjMGPI/rC5y/k2aWsAGZIPRU43TcCLCFF8
	 kbf2b5zMKqauQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26E8F4E00B;
	Sat, 28 Nov 2026 07:05:22 +0000 (UTC)
From: Felix Huang via B4 Relay <devnull+akafelixab.gmail.com@kernel.org>
Date: Sat, 28 Nov 2026 02:06:39 -0500
Subject: [PATCH v2] i2c: diolan-u2c: Use get_unaligned_le32() to read
 serial number
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
Message-Id: <20261128-i2c-diolan-u2c-unaligned-v2-1-c6028a74f24f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dgwdI1BX3sOwKO0IY6AlLRAN4
 e4WvIC7/5L//1tFpMAUxS1bRaCFI3uXAE+ZMJ12LQHbxAJzLKTEEhgNWPa9djCnODvdc+vIAl6
 VIktVpRWKNB8DPfl9XD/qH8e5eZGZ9r+90XGcfPgc7kXuvT80iwQJubkUKJuyULm9t4Pm/mz8I
 Opt277Acooi0gAAAA==
X-Change-ID: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92
To: Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, Felix Huang <akafelixab@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795849600; l=1942;
 i=akafelixab@gmail.com; s=20261128; h=from:subject:message-id;
 bh=n00xqsAnw9+08teHGoItt6A75VThG+EK+ZptSH56EsQ=;
 b=rCspYky+MS46n/nURjB5MDUA/m02OpYbVjAv92czm7Brx4kmw14mbTWQG1w1IAwe1HjvX92Ve
 5r4nThnujT6A6dFWCKRrYLTSIX/cnxz8whsIkvTJwcOjRfli1+3lr37
X-Developer-Key: i=akafelixab@gmail.com; a=ed25519;
 pk=Axl3BM1UWa+m0/AWcEhRIdIk/WY9FnY4wZkyQn64uVY=
X-Endpoint-Received: by B4 Relay for akafelixab@gmail.com/20261128 with
 auth_id=1670
X-Original-From: Felix Huang <akafelixab@gmail.com>
Reply-To: akafelixab@gmail.com
Content-Transfer-Encoding: 7bit

From: Felix Huang <akafelixab@gmail.com>

Sparse reports:

  drivers/i2c/busses/i2c-diolan-u2c.c:290:26: warning:
  cast to restricted __le32

Replace the explicit cast and le32_to_cpu() conversion with
get_unaligned_le32(). This preserves the existing conversion semantics
and silences the sparse warning.

Signed-off-by: Felix Huang <akafelixab@gmail.com>
---
Changes in v2:
- Reword the commit message to accurately describe the motivation.
- Do not claim that the existing access may be unaligned; the
  serial-number buffer is naturally aligned.
- Focus on fixing the sparse "cast to restricted __le32" warning.
- Link to v1: https://patch.msgid.link/20261127-i2c-diolan-u2c-unaligned-v1-1-0c3621b7690d@gmail.com

To: Guenter Roeck <linux@roeck-us.net>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-diolan-u2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index d502f6e47..24db6d26c 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/i2c.h>
+#include <linux/unaligned.h>
 
 #define DRIVER_NAME		"i2c-diolan-u2c"
 
@@ -283,13 +284,12 @@ static void diolan_fw_version(struct i2c_diolan_u2c *dev)
 static void diolan_get_serial(struct i2c_diolan_u2c *dev)
 {
 	int ret;
-	u32 serial;
 
 	ret = diolan_usb_cmd(dev, CMD_GET_SERIAL, true);
 	if (ret >= 4) {
-		serial = le32_to_cpu(*(u32 *)dev->ibuffer);
 		dev_info(&dev->interface->dev,
-			 "Diolan U2C serial number %u\n", serial);
+			 "Diolan U2C serial number %u\n",
+			 get_unaligned_le32(dev->ibuffer));
 	}
 }
 

---
base-commit: f4585067150b85e33f60876149a6e742928da75e
change-id: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92

Best regards,
--  
Felix Huang <akafelixab@gmail.com>


