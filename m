Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EC3451D9
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689300; cv=none; b=OV4BeIio4XN7zSg8YBEf1EiO3VgWofRw6HSEZUScJsnQ+R0L4NmwVZqU+hEYPyEkGPX4+EAqLtl/JA1/QQhq9szWvhO4E9cMWDMW+TWGfZRwkYPmTp/u+gvWelSxI0wn++Wtrs+8bo97X+G4cevffriukjHZ8fYQc793br9+1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689300; c=relaxed/simple;
	bh=rTffjdrOryhDwlxQuRa+2TakfdxqX1o9E9VA79LUOOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7IaR2kHZEkPYEr9WvkmTQSho9CXSxV1I2rs9BTXUrkC2bAk3wJ2q5paCH+1ZOmw2wtmNqnggUj9Kx/zrZGh9ZLxJzYQuIfyfNHwVDOHdksIi2PEFD+U3IURcg4bJk2pFDMOhJa0/ttQWENloTAIF0pGBVUXFpidG8JzhEUkHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUaJn3KI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUaJn3KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC4C2BCC6
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778689300;
	bh=rTffjdrOryhDwlxQuRa+2TakfdxqX1o9E9VA79LUOOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sUaJn3KIPEG9L0YSX/h4eolohFZqQNZAvvMQNzPLprlF7CGtb5iqgkEq9nC5OUnsW
	 B77Jb0LNZf3h/bKlZp4/75kkyBXIqT5QK02FfW5bTLKGLXNzphCvVyWkRIIYGg4Dgh
	 SnSDBHRrgsBHUnCwaob6A09vDQxFr9GmaKRxaCaeeb2Yv746nEKye5tpxObsl5uaNo
	 N4K5v6a9lwWvc9klXvxSEW64vGBXKQ3sKkbt2Ic6gcbWzJgOFb7JXB2NyUa6/HrhKJ
	 H2qM0j8nBIY3WK6d3gpl41N5i9rCbVhplQsMRYJ9dAFyswAyW5nw0+dk0aYDmMWnhp
	 zE8e0oZF14fCw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd11a3729e8so493096366b.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 09:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/kYGxeP9gTe8QEKCkMqu7heqfS5cfR5Y/wUCBf8x7GV1+MuCOolnWFPubFO++lnKfihKVjk64/vfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3zQnqzYh07mA4h+HtdwuT/2/sIjcgwCLoEhH9wgLeoBwmIiv
	2cny6r9Kg/ZvY9S4IKdOfAw6aVWVpm04E2PIeR1OrE3PsnJ5KCDGev0H4fHQJK+/Z9Pkg3vahrA
	kVDuWvKRrn3t6r08OWa1uhvfe2hzGVw==
X-Received: by 2002:a17:907:6eab:b0:bcd:695d:2845 with SMTP id
 a640c23a62f3a-bd3c1834a6dmr282224466b.38.1778689298864; Wed, 13 May 2026
 09:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de> <af9xGlIWG_OmREzX@shikoro>
In-Reply-To: <af9xGlIWG_OmREzX@shikoro>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 May 2026 11:21:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+RyLno6kojsULC9M-Db+h1N+aoyJZgYs8nXtY4J+zEFw@mail.gmail.com>
X-Gm-Features: AVHnY4LRjPtG3bGLykpE4bLmsSMmJsiDORRAI9IDDt5dLqMF_Yt0_ZgVin2JNIY
Message-ID: <CAL_Jsq+RyLno6kojsULC9M-Db+h1N+aoyJZgYs8nXtY4J+zEFw@mail.gmail.com>
Subject: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: markus.stockhausen@gmx.de, Bartosz Golaszewski <brgl@kernel.org>, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 12:38=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi all,
>
> > Thats what I broke my head about the most. From testing and
> > my little knowledge I came to the conclusion
> >
> > - two native i2c-gpio based busses can not share the same SCL
> > - so mux infrastructure cannot build on top of that
> >
> > But maybe some I2C expert can advise.
>
> I am not sure i2c-mux is the right approach here. Because every SDA is
> already wired, there is no need to select/deselect something. It is only
> that SCL is shared, right?

There's no physical select, but it's still only 1 active at any time
just like a mux.

Rob
