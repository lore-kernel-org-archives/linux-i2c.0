Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D447ECD7
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246144; cv=pass; b=nfzW6rgcs2Y8tIZ+ltZ5H0jJZgo71jOFidgTscyN/qaSjHp9P5vWZJ5Oug+v+Q2dhfE8laNz+sazJ/K73d/59Z9EKm//jUoN+I+5g9Q3PVVpXU3yZAmq5BwLMhfEAOeZe7KtJTRiFZ7yqxiujdRmP+Lmz/txOq6cIqtopBl4egI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246144; c=relaxed/simple;
	bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNBnn2VWUpphj6gVp3imvmUZcWYVvaweuTaMx3Ja5fmZWGqklEaIfLtS2cOCF6qWQTySkGf++eDm/GKgwDiJU9VhlJ9OotWpNzzIGFqxv2SgglHI1xZYQUFRWHbHmgfDHeBMMRuN59ri2NQl5p8rW5G/oSmT0NynhUPLGHDpnlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhlFp3TR; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhlFp3TR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so91679e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 10:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787246139; cv=none;
        d=google.com; s=arc-20260327;
        b=ONHoh/fwFWaGQgzevgTXJBAj8g3zKR5IlbjrxcrOlP9sj1d/0ND21Mc3DoHk1q/mF2
         GH9zAQBY/SigY7Zdw2faqgD53h3swCH6VNmP9DT9TadDQUmMRv4kM0zezfBIDYpYncnb
         02xwmWecVTQZZoYp+KtLauE4XVbK8RwKMonB0FNklKO/twp6PcKKlotEfNTOx0/eMnev
         7B96Urz/5ADUyiYTXMGzmxRjaX6UJfSCAS/4ymi2JxAv3xy3hbHtsJ57D6rlEGf5KMdG
         4WAJgSgff7LbxqdvvwYJazcgy4cdw/7aJoGc8YORKeyl4vNkZRBb0d0rrmG+Zl9+xO0S
         NQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        fh=YRMVg/3raUhDyuh4shXz/4cA0pHGHnXwVuEzLXyexrg=;
        b=T1eIm/T1GT2zFq/pbGZKTY4Zd2e1KvdQ1WuahWHc24scHO7mo0nEienSnMsw4LXmCC
         /HnsWyjeIfzVMYd3E7kXd9Vv9flKV+3uJLZ9JDciaQjbtGrlutm9yGojRwREZrq1XIhf
         EQ7oFfBMtHF0YIP5KYMSwIInXt99asIJ6/p9654wfg2H985MOBOoP0NZzYI6S7z68Rwu
         FFiM1XCRsbwxrFGOJsrZPmvrKJ7W1vUIJ7l/pJ3eKE2LNSqjjbwGc2Y4mLKdFFyDWISK
         YdzIBC3o7anpYfOlX2BaUdVI4X24lkbfrGH5cMdCWT3tuwOJAsrShtp+Ynv8F8jJCpEh
         oAtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246139; x=1787850939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=QhlFp3TRefwrLZ5PfMTwM44EhPA7eyKSTgpKlbnn8CsBNAd+6s3hZS463nASuDpHC+
         AJxWvHeeK6gWkaANJOs1Li8zVYb/fJ8LAPNBJW6zoGBncjp3YZXPBeXJl02D4JiR/9hO
         ycHMAUkbsmDiOuee7uP63wrTV/iaI3TE1pEV6msMexdgEaU4uA9feVoFm8Z1cHGdsp1y
         wZNhRoJLmizaB/068ODHC4Udt1Ai20xGeK0V3yREl9YlobBc5n9g5JWd29Zgycu8I7sl
         6CBZuH9NWPt0QyEeG7aaAkiBQHc5bLdWkGYoE5bpXonU9GlrhZaAT8kRnfM5/ZCCmH2r
         xCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246139; x=1787850939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=q3iGQ7cT6qSmQYcE+cNNYn4jNXG/tOp2Fa1JdVsfQM3w1zGd1IHxLPEfbxGybUloIe
         B6TezHru670MTJHNIN/tf79LkJl3N2pJfJQjdRgHBSOjJzxcXLTXtWwqMumgV66UO5WX
         WXCKJZpgtR61+rTJQY8p0/C5fmvuPMOGnGdR0IvD+u+YxILJT0wpunoxWQ53BDA/+ZVx
         yBw6DdbUmJNKJk/8y+FMbeFMy2WDaphOb7xGkjNrJxLoOhrrthq9QT3jAOpLefHXna5w
         m0VfYYSetZbuschvjqmGWw2Jw3SaCAAVtcy9kxoNHXHKbGx8OxmA5unPEbBD9cp6iWbi
         k8Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rpy3AWmV6QsdwLSngBXW5TL1UYs4UVJ/Q81xU/PlaFb2BPwigLptGZlNMRxVYc0gJs+NnqlS/hKKy8=@vger.kernel.org
X-Gm-Message-State: AFuF++kew5MForU3tX09/hAsAQO+3rgQLlX/G/pEfilfuvrxADlSB7Yq
	Lg4gkEwgTdEiGMuzFLW5r0vFYM7t4nrciu75Vj+p8pijyplGmcrABph7VweluBW0k+K2P5fya/1
	dNK1ABT/cV7YLY84B2xTOmtKRETpOFTY=
X-Gm-Gg: AR+sD132joVsNSeRzFdSx+C5GDwkifWPXASTS2dnaP5x3mXfudzoRCCbQFz4bjz4Itr
	hOfy07wqNzQFDYA+8xUVcDmc6hZQqOTh6lPx9W34qeLsWvsiFvKSXNKpLC0GV2M7LTaHIxIX6Yl
	FO7SJZ5UxWH/yYGlYieXpgomhkiDrBI+qfDAsgN801flYx7gXFS9NwnvffzDgqJEAwP7yBViQtA
	UPgchdW4z/mMgmx1mEx6ilv9eeYrWaSuGuzNtKPtzDsWaVVrvQ2380wp4IHejtMO6PY/qc2+eu3
	eho5Rxm+rnfl6wauGB8VIv/lRa7j7cglDrFE7eRBOEJAUsfoogNNm8Z9H9MZOeAZw9kIumHi6ig
	583KePJxhJ+DAHqeWFfe7rtIQwQ==
X-Received: by 2002:a05:6512:3c92:b0:5b0:bc3:dc11 with SMTP id
 2adb3069b0e04-5b478d1f07fmr4752522e87.22.1787246139023; Thu, 20 Aug 2026
 10:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
 <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com> <20260820100302.1609c979@kernel.org>
In-Reply-To: <20260820100302.1609c979@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Thu, 20 Aug 2026 10:15:26 -0700
X-Gm-Features: AcwNN1VG-G40EWmCjL4DcV3v9ciEADsSL9chtIKAvcClckRaycXWK-AFTAquNos
Message-ID: <CAOQiBWPZg4xkZFsUm9g6XBYz+vixaKPaofdv1rvxGwufD3jm9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I will split the series and send the IS32FL3207 binding
and driver through the LED tree, and the I2C mux changes through the
I2C tree. Once those prerequisites land, I will rebase and resend only
the ptp_ocp board-profile changes to net-next.

Thanks for the clarification.



On Thu, Aug 20, 2026 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 18 Aug 2026 11:12:35 -0700 Ahmad Byagowi wrote:
> > I should have stated this existing hardware and end-user use case
> > explicitly in the cover letter. I will add it to the next revision.
>
> You need to send the leds and i2c patches to relevant trees first.
> We won't take them via net-next.



--
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
