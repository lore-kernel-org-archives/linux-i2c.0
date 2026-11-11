Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409108;
	b=x4fuFp5HUK0FMmUNPlP+Vx589/Sd266DjVcnlNoeVKSWyjcotr5rsRF2yuWj1uFUi4FV
	 3J8NkJZr+BLVQS4dBIyJm5W/eTAnFBrsPokysGgR95CVjM0qFkdKuVqy2+Xgi3orASpX0
	 hCX52t+zDBoaC4rLbtKcNKZHmhnOwLz0W2FRfgoUsE3O/+e0bH4Pm9z4em0BOKRwiltFC
	 jVMiUoTJPnGz6D/pq0XNEMPTbkuC6w2qQIWXF8Ldpz+Cw4l8WdM4EJ0szJgTslk/7uJ+v
	 gMXW3qTCtyuj5zClqj7g6Jgu/qqCTuExTq+z6LKIuKtNfDrfUaqZzZKj5iCF9OBIp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409108;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=byL/9IM6xgjdPi5Ss/cz8AdXkgWexIzqBw9kg9a3atE=;
	b=2ujyoSXRg2KTWITNg3QqVobAnrkAo4wrFuGlfNy35KzKzLZ0/i3Sy7vB8HZE0SUcf0ge
	 iytnz/mpZSKckyCO5tPCz8MXXmnVOeZklLfplhJW0Hn+p851yseRAKTGJ1WQ5ecc7gAG1
	 zsDUCUtxOxwT4g8PDhFQCtpGlg+kOAKNNmS/MiLixqC2cVKZ5tMTyXlVkOX6DjtcnCkPo
	 svPomXLnxUuUjAGCQcQzVRFZMDVHaGeq3Qe4G4FZwtW0FIcIh9HRfRadQLOzarbrvrish
	 wOXUTDFY7FrIF1jZ2JHVoPCppDup9l6NXjVaz/tRKqFr54ucpV91XCjbYdyG2LvyF8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bT+MHnvQ;
	arc=none smtp.remote-ip=95.215.58.223
Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191B606A88C
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 14:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D191B606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bT+MHnvQ
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=byL/9IM6xgjdPi5Ss/cz8AdXkgWexIzqBw9kg9a3atE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794409105; v=1; x=1795013905;
 b=bT+MHnvQe9RepUohkjLvksKWNYTiu9JXdRJihGeN0HMqqisGTdqqZcz1xNgKsA827RcFkb63
 WWt7b7ifDkmoOv7E7hf3vlPcmr4Ka76BCwQiGJ5voaBXLUz/iOaS6VnoGyAitgfo1xVgJYMgtDC
 SYvUJDspR7Ee94EHcIQFUxyg=
X-Envelope-To: linux-i2c@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36196609946a065f;
	Wed, 11 Nov 2026 14:58:08 +0000
X-Mizu-Trace-ID: 36196609946a065f
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>,
 Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Wed, 11 Nov 2026 14:58:08 +0000
Message-ID: <179440908805.1963.3189482737225975976@linux.dev>
In-Reply-To:
 <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
 <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
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

Hi Coirul,

Sorry for the slow reply. Co-developed-by/Signed-off-by is fine with me
-- your call either way, I don't mind.

Cheers
Igor
