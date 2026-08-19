Received: from mta0.migadu.com (out-243.mta0.migadu.com [91.218.175.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4636C592
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174890; cv=none; b=Z1KH9wyK95WLBjq2qi3hPnvPhXG+kzeXDgkt8VUjhHodksFBBFMYtljRecO1D6O7jXV7XLQeW3JkEaGgILag8ZG/tD/hZNxTHki22TKvu8WzUX+/q0Km+pEH6BV4NA5Z4SLSQhmlfx1IeCmPLFHQaX2pUCgc0LUv38bcuvqWvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174890; c=relaxed/simple;
	bh=H5a+lF2Of1lJSMP6LcaW5/240bAK30koiCdiuaHbJ20=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qm4oE36jhKY1A6lAdTp9UdmIPAWmrc8XCd4acs2RYAWenwn+drHkxrtwaB5fzn7VvCyzDsPN36UG2xFKe9ZTpzAlA0GMcEI+ZZBEaMCI4+qhfEKV44KMaG6rUdyJLWON+IZ0LD/Ls3Q5LJwIMA0njLMLBX5h7y1TNuIbs+dEWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSkjUgNo; arc=none smtp.client-ip=91.218.175.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSkjUgNo"
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H5a+lF2Of1lJSMP6LcaW5/240bAK30koiCdiuaHbJ20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787174886; v=1; x=1787779686;
 b=oSkjUgNoEAIn0XywfqlzDFR1v8KwTeAKf8pgT1Qh5/+h5zrd2ZW0yhbsVIMbGgdxk/+4iM6/
 HyRkN6qowE7dl99/peQZufThh97c5GR2ZGfWrZvVHjXrx4IiSrGIhL9TDPVAoS5PtHqz41DA56K
 WhDO3UPMLJ8tEU6kekavcVdA=
X-Envelope-To: linux-i2c@vger.kernel.org
Received: from Vasilio. (90.193.199.60)
	by smtp.migadu.com with ESMTPS id 17abddbf796f79fe;
	Wed, 19 Aug 2026 21:28:05 +0000
X-Mizu-Trace-ID: 17abddbf796f79fe
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL] rust-i2c-next for 7.3
Date: Wed, 19 Aug 2026 22:28:03 +0100
Message-ID: <178717488339.2840.16053648973983973210@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andi,

First pull request from the rust-i2c tree for you.

Thank you.

Igor

The following changes since commit 527dd7fb6209857f8ff4426055b3a418e60faa8b:

  Merge branch 'i2c/i2c' into i2c/i2c-next (2026-07-29 23:40:39 +0200)

are available in the Git repository at:

  https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3

for you to fetch changes up to 61ddec70c9bcc3d4b0471c8683e57d3b03cecf0a:

  i2c: rust: mark I2cAdapter methods as inline (2026-08-09 12:04:34 +0100)

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
