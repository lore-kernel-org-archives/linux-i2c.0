Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D203FE35D;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510244; cv=none; b=CvzsD9PY3wtSRTFZryKSGzNZ7gaN7tR1aTmbkmgNl1wxb3Dmf0dO8VyBUoIocPyKTrhLhN3sgy7+R6uClpqwhLwtovFSms3qpksvrfxYsDslf4TLhR+9r8KQzDrcJWbBrUnkyJ+qNr6L4NG5P668KRfZX2NvGwoDveV+9ERHlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510244; c=relaxed/simple;
	bh=YKrnQC8fFwK+oR/tjBSkarGTglJyDUnt6IZ1Dvz9i04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7/75g4U3Ep8SXypd9MtYWmKlNyumVp7U2u3WidQeGgV9ss3INgL8xEemR5hnArpOsR+l85Vss0YeRAmTqW2VhRltcof0PlukDjvOKkeVohP+b9tfo+OoWxeskc3IGkU7WOpPUbUy2r6YHCTJfMVx7Awk3oYnfR0oxlRKq1ilHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/5Hjq5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/5Hjq5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90121C2BCC9;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=YKrnQC8fFwK+oR/tjBSkarGTglJyDUnt6IZ1Dvz9i04=;
	h=From:To:Cc:Subject:Date:From;
	b=p/5Hjq5nk2i5vEtLjCVzXktD48iDVu7bElqmrBZ4EJMx2hDcy/k0wKGvCTK+smrU4
	 7GOJXvxxArMEPBUgsxLJhNefBHonKnkfSZ9FKWkjjXVyU2sM4iLuNxQs/foaqqDI3n
	 e8zynLY/I6vfud4UWUTqkzSW+psqoJSyu9YpSUWsLwik4+9qdaOxlRgSaHuMz7vsWG
	 tK50ggd6zf3F4myJQupQRLlObvHTYvC6HGHjxgAoQoWFq+JdXQoD+37rSOqZBAB4q4
	 5RdLeHWZXx4ttPhBi75AJLExz+EzKHIHHPKbvcXhLsiU9ckFkGMia/jjIWbJaOlumP
	 KWSG1yW0koxjw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033q5-0W7P;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 00/10] i2c: core: adapter registration fixes
Date: Mon, 11 May 2026 16:37:05 +0200
Message-ID: <20260511143715.729714-1-johan@kernel.org>
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


Changes in v3:
 - split NULL-deref fix from probe loop fix (2-3/10)
 - add missing adapter name error handling (5/10)
 - replace adapter in IDR also on registration failures (8/10)

Changes in v2:
 - fix irq domain leak (new, flagged by Sashiko when reviewing v1)
 - add adapter to IDR before registration as needed by i2c-dev
 - honour devicetree alias also when using i2c_add_numbered_adapter()


Johan Hovold (10):
  i2c: core: fix irq domain leak on adapter registration failure
  i2c: core: fix hang on adapter registration failure
  i2c: core: fix NULL-deref on adapter registration failure
  i2c: core: fix adapter probe deferral loop
  i2c: core: fix adapter debugfs creation
  i2c: core: disable runtime PM on adapter registration failure
  i2c: core: fix adapter registration race
  i2c: core: fix adapter deregistration race
  i2c: core: clean up bus id allocation
  i2c: core: clean up adapter registration error label

 drivers/i2c/i2c-core-base.c | 173 +++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 73 deletions(-)

-- 
2.53.0

