Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3F3BE643
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787398739; cv=none; b=APexMjW/AtiBOCCgDIN207UJ94RBacv6w6pzyJQh0CSHmWeUWBPG5tjjfLuVecUtuWHEhf9OjB8HTbygnL1eed9Miu0Fk1gRPR7j+45hWo2LocXGM/91oiS3zPPN/NtgeR20t7rfB5AbJbDJG6jgRQMgUn2M/t94c2ngnl322mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787398739; c=relaxed/simple;
	bh=6vraq3QEPbFs95hq4rBaV2iqWPM/Nu7KXs4yvsug4GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YpdIfDPBK4nl9dflCcs8YFNypDEhr8RqX+zSZlEEfZjxEYhKO4NrlCYXD8Vau7sammK8dRiCHd/k9Uvl9baUA+ku6L6duT+y5tRZa9gP0tMCRhnsNY0iwjJDiKUlP6am0kqBR85vXmLC5XZOlfCvbBSrHcsEPNNx8ECgsCA4f/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uh3oHt4u; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uh3oHt4u"
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6vraq3QEPbFs95hq4rBaV2iqWPM/Nu7KXs4yvsug4GY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787398732; v=1; x=1788003532;
 b=uh3oHt4uWxS6t9BtYkfhMPzxH+KYU6GNkT1uVPkAPtBczSjycrBjls264jNsifX0ZB6SCKZw
 egpVF0r7q0YPnnPWn2tUN4MLD1L2g2dN5rTF2TPD9+5Sp1+kxdQZC9dwo3xUrNSvezfHg3Mg2WZ
 npbet5Dre8FtKGQFvQp31KvM=
X-Envelope-To: linux-i2c@vger.kernel.org
Received: from Vasilio. (90.193.199.60)
	by smtp.migadu.com with ESMTPS id cbf5556634461e63;
	Sat, 22 Aug 2026 11:38:51 +0000
X-Mizu-Trace-ID: cbf5556634461e63
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.3
Date: Sat, 22 Aug 2026 12:38:47 +0100
Message-ID: <178739872719.9834.5401695033021882071@linux.dev>
In-Reply-To: <aodUPU8RGR1ZJlQm@zenone.zhora.eu>
References: <178717488339.2840.16053648973983973210@linux.dev>
 <aodUPU8RGR1ZJlQm@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andi,

No problem, rebased on i2c/i2c. Updated pull below.

Thanks
Igor

The following changes since commit 7a79b02dd1b09c235c3cf6075bccca2160d1b826:

  i2c: rcar: fix reset handling for Gen5 (2026-08-19 22:07:13 +0200)

are available in the Git repository at:

  https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3

for you to fetch changes up to b5fa55ad007059547c9139d4c4872e158ae255f2:

  i2c: rust: mark I2cAdapter methods as inline (2026-08-22 12:22:27 +0100)

----------------------------------------------------------------
i2c: rust: mark I2cAdapter methods as inline

A single cleanup for the Rust I2C abstractions, targeting 7.3.

`I2cAdapter::get`, `inc_ref`, and `dec_ref` are trivial wrappers around
`i2c_get_adapter`/`i2c_put_adapter` and were showing up as their own
symbols in the build. Mark them `#[inline]` so they get folded into
their callers instead.

Signed-off-by: Igor Korotin <igor.korotin@linux.dev>

----------------------------------------------------------------
Nicolás Antinori (1):
      i2c: rust: mark I2cAdapter methods as inline

 rust/kernel/i2c.rs | 3 +++
 1 file changed, 3 insertions(+)
