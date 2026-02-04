Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FA3446CF;
	Wed,  4 Feb 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224600; cv=none; b=icJOTRgF02DYJT7OjqV8TMrSjr6SvFbL1vc5TmG93QsKMy2CNuUPDC4naBWzepWi2/O3yPzPZPOuUqn4P/ClUhbnKzsGBqqUjPvoRmlBFzytClecje7SjqAf+AInYZPNOV9mku3PlysJZs2OTa5FKRoRFrBoEjjcBRXeXXMMRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224600; c=relaxed/simple;
	bh=1qQ08ttRG6Xs0ABm9xGHeXkt1XJarlrgfFONUPUgsRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Sod4mpn8Ec7tr12D4g0a4j2gaU9fGJdH7+Gc9GrFMsZF2zHP+yTYW14QxlRRkmHB/uXD9ibYTaChkTEfeFFIVimbjU1VraR1lyDFhPLhNq2I0RAp9mmNYAa3Ww6vlS19ZbmwyXnFqf7IicavcLNBN2PJ3jOMjZtGYkPjvOjuqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u64mNmTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u64mNmTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F2C4CEF7;
	Wed,  4 Feb 2026 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224600;
	bh=1qQ08ttRG6Xs0ABm9xGHeXkt1XJarlrgfFONUPUgsRc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=u64mNmToNIK/DeDyNGPM7pnI+wG3Cfplj53lhTjynrHMlYVtoZDSAO4dCpb6HljZC
	 gsaXsb17S+KP86zctmDE80k2HWx4Iy7JO1HUAG3LC4X+QXdccA1d3pl6FWu/+UMvNA
	 JTWuifrDFYoXJaeljbBF0tPPHeEhSO5oodWo8s2NasYwDc860RRttAor+hzXVwLoML
	 XamFhzt7Om7zNqOv8JSsfwoGnMS9nw54BZKLzgzumvwdgN/FmkYLd3hTOktcn91/Af
	 rU3N7zN7TfYFDjMbK8kkCnn6p+L/cAmhnNMkM1NlVBrR1jnDfbfZ/zobYduRP+qGHX
	 rNw4HcrkvuP1w==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 18:03:15 +0100
Message-Id: <DG6C8WCFHEDC.1XPP6ST35HRG9@kernel.org>
Subject: Re: [PATCH 4/5] rust: i2c: add I2C wrappers
Cc: "Markus Probst" <markus.probst@posteo.de>,
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Wolfram
 Sang" <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-i2c@vger.kernel.org>
To: "Igor Korotin" <igor.korotin@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
 <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
 <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>
In-Reply-To: <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>

On Wed Feb 4, 2026 at 5:49 PM CET, Igor Korotin wrote:
> `Bound` can be safely dereferenced to `Normal`. Since `Normal` represents
> the minimal required typestate for device operations, any API that works
> with `Normal` automatically works with `Bound` or `Core` as well. Requiri=
ng
> `Bound` would unnecessarily restrict the API and force duplication or=20
> unsafe casts.

We cannot allow drivers to retain access to device resources of unbound dev=
ices.
To prevent that we never give out a pci::Bar or IoMem instance without a De=
vres
container.
