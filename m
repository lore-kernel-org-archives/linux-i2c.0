Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3243FD1C
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021467; cv=none; b=T54XgUr1IDQcqB6VLbn3JGJXrUImAmNoLF3I705srhT6zHtqgIH+/japJknrWY5QpXRrEo8hh68Co6HkOO/eDoj97URLfNrt5L9d/nup2B2vK9T6/aTpKit6OX47OFFChJAM0Lzht+5Zh13aub7Unkyca+tQy1hunwTcr2WELew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021467; c=relaxed/simple;
	bh=U14Ixi4PmdDygjLqZomKN7YLuEihwlujxzW3urlSKvY=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=KvtfiV4CvVF1BHcB4dobTzkLzz0EmuFoN/UTsrth/1dvWWm4rg8pDqaW/zv9Na2Dn+7PJSqc8je+UKZHtVPwt0nye03cRjIFhTyABQ5V1MMsKFR5C/Nt5Mmot0IpucB1QeY9vXpnGvoaQLHZvHhXKjYZW9Bwdedwdt8KS5GXqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=mL85lNy1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="mL85lNy1"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so7109944a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1784021461; x=1784626261; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8twvayw2qmoaubwqycxgLztJxY90g3Fc20P8oFW102M=;
        b=mL85lNy1GrzfbbMsyX4a0Zr/ZJamgqMRk7ZU9YG2wGNYYmM0gWqTy6kKEY064eYgiM
         Z8s8MFeYgr3iqCTtGfLwcZcEhDOtf8dM8bA5FJ+ZqNuyG43MSUjN7gYYaTVhMjGVxY2G
         XWbduA40xhyav9Hz5axF0qp+1a/bTlxncr8/jmyFHSERDlm/jpWRxhdYHBSVbQydfIvC
         Psgbq4WYoqK0QRl9E17RpYOi8xMJtPSKqTfIe7GUHBASjhXYSfdi1VJIshn+uOc86XYt
         5PQMDF3rnCuFhtEkqfr89KwuJNkZJGmSoWokSCQVkVqUROELcCH8fAmwG2qlgM9qI423
         T6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021461; x=1784626261;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8twvayw2qmoaubwqycxgLztJxY90g3Fc20P8oFW102M=;
        b=awIUKxFIG1lSr4tX/EtDB5dqPJSO9riGSLKssxRAZgyYG4Ji7qhAaZWveUiT2CBDwt
         cUQNhtRokgx8AwB4PbIWdDLxBDUbVw6jOThDfoS005ZLZTcoQkPwAKIkVXX5RQbfHaRG
         ngy07170C7AxLWZloLEQBN278woUCx8hWPVvCBqMfuQq3vj3PMZxDIZO09yzu3cn+gVR
         Q7cFRJPiOf0ZdmBSWq6pOadLpO8C9jWshi/WrTBqRWWlyuK/yjyXT1jJodcHSl+ognri
         puy4daC57/34bOVsQAwvJhgyRgJIbbp4AjsC1aA5ugMMbI8m1Bu3eQ2DHtj39hbk4IUq
         ltIg==
X-Forwarded-Encrypted: i=1; AHgh+RrCWj/KJqAPKl8l3NmMz7NEndctFcuiLM1IRyalKP440y0FHayVqDOm7ZBY/wllinbbwXZa/T9fDsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjnVUt3JLn18NxSnpCVrFayt9Poo3u+3QMso3WxtGUmYfZ2G9
	hoMic2VoyxJEQdN5ygLJsDkGqsirMFp0pDihZwqA1WXpzRu+ST8rr6iPl/zRNAaudn2QVWVoeeu
	AvyWtE54Ws+Hn87MSzs11JtLvFi1dATEdk/n1zntnugGoD3T3vdwvqJTs
X-Gm-Gg: AfdE7cmewSx40pkCMTg4guFRwXnoXH2w8OiQaJ3uf1Moq1+Jzej4sqO4Zo5OnZR0k0i
	aWTFm8MDbLarZYTvopqn8oiOCgN76PGTNHk+x2WY30qiHYx0lstzbKgXgxK/fqzzmzqt/IOQAyO
	4BxJnUsTNPXCWFEzKGixewPX+8RT9fc49rGdO18biFGcGZeOCGoOMCQW2kzIgMmFCTULwz4LAj8
	mwB6HqVeiVQu7vSS4LZjeCwUNSjdEHjOpnSYzJ/TZ2qXvmv+USpEAcNV0kHEfNymNK2ZBD62eSq
	3zE63KI1aVQlL+MW0oZZ6NvUbGGm6ytoSjyTQa9zDvQrawXajh6KnF2mugFDLbgcZqmwG7jlI7k
	rp0yyhfN7bi71b7lQnSw3i1N0VpFyKW+25LnpuHbs5Mnk6HPtEtCzvsYwOl8MJLn/tyEp3BZj/2
	SB4FpBOUWBPSo5DDrPltH3Jy1O
X-Received: by 2002:a17:907:e1cd:20b0:c16:677b:4d1f with SMTP id a640c23a62f3a-c16677b65b2mr52656866b.54.1784021460866;
        Tue, 14 Jul 2026 02:31:00 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:4076:3d5f:87e8:a363])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1602f5e9c5sm587515366b.21.2026.07.14.02.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 14 Jul 2026 11:30:59 +0200
Message-Id: <DJY6TSDILIMA.2RMO1HREUOALC@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Cc: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de> <alKYhB6PKffxI2vt@shikoro> <DJXC1KBY7IXJ.32N5ILIXL8J4N@sevenlab.de> <alT-251aiK7B0ViQ@shikoro>
In-Reply-To: <alT-251aiK7B0ViQ@shikoro>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Mon Jul 13, 2026 at 5:06 PM CEST, Wolfram Sang wrote:
> Hi Gero,
>
>> they have non-unique I2C bus names which uses i2cdump and evaluates
>> stderr for the string
>
> I get your point. I'd argue that relying on error strings is very thin
> ice, as they are not an API. I think error messages are going to change
> with this patch set anyhow. Probably for the better, if done right. I'd
> suggest to continue with the series based on our feedback and see how we
> end up with the error reporting in a user friendly way. Maybe we can
> even use better return values to help scripts? We will see...
>
> D'accord?

Agreed, though I would keep the return values as is for this patch set.

Best,
Gero

>
> Happy hacking,
>
>    Wolfram

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
