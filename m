Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A6282F23;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=Hai4PZrbFmOUNJnnNyDPl1Cge8kJgB6MMKBr1gfPx9RQM6A3qQJF9Cbu+THf54Vwq95kTZ1PD9FDnfhixl3dPCnleVk1+AkalkdNydCQSo0HAtZoJYG5prSENp05UvY35LFredNP1EtVvgOtw1jT/90fNVahgsMdLVcrGluyD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=+ZYvhT2jap8wV13up78FsTzzMZWIs1iA7zfhknqTL3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2nPVmVC6LU67yrW7JJ8OiZ/oYWLvPcnymlZQ0ONVmPicrz8zIzht2dxWzNO9lRT/wChxYh7dcEKOFrNrA/e2CB2NjCgL+bXNB3+xwtR5OKaCJnWA+gmFYSKxrShqWXXT0l9Juctg0mjgal74ERSmLssPIqBG8j+9FRjabMNOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcEqaQUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcEqaQUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE3C2BCF5;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=+ZYvhT2jap8wV13up78FsTzzMZWIs1iA7zfhknqTL3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=pcEqaQUDdcHULU69WXVRxH2Q6WLKTHbb6wh/3/Xtd7VkEiO97QVLZ4wjNncYc2Zkw
	 DoBRhdH5IjD9y6a9E+R3+UqMcH8UXw/k4fLZoI2CEvDn2RVbgxZFK4efd/vvx3tUA2
	 wqUefwBe+LD+H90eZc3AxkYe+NCVRZeg/jJjOGqooOsSqL6U2cIintEamxxZcPwIRI
	 ynMQlDZDIP6djx5hreeRqqrswwUDZFPzdIcLGQbz6lAWJtCFNpCaaaEH1xpus61kw/
	 Kt+nNPvCA19+KaScpUMO8MFdbuqxpv0p2DzPWK6YhjLWfDabOQjB73ViE0OuJsIZLg
	 0psqV5Fr9PXag==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7J-00000001agy-3xBO;
	Fri, 08 May 2026 11:03:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/9] i2c: core: adapter registration fixes
Date: Fri,  8 May 2026 11:03:02 +0200
Message-ID: <20260508090311.379333-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a number of bugs related to adapter registration found
through inspection (when looking into addressing i2c lifetime issues).

Included are also two related cleanups.

Johan


Changes in v2
 - fix irq domain leak (new, flagged by Sashiko when reviewing v1)
 - add adapter to IDR before registration as needed by i2c-dev
 - honour devicetree alias also when using i2c_add_numbered_adapter()


Johan Hovold (9):
  i2c: core: fix irq domain leak on adapter registration failure
  i2c: core: fix hang on adapter registration failure
  i2c: core: fix adapter probe deferral loop
  i2c: core: fix adapter debugfs creation
  i2c: core: disable runtime PM on adapter registration failure
  i2c: core: fix adapter registration race
  i2c: core: fix adapter deregistration race
  i2c: core: clean up bus id allocation
  i2c: core: clean up adapter registration error label

 drivers/i2c/i2c-core-base.c | 165 ++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 72 deletions(-)

-- 
2.53.0

