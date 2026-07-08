Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54522377558
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488686; cv=none; b=GczLCopXKPmiPUh3KbHjTdEG5jgtiIpcJqHR208LpyPyHVDIca88T+4kONe+0mQeMIVw2pSY8cXNrGkoqB746ITqXl9U5Xhiupck49niTolUa5Ugn2z4VhzoaGhQREo5WxbGqq6ssoTQd4Gcmfsqk41IlmPNPb7X8yOwjZ4tHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488686; c=relaxed/simple;
	bh=M1uisWYpzgEnw2dPAwJxQhUgRP8dT0LQrCqOeboFjF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eyQWWg7TN9JJO4y4JD5Kgrf4jKaKD0uVt/LhLrCFg8F/7DFz6S1qAukgcNvASfryD5MWsOCEPUPaa02UP+Hjl4TpFQU/5Ly3gr7Yps6LMY9K4Lazg76QixqEyu2lspAqs0UUAnzy9jn5QM0nQ5VNkdvYSdTMBayd9Qu9DHBlbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=EiLwlx4f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="EiLwlx4f"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so170747a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783488685; x=1784093485; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dak4akOszATHUuVHUGcKavDV2nufAV4UMfTBzFNjm64=;
        b=EiLwlx4f55WPUdpfI4MWu162ECC6EotgyMUuD85BrqXMjWj7o3B8JweTTf+w7BIP+b
         dh99sDjDiqn8RpFGxGrwrc54xoyJBOjYtEs3cC1FVAhaZImMe8QRSwJloPfHNWniy6qR
         3+hL06Y3CYoZ6MgZBFaF4dhjHqGfBahSjaN+CvFeVAiq+3pwMS2BA8LgMCBgFY59dDqu
         cc7RJOgmANK7Kt+Y5AO4xsErZ62ebrTDI+B5b5pzC6nlYSEAIFONf2GXJmVE02g3tcbe
         8js6xLzvwlBd8x/VnTwgIoakq+lHRzWrCQl0FaphbzB4hyUVXM5JskpKQZDyj56vbr/L
         uBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488685; x=1784093485;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dak4akOszATHUuVHUGcKavDV2nufAV4UMfTBzFNjm64=;
        b=iPTIrcScRumYwwN/ywor8rwDfhB1CLNt21U9WoOtKeuvJXBEcpPTh4Rm4hEbHIZHiI
         NYU42rAcyAKgh4g0Fdms2hIzHWjT+IeN+RRiQN6ju94Mw7tIU+TixdIoERlygGW26ykL
         KFfZw9fWxQUP61OlhzRj3kL0grb6+KJVo+UyBT2E0VizKTCPc1CbF7opK4Z3V57o2NsZ
         0QkKwNDVH583oTKcPCaxM6c/AEY5L1Zls9nAhvg+Pfe6dUuzj6YQgQ+ugnnlPGo1CXDG
         LrtPxbB52gCNE33heEZ/oH5DPa0V4unf52aJuJsa9uJIyaZ31IeW4W1Jz4UxzRRu4eth
         RnaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIkxnZYldt5k1PlT6Q+36GQch/kB2/CUtAVNR2sIqj91LlMDA0Rn/o7keNpgMsj9hgLdlMZklEuQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyJF2ABdXWP36XB4T1Y0qgwg1CXX5Y7XTTocLkQNYPMZI4QOm
	JtR55dw+a84JyNP0/X8N2HY0PgibyyvQOwISGA+Ke1zl82h6Aq/zcBkNjDXAgzoqEAz6m/zsbue
	mr72usF4=
X-Gm-Gg: AfdE7cl3YH5XPpCKVrJQF4cx6YsZjun9d+iVO80nzl9jplzTa6Ukb1gUndKfdl22UEg
	2oyvzgVFB05T2SBkXPOUE9O9cJukxmRoUsYgyrhnjwS3Oll/Xa8EdInNlV2iMwB6+ZZGil+uzHY
	iEBBAfcITMoYBN2ID8Ngvd1XyQOvlsKSf0amhGDTPbs9jobTZzOpzPECAHXs/YhoDrvbniO7Mn5
	lCnvhTg2p6vLecO2GuUkUrHvCqz0DHYcJ/1hFoymiq95Imt5GdSaOilGiZwWyF6LiYbbDajvjnW
	yFRmXKlqGn40xLCtteKrBa5DsQ4VXIAu9BiONHYdBhXq9GfINTIzWkaYu1p2QiTzwu/BE6AfWzv
	QE9/aRujMCRqserTJlU9MsPX/2IQFPzoImLfcKXe8Po/1M0LVsaE3rtx0QaxgSiQfzA215HA5vZ
	+9Hp7DZA8P6gFSpbe1bCRc5LaDpl/obk6zTcMZ9eatQW5yOke5R2sgcxFbLg==
X-Received: by 2002:a05:6a20:1615:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c0bcc3124cmr1082633637.57.1783488684650;
        Tue, 07 Jul 2026 22:31:24 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm14799084c88.15.2026.07.07.22.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 23:33:24 -0600
Message-Id: <DJSY0M2NCF0S.Y3YUOZXTH3FI@brighamcampbell.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>, "Kamil Aronowski"
 <kamil.aronowski@3mdeb.com>
Subject: Re: [PATCH i2c-tools v3 1/8] decode-dimms: Implement DDR5 checksum
 parsing
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Stephen Horvath" <s.horvath@outlook.com.au>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Jean Delvare" <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <20260629-ddr5-v3-1-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-1-07f45075a51a@outlook.com.au>

Hello!

I'm cross-referencing the code you've written with JEDEC Standard No.
400-5D.01. If I have any questions, they will likely be because of
perceived discrepancies between your code and the standard. Please know
the following:

 * I'm not very familiar with perl
 * I'm not familiar with this JEDEC standard
 * I have compiled your code, but have been unable to test it

Please treat my feedback with healthy skepticism. Keep the above in mind
when reviewing any feedback I have on other patches in this series.

On Mon Jun 29, 2026 at 1:10 AM MDT, Stephen Horvath wrote:
> @@ -2402,7 +2403,12 @@ sub spd_sizes($)
>  	my $bytes =3D shift;
>  	my $type =3D $bytes->[2];
> =20
> -	if ($type =3D=3D 12 || $type =3D=3D 14 || $type =3D=3D 16 || $type =3D=
=3D 17) {
> +	if ($type =3D=3D 18 || $type =3D=3D 19 || $type =3D=3D 20 || $type =3D=
=3D 21) {
> +		# DDR5
> +		my $spd_len =3D 256 * ((($bytes->[0] >> 4) & 7) + 1);

Shouldn't this actually be as follows (exponent and no +1):
		my $spd_len =3D 2 ** (7 + (($bytes->[0] >> 4) & 7));

Reading the datasheet, it looks like your algorithm only happens to work
for the particular value which we expect SPD5118 devices to have
(0b011). This makes me suspect that the algorithm for DDR4 may also be
wrong, but I don't have the datasheet pulled up...

See Section 8.1.1.

> +		my $used =3D $spd_len;
> +		return ($spd_len, $used);
> +	} elsif ($type =3D=3D 12 || $type =3D=3D 14 || $type =3D=3D 16 || $type=
 =3D=3D 17) {
>  		# DDR4
>  		my $spd_len =3D 256 * (($bytes->[0] >> 4) & 7);
>  		my $used =3D 128 * ($bytes->[0] & 15);
> @@ -2684,6 +2698,12 @@ for my $i (0 .. $#dimm) {
>  		 $dimm[$i]->{chk_spd}, $dimm[$i]->{chk_calc}) =3D
>  			checksum(\@bytes);
>  	} else {
> +

No need for this empty line.

> +		# Check for DDR5 protocol type 18, 19, 20, 21 and size >=3D 512
> +		if ($bytes[2] >=3D 18 && $bytes[2] <=3D 21 && ($bytes[0] & 0x70) >=3D =
0x30) {
> +			# DDR5's checksum is at 510-511
> +			push(@bytes, readspd(@bytes, 512, $dimm[$i]->{file}));
> +		}
>  		($dimm[$i]->{chk_label}, $dimm[$i]->{chk_valid},
>  		 $dimm[$i]->{chk_spd}, $dimm[$i]->{chk_calc}) =3D
>  			check_crc(\@bytes);

Thanks,
--=20
Brigham Campbell
https://brighamcampbell.com

