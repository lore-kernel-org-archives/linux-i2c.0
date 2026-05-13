Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B6367298
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658659; cv=none; b=LZFmsDIVQhy0OjqU4FCYj0VZ44r1LMK6blHG0zk0W0AewcRysatO9AD4ytDdgN0G8v+hrdKaIRO1NXh+GJuDIXMrEAN2VODaVInPZdfuQAaD+DEO6CSPZkHWSFvSzns+L1EKeikWHD6zDqixlam7SD+0lA9Jk4VPXG3yi7qEppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658659; c=relaxed/simple;
	bh=p9Ohp9WPIQd1AoIgFc6IB/L4M72lF1cObc3C1yrOMLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSkD03R7aBmWAuo1ooDmF3amKpjwkneEmLpyHwlvm9hITEUiiupqBmuxjokyUP7rsMImbUoRaNW3h1XNkO8uuG2CW9UGqLSgtijR0sZoxXF+NOnG5qN2m50OrqYJFB9psqETibMoRIw6PU+OWaSXpFUsiz4uJ5/OtNTCbzoIEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfPnF7cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfPnF7cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059BAC4AF0B
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778658659;
	bh=p9Ohp9WPIQd1AoIgFc6IB/L4M72lF1cObc3C1yrOMLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfPnF7cuAC6ib+IP35I89v+FxHX9d9TGeyxhLDNRmV2ceO8hqM8AnhASQRxg1NiwK
	 uT7AJ6Q2XdLMy+Ff26XOhstvUETfIt49a31fCede2QDCXQHZeO3AXEGGRMuluAOOys
	 spekrfjetnhtlK+0+XddAcszOscScHGVVCPIxK1+36XWLmkL+rhfb1YhipNmFINeO8
	 EciNAb1MKFw2YVFkOcYpUGo8IYWA3HXn1QlD/fM+BxYjcsWclbhN4ylwPsXx9KIoCW
	 J1cL4irCpL68IB5le61VQTMfbr9y5aX0AacOgrwuxow4tX1fATtC3g2OKm/8VBt3Nq
	 sx6ADxv+PDQEQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-393c40246afso67196581fa.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 00:50:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+PXsecmGADrP4lCHC/eqq1mrHex6uq9cKqTXCeskmi8Iul6nEcx4P5WaZqZGJPC4QfID9qJhoGDIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwbd4p774zR246J7s006pXnchynybMEQnxfuAgr3d6XFTT6JD+
	VtOMJeESHxcTPGeD4pRaohNiwxeCGYn/J6ojm8YQDdq/afqT9cwcrRWJA9B6FsVZoRlkrWynMg2
	nQ6U03u7zwCYi8NTN6gX4PyYNcbSHdIFcn4KLLXPk5Q==
X-Received: by 2002:a2e:ae18:0:10b0:38d:e744:8663 with SMTP id
 38308e7fff4ca-3944b60bb79mr4560581fa.26.1778658657667; Wed, 13 May 2026
 00:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
 <004c01dce29a$0e44e7b0$2aceb710$@gmx.de> <agQkbnSHblUNz-IZ@shikoro>
 <CAMRc=MddGonpdukfZ_eHa8C4ysdCTqhYva6yVRue06LVkyubxg@mail.gmail.com> <agQspjVCkbmVDnt_@shikoro>
In-Reply-To: <agQspjVCkbmVDnt_@shikoro>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 13 May 2026 09:50:44 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf9j9Y3nFaDD1t1nqhd8ogH6TVceKA=vtM-u5dY6_ptrw@mail.gmail.com>
X-Gm-Features: AVHnY4J7mArgZfFLDspRetTPfaw6yjD5xgcHAlbljH1t9z5KbSl0zlXC_WKFXlw
Message-ID: <CAMRc=Mf9j9Y3nFaDD1t1nqhd8ogH6TVceKA=vtM-u5dY6_ptrw@mail.gmail.com>
Subject: Re: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: markus.stockhausen@gmx.de, andi.shyti@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:47=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Bart,
>
> > Yes, in that case it seems to me it needs a separate virtual device
> > driving it. In general, the idea Markus presented is fine but it must
> > not be described in DT. Instead, you need to create an auxiliary
> > device from subsystem code.
>
> Okay, I get it that it should not be described in DT. DT should only
> have standard i2c-gpio busses and the OS needs to figure the details,
> right?
>
> I wonder about the subsystem involvement, though. The I2C core doesn't
> care about the scl-gpios property (except for GPIO recovery which is
> moot with the i2c-gpio driver). So, maybe this should be handled in the
> i2c-gpio driver instead?
>

Sure, the driver can live under drivers/gpio/ and still be
instantiated in i2c core, no problem with that.

Bartosz
