Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9873E3DAB
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493174; cv=none; b=XTPKqBJPb1KVA1etIP/2AZ7J8SiLBAT4B1cqnT+ESch0jMWK87xLA3FjzOKJrRm9OtHH087YQxSRwCyvP410LYHbZ2v4RbBxnSyfFLKy9uQHHozxmbfzQJUBMI2SBDrlVXHx0eDIChbyYAvWKUvB76xqDCsFOJLokEUQyXIvR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493174; c=relaxed/simple;
	bh=dhGjIacFvKEqbBCGF07+JyMUdOACOVN7osK5/UydeLo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=RaiHPwhOeaW2he4bLRVQPy9Mt1D0Cqgn+wfEomDxFZEBqXxEfZblsIOv8Xha4ZY5nU72TY+/fc5ZTM4Sgo9zLikYg+Fa3F+hO4bc90bI8bXdcbFP3kxdr6UOE2SWrL6eS6Ejp6ow/AaYqDZAamZPkmr017PxiZB/2Rak76YZar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=MShSfolm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="MShSfolm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8482074a000so242588b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783493170; x=1784097970; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dhGjIacFvKEqbBCGF07+JyMUdOACOVN7osK5/UydeLo=;
        b=MShSfolmn5oyrLZ/B1QNVrRJG9M7Ycsl1Qc5ZgYYLFBgqzQeNbqCkq67ocBfXCWKqp
         RE9HPh8k+DLS0LnJ8Pv5wHI49BywqXqOJJQCFmqqYuSSJ+ewHEqm7ikGZUCDYDZoWXD0
         P1WjypnbaFI6nHpmDzv/NT0H7n/+EwqnT3LbymjrE4WwgNycHH/SPeBWWLykuRhRElbA
         LsY1b3wIixYOScuB4bkrcEy0w4ztDvhCUI9a3B9bKPpoxvNEXWJPtQnKps7t0+IqTWZh
         naIjTbQ51N9y17sUo3usm/Oq40Fcbp5I2Ktca2AFlnBbfRRKmckjCeDEznR4Elnjmvel
         s+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493170; x=1784097970;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhGjIacFvKEqbBCGF07+JyMUdOACOVN7osK5/UydeLo=;
        b=pP0HccEYM0AZFkV96a1xefUMVXSuGpc/XWAjgMnZ8oETc57QncKj5iKG/hlhwo1qS9
         xKNBzUhzUrfRWFgYUgEn6TUAJHObuxx9V+nB6mr87RcoFqqLkonixefhBZTKonpTA3ID
         4ApMyGz3IIv3vVqp3UNFBVZTbDUCGAgqQ2Sv4mZWPUMZtrrDwVMJUYT6+hwMWuuf/iO+
         gXmUwKZWIZcaF+Umg92P8L972/cH17QQUZR2F1rotY2jyPTv8yM5S4xIjkQ7j7q+2Uv1
         9S03MSi+Hp4w/P9iQnkgn9CZuZLOQKhV10wGj7HjL3G/Ht9G5m7FE+8KOSSlyljEK8Du
         GfSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7u3ZkeUVmaOD/CnZsNtY1gimbCemjEBP5HxJswTGrwiPemNqqpL0jkdJR/mPlzj/gM3U3TYTF9Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGeVPB/yDsufWgqBGbO2bDszpcvOuAU+xi9w6uFX1zmf3gcxJ
	4mHx3ayIFaTvVAzZVrxQUby6Bh2Abhw5ldjV7YrrX/dS0pbkDyMWGLz1T2MOolKMOOSJsyDHsgT
	T/pIUxto=
X-Gm-Gg: AfdE7cm+MfQckI2YlBjNlb/q8gMNTLDk9NA8szEN3D01Db6Kj7qHOsh6USwGybJWez/
	VXptyFH8V9/ZvvbI19QOa8lIwWRnkizXEeocUpEDfA1I/3KDsvfhsXkn4KVJzj0fBQNokp5UT6S
	koyKSYQW5MYJN3l+vkS8Qbl6f0uOURi7bvkDE1orQU8Ez/lCCpCyyxswWVZy4wofVxfnbMTWOXJ
	09Zk0sc8+jkHBAHUQFwqvXToNCxumqDZl4wxkvvdllTXoWM3dR40uG3fcIKRwlQVvkIPngNZSFJ
	KHKMbP9TsmZCPjjk3Ss0ZHK5zwVixpdMID4ZqGFDrSyF2QXUwaeYlE23XigrZYMB6031pW/UE0t
	ZyAtb9oYWMkGml6AEkKQilToWQiwdVlNoR6jsGmOcExC1gxm3XCSGJ4oNwaeaI4U3eBDVmq5yBt
	HGpl884M70U8pbkL5LgfbOj5zz7tVdspCZZ862kOiWMYDFqe5KYGbPLmnhow==
X-Received: by 2002:a05:6300:2288:b0:3bf:9cbd:9a39 with SMTP id adf61e73a8af0-3c0bc8a3ab0mr1351007637.10.1783493170324;
        Tue, 07 Jul 2026 23:46:10 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm17804683c88.1.2026.07.07.23.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 00:48:15 -0600
Message-Id: <DJSZLX53OSFO.3AMQ57D7GX3JN@brighamcampbell.com>
To: "Stephen Horvath" <s.horvath@outlook.com.au>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Jean Delvare" <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "Guenter Roeck" <linux@roeck-us.net>, "Kamil Aronowski"
 <kamil.aronowski@3mdeb.com>
Subject: Re: [PATCH i2c-tools v3 2/8] decode-dimms: Decode DDR5 Manufacturer
 Data
From: "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <20260629-ddr5-v3-2-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-2-07f45075a51a@outlook.com.au>

On Mon Jun 29, 2026 at 1:10 AM MDT, Stephen Horvath wrote:
> Decode the DRAM's manufacturer data for DDR5.
> There are more manufacturers in the common and type specific sections,
> but only the 'Manufacturing Information' section of the eeprom has been
> implemented.

The overlap (and possible collision) between ASCII-encoded and
binary-encoded DRAM stepping values is unfortunate, but that's clearly a
shortcoming of the JEDEC standard itself, not your code.

Reviewed-by: Brigham Campbell <me@brighamcampbell.com>

I'll try to provide feedback on the rest of the series tomorrow evening.

Cheers!
--=20
Brigham Campbell
https://brighamcampbell.com

