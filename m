Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B1374722
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501811; cv=none; b=EykkRWtiXoBHDBTEXZOzIl23XLyPZTqnRbn/wEfzkVdq2pR74rbhi/pmidKN2+fXDbKu1g3hWkBWr39I6LHOnp5lQdi2o/vILCGX9VCTgeOnJL/jP4NKqsy955PFBFylDRF5Jz9PDiPo115ggiyCk8IPuBOUTpDbKm5pPS4qM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501811; c=relaxed/simple;
	bh=GfRreuB3opq1LCDznA3I4nzdBIH+Lg3QXUNl0GdowsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7YKWwL8Mx6dh2VzPs3/yRygJGYp4G/EiWkaOWGjVTfLMdvQK/jvtLvZvb1BS7XmK2vW07dYp5swkeDz0hWf+XP/GKZG64JJnbxpY0KOVz37bMj4TJvNv76FdP3YgEYqstmj9VaT6O3s43w6Y1vouWCmY9GKPlOgAirEgdhqkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofSYL3fq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofSYL3fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94755C2BCC9
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501811;
	bh=GfRreuB3opq1LCDznA3I4nzdBIH+Lg3QXUNl0GdowsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ofSYL3fqlZgAvqZdDKgsTAU9aDBX/GoYxj2fJEgtQX4rufaYXIxHXvL565XyxcieY
	 VxsP+CmKJ9CXtU2VS7a4qb7o2eepLrSS2SdnmQ4rlW8LjIoRE+3oZcLs0TK4FOcThm
	 GPIdt4mqw542w5yr02Cx0679zuLIO0SjJWijSAvMfvOtQlqR/TT8CenIuwF+2B/SbT
	 29WNmHk0QkideU98a6JOaYGnt1wqZPGXclEeWHZWMNuI7FTQmdzHtT/MEAdqv4/HOb
	 Mss+iIkPjYKBBAj4Slvh/gwA8gmHiet7aTCluneiHlTLBURY+zzMTek0JjcIwMAMqM
	 Ak/cpGToWpgIA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso7423807a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 05:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3B0YvktSdwCfcPC/HJosHAjheovRjn9BVYCQ7acpvuM1ZsmdbT/BuU7fo/tNCfo6Hlw9YrOVJAmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNzcvjzODCkghWgMlLV3AnQdXQVYOE43dDadstUfnOfREWr/1
	rbqRnxpAPoJ93/O/gfa8hW84inu20Re3lciLFl1qw2N/lYFxmtagI3gsVjAcRxuB2fY6aq86e22
	npggFBOSayK9Si3THthM5LGD4+g/mHA==
X-Received: by 2002:a05:6402:278c:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-67d6489d6e9mr12563596a12.23.1778501810143; Mon, 11 May 2026
 05:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509171644.12513-2-wsa+renesas@sang-engineering.com> <177835197752.785526.10193851716163594776.robh@kernel.org>
In-Reply-To: <177835197752.785526.10193851716163594776.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 11 May 2026 07:16:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+aSeEJ=ccCVT19Ogg9AehLLtM3p2PxaYVdm9Ye5t5bjg@mail.gmail.com>
X-Gm-Features: AVHnY4Lvfiik-MUx3itZOwGe8VeLrdr29cd_S6l4DqXXYjWNAGohg8IRTAVyuCE
Message-ID: <CAL_Jsq+aSeEJ=ccCVT19Ogg9AehLLtM3p2PxaYVdm9Ye5t5bjg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: remove Wolfram Sang as maintainer
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 1:39=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Sat, 09 May 2026 19:16:45 +0200, Wolfram Sang wrote:
> > The YAML conversion added me as maintainer but I can't recall being
> > asked nor do I want to maintain it now. Remove the entry.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml | 3 ---
> >  1 file changed, 3 deletions(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
2c/i2c-mux-pinctrl.yaml: 'maintainers' is a required property
>         hint: Metaschema for devicetree binding documentation
>         from schema $id: http://devicetree.org/meta-schemas/base.yaml

Should be Peter Rosin.

Rob
