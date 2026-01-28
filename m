Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4C340293;
	Wed, 28 Jan 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603148; cv=none; b=ARRSDFYYkQlUl9jjGX9TPmMylGOb8K2vSc8rfIDGPoeNQ6eL1Uzx3HldKFExZl/0y6ShyU0kpesgk6WlA7eItDn4P0YnE2lFenLRa/bMl7kEx7aCOM+NCLWulj1F1Xv+iYPihgfYC8WM/IhqBDM+tm64dqORxHAGNhjtvQtEqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603148; c=relaxed/simple;
	bh=4Hf8WFVjj3Fr8FkaoNLFWcuWjq8ROC9IttcHryo+64E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBQSo071Jn8m1uILOsqH0g7dx9YLBkcjYxPCr+3fTeZ1qOn1PsKLd9YgYm58xNV1ftlIv1hffXVZR3/on2agnu5Poxpso8/+GH0AgNLxsx17/YNhZGd6mPCCeS4v2MaYLNaikQsxDGdDdYGSWqmtFn9KZ5TRIYaNw1YuyPzjDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5v6j9IC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5v6j9IC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1A6EC2BCAF;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603147;
	bh=4Hf8WFVjj3Fr8FkaoNLFWcuWjq8ROC9IttcHryo+64E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W5v6j9ICJ+4Zl1bzJQOMCZCZw9JRUHTudvZ3krWOw8Kz04QNC82GWWwO8xzmdsRA4
	 HUrPKkwznuk9HM4aK4Bw/GwIlPD3I2VtwYrtBivfdTDIfJR+rXyRxp2aHHj4CkyRjE
	 1z16VDBRy5XTe1c+ymBHShZnnzxXzB+PJ8SgP84twzCSit0OgnbR57Z8dm1wLLghNw
	 /XCs6upOJH4bbqPyu1rTRU0Ix2Y1BOZ2OC14hWGNt3WthKeIYP/mAizW6rrE+BWufP
	 tQk7/x31tBl44PfEs9CFrEpifESSo26mdOhwwu5I6kqDZLhP/MSNxUPqyV5g/3agXK
	 Hxlf56DvA4QwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8FD25B48;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 28 Jan 2026 20:25:46 +0800
Subject: [PATCH v3 3/4] MAINTAINERS: add an entry for Andes I2C driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-atciic100-v3-3-8c002fcc2bb4@andestech.com>
References: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
In-Reply-To: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769603146; l=725;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=R5gM2pzYU1W+0/8WWd58LyJRsiDel4+cHcYEncZpNOE=;
 b=nkvGd6uphKL+SR3Wj1edsbzWRIJnDia++C+nJ2w9q+QAj8xXJGRcJmp0GxcDMwtYFnu6OTPqQ
 ZSL9x9NgzgLCrzEVeb9jOFiokz8xBwtii7pXPkzMKgGUp85tlApImYx
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
index 6863d5fa07a1..e2fdcf2b9677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1819,6 +1819,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
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


