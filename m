Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625030FF33;
	Fri,  3 Apr 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197272; cv=none; b=FWVsSS3jaYofbZN5tTIDxNKVA8vKJgmGiuIJ9+KvxQKvodIrDV2k68XXZyTdS4WO7Ehqe4bwzfWjfXWzWJl4HjCUEgOiIhuRMHAw/1wPafYMeMp8UZeoqFkIjJVgOFLJshguYsuG1VWUP6LbG21LrkWT9A7X3beKjEPyw1AYXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197272; c=relaxed/simple;
	bh=K8oeJDGJgKwCw/imZxnFtBFV9/YbnaYrRBrp4HEV4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O1xkOp8uMCBJfKTHeRLbSOmZtUUeFx7QSX5xzQnjh6UXFTiF9ed9qmkXPqZEvB/fGXpABEHx027w73FWUDmZ0/unY4Qmt3hdrxQ0bCWCF0VFhHRPisZiDquweT0hhkwfw7qvBsD8LL+bt03gu9jAvAKvOKEgXRoOHdPYrJXJPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRJKmXtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRJKmXtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BDEC4CEF7;
	Fri,  3 Apr 2026 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775197271;
	bh=K8oeJDGJgKwCw/imZxnFtBFV9/YbnaYrRBrp4HEV4Zk=;
	h=Date:From:To:Cc:Subject:From;
	b=MRJKmXtPouFgRJkUHjPBhMQSl0AcuC4UORK2yrPPNEjL+QI3YjIO9sifMe6OaITXL
	 KXi4fsN1zlBkNHqs3vvrGYeieJSI3bfYyWVwOB5gnsyBjqvj/45ZJRVH2C9bUdJCiX
	 HHLdXrAhWY+6UzGh+1uMMFliHm+kAuxOuURNrp5ECdBDI8llRpzBsfc1/fkn1AoddZ
	 Kapa6dZwtxQhUrEIHmzhfjUG4CRTJQiewl4nF0RZsgl0e13+P/5cSX6gZUqUmv2/9G
	 zISewfHts4dnKJiWQP/9rZ0DSF4wysvANjB6+awWKADSqPIxJKCr7zrtPV7oEzC3ku
	 rjtz+/l0ghk2g==
Date: Fri, 3 Apr 2026 08:21:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v7.0-rc7
Message-ID: <ac9aokZYJOTAW22a@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here is the fixes pull request for v7.0-rc7.

It contains a small fix to avoid using uninitialized fields
in dma_slave_config, triggered somewhere deep in the fsl edma
driver.

Thanks and I wish you and all the community a appy Easter,
Andi

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-7.0-rc7

for you to fetch changes up to 39ed7d89b973329cc5c764b65ba6302b17b1907e:

  i2c: imx: zero-initialize dma_slave_config for eDMA (2026-04-02 01:22:46 +0200)

----------------------------------------------------------------
i2c-fixes for v7.0-rc7

imx: set dma_slave_config to 0 and avoid uninitialized fields

----------------------------------------------------------------
Anthony Pighin (1):
      i2c: imx: zero-initialize dma_slave_config for eDMA

 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
