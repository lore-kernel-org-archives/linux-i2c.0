Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078630C610
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956998; cv=none; b=gjXSqobngQVMJuiw5IuShaC/cT33CNmDXf+gVIULv3zO3qzIuWvPs8oEgJH7bLJES0g2xAopdXh2Jbpcg7p/PTcQQ+J4KVxXQ5x1hQYDR551g8XN4UVdBrek/ndHuznvFfe3yl+fLbWzMFSkF+/x4jiXU7E1C3WqwUEqaUzuhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956998; c=relaxed/simple;
	bh=wbkMwk5bnt4Sgf/PzP4xurpb5BTfCEV2OgvAd/oWN0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZXMgSPYiFHK2alg45yrkQ57FQ/ME/5ATRTMoMd5pye569T5zd5pytvmdUv6/5dtOFMXwGiDRxoJtoGIT+Vp9apDj3Amtq2gVYi9nSa3y0por1RMPNsppOk0kfK4gyMLU9wkwS+Y47yyE7vQXcqM4y3q/PDFOaE0iXJzqhMUjiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=erHCarYZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="erHCarYZ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1979804a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783956994; x=1784561794; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnFDyGeQaKUaMg2ab1VtJ3LTchxZosU24JbBIglsraE=;
        b=erHCarYZrDP+l4A1Sl5nANDc/W7UQadPHbYTR4SsAcoeRRwmy+P3RWYlZV7VLK2VOb
         JWIn2OZQYnvCNwHtrWjw8w0fS7pZvLBnWf8YLAEHDbRdZh/OVgywAQAaOSU0h6yrOziV
         CbUm13ctgBDkSJyOw0XN5FKiJ5DxuNb9Flkx5ldomtoIFHuI2xIAEZPSfajXZUeTMuhX
         7vYOP6uKe17dYQKncPIfM1X7VrfOL900LbuECoacOFkph0ViCgIsm02tZ8o+Yc/GdsjY
         3f9qOLYdZ/XAteak35yy+vM1Kvy4gU2W0E86+jeVkAcDVIt9+drK3tDfPRlZBt7AhCCL
         7nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956994; x=1784561794;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnFDyGeQaKUaMg2ab1VtJ3LTchxZosU24JbBIglsraE=;
        b=Y5xy59ZD56lexnvnny/b5eUHg6rMA9WSh05B4zcWF2dH6kx4Eu6Pqr1inyO15hr45i
         5j3/0mPRPFIRoE2sgF9Pi0szRrb2r9XdOXsZcuD60nM/wO5ZK0AsNmdHHj5aOsIQ4VV7
         JSiMqSlYBtXmHUULHXB02Hir/3+KEi+Sel1RW9COjauACwBLLoXwnxPRtk2FY6HKPPX4
         eqKWTi0gnMnnH2HR/MKOibG++I7QRDiNmzhbJiYHY2Lsdn4i4y4/Sie0fnm5Hf+1vEPZ
         GzBYxW00zqbWGjRJ0qRQ29WdQg5DmyXG+yon/WXWXgp0SouWeIty9woBzQBkQJEmSmhC
         3g7A==
X-Forwarded-Encrypted: i=1; AHgh+RohD3YfnoUn1zUDOXH/LiEHsHkdv//z+B9GK9jvCFm+tSk0iOWmrG/DABbWJIVCARWt8lZc6iTHShc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeOD/x2RK1LTaSfwu4niIrLC+bWUDenr0j5Drb9XAREQkdec1
	Nq87qKzHtFvX1H4GORLM2FYTNLT7D9aee0BDUTYJtbnSD3I0IzGX0OB/bc1nbWou6HI=
X-Gm-Gg: AfdE7cmQlQdm/aFKXkVeOhw4ttx41IQ0FhfXLdUdAIFK6oKZuv1QzLXCW5wbHHnUtkn
	GRLtCp0HNxml4O9rAAF4L7d76VRqD4YMf4eq4N8GRxdhBK712xO/52yxDQiPmk3Bg8vqhMAVb0P
	EzmEJoQKvkbZJjT+yLd0fFw3beuoOua8GXx3ZjGznkepmMn3tksL0JIJFs4jYskpf9han6UljQV
	wjRfVsT18Geo3GO5ZDhAX9w+90mNVZgd8vRDiM0Pvb/3FJw4SfcL8wt1FkwoEymMejy16OelzKf
	5q28YEg+yPlmCxD4x8kO/O6WRIZh4H1WDwqxx6J8VB8GkCMdfeIwYiFbYopLl6Gz4hPQlb6LGk7
	eluA3iHbT96ayr+3PQxLMkc6w3+VHQNKC4M3+7e3x/FCLbwXVHxm33BQgmeYOJ51s2Wyt7tnNaQ
	HCvDBkDvG0NxPov9Bbw410xb0jHbWY6mD7twMxtyaQi7J2xsECz7psyoHLtQ==
X-Received: by 2002:a05:6a21:502:b0:3c0:9c1a:894c with SMTP id adf61e73a8af0-3c110b2f98bmr10384951637.68.1783956994243;
        Mon, 13 Jul 2026 08:36:34 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm25356346c88.0.2026.07.13.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 09:38:50 -0600
Message-Id: <DJXK0VTX8680.10EZPJHF4UJN6@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
 "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJXCC2TLMKGV.GQPIOKMUNXD4@sevenlab.de>
In-Reply-To: <DJXCC2TLMKGV.GQPIOKMUNXD4@sevenlab.de>

On Mon Jul 13, 2026 at 3:37 AM MDT, Gero Schw=C3=A4ricke wrote:
> On Mon Jul 6, 2026 at 6:27 AM CEST, Brigham Campbell wrote:
>> @@ -446,6 +442,38 @@ int open_i2c_dev(int i2cbus, char *filename, size_t=
 size, int quiet)
>>  	return file;
>>  }
>> =20
>> +int open_i2c_dev_path(const char *i2cbus_arg, int quiet)
>> +{
>> +	int file =3D open(i2cbus_arg, O_RDWR);
>> +
>> +	if (file < 0 && !quiet) {
>> +		fprintf(stderr, "Error: Could not open file "
>> +			"`%s': %s\n", i2cbus_arg, strerror(errno));
>> +		if (errno =3D=3D EACCES)
>> +			fprintf(stderr, "Run as root?\n");
>> +	}
>> +
>> +	return file;
>> +}
>> +
>> +int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int qu=
iet)
>> +{
>> +	int file, i2cbus;
>> +
>> +	i2cbus =3D lookup_i2c_bus(i2cbus_arg);
>> +
>> +	if (i2cbus < 0) {
>> +		*filename =3D i2cbus_arg;
>> +		file =3D open_i2c_dev_path(i2cbus_arg, quiet);
>> +		if (file < 0)
>> +			fprintf(stderr, "Failed to open `%s' as a bus name "
>> +					"and as a path.\n", i2cbus_arg);
>> +		return file;
>> +	}
>> +
>> +	return open_i2c_dev_num(i2cbus, *filename, size, quiet);
>> +}
>
> It just occurred to me that the zero-copy pointer shuffling may be
> overkill: I think using `char *filename`, instead of `char **filename`,
> and copying `i2cbus_arg` in case it is a path reduces complexity at a
> reasonably small cost of copying 20 bytes in the worst case. But it's a
> matter of oppinion I assume.

I was not interested in avoiding the cost of copying 20 bytes. I expect
the biggest performance overhead would be the actual i2c transaction
itself, followed by enumeration of sysfs in gather_i2c_busses. I'm not
at all worried about a single strcpy.

I was actually interested in accounting for the fact that because this
patch allows users to pass in symlinks, users may very well pass in
paths which are longer than 20 characters. In this case, the filename
buffer isn't big enough. Rather than allocate a new buffer and copy the
string over, I simply copied the pointer to the path in argv.

Maybe it would be easier to understand an approach which simply
increases the size of the filename buffer to PATH_MAX from limits.h and
just copies the path directly into the buffer via strcpy? I had
considered this approach. In this case, I might consider moving the
(much bigger) buffer from the stack to the heap so as not to overrun the
stack frame...

Thanks for your thorough reviewal of the code! I appreciate the feedback
I've received from you and Gero. I'll try to respond to some more of the
feedback tonight.

--=20
Brigham Campbell
https://brighamcampbell.com

