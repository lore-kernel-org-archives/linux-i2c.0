Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAD480333;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=XOw/8dudE/i5QYj7F02O456ERvTHsmZDWrzhZzWks+DMnDW1zbg8m+fpfFf32WrJlO5D+Zohu4pPEF53dQei5dXY3pFyw0W6TmOo0ESxC74TSdA51Azza30SbOYAi6VyOv6yv6eAZxEcPZpyqkp3i5v3xNbmwSCZcp8PhzdTfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=uvYFkySG/K6NGjEHDPK4DqIo2mfvMalgBlwyJKCEUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjItGwpCjKXmwn0mowJdk2oBgVepRELhgOsge5vm7kaP9QmCyqGZ7cYy3JJ5oxrAphit+WCgTEf1+FhP1OsaMVkWpUTeleHZNH1CgzsHzHtvdJKUNF3YYw/eZcjLlhcSsrvEA/hHu5S7+N6zdwZnuX05LCGAp/dBuV3J0l4o2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H91pZSct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H91pZSct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDFBC2BCFB;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=uvYFkySG/K6NGjEHDPK4DqIo2mfvMalgBlwyJKCEUsg=;
	h=From:To:Cc:Subject:Date:From;
	b=H91pZScty490dHWf12L6P1VYVdpW01lA7qNSwhLJhs9dTCe2eDpD6uC8RehvCI55Z
	 u/hYwI3bAxeIJomS+9dbhYzPUc8WBuUvyIgnpTCp9tSb3VTTCo+5XIEK7Jv+vFoIki
	 wehXoyb5erzczy+QDsDcu/zCDsBXCpKtZPeMPWnqQOJUk2pkvMOO18DUMbizACpHOm
	 OMZVtEzN8PoAsyrWIQHfaYmZDuDydP5PTG2aXLTwgOp6PVR8gDPR/Xh87J1l6vgWkd
	 CssgGXY5BXVm1S8Q8ezxu5IjQbLm2VlI5CzfuvYmuUImpkENRuXU9Qi942adaFwO9Q
	 6P7bgIZpf/rUw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Ksq-0JPo;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] i2c: core: adapter registration fixes
Date: Tue,  5 May 2026 16:25:39 +0200
Message-ID: <20260505142547.795054-1-johan@kernel.org>
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


Johan Hovold (8):
  i2c: core: fix hang on adapter registration failure
  i2c: core: fix adapter probe deferral loop
  i2c: core: fix adapter debugfs creation
  i2c: core: disable runtime PM on adapter registration failure
  i2c: core: fix adapter registration race
  i2c: core: fix adapter deregistration race
  i2c: core: clean up bus id allocation
  i2c: core: clean up adapter registration error label

 drivers/i2c/i2c-core-base.c | 164 ++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 74 deletions(-)

-- 
2.53.0

