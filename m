Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351341;
	b=FfMjpF1dJupTdmIF2fZ9lzcxYveiFMtZh0+YrJME/cWVfACvVcrfMLQFxahG9IarlYah
	 8L6PwI8pvJHBMzVLAppBrQJ/0QcamEE7eF4dMvK9eZlJNjZImwTAMmLRT3L8jkDSZX5c6
	 v6QkJjiCqPxGK5f1gMZoTHVr7uVz++uGwMrKNWFxqeV6F5kjF5ciI1HxEpzL+h+S0XJVo
	 ge7PvdjQm0AVjjbrhTpZ1gK1uUbdE+R241P0dtRiczsTUWstMQTMivmuzGyPi6BNqBiit
	 2mCIJTOaGq2ASSQ/6BdFeUsQb0I9DUYGWcQdCHCabm2sYYWjEWdfE61ygOBsNciyD5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NjLyddmhAPXtNb3QKE/8D0uZ863VQXkt9WgAWFpo7lM=;
	b=MpXpoNzluVRRcTfsIVdxBo9WYfbPqn/cti4lNyvu8yxY8KJub977E8ICMEcczpNDFORg
	 aABm/+XCJcOp96obeXK58NK8B2J5XTtv93kr8pgmie576rZa/JAe+zjKjdwZWLi99g6bm
	 ++j/a/lUE4RkHhWExfIaZypa6tZLjbEb4Sea6ISDTNi8PSikhJivDJ67lWH7u10cEq0jb
	 dfWEUL+HO7isUvxbnlrb1MHXEctc2u4/qOdRMq2RywAECT3ozlyl1UnPcqtI8193XHz+8
	 FkBV8t2FTC5/6TSJa65TRYkv+e+WL+29dg7Zvh5kbfQO1nkChF3UPwj9WY9iAc1GUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=iWfDGmTC;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF8606A330
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CDF8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=iWfDGmTC
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so1671791f8f.3
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 04:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mgcrea.io; s=google; t=1795351339; x=1795956139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjLyddmhAPXtNb3QKE/8D0uZ863VQXkt9WgAWFpo7lM=;
        b=iWfDGmTCde2bt+wepq4PgJNyha1vow8HgShJhgAqgwEb4VqiIG1qAiKLIKiWaGRuxd
         f8R6vPe1+sThZNdOoA0Mq356EC2okYJ243uZQdz5uLx7ZsNjaqfeymrnBu2nUSX3KkFt
         YgB7/fupJe1qhGJlFwKWug3Ng1ZX/n1BdxOf5Jjvnk70H94tQnTcRAB1K9VrdyKhjJko
         LnW8pJK3Oe1kytqRL+BYgKvMiCn9vuCirhPSy6vw+PNkvaNOsUsgwZlsKRHzqWW2qvcS
         WcUTjr5KMnUfMGamPt2r79Go/SYQtMvprdmDjIHkSPDd674WlwFczVf+G/FHc1QPveKO
         xVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795351339; x=1795956139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjLyddmhAPXtNb3QKE/8D0uZ863VQXkt9WgAWFpo7lM=;
        b=BzxqXtX3gVVCKbuFZ9yUUl7FmL5N3sGfYNE2hI58ZzO+C+0gUjaWM0mqXynertGr1M
         pt/OuziWeC1mzJ6OixFY0PQ1q/knpI1CVv4G/15xKRVYXR3Jr1XLykz6U3oKok3/CWMk
         QH5mNxkNDwf4gyekkRftYyyO81MEsY1+JoyF5uHtX6LnrhouYz12XVsB059Fm7fTNnsk
         OHfcLFskWgYiXi5zkE+mBZLd/cRT1lknkfTEzmiGSUV20j9phakZPAe6J5eMK/K0dQ9U
         aCGkUqUJaJH/2SXatkaK8SZ/bh5l2E90UKMJerX1rVByKxXyVGKMRkEz5WKmg1MpgGfi
         pXmw==
X-Forwarded-Encrypted: i=1; AL+hErFgQJqb9vs6hG8Vsare9CV+z6HcMUd4PKPUXOyhrmKpf6vTrGzXs6AXKq2W9TXwA+BA7V57y0LN+40=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w9NciW9fpQ0dPT8u4q33HQDJVQrYv6LXIgJcAAazW9WkSvI7m
	6x7cpOJ52o2ecotzioO9f9VrCFUEW+bCP1wIEXhZe1BLEM51dFX8baZVxqCCYOyaYLE=
X-Gm-Gg: AZFdTZclFj7/aL4DeJx3u2Pn/5bkC8cebAt/caC9lj7uAAo3CEySHhZoo74IBArUUIZ
	npJhv8JkPUZ20DMbwTvgS869bl0OIOmt2UsXOoaDke/BkFo6wUaNUWC+I3gkkBx0ApL8zOeVfMP
	yJcKtq2LNyZ0CmdsH6HCm13ZYAhtOxzGrJ5+M4OuxdPichssBr00MWopR2+BSLpeIEQN2ZqRVAU
	AAHac61cuQ4TgftPwCOE8WbZUs82nT2s9DlsIQyuC+K4iZXy5e5oCeG2D0XyJc1vaXk40hFvnDu
	rmi2XssIY5rVi5e6IKRYT4n54h1U+jXoAxcoEzpdOwU6+SuV4DsvDCgDDgMd6S2sliWBegG2EhH
	QPZCAYlGhzZGciqSzQK9vB7GWl7TY7tng1b/PEbeiYf5aJxFNmh0JvOPrjAIvlmSvBQG6QP8Ui6
	TIrBkLliKUp07P7bo7J1LErOmgYvGVY/P+7ncnWq3Ou2P4nDLDa9od9CUhLW8a5RTS39EYE3iO/
	IlXMfOseug3DUkqO4yp7EDsR6vC+yY38ZElrJ+udMYWHwjh2SiPB/VF49+V17MBSIMbFyvtANN8
	eHBF7gho0NffIEa6lA2j7ROvRQjbMHolhyhoMYpD67KhxbRLWyrTZa7Dw05sxg==
X-Received: by 2002:a5d:5d0a:0:b0:4a8:eed3:760 with SMTP id ffacd0b85a97d-4abb225faa7mr18135404f8f.31.1795351339007;
        Sun, 22 Nov 2026 04:42:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:a5ac:a6f0:7687:6596])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm16091531f8f.56.2026.11.22.04.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 04:42:18 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
Date: Sun, 22 Nov 2026 13:42:17 +0100
Message-ID: <20261122124217.9668-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <C17AD04D-6EE7-4CF8-8DB1-FED4A16C66AB@goldelico.com>
References: <20261024212520.91401-1-olivier@mgcrea.io> <20261024212520.91401-3-olivier@mgcrea.io> <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org> <at8jCGfp9dKjieoo@zenone.zhora.eu> <20261109190345.61480-1-olivier@mgcrea.io> <384F58FF-41C4-46AC-8B2A-1B6ABCDA6981@goldelico.com> <C17AD04D-6EE7-4CF8-8DB1-FED4A16C66AB@goldelico.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi,

On Thu, Nov 12, 2026 at 11:06:39AM +0100, H. Nikolaus Schaller wrote:
> So at the moment I have no device using I2C at high speed to do real tests.
>
> Please go ahead and if I find something we can write updates later on.

Nikolaus can't test it for now and is fine with it going in. Could you
take v2 as it is, with the two patches swapped as you offered? It still
applies on i2c/i2c-next.

Thanks,
Olivier
