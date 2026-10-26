Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055838;
	b=mCC2xGdglTIrds1A1G05uCfak8GZbWfT06HpQzIi9FzK7gn8IAV3xTIhqlEBFi7YdPmc
	 BNm+rOkPP8QzS+zy+xFhnozWuHTH7Nj8pqGs9SJ94yJ/4etHlJCqUFg6ZvsAhRIvQ19OW
	 nzdY+0MmrYxvpTslg5uSS/GRkEzM2iRhmki4O3nj/6Uup8OiutUP9sniQYF71LJRq87cN
	 l7ixlbEXR9eIMcmlNFPYH6yAZUjXw30cCINKipaoO1IrXejFCSaylRUXrHvJu7XlyrhyW
	 45nOUw4loASK0pK/+gMOLiJoGI2+O5+wMAa2EvKbo9u01LGptrQxzxCnnB+kBhxgnKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RPX+RWHDa83ciD85+v8NE/MCh3vpHSDKFtDo6LQXVqw=;
	b=YC0UNhd2nfpOpAtU8u6ryvJ2y7Ps9kYgRawqWsOuwU0kJGWcMindbzfsR6Qk3GfWN1c2
	 q/fwB+/iOGPeEBq4ThiO4h1MGfWPbbZz8sPvyFb4fotPkwddm9si8yJpI8lOMp2TOWzzo
	 y3D++CuqLTxjs6a2C9xcNNRmnOnRGZ5dHOVfAIYHhmI0MqigC6yK4xc/EmBbm++6CGi0T
	 PqY/dlPe0bw4uKZXNlCyRE/ODp6yMDRCPiloP882u91u2BCk7QPyW0OqGPWU2EO1LPmP4
	 qSoMTsTQy3jHog4Iuuby3IMkHV6CBZlYMbwxuEM7RD3tXg8g/b4h3WGh2UexqVde1+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jZz9kKk4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4E606A31D
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 23:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF4E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jZz9kKk4
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so1006708241.3
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 16:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055836; cv=none;
        d=google.com; s=arc-20260327;
        b=rspxyl8G90C/ojyihwhUfqWguH/QRKl60ood00lMeaqgZkFtZsbfVQid93m0RkXN3a
         34gymvOywyI7w1lRQXhefTz8GvaA0gVLsuVGTtfWLot+HrJIRFmXWEAhpTC4joRDNU2p
         TFHLbFNW6RfjpA7oHUmGSv9O559X0NqdMt+dslfoYBDoo+a1MWsr72uVomEILCFJ580z
         mhG6E+qG3kGESocgabQsr41EVftXctPwDovtiydm3MW4YY2k8Gn70ldvmlN+uf09hz15
         2+nUeToA43BwsEs9jlx9m8SXKbNxz0zInUZW44UF5p5LNAqX8ZKoQscNEWCBzpEPMDLX
         lbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RPX+RWHDa83ciD85+v8NE/MCh3vpHSDKFtDo6LQXVqw=;
        fh=SHSzdBbeEcooHHbgo7rQ+QPuC5NsOPNpBddvtRWlP1s=;
        b=YEjWHKm3Sj0CmyoXN5QwyY8ZGEuoH5fkMWmZsE5RfT4Elrf61kQBkDzpQUmOr5V9Uy
         AIsq7Un6/atfTICxGCOZJUOUQBn693rwZvtg1olHwkVQbyEzaIO1cVGTC/6DlQVEU7Pv
         JiSMH5NiAaMu+7RddCA7puVTMEyGR6WVoaUzx3L47kZjkeC9beX0ITCFwsxWjuE9MjTq
         EIjumevQkYv4cC7BavDhWYSKbTvG3yzJdmZ9Qq2g8VLqxl4kgceKqTHXHmCoDc/hM/ms
         kPZq+IMaS5N3+vF9edo1lW6zjUFvr7m49fJSouAh52L9ANxp8j47iEYt3VcVAv5/r03+
         Gk1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793055836; x=1793660636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPX+RWHDa83ciD85+v8NE/MCh3vpHSDKFtDo6LQXVqw=;
        b=jZz9kKk4Hvx7975rPnqAOpG2BDDGbG1wGe+6j7dFUC1pE+0uZyJUkQ7Lfb9EPJOyVP
         d8/CXI3hG+x8KMP5QxUQMw3uLbSMqTYRFLn5VCUxPjjBs7GpFcYcsDMbD3z/23n4b48y
         kWNPUERCIWBMP5DU6GYkghTHqON34amEU9449mLGkyK2AW1QcSwzTYjulGoGUg1ni5nM
         k8K80+HFvSiibQBluYM65q9tHQaM9doEZPo8cxG0L8+VTWPMeH8QqSbVvXSAH+cynCB0
         UbYODQQgx7wnCP91P+TIQoFlFOttOQHCCSPt3J2a+/sv0MjzUKraHbZJ68RSZdK4wpjI
         lmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055836; x=1793660636;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RPX+RWHDa83ciD85+v8NE/MCh3vpHSDKFtDo6LQXVqw=;
        b=vXI0M7NQ53AQkJMbW+KBMBtvhVYW+wemAMSnX3DXAsKO//2n2FCZSEYJmWK3La0THR
         LrvZ8v3ebZCLyuxf2cP0ctjCC2z6M+vs5yoS0stGMmcClOpxcl1wNduBPgt8NBfM+/YE
         JvBkCE48rPvRAR4V2N7Vr/vPHJhy4QXjdSGoIzxR4pMm7QjRxDJmwEby6NhwFPpbuzFD
         m8Ihax+99h+Ndjkza5NFz+tHqTTOr5Ef0HNL2yaElqbPKZmqZN5QVuVTVhHsG4J4iY59
         nm8bPLLZ5OKMlpLVonIFomSqUY2AzTD1oZ4MwgaMotUkBpOT6LZV6iuFQ8F8ewFC1STa
         SKKA==
X-Forwarded-Encrypted: i=1; AKwUvBxzJ5JLFOQFsHFjBURCXdI6caelwTVOVZwWiEvgJy/pUJvLyod1uT1lSCTnSfDmrpnDKtX8UXMpLF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQJb2MCZ64NO6OEAnmPNHC/MYcE3jspNFE6H1m3+nXQXN+Vtxy
	1du5tabr78UaECChYLoky1/OkKw1TDbLdNpTNq8v3ZwYR2kWX9qyOVj/3D8DOSL5g7xLyxAI4cM
	qFkCWJUQLXb2qyVpsSrmI4A+GOHa1p5g=
X-Gm-Gg: AYBFou3yEh751hZWAkhV6yaVrod8Aw8Z6EJB+eF2VswdbStwiDKsN8vulIL+cdmWT1m
	0/pQFVAUKOOr+IdNfJbAHszDLw1MxwmG0G/n6J2mY/OUcqu+P4LduSs+j/lEDbRRkpYLoCH+3VD
	ZrO7fWP1UEQtreixDFpuj0o3F3hOGefgEy9VmGl9/ff1KvSCCVyrdpvyF+iWrtLjBtXn32r6fog
	Dk57yH0j/kcjFxdDeBkqUQV0RAtY6qw23A9h6jMCJevWljtDkUASjaiAMj/ymYXXGJhXKhMO5iH
	OHBTkvc8JXnBgp+TyQL+GjZHKesdL8jzzzGh/ILQ3OIDCVnf21JpuHvq5XJGnF50ujigXDXskQ+
	M+EugcM7fbCEtYwooGP5RNO02UD8vpOFc0kiwYf8k8yRjnE8MHA76qg71xq9+MZOyoaY=
X-Received: by 2002:a05:6102:5049:b0:7c8:fb4e:a3b0 with SMTP id
 ada2fe7eead31-7ce5ccddc2fmr2242244137.12.1793055836538; Mon, 26 Oct 2026
 16:03:56 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022193853.670625-1-ansuelsmth@gmail.com> <at_arsis_PFKDFxb@zenone.zhora.eu>
In-Reply-To: <at_arsis_PFKDFxb@zenone.zhora.eu>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 27 Oct 2026 00:03:43 +0100
X-Gm-Features: AclHuK9hoAjXwtHctYpz4oUv0zbqoQn_yeGbBI3iJDzHErUSMIyJMIBdwhVkFh8
Message-ID: <CA+_ehUwY2Z-qvrX5+sdZdrtpF-QtAozi7fHbV7Zz2cM-5UzPHA@mail.gmail.com>
Subject: Re: [PATCH RESEND] i2c: mt7621: fix copying uninitialized kernel
 stack with reduced page_len
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 26 ott 2026 alle ore 23:59 Andi Shyti
<andi.shyti@kernel.org> ha scritto:
>
> On Thu, Oct 22, 2026 at 09:38:51PM +0200, Christian Marangi wrote:
> > When a page_len is less than 5 bytes in mtk_i2c_xfer, uninitialized kernel
> > stack data is copied and written to REG_SM0D1_REG. Equally on the read
> > part, an unnecessary read is done.
> >
> > Guard these extra copy/write and read for the page_len to fix leaking
> > uninitialized stack memory.
> >
> > Fixes: d04913ec5f89 ("i2c: mt7621: Add MediaTek MT7621/7628/7688 I2C driver")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
>
> BTW, this is not a RESEND, this is a V2 because the patch is
> completely different from the supposed first send.
>
> Next time, please version it properly and add the changelog.
>

I used the RESEND tag for this as the first submission was
completely wrong and didn't reflect the actual changes.

(file got mixed on saving and committing)

Had to be more clear and maybe just say ignore the previous patch?
(a v2 implied that i made changes to that patch but there weren't)

Anyway corner case... sorry won't happen again :(
