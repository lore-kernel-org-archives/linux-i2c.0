Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7617A2EA
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761924; cv=none; b=eqJCt8J5xJca5pUFJJYOgA4EiilqySEQ7qN/fGcTq0CzBEjbjDFl6siQhY+q33y/oVfgnqqg1jV3SPQ5eB+Udk8xXy1yOG5H3Q9VdYpHpYjVPLwTfXEFlJsQB7sOyO+E+1l/B5zKr4YWAawOfGUj3IirotqzGcqHm27NNvlqSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761924; c=relaxed/simple;
	bh=n3noWi5XebMwrJuYQOTMStuhRUIPxLzPyjj2Nj+ZddQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OtLca6mx+4pGhKkLwFV9rlfwXMUJ1VET++bzVFKnS+2RrEVoskYhH1PKKUAvzA45qAtt3akrotZdQ0PtquuipBFJZlITtB1pYEbSwD5gLW0MaKj3+yfiggibwdb9HwSVbJ6r5Q8Lt4HsHVtLTEqbqI0Rsn1xvv+cVET5gNYzU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=un3WREqT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="un3WREqT"
Message-ID: <3f459ba1-3d03-4c44-a8f1-5ec939f9c0e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775761910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3vBca7wH1omGwKGYb7bsyXleBVMMZTmsn+rmVAChtg=;
	b=un3WREqTnCSfOmffWju+JkwWa4hFOawfUqsY5U850u8HQPpFuJgLF07yHXjac1GgSBC/Kv
	BZxua+dDmWog7rlYgfF5tEKevu9rjjWSRlW+M2bBrZrH9uhY1jrLSm08ZFdCJz+BX0HK6L
	aKKziVgEca6iAGwgE2sGguWuMfcM2GU=
Date: Thu, 9 Apr 2026 20:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, lkml
 <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
Subject: [GIT PULL] rust-i2c-next for v8.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Wolfram,

As discussed, here's the first pull request from rust-i2c subsystem tree

Thank you.

Igor

The following changes since commit 8fc326e15895c9f0403e6243dd4ad468b10aab3d:

   Merge branch 'i2c/for-current' into i2c/for-next (2026-04-04 12:03:01 
+0200)

are available in the Git repository at:

   https://github.com/ikrtn/linux.git tags/rust-i2c-for-v8.0

for you to fetch changes up to b388d1f9a51d3e1ad48e1d98bfe2ca5d022e0a83:

   MAINTAINERS: add Rust I2C tree and update Igor Korotin's email 
(2026-04-09 19:41:00 +0100)

----------------------------------------------------------------
Add Rust I2C subsystem tree and update maintainer email

- Add Rust I2C git tree entry to MAINTAINERS for collecting patches
   to be submitted upstream via the I2C tree
- Update Igor Korotin's email from igor.korotin.linux@gmail.com
   to igor.korotin@linux.dev in MAINTAINERS and .mailmap

----------------------------------------------------------------
Igor Korotin (1):
       MAINTAINERS: add Rust I2C tree and update Igor Korotin's email

  .mailmap    | 1 +
  MAINTAINERS | 3 ++-
  2 files changed, 3 insertions(+), 1 deletion(-)
