Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB23F3293;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429790; cv=none; b=TebN+3JdzwoXdIR9knE/LJpsL+2F6spY1pKo6wpFJU4Q/pCoAUgbkn9KsDAt+qE8mX32CoHdDXLRiBKqUT8QB8dPXvpiQg/MivLZXF7PXVFWRBaqXF3Bena1xtEjAZ/m/kEuz+oxRnIHtoUg7d8LBtCRo1654xmdfqF7AkCdmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429790; c=relaxed/simple;
	bh=Y37RDRvGcdTfSt4TfIk21BIoyh2Lq99rEpBKHLZTJuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRLo4A8W/0UbgLBynKA8pZm+PP58W9Q3V8X6YHMQaGSAfyh3bH4QgygcjwlJopzOBgBe7Flkpqcg7HqFsqiyNvWZtDC2v29cyNhjrmhS6OYU9jf077/zZSJcYQNx2ooVVX8h0cJ4eHXni/t4IQd/qtgms1IKyNjJk7f++DCmWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPDEunv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPDEunv5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F118C2BCFB;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786429790;
	bh=Y37RDRvGcdTfSt4TfIk21BIoyh2Lq99rEpBKHLZTJuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rPDEunv5AnDYg+HNXstJ+TH+EnuYAAwkeRkXj5yT1PRMwCHIXx+1HacfLuRPselBt
	 Hl/ebu0173LTLe1WKM6EHtI1OfBs81GGVgd++6BDQDE87R84jwkW2v/QXJYdzpZAQC
	 voCVDxdeIZkrQym2zcze4/G4IPXRHAlY0F8M1aCQlRHf9a6ijzY/IZ3Jb5vwupJlOP
	 1Qma46/pgU+0igXeUxZ9kuUZ/WnJ0U00q3xIlqrp781CV6tErQM5JYBqvx4NQFCJTU
	 6UPhiPLQveyV+Eu29TbEgjkjkPeHKu80hD6lo3hs3STTKp/O4KQKf2ogMgyyxiduyc
	 VMi90FehM1ZDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D228C5AC67;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Tue, 11 Aug 2026 14:29:50 +0800
Subject: [PATCH v5 3/4] MAINTAINERS: add an entry for Andes I2C driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-atciic100-v5-3-1d306c21dba3@andestech.com>
References: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
In-Reply-To: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786429789; l=771;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=uExPQvJDzXhEA4CaNzsQ8AegVCh731pt3gwkmiHcb3E=;
 b=Qv/zV69Wu6HC8PkNbTRV3bFVeZx8Xd3H6PePxXOGXirwnr3BcsnCsmKgTx0MDSDunYSZTIUkF
 mElc1UcXubvAR+nSfTCnDThPxpXxj5/++ZNJJSu/+n+BdoGDccKwBZy
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Add an entry for the Andes I2C driver to the MAINTAINERS file.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..d1727fd0e83e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1938,6 +1938,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
 F:	drivers/watchdog/atcwdt200_wdt.c
 
+ANDES I2C DRIVER
+M:	Ben Zong-You Xie <ben717@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
+F:	drivers/i2c/busses/i2c-andes.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>

-- 
2.34.1


