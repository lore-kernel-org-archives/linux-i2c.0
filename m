Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206494;
	b=cMy2d/awCXcI1LdygDjvmZYcCdNHbPxUFoh9Qqiht4KcTUuElZvpS4Kh2A49B+weyl+H
	 3pVvr0nhArBJRrLM0QhEJtEKIao8Iqh8xxiay7lN0fpufzQ5Cj3uQBo125NgtOdGBKgh/
	 /pvw/SAi6pMiH39ap1Oi6SPZzghayG9WhreOJbTRbNipE+C3Tik36DOPVLancUEu9bOMc
	 dfejAEXk609Maz0wc6SOXtayPmnj3kRvzdQPp0d3TwdbxPxitDYpNVXOrtgK0826+0IJV
	 3f+s0IOw9BCPqKeSoMh3fhts00AvHeUMwixMXg0QTD5xNnOz+Q1Zvi0a1WQhviM5wJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=65KvZC1LFbngmbRx+tq6aCYPHEbvFJnMwAW5Rz+frMc=;
	b=C06KJKPt726EugWZiY+yfiZNuiMYoRZ2T3/Jc4IQeIfQgPwDmQ122PPNjUosgjw7RnDk
	 30xhlo7S1R64YkwX5W7zoq6DZnyy9hhUdekPFf9EgEQskmG2vOhIN94wfB37rIRdBDqst
	 urKjqNj/5aQPWZkV5EHhPXQZ4z4N7vqMrqq37XjmGjNVWjlmO0VqczpG4rCQ1kBOtqDI9
	 ZBQ1UVQhTP7jYjgWbwAeGXsXv/FW0kpRvOjNdbbEMxUUHE3MWBNQVyxSJ5qcb+GEr/QCA
	 LpHh3a4CRBS0/iMCCtOURUTRlOsROn9wfXRf2nmZ+fT7qA8Qsr8jnI053AkEBN8cQ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFOn0vpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A368606A31C;
	Wed, 28 Oct 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFOn0vpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3131F01825;
	Wed, 28 Oct 2026 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206494;
	bh=65KvZC1LFbngmbRx+tq6aCYPHEbvFJnMwAW5Rz+frMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFOn0vpFnqsn8D2yL8Hs3CuvHUH66Si8iOmjA6/UW1SOmblzK5qAn6l34I8ULuSgO
	 6uYXkeC16FNxLGAGgcNyF6nnPryNRiXa/P131p9lFnTgD3N1x459tL4XHiM6zQx+iX
	 M3XTKxZ1MWjXppZnn+UGv3QlSZigzFEwsKpTZ103kMDznQWtKsqC+OJFLPbObRELLx
	 M4Y1dVLoSUkn3xC/SINx8VhiqB8NWYu2oE1I++fZne7lRy8eX100StDn9TtZbHpzAv
	 LCpdMeCVbzSKMxAP/wPW5MUVAYIzijdKb+2A1vGit0gk4S13lNQQkgvu8ibYdZLPLh
	 2PMBBckPLcDyg==
Date: Wed, 28 Oct 2026 17:54:50 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: hix5hd2: check clk_prepare_enable in runtime resume
Message-ID: <auIospeKKEECNiaf@zenone.zhora.eu>
References: <20261026112608.2767-1-tangbin@cmss.chinamobile.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026112608.2767-1-tangbin@cmss.chinamobile.com>

Hi Tang,

On Mon, Oct 26, 2026 at 07:26:08PM +0800, Tang Bin wrote:
> hix5hd2_i2c_runtime_resume() ignored the return value of
> clk_prepare_enable(priv->clk), then ran hix5hd2_i2c_init() (register
> access) and returned 0. On clock enable failure the hardware is accessed
> with the clock disabled (bus hang) and the matching runtime_suspend()
> clk_disable_unprepare() unbalances the clock count. Propagate the error.
> 
> Fixes: 9242e72aaea0 ("i2c: use dev_get_drvdata() to get private data in suspend/resume hooks")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

pushed to i2c/i2c.

Please next time send these patches in a single series.

BTW, for both I removed the Fixes tag as I don't think they are
necessary.

Andi
