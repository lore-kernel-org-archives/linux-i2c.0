Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CD41325C
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006925; cv=none; b=bIAzBisnCUVPQTALJlnzlA1d5/PnRzsMxYGn0SESP0iU3lRUOcMvWYbNqim5VldCP3a3V4/g4hRrVXosmctZA82Cc+Dg4joFnx0CZ6IobSWD/TmQ8awPrshCDSRnT2VomkYRN+Xn7wxbKiZE+cKnenJ31TtFbgL6Y4YHHr0vK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006925; c=relaxed/simple;
	bh=Nqf3YO87WrzNM7BINtAtbxa7Cdud+kVMGo0EvPdnscA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BUaA1y9zlcTKReUxnlowX2qjcI0/jfMpyroQ7c+02tvtWl87XpGZU4tQi+wqk9K2yG12vf8vYQaKC3foDI/TcFIbc8DHXgLhpCG3P78YcUYfNkz4ITDO/Ez9dKBz4UavRQng3cN8onry1ufla7XxgnRLR0HsmZvVU/eDttGYoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8ydkJ8Q; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8ydkJ8Q"
Date: Tue, 09 Jun 2026 13:08:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781006918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqf3YO87WrzNM7BINtAtbxa7Cdud+kVMGo0EvPdnscA=;
	b=Y8ydkJ8Q7hKiAkSBYm2L1fsTLlc7q6yC4yt9ROlmA5zV0wfixbVwGG4h3kcrF0VJE9qyem
	cRZll3fqnQ1E6+MfCjXT/2NZo3P1ouC24Ja6X12spkE2gN/b9ldBiImbCB4/vt2H4ohG7b
	CB6vy+umI997iqhYjb3f6Cyf5+YwVZ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 rust-for-linux@vger.kernel.org
CC: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [GIT PULL] rust-i2c-fixes for 7.1-rc7
In-Reply-To: <aifcUBtuker3f9t2@shikoro>
References: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev> <aiZ0eD-A2F8woqTb@shikoro> <aifcUBtuker3f9t2@shikoro>
Message-ID: <5633BA97-5666-45C8-A024-87A737A4086A@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT



Hello Wolfram

On June 9, 2026 10:26:40 AM GMT+01:00, Wolfram Sang <wsa+renesas@sang-engi=
neering=2Ecom> wrote:
>Hi all,
>
>(adding a few more people to CC to have a potentially bigger discussion)
>
>> Please be already aware that from 7=2E2 on, you will need send pull
>> requests to Andi who takes over the I2C subsystem=2E I will write a
>> seperate mail about the handover later today=2E
>
>Done now [1]=2E On a second thought, after pulling in the I2C abstraction=
s
>a few times now, I wonder meanwhile if the Rust-tree wouldn't be the
>better path to upstream=2E The abstractions are way more Rust than they
>are I2C=2E And potential merge-conflicts come from generic Rust
>abstraction updates, not from I2C=2E
>
>This is Andi's choice now, of course=2E Just wanted to give my 2 cents
>here=2E=2E=2E

Thanks for the heads-up on the handover =E2=80=94 noted, I'll direct pull =
requests to Andi from 7=2E2 onward=2E

On the Rust-tree question: I don't have a strong preference either way fro=
m a workflow perspective, but technically your reasoning makes sense to me=
=2E As long as the changes don't introduce or alter any I2C-specific behavi=
or =E2=80=94 and so far they don't =E2=80=94 routing them through the Rust =
tree seems like the more natural fit, and would avoid spurious merge confli=
cts driven by generic abstraction updates rather than anything I2C-related=
=2E

Ultimately Andi's call, of course=2E Happy to adapt to whatever process wo=
rks best=2E

Cheers
Igor
