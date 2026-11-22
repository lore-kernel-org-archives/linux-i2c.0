Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795382814;
	b=3KsTx5QfNOmz+U+VUpUgN8eS03mKCJ+pVP6XipR6uE/RTxjBd0iR80YA4gOxgehLowZ6
	 BLgzrTOwEhNiZj7Qkoc/UJ4cXP8eWx+oc+o5p+lITYYq2nsEFSqJa/E+yNtUw/dizRNoH
	 YxfadmnQgKiKt9MKSi/atY2yVNAkAs54MfREEacNnyjR+eIpPT++0StdZvF/hLaRXcqs2
	 Oc4eLazsSMM0RkQTltYRo1oZELixb0aosUU5WmUKKQzlukt1pB7TBD9pAjyFQVxFl5eqr
	 pk2RUPB5PflyNwvAQSx2zKydKoHByLuy0J+ekixcW7wiZmgdFo0XyP1By4zX2vrDC7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795382814;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=jsDS/or0ZVK6HGVKSX4EnqK/vovBXxaPLUaDJcNOoUA=;
	b=3yFHrW4QDNzeTkG5mMylG9DiUJQ7eqiTnIzRw4rSVdcZzjIxreBs4i7BYQBiQKKhcUIT
	 MK2+uSHs6ujf/cNdRsVcp0pkteKn7Uor/WboM2DYCIDaPZoI48UCMZwY0TarpQqQZiHyp
	 QgkoZBo2USLvs/LBXsy/+A20uCqo7CPj7/SlEc0O2hVHgP6/bL2xzcRYI0+qmhkEfuOQu
	 msfukFAdaGJdgaoe1vNJncrmv3JXy2VFocPwvDqs1XM8H1OtnEWvwHGGEfW/5c/jbPfY1
	 8qfhsW7RBnftZA6VkddIBPd/Sp2k+Jsbtt21RxU1oN4g8aszTRn8f+/Aknk+5wHiQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xANBxYUI;
	arc=none smtp.remote-ip=95.215.58.51
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DD606A31D
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785DD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xANBxYUI
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Uow9eIxLhRXEAVGxWSlS7vx9hm4sdE+4FNVYGS631Rc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795382811; v=1; x=1795987611;
 b=xANBxYUITi9B5efgDjY21YP7+PE0dMcqBar8Ng3EmiStWfVHanEK6c560pHB4t/9gsezaBaH
 rvwhOT1xv/6Y/QStO/Re8XRrr8GbhcQ5ytx93CZbsQfCiK63G6ZX07+KW7qX58pKratQgFo8Vuq
 NBJqFOjimS3cokAJfeWpVizM=
X-Envelope-To: linux-i2c@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0d161315944e3b4a;
	Sun, 22 Nov 2026 21:26:51 +0000
X-Mizu-Trace-ID: 0d161315944e3b4a
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Shuai Liu <847807867@qq.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v7 3/4] rust: add minimal IIO subsystem abstractions
Date: Sun, 22 Nov 2026 21:26:50 +0000
Message-ID: <179538281024.9825.4132712997497273037@linux.dev>
In-Reply-To: <20261109155743.83740-4-muchamadcoirulanwar@gmail.com>
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-4-muchamadcoirulanwar@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Clippy shows two issues in iio.rs:

1. Line 332 -- ..unsafe { zeroed() } in VTABLE. The SAFETY reasoning is
   already written above the const, but clippy's undocumented_unsafe_blocks
   wants its own comment immediately above that specific line.

2. Line 408 -- unsafe { (&*priv_ptr).channels() }, drop the &:
   unsafe { (*priv_ptr).channels() }. needless_borrow, no semantic change.

Cheers
Igor
