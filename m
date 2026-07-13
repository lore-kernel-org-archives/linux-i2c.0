Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81BE3E3DBD
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935451; cv=none; b=oBjaUQbkm/IQ1lJ4gTgHDLch0saj68hNAJBUqU3kd1uvPGI0aeYWMj3xUMPL2PpRo6UQfeBg0RDzsnqVW6UPFk6BeoWdW7CpClKwTAnA8cDr0/S49UnJyWIB5byTj/ncCl6QoroEWxvPXKUSPjxZ+nRgibf8CN8xxhu4VDyWP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935451; c=relaxed/simple;
	bh=5OYRa/UMawELMpsEysjPSuApHW+l8Ymu6iwXV4JYg/0=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=T2GoLfCkrIh7J5hlNQ21ORW3p5eeNP7g52hECWrRT2YL6XCgtEyKSHUVDBo8joCe3GnuyNHES/lD/JMvJgB4jE0ODMvm36XikjfhnMu00MPOqtfZ5zRIaYJCgUvlytz9B1AA8SbhvOAn+QLps953TCOo9nHja4yddesNyMTNd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=TOnhn10e; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="TOnhn10e"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so1808143a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1783935439; x=1784540239; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ekhyd/xxPdDTypWiHzOSPyXc5RwDzTQLY5V9pEC72eA=;
        b=TOnhn10ePoP4iXATplVP/5OqN/tD6U28Ca70A3rjXGS0iZjvaVgynstiU9pZVs3zuU
         MTmsEsHpb4VLd9VQBwdygSK64PzU4AlpR3jd+WX0bmlsn7kKD/iLrZCikuH+7lvhY1aX
         JAIz6lHryL7kVEpZ216HKh+gYn8+c/p9TxtzIfltVJdo4RLTbPRgpV/rgG0tTavE8lad
         6yxALUO9XMVOIF6vPjEcwGSfgel8H2UnIWuboQlOyJkc8YCsO8BgWIvu1rbiZYSOagpW
         Vn4dY89oXoYUHp1qfbXAAW5pGYsbTyXneOQwFTtOGj5epOc9TPmL7cik7AiDIm/2itYG
         2dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783935439; x=1784540239;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ekhyd/xxPdDTypWiHzOSPyXc5RwDzTQLY5V9pEC72eA=;
        b=h9uCc8W0l4cYU/X+wrz4/Smsv0edhhHIdDlSXe3iQ+Z/mPk9ZAXDeGZsgTCrnZHeHx
         JKUi7y+TbeGZ7M2FHIdnDm13Skq4b981FPR1vWwArS1WQk+WDkmx9yz5pU0VwM6JCTyM
         w+WGa1qeep8QwaNwH2C078Pvi33cCNXFZENGKKkRAqt05z37tL3IkK+oB3d/96eT5qND
         pZ84BijebAupETVw8TpjHsymnsRGYGXxF4rBI5oDGqb3rOswH6aYwYVMK4OxLzhcUdQ/
         jeLMtkKiNurHiIFf+xEL3XG5hFvZq5K8PCCGnRz7ZDKqcFc6jxmQVdEIKLSh2RxPgrbM
         18mA==
X-Forwarded-Encrypted: i=1; AHgh+RrqDaeMfUoRcOa0moWu9Vx4AGXY6F0GAcBRqA3h9jdM8MXnD+iMjggW10J0LMs7KOQdyb/B8cUbwu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWeiyfm4mbxJvuT+sAbRU9FsNKyd+1lPVSMy/Kn2UPTLy3Opx
	3ZYlSxBVoSoH7UDsQT5vxQ/u7Rb1RB8Xp9DD+1/DU/mfFmTcWhc6grPdU4ol5cpDn+0O+orkHDT
	DMYvtAeHgmmMtqthQs2RYHjpdnqcZXMV4LLwAIBDYAt6gqgMvtKlvyv6b
X-Gm-Gg: AfdE7clcImrgLq3hoDu/IVA2YEckb/hRr+3w3sRJbfZ51BqcbiiwzxD4MBGG9H8zzAa
	lpeN593mxDtxWQ5amAtZMVbx/XhhxeVGRf/jq1bZptPj+d3Pzm3NX5BYeSQAxulw8yMKMc1agIe
	lD9Tsw4BXGg+R+ywmFP1yHWt5ZanJwO7WBAARe/y3GuDe7fF1pCixEW/GcbgYbaNoXaQzc6mfKk
	6FMFCJXFxC2w7/GBNmDUICARLCJuFNnW1GNiuEtVBo1h6z5J6XjTuFz5rot6jgPsSKn5ps8BtVs
	i2IJ1uU0Lfdmfz52CtFl+Bf2Aki95NBJBwgKtkOsK1wCZX/fDm4ME9a9ovD4YBZK98aWHGtQXXC
	t9xX4pqlyazB2IKI/Mw9kBLliZ9l0whWuTmiC9LUyhkHicmKCqEgtzMuy6b/TvH8vxIubK6Uwah
	9INOpX0cFqH3hAfvCTStHqIstr+nUR8GBs4I4=
X-Received: by 2002:a05:6402:5256:b0:699:fbe4:16d4 with SMTP id 4fb4d7f45d1cf-69c5efb8717mr3091352a12.18.1783935439506;
        Mon, 13 Jul 2026 02:37:19 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:1387:c6ae:4e5c:a893])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd3e06d6sm6870926a12.26.2026.07.13.02.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 13 Jul 2026 11:37:18 +0200
Message-Id: <DJXCC2TLMKGV.GQPIOKMUNXD4@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
In-Reply-To: <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Brigham,

On Mon Jul 6, 2026 at 6:27 AM CEST, Brigham Campbell wrote:
> @@ -446,6 +442,38 @@ int open_i2c_dev(int i2cbus, char *filename, size_t =
size, int quiet)
>  	return file;
>  }
> =20
> +int open_i2c_dev_path(const char *i2cbus_arg, int quiet)
> +{
> +	int file =3D open(i2cbus_arg, O_RDWR);
> +
> +	if (file < 0 && !quiet) {
> +		fprintf(stderr, "Error: Could not open file "
> +			"`%s': %s\n", i2cbus_arg, strerror(errno));
> +		if (errno =3D=3D EACCES)
> +			fprintf(stderr, "Run as root?\n");
> +	}
> +
> +	return file;
> +}
> +
> +int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int qui=
et)
> +{
> +	int file, i2cbus;
> +
> +	i2cbus =3D lookup_i2c_bus(i2cbus_arg);
> +
> +	if (i2cbus < 0) {
> +		*filename =3D i2cbus_arg;
> +		file =3D open_i2c_dev_path(i2cbus_arg, quiet);
> +		if (file < 0)
> +			fprintf(stderr, "Failed to open `%s' as a bus name "
> +					"and as a path.\n", i2cbus_arg);
> +		return file;
> +	}
> +
> +	return open_i2c_dev_num(i2cbus, *filename, size, quiet);
> +}

It just occurred to me that the zero-copy pointer shuffling may be
overkill: I think using `char *filename`, instead of `char **filename`,
and copying `i2cbus_arg` in case it is a path reduces complexity at a
reasonably small cost of copying 20 bytes in the worst case. But it's a
matter of oppinion I assume.

Best,
Gero

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
