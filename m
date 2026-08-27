Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9D3B71C0;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821725; cv=none; b=dB58bpKHKag1UahEPvOJwTmAM9D+1dI1pCLWvB+V4Z6hfm09q1ca6Yk1ffff7qcTlyy+fHFTznuhYQ0nMEOncqsH7/mCOgDgOGOodPw6oui/DVuAwUnwuNCYUV/MQahKKg6+9SVz3h23065p4Mv8/JricwEYlQ2OpNX6Qk+Bt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821725; c=relaxed/simple;
	bh=wrUkFwnM+R07bwYLdGeFKD6f7cCxL8V0HhE9wAhAhsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWQCou5CQmh+6+7fpMNSL3yG4sDVijVnX970BWv14GDOoD6DWglcp2N+SVqNPBhFp28cqSoFVDgpTQ6kZAaC6DPbz47xXwr4u/TR51AOLBoeC/y02hU0OUVoZZ3sPav4HrG9xAbPjwS3QCx3GmpF0OGb4mJ9yelkb62H14oyliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFQJEyMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFQJEyMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B321F00A3E;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821722;
	bh=z2B/sO6n1rd/Y3SEpkWHwaRbIGjo8FB6XSMqx1GnY7Q=;
	h=From:To:Cc:Subject:Date;
	b=YFQJEyMMQqla8HlzhpENEhuVWUD/DX1FyXDo4oojjdKtvid6Y4XHWL0MsJpBujd32
	 Vdetn3noxRoa86XF1fTAR19W5vDk3OJaHbWEoJ4/S2cWBgfpRz/gSQZ30IFwEL+zaE
	 awhpHOKYRi3Mo3cghEX63+guB79d1Whfa+yuO9IxppjSoLHqavENFuy4ni6cjjTfbB
	 dBmIm8Yw0bJNzrCJ+tcuFYkIy1RE5mXLEhJmHbynYwtstELXctLT8yYqWikR2BuyEQ
	 o+ASxSlA3yfIHociwS11CSQ9jaAbuK2KBAQwunEqbXA+gsG1GHTHlhrWCDHtEkcMh2
	 JG5Nuae/yxqUQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzW6C-00000002g8D-0k9M;
	Thu, 27 Aug 2026 11:08:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] i2c: dev: fix blocked adapter deregistration
Date: Thu, 27 Aug 2026 11:08:01 +0200
Message-ID: <20260827090804.638565-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of addressing i2c lifetime issues, this series fixes an issue
which may actually matter to some people, at least if they are playing
around with USB attached i2c controllers, and whose fix does not depend
on any larger rework.

This could possibly go into 7.3, but can also wait for 7.4 as the impact
of the issue (both in terms of number of affected users and symptoms)
should be limited.

Johan


Johan Hovold (3):
  i2c: dev: fix blocked adapter deregistration
  i2c: dev: drop unnecessary sysfs device lookup
  i2c: dev: clean up registration

 drivers/i2c/i2c-dev.c | 155 +++++++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 61 deletions(-)

-- 
2.54.0

