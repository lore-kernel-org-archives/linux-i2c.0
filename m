Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBF3BADA7
	for <linux-i2c@vger.kernel.org>; Sat, 11 Jul 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766073; cv=none; b=lbrwGeJsXPV0qTciTERfcusWfdyjhFhzzMOEtg6uQVIjNwHF6XTUMOTY5OFOFCjqJeGZJnGgEyqOv6Ru0UfJpDbIlXaLW5JPuvVCKL0V1oQm1bz8KRqNrUmlJM6GvEKtEiFprZ6qDuyPBU64LbnFQYZ6svDZQi/TOoEpHv76+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766073; c=relaxed/simple;
	bh=M4wMGAyEGwO/BYf2g7dMc+CI6AztqNnw9Q98ZbatvKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:
	 Content-Type:MIME-Version; b=JRN6IbB3S2nsWmvH7xphK8c814eBoNWKaU0ps8hC+I11krA8MDorTXT5HrvtFcu8xq3Z8aKCVK9mGAQe2WBlEKCa+tWJkRtihLVAva0qPh9Zhlvd2UeGWfb87SH5vHXYAfAhxk8cT3y/lXXxURIV23HqfXa3RYvtpNCvEG91PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxnlLyWN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxnlLyWN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783766059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4wMGAyEGwO/BYf2g7dMc+CI6AztqNnw9Q98ZbatvKo=;
	b=MxnlLyWNuBnw97dOyIznI7YCQpzjHjgoAInIVRj8wUUwS3TFmZiyjvTILUXH3HlLIpzbPb
	dlxIP+QQ4QxIoJWBK2NerUzOypFGD4stTikAPXkeEUkEoCUugEhQ3ub4oMc0fxuxs6Dw3C
	JlaPngMcQRdSry4l3W/0jQz/H/RBmm0=
From: Igor Korotin <igor.korotin@linux.dev>
To: rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, Tamir Duberstein <tamird@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Bruce Robertson <brucer42@gmail.com>
Subject: Re: [RFC PATCH 1/3] rust: i2c: add SMBus byte transfer helpers
In-Reply-To: <20260708214738.25008-2-brucer42@gmail.com>
References: <20260708214738.25008-1-brucer42@gmail.com>
 <20260708214738.25008-2-brucer42@gmail.com>
Message-ID: <178376605131.22511.1602274538745913609@linux.dev>
Date: Sat, 11 Jul 2026 11:34:11 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Bruce,

Thanks for the patch. Same feedback I gave Muchamad on a similar patch:
I2cClient should implement the `Io` trait rather than adding standalone
SMBus methods like these -- this was already agreed on previously [1][2].

There's also an in-flight series doing exactly this rework right now:
Muchamad's "[RFC PATCH v4 1/3] i2c: rust: implement SMBus read
abstraction via kernel::io::Io for I2cClient". Worth looking at before
reworking this yourself, both to avoid landing two competing
implementations of the same thing, and because I've just raised a
problem with that approach that affects this patch too: overriding
try_read8()/try_read16() isn't enough on its own -- the generic
try_read/try_write/try_update entry points still silently swallow real
SMBus failures (NACK, arbitration loss, timeout) unless every one of
them gets the same treatment. Your smbus_update_bits() is exactly the
kind of read-modify-write that's affected (my reply on that thread,
Message-ID <178376430529.16552.7043868463863908196@linux.dev>, has the
detailed breakdown).

I'd suggest holding this patch until that discussion settles -- Cc'ing
Danilo here too, since it's ultimately a question of whether
Io/IoCapable is the right abstraction for I2C at all -- rather than
reworking it in parallel.

Cheers
Igor

[1] https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34=
cd1a@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.g=
it/commit/?h=3Ddriver-core-testing&id=3D121d87b28e1d9061d3aaa156c43a627d3cb5e=
620
