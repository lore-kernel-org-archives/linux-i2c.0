Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8E364949;
	Mon,  9 Mar 2026 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043992; cv=none; b=oFm2O4/YnpMTlbqDZwoMqlfb5RkplVSHMtk8ur5FIpHM27zKo+i+DzM5XfFfb4rGFinauvrnGaD0ESzOtE0Y2D3OsMlVpQVUvBrNF0a94amXRT/ZfU70FyAM8lzpeOeP0OmYU6vppx3Aro9G1LiKdACCO7yME0bOFSXTvE9kSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043992; c=relaxed/simple;
	bh=egg9rqAIiY5AYS60WLS/qf6RGzOjxvHsVCcbQO5M4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+BjstvOHVT7uVf8BS3SJiA1KN1GQLNClaLiJlomAN552MVqIEeNW2NRHWZ+KVAw9iirNyAQ3wwYwJOLXmXjcO+xwX1OeNYl6PTu5wBhFPNSmiPEIzb5dwtTysugDMLecDlNB7PAmLSCrB97TKySLhuObZ9ahBIu0ztSVKyR+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw7CXz13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw7CXz13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038DDC19423;
	Mon,  9 Mar 2026 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043992;
	bh=egg9rqAIiY5AYS60WLS/qf6RGzOjxvHsVCcbQO5M4aY=;
	h=From:To:Cc:Subject:Date:From;
	b=Uw7CXz13cpD4E06xZmaWtmwkGeXug1LuMvhggyMm+IjbitrUmrHjSa0obke+BOwY2
	 nPBpuzF6L0CRykJPyWZPzZzXOkX0/sJxc8anwTEZdEsIGfn1so29eX2zc99nLoE91i
	 ueeIhEZVbsw+TrKY/h6+mG15WDYK/z0YcyxoazvP9FVcz1AxPn//kio6mGLW2E1a1P
	 7hLFHf//5eXPjzypN5JNlSRoWnnKZFpvnS/qV1gcFs+HorsdyPnnw2wV7008MHdHon
	 xXaHV7R44pHShOBuSc4cz8ET20JAJ+4D1eQ06d2T/kqjqLKdbNZlEt5qte96fU2Tvp
	 gt8KuBu2iEfPQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzVjh-000000002H6-31u8;
	Mon, 09 Mar 2026 09:13:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] i2c: tegra: enable compile testing on all archs
Date: Mon,  9 Mar 2026 09:12:59 +0100
Message-ID: <20260309081259.2557-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4a2d5f663dab ("i2c: Enable compile testing for more drivers")
enabled compile testing of the Tegra i2c driver only for architectures
that explicitly provide readsX() and writesX().

This limitation appears to have been too restrictive since the generic
implementation of these primitives added by commit 9ab3a7a0d2b4
("asm-generic/io.h: Implement generic {read,write}s*()") predates the
commit in question.

Allow compile testing of the driver on all architectures.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/busses/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e11d50750e63..33b06fa70f91 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1211,8 +1211,7 @@ config I2C_SYNQUACER
 
 config I2C_TEGRA
 	tristate "NVIDIA Tegra internal I2C controller"
-	depends on ARCH_TEGRA || (COMPILE_TEST && (ARC || ARM || ARM64 || M68K || RISCV || SUPERH || SPARC))
-	# COMPILE_TEST needs architectures with readsX()/writesX() primitives
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C controller embedded in NVIDIA Tegra SOCs
-- 
2.52.0

