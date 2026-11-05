Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868160;
	b=KcLeQYLLSdDVEWpi6wb+XWVvqjJD3AWYV1r0uCyMdO3CR3wdB8vW6MdIn5W+a5ND8mAc
	 AMqgu9IqkHfnxUnQ+47wlsa0JmxWxH1ja0HzKep1TidCQmT7vA/9aCah7CD8EWzHndmq3
	 hobdS/5WXX8A/hNxH6ITNINkxruDcUzrMLrKt3sMgvOTghVkXXtjzsQq8ixml2IWjZpj9
	 dTElZ1Roffj29DgM7QWkhLY7hXqNWS29vYBOYwdVhEG60MQ1Wa3R0Tt4Hd5Ibt/Bgsf8e
	 oQ2QSTe1iRSkDYDn9xpmYkV38xmt/kfx71N2vM2zvR2k7m6FkOOecXov9j3jKONGAPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868160;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rvtDLCSmskozuno0dIt+ThevDRMQi02bPeyK4nH9tqY=;
	b=PXnNMVcOSwi0uTc2xqV+IGGHGcL++XCSHQfbSffIhVgbJoQjQaLomZ6J1jUxkf4zN+CP
	 qJPhm6r+C02Ni1uC/Cra/I3Tx40dR8mxEhsURB4KhOPYgNYC01wzGIQAIx4G7mHhMn5Xo
	 kXIpgvvPmk4wSECxXGDbg75WzvjA16CgM0quhWFGPUDv3V5C3p1/eocDMEIxsE80bH6rP
	 stLymZe7Pwo5hpBk7jMTQsgfRDPmmcdFfykvOSMShp6VVx4jwSnCtJS6B95CP+JrJnJeZ
	 8tI+rdRbmxKiv4YvXwZLkANmREp1bnZnOG4SH47tcx/bcsjunvhaFU3gZoT6p/GttuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN+4QOBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E64606A32D
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN+4QOBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D41F00A1C
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868159;
	bh=rvtDLCSmskozuno0dIt+ThevDRMQi02bPeyK4nH9tqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oN+4QOBsbnBg0fLnbGyLj7eJTEX7Y+6Q9LopYs4Wu9GhT5EqlScslk3mic3dgx8xj
	 xJa2JaY4gqnDKXfFQEsujalxSH5j30shV6Y4TvrddcRNHF4wGbAgbCMcHmhWG1FPKd
	 cBQq1JtXZiv7EDHx9SfnECtZh1r823a3p1U5RgHLPzc/wm88g43ClP2AorR1p0mB/T
	 D343BG2HcdA09hPEoio1DKGm4zeV+xShH31aTbbG7SdbigPMtaCLsgzoCmqQlUPJgp
	 pXPnQ936Eywq0EWeY+T5VweYFmDJjO37g5PttHtOc4tC/6vzd6jbkfqmZlrTxcfLzA
	 7GcKcBM5/aEXQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so479229e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByhYj7CqmKw/tZ5h9RAnDWVea8jDe6WpB7jeqk7c/5AwccMUFXsIbGcLysvjbeaAx6RB2gpGor9g3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nVj1stXxQ8LZCFHNk5C1G+pmGb2yWhQ2V9ylciAiUsxIMni5v
	QdgzHX9ObBP07DmL+9rlHYIymtVlaAE3oa3tKydwRtlNsbkd5BTF9b5+XNjJrKHDFs+d/PeeUUq
	RBjBf+6YBld/Y1jPoi3h6uMDXaYmTEuA=
X-Received: by 2002:a05:6512:2251:b0:5ba:35ee:bd96 with SMTP id
 2adb3069b0e04-5bffa1ac589mr492769e87.41.1793868158370; Thu, 05 Nov 2026
 00:42:38 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com> <20261103-i2c-nomadik-fixes-v1-7-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-7-655c6af2cb70@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:42:24 +0100
X-Gmail-Original-Message-ID: <CAD++jLkO7_Sp2P1JXLx7R3mdG-XHuBVAhOKmqDwBUWx8w7aXTw@mail.gmail.com>
X-Gm-Features: AclHuK8MJxI4wS-teKXOpfKbaFW_kc2gE9B-vbnzGqTtWPAzGtR0sGkpo-3ChDg
Message-ID: <CAD++jLkO7_Sp2P1JXLx7R3mdG-XHuBVAhOKmqDwBUWx8w7aXTw@mail.gmail.com>
Subject: Re: [PATCH 7/8] i2c: nomadik: fix race condition with interrupt handler
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>, Ben Dooks <ben-linux@fluff.org>, 
	Andrea Gallo <andrea.gallo@stericsson.com>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:30=E2=80=AFAM Dmitry Guzman <Dmitry.Guzman@mobiley=
e.com> wrote:

> If nmk_i2c_wait_xfer_done() gets timeout on waiting for wakeup from
> interrupt handler, there is no synchronization with interrupt handler
> that may run in parallel. This can potentially lead to various race
> conditions between thread and interrupt handler.
>
> Disable and clear all pending interrupt requests and wait until running
> interrupt handler finishes after the timeout.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
