Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309524;
	b=gYAUYtmYN1a6Eo9fKFi7pmM+0q5EAT6+NarvZ5qhmK3GJs8JCb0LFZHd/7QZ679YQHVz
	 FT53rsT/kqdLCVrkbvZJCV4zltq6Rrjgh2M8+TMQO85LEodRniy/QAmCuiL/D3i26ATpq
	 2PCJy/RhUydsy4TSzAB+59ZaPh0mCGKeCqMC7pmwNOjsTLso4GrKYHQteNFlgmFBCsSuv
	 AJTJJFj4aCuKzZpKOhZqEacxpKC1Iul3JrJnlNFAhE2h66hf1XYAdju3sEdiVvJQciweu
	 HhrFeRIH2AD0F83fkrg/HAMc5BZmFHLWjqBLs7ifswBFLIH4sV9Le/WPXwelQAWczLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lihVjw0iJrxJh6yjkrGWB0Po4chCl0P+JcexEjDc7sk=;
	b=v+2NHnwNXQTutcDBv2tTauta9nuSRHFh2yMfDSOOQ728KZtxsvRbM+1+M2f83ATLApUZ
	 y29tGMFwhKfEb2OYl8gELLuEHIBsZ7y6L+idWdQ5Yp2Jktr0EjngQ7/vztVjq/mhUcrJO
	 Fp/4kH52o6ijKzJtwTlAXdgbUbi3nZX2Cqa1aT7nGEdgAkp9YtAvQEA1qRcv4n2sLW5lq
	 owDypETOC/qViGHWHUtFi0kcL7y8hHxsgC89beev+8sBsUR3ZydSr0kVf17+DFLZkG0E9
	 OUf8+hy7UZkYG4CYySbmr4lcgMwIT8lvkIwdY/cTNags3QemVRY07F7SvuzlptGfd2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=L0AxKEyb;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B2606A32A
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E7B2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=L0AxKEyb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lihV
	jw0iJrxJh6yjkrGWB0Po4chCl0P+JcexEjDc7sk=; b=L0AxKEybWkmefJenw1/5
	GOwYwRPx7FDgD5MoJWlqaukVneLVPMhHPtn3AdfrzaD5ofYYEj5cy0hYs0/48xyt
	tegSOwrpyhSPVqlmwmH2jdvuYfY4gVWKOGbkb2skD1RQTm7fkIWuos62F7DDWRBa
	73wO3RlVpJ2Wt/Stb+EZ9MYbcX9Zejm6L3vyFr/iOvVQMVaqk0og/PUQCMsDiS2P
	osIExAKNuD8WgrxS/QCdnrtpDI6JRlWWZHdvaAkIbnYoaYta3++Js5YpWg6Zg9EU
	EJcy7MFQ92/mLjDHXl8Ht8bpj47Wjq/zBGjAiXqtmURL5ni8R8qn6mrGFmO4uoif
	ng==
Received: (qmail 207679 invoked from network); 10 Nov 2026 12:18:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:18:40 +0100
X-UD-Smtp-Session: l3s3148p1@cOeOPepfdIsujnsO
Date: Tue, 10 Nov 2026 12:18:39 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: qcom-geni: Clear stale TX/RX buffer pointers
 after GPI cleanup
Message-ID: <avL9j9GS565kip8A@shikoro>
References: <20260902-i2c_double_free-v1-1-0f582ef32e55@oss.qualcomm.com>
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
In-Reply-To: <20260902-i2c_double_free-v1-1-0f582ef32e55@oss.qualcomm.com>

On Wed, Sep 02, 2026 at 08:15:13PM +0530, Aniket Randive wrote:
> The TX and RX buffer pointers are reused across messages in a GPI
> transfer. After a buffer is unmapped and freed, the pointer is left
> unchanged. A later message can reuse the stale pointer in the cleanup
> path, causing a double unmap and double free.
> 
> This can happen when a READ message is followed by a WRITE message,
> leaving a stale RX buffer pointer behind. A similar issue can occur for
> the TX buffer when a mapping or allocation failure prevents the pointer
> from being updated before the error path runs.
> 
> Clear tx_buf and rx_buf after unmapping and freeing them. This ensures
> later iterations and error paths only see a valid buffer pointer or
> NULL, preventing double unmap and double free issues.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-andi, but maybe this should go to i2c-fixes first?

