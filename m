Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A0175A74;
	Tue, 23 Jun 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196761; cv=none; b=FkFFrl3CQo7GCxtC++DKjmaUENUmFPQsYEdQizGl/CJnRZi6LS6dvwDJxBsmLkBZJlO40XgftHE1q+xXjjFxa3/r5mo9Ihi2Yn0f/QZN/q/y01SnnvhBU5JUcN6DAB32G7j12nkju6kj1whRakIZFrqk3XseOg5V5yKWHxsSa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196761; c=relaxed/simple;
	bh=Zd1XDe8g7ike8eGHQv4Edo5nFNNZOa69Tu9R5cuUtEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r6dnZaPgbr7yNQAE8xC6qcQXa8c7dY+A/25vgQvNL5PBMcHETw8diAaC9zAilJ0jnVay3evzUXKbO3XH2kx5JtNQUkl5Dp/h5y42aoLl2O73gyMQXLLebIS1M4M/iWtfCYqzh6NhcHQIJUE0zVhzYkVi2LbowrNqnMzkMtoYf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=DsAn9+Bb; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="DsAn9+Bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1782196718;
	bh=Zd1XDe8g7ike8eGHQv4Edo5nFNNZOa69Tu9R5cuUtEw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=DsAn9+Bbph3D7XQmUw2hXBqfTKXBs/Mm2XZ2scYPmS6d9rpjeSKRznGXmsW1G+Csq
	 PEM4CgEL8Le2RyAo24D+kFr0Ynz0cjxIn8s66wAi5ezuWIKgYnCwGhlyioc3FK8rbM
	 eXeDUBq9Exvu1ggyWbLKHJKIJZhgXR+5ee6xYPKs=
X-QQ-mid: esmtpgz15t1782196713tbe179882
X-QQ-Originating-IP: BNVmBHKlazKuOCJTGVqBkVvlf1Yt2DUDZVZSvhAmtFU=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 14:38:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16372566334252933970
EX-QQ-RecipientCnt: 5
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:38:30 +0800
Message-Id: <DJG80AA3AFQ2.2SQ3ILKOLW331@linux.spacemit.com>
Cc: "Andi Shyti" <andi.shyti@kernel.org>
Subject: Re: [PATCH v1 1/1] i2c: k1: Use generic definitions for bus
 frequencies
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nvi1nD8XUapZk9Oj2K7D1sfMoCE2qfGPpZbNeULIpCzU4BADrlbkXJn0
	LTeMOkfLqrKJRLehCYSufYtC+Cq+2fl/iDN30EAIwT8FYgPbBScvEcHD0tn6mK/iT+S7zeS
	95br723RPJ9Dc7RX+xFJV5Q103ji96Xv0WwxxaohqBM5cEuzu2Y+JRbrBNG1Ncaq/PCHUoL
	iaNpyY6iio9wXFTs+gQcPEsARoe48x+yXx56f6ji0gEcxAogjHBYZMFMP4oHlf3B4FAY6y4
	2A7Y/9StRQO3lTetTWUXQwb51BHMQXJWv0yH5m1PIrGJE0w7qq5KFFR2a/yRCIve6Eq5ofY
	f8nwXGAZ40edrV6yfu+ooYia+iNKVwss9d6gyktMuUr1vI6mCirohm0Y75c+tLgz8GzsAUE
	aa4AuHN+8QbMMtHsPxaodR6SvI6nRTynovZRKQfREfwYIv6DsiJE0WHFOX6nTRsIvlXKU0L
	vCygGZp5OjQJjAgeqkBlar7zvoxIlUCBq2xkgVixEkoGN3PhqGBGKhdjbBU4HRO7qVzzDeY
	K/xD4wIxL4EqVRS+hKsJkPNfQW3PfwUiaoWNtMntgZ/tU2YSuEf7MuHliaHjoUycJ/LZfkk
	e6t89wg3WAYU9A2GmQ8+0KVxSLx4rr0YudFLMUrdi4H4N/GJd0IKVpV+1YQUfPttD+D/kLU
	Hg1AaUUI+y+INN8TDin2O2RNbOf3WBXVpfyVbG9fgcA8/hj+0VdEiYETiVlWf0Xf2ocY5Xx
	1tGa1wKOqdvlPzJhQ/Zp29CFoMFx/4u2SUk+Q3MbVtbVODAJoupl2giO9bEyKzT5L7HOdTm
	4pBM54OXOK/DnbFnyWJFdsklTsNpSSoLO7aToRTjbbtOLmUsmwgX5wvDsbNM+uOQRuvGtxX
	xjxJLjCdg4aaEMM5NDaX0ympblaOOMnFlqQXVZqDi0JRqud4ZweQrk5Oirb0HA+Gk19P8l0
	dk7CX4AYwKGxSNodr90tGKCi0yov8xUMSv5DSe8kduzVVwy4GpKV17H23ttYL/7+2PZm8n5
	xlsDsF6HtDsumEity4DMT5NQTKYx0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Thu Jun 18, 2026 at 10:11 PM CST, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
Thanks, Andy. Indeed, this macro was introduced in e6282fc6f889d.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
