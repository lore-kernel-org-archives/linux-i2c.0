Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316B35295C;
	Thu, 27 Aug 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826183; cv=none; b=qLMWnRG64N1OdcbqblTRAXOkTwR7rKflIXw9soXjCuvTFtxLtToJmtGgX9J5cVmSIgawtJBkLiSjEV4L1nJ9RDsndgbDoxj9zop8jDAsEpQ7UCXkYJnZQ/+u2VCfzOR4uu7Jlst9CoF9dF/jt92UVxXCzCdbyhq0pJvC4cz4zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826183; c=relaxed/simple;
	bh=aSgD6wiChUmhxC0Hp5eqrUp5tos0OiOgdR2ZS+Kr2hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3qA2g5zCQrLAfrE4Z/+SJib/jypA1Hgy7zzqfV5hQTDrXSDnlg1FC2K/EGodkDr4CL1JZw4JQY7rHb1G9/99fKB00nX4WFTIBVwxy5AMzKW3KOyRzNnIlVrC2APV+3WdmdtWBSCeiyZ9utmVc+Q1EfEJUw7WGZaA6T9RdoBIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ7mIYN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ7mIYN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D81F00A3D;
	Thu, 27 Aug 2026 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826178;
	bh=E4hblX97bTeZePzi3MW6i3mCj9dAe7r+0Pko5Pm6r2M=;
	h=From:To:Cc:Subject:Date;
	b=iJ7mIYN4dSYwQxLVvD/vRSTuMj+JNwDm9akLOQSKChQF43nO47VpQliYQeEh2TqpC
	 krOPPWYElNceRPxr3YivNSqu4y/wHmAWLOjrJvLZdKXa2xFhpAPVKCsG9d1lLCex3/
	 YJ6D/iX5U9Yv25tPxrlaC4kiAxWkj1woR6pG6MB37pKFJMZ5YzznPR0/qpkbK1x3OB
	 5EFrJGHknd8BKZDoJ3mT4GpCHE04RKHtyz/8l67Sifq41IBYIg1/b1I8q4wzERmB/n
	 5Z/XnIodxjZUHd+nTq7LCbnpGeatI4zj/KzQK6RhFZ/6fn91DuFp7nkMZaZKqajs6h
	 NPVskjtYMxWvg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzXG4-00000002pBz-0zyu;
	Thu, 27 Aug 2026 12:22:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] i2c: dev: fix blocked adapter deregistration
Date: Thu, 27 Aug 2026 12:20:40 +0200
Message-ID: <20260827102043.673273-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of addressing I2C lifetime issues, this series fixes an issue
which may actually matter to some people, at least if they are playing
around with USB attached I2C controllers, and whose fix does not depend
on any larger rework.
  
This could possibly go into 7.3, but can also wait for 7.4 as the
impact of the issue (both in terms of number of affected users and
symptoms) should be limited.

Johan


Changes in v2:
 - take rwsem also on open()
 - clear adap pointer also if chardev registration fails


Johan Hovold (3):
  i2c: dev: fix blocked adapter deregistration
  i2c: dev: drop unnecessary sysfs device lookup
  i2c: dev: clean up registration

 drivers/i2c/i2c-dev.c | 162 +++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 59 deletions(-)

-- 
2.54.0

