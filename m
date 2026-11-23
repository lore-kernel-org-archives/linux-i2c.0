Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416165;
	b=5FSkGZAnApQQvUQcDgGbPcWa0R+YsYcxsXCk+3/Jq7+V8cqz8Imbr5mDnqxodnNHNwEL
	 xqMS6kvg7vf8lSyhXN+mjyxcrK9JKgYNgFKeSTSHfeVux0Lg/+03FPiD5N7PXjPBpZI0n
	 gcpaw1KKmobFb175rdZVGQjBNcbPMPK7vM5lO1te5rchforg62q2BSrKVM/OXi+Qu/5Ij
	 J/kqPlLQUn+cTdfRRuc9GbdJQX7wPmqZdc2tEX8hvbyTDsrZmnhjd+Q/zWVtOrGO96W08
	 n/t1GwhcibVzoP8DX2wXtGeAeptOy3DzN+CqxMFIUoMfNYWtATEuGDA4c5OvlSOnLTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
	b=glzcXTdkoeDWUoo+3A1JZv925hORd2TxXq9VzWf6XncGpDkOt3wEc0G9yjjscoUVDI5u
	 J3YwJVWA44WZ/0V7LsMNMPV8UwbEPH8hRSZMhMIvGllTqbQYQDBaSjxETkTs98F2rshAi
	 QpEio/aodaADSfFRT4LbGuOhP6d4xwFPUaigQSTDL8TSmBApPOUqJuOp0mzOgzNSRhPwC
	 KWpQz00uTLqgZw+Z5MlLbJ+nx9OjfKuoh29bLnO8Ux9FYYnsz3FhLY1I37XQteeQLF4HC
	 u37f/6BlGrLgHq5gQ2v6t8KgQvsPbu9evMckm9HqvvG33iU185XMcVbXmhR5WUoTy0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ScVPpVXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AC606A31A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 06:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E62AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ScVPpVXT
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67df3b1ca06so3137528d50.2
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 22:42:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795416164; cv=none;
        d=google.com; s=arc-20260327;
        b=eQTsRakMnp/cMoPJQ62v9o2eVxhsW3cqF2nctXH5/XxEQPiLrmbXH53CFd7MwHDci8
         /w+yGg3O227AlLE4FpXjTwl8OLKY3v2vUTWs4izkeDvPgQ1G8r9/adHpRLpMWqAUeKKi
         v+35fEba5YnVNp3QrIcOW3lHEUnvbMaRNbc2aprd8MPsRGjn0XQQ9chRI3oE7V2hGDjI
         p+2UBH+NqobRAAD+KRfYdqx9uNiAg04SLRkCoBPnNIYQ3OkjlusilLQiDP0ay/NYx3F2
         13JuRiukls1RTUYFsY7/21mu7foqqeeyTPo6ZMVFXUI43xTGkhdaRIUlO+646Yx6VC15
         y1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        fh=/S9RqlkNM56eprwEd3Ehd7TDyo2NW73KaFj4CuUg7wc=;
        b=d6sHOM6ibYNyHRyG5/rDDXN8IEuxozKgPTr/e59PnIKrqh/T9LKlVN3+oAM7tOKlNx
         iLPqTxoga5172XnEfsi+AltzU2Gq2h3iMMPgqlD0ZAJGk9+1YiBl1UKjY9BrkTzUh3mP
         GFH+BLpAAp4HvPKvrwEv3eWdEM5ZCSY6NFW05hGYgEMQ3f1uYFxBUxUx3rmgBYZE6AMA
         1WZx+RXRWgBtwQ9+abtIIBa6znu7g42JeLnUQjvQwjXoY0xlWeJn4uflUarqTL2kKiNp
         UvtywZJD79CRdDC/oYP9Y70fKVQ+H0lYnCIQ6eBaxFH7IiRsVkMl1lAhHYBnH+f1pJ5y
         KbgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795416164; x=1796020964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        b=ScVPpVXTZPlEkXMOVmOrpFrbcx18M4yy08hKdSrknGePgEsA0KYlK1JTjkk8liiJLi
         en8EFA/UOSUydUn7tdFUr0OTU53c8TrzHtfc7GJjHfLX4Ohd6yADP8zoasW3nR5u+PZq
         yi2p9rTbYLEFcbTnKsp7Phu5W6LA/kca/ozPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416164; x=1796020964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        b=p7SjwLKRSVNDRdc1WGukTwAix1WRhWyIcnGR1gOnkyULWBvxJkXb5sh1h2eLwYr2L2
         9Ysz2zuogl8PzQabImGz38Z1cIq5Pk9Tmf8GPbOIhkdoydVhLjHETaHKvgs3MFc+IayZ
         HBFG6EoihXVwRiih8CYglWJnPJHnQO5SOKJBStKNG3StCEssJlzz49BxpKouDCsRZzJ5
         6aVPJyt1qZ1mv9s8sr5IjHN4CphHoNOZwpDfJm6+oVqR2KlpVdtrbLWul9j5pzH0NLPe
         w3Vb2wkaUYqHD5NbhoMGDzi99aLcL5vwKZ9C7FeRg2ecV4v12bLQqnVZ7t2Sydey8EQz
         UohA==
X-Forwarded-Encrypted: i=1; AL+hErH2MCzmRBBdcnBFGu75baCsJIUaXKHkGmdfb3Y+AHJv3LDOqoE+5eRruio59NK6hnJBbaoYgTtupNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FEUYWUOwKrXSalQxu9MkEetjySBzr+No0fjn+sT4++axlS/B8
	RD5xlIfrg9jTn0MvK1R/BZwvY3tMnnJHJtbLTElkUNPwkejTn1/g48ruaiY64+ZK/TT+teI5Bux
	mBDz0c1TwjyX3MAH8pwQAs8iZIgW5VPS5BkmLJhMc
X-Gm-Gg: AZFdTZdR/jcskHtjbEyZFamONDiT7RS+JXTw/h3Bm+U/WqWtXcafUFw1erVMHt2dQL0
	Ugm/PVgLP13o5R0Wt/1HddxU85AlXquz1e7QsfAhcmISVZ7V0o037bOFvKKDSk5ERVHzlFBn5c/
	PA1Xp04+l1I51fy6t7rUYvFC+nmpG1UjAXN42UW0AlSDBY1qxUH+qVY43Nbw6yGO8jhFh5ossZt
	dmLn4zUc1KiwR8Ydf8uRVo+nw9ml4qb86R5B34yaPxZizeguFAgS5Wdg4qeGMHzLaMBcDYhj7Gf
	M3lOu5Dorp8nlVFjW/Jj9MYNz0v0njcS3rdic3RztGUC98UKn9ya1CORhL5pAO5kMEVFdYIWEzv
	cA9JIpXj7Qe/b0Tbz2bqQoXE4rBQQ+6f+GLwYnW6tnjxmHphmTy4VUPQq8pWj25/P5b8=
X-Received: by 2002:a05:690c:9c02:b0:8b2:bb94:8cb2 with SMTP id
 00721157ae682-8b5204ac257mr41593057b3.35.1795416164019; Sun, 22 Nov 2026
 22:42:44 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043734.2179858-1-wenst@chromium.org> <20261103043734.2179858-5-wenst@chromium.org>
 <avLw2AiqcnO9Blun@shikoro>
In-Reply-To: <avLw2AiqcnO9Blun@shikoro>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 23 Nov 2026 14:42:31 +0800
X-Gm-Features: Aa3M54qFQQaP0XRNtPCyFnaJIa2pdaKUHFg7uIqYmbd3iYo_i21tDqRJOm5IHRA
Message-ID: <CAGXv+5F5hf_8U6j6tJ1WcS6gUCiA82ny+6DXPv12g=vUjwYUhw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] i2c: of-prober: skip post-power-on delay if
 powered on sufficiently long
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Tue, Nov 10, 2026 at 6:24=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, Nov 03, 2026 at 12:37:28PM +0800, Chen-Yu Tsai wrote:
> > On some devices the I2C component is powered from an always-on power
> > rail, or the power rail has been left on by either POR defaults or
> > the bootloader. By the time the prober probes the device, the device
> > most certainly has finished initializing and can respond. There is no
> > need for the delay.
> >
> > In such designs, the system integrators tend to work around the delay
> > to avoid the boot time penalty by simply omitting it from the device
> > tree and the component prober. This is undesired, as the device tree
> > is not fully describing the hardware.
> >
> > Switch to the new regulator_enable_and_wait() function that makes sure
> > a certain amount of time has passed since the regulator supply was
> > actually enabled.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> @Andi: Chen-Yu is the maintainer of the of-prober, so I suggest these
> changes just go in together with this series.

For this series, you'll need to first merge in a tag from Mark's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
    tags/regulator-enable-wait

This tag provides the new regulator_enable_and_wait() function this patch
depends on.


Thanks
ChenYu
