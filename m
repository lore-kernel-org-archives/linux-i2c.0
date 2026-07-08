Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6544D696
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514259; cv=pass; b=jJ03b++JYqQdPGyQnMJ4OZ3jJNWyMFB1v51kayg02GJYQ1ZCsQbNe7pwGudBtNO0vMTznYiIsgi4k0CsXhINOj0FxKAyFGMpJvB5JVNO1slCwSC7VTmIkSAvyhpLByWvSD2WdiYzJGIdGrq1zo/Qcxdo1r1OhTA/um4RElnKJCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514259; c=relaxed/simple;
	bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvA+wz3UkjnJv2L3EHevu1YsGOo1sVGhNAzi1cdfjyQr+jGxVotb1gU2sQaMocOg12eS/zDSvbTO6irJhuizwhFjSVN1Qm5u97XQivj6Y1cGQRjQuso2/wVh0i3Ljp/XCG7PdGeiw8cxtBvXqa3IMK4+bUZ/VaQVJczBTOv6PVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGJnPkz7; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGJnPkz7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39b38198496so5395801fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783514254; cv=none;
        d=google.com; s=arc-20260327;
        b=diilu3YLlCkYp7z1Rzr6wB5ZgBeRwhpiXzOIk6A3zgArY8i8dMOtpR5CKDzI8lRwLX
         OFMZdndI9sMK42p22P7xcIgsLWijKH35Mn7Kc0D+umoob+TUu9QgxH0OiMV9yZhWiyk/
         nQTjdiyYy6UQsngOZJ2TFR7ECXaxm+eESHgRqbFbJs79QrdcLu6KhXpszo5MRQLpz9at
         qQZ+cFfwGSBOVSrM6A3geE1P6FRTQzaeGv5Nt8z54+Qpx9B2EXlHDqMA3G57Ez9JrOSF
         u90KJWQ9xiO+gRexcDP21utEgcFswZodUuby7qlAt7X71IW0j/xGmkYpXIIVXRtezbNJ
         TbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        fh=0Dvy8ZhikcVgf9tRUa7JiCTOcnQv3Ab0+F2f+NgwYx4=;
        b=I17dp9DDWlKj7OEPmrG9WJmnp8jk278CKg7kIlWKkAMuJSF0gAs+7RbKhMqrt5a3AF
         j4YDmaB9cccYsnTlM8BHS0C57M995acvOIGiNMYCqUXqjIN0BT9UxFAW/delxEXcGf3i
         VyXvv2ODBxoJ96ipRf/YqWCldYMNAvTPzP18LHZ72K+Ka49d7AlzxOEMej9IEGkqnr37
         NdFj18lc71QYpE//F2LFuWmZhVG+F5JB4C5pdCvF71agAdR24EungyXvwajUdDP2pHrV
         TgXUtOHfYsbrIcv4dpemzRqCW16wWIb4cf3eRL0AzzAnAjGOC2DtY+PxlKx38QkQleoK
         5uhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783514254; x=1784119054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        b=VGJnPkz7jry3sSBBc6ToDVQ4zShuMfMwOl6gfwbDZnZsRqNUlKvsLeIanUzlfwyFe/
         Pt5ol2TcUDCVjcrUZgoi6nFhT7fVJS/fJjnQZtLtjeJ8LcNVubk2rzPPnJMfppXJ/luq
         SqJxTIItrInFXthF/wqGOqAYZSdkifwXAWjR8YZaip7mbV+IbfaPrpuDQGpkeIapq9Xi
         aUayVXslJtE5+b9f5bbVXG3FFvFd6B3hQkiYNy/MwIolrXty0sRaJnmGUkbUpS9CLmkW
         BGjgTVmVzC5sHqlxl182jB/8L2NdVMcYzuExLG8ChLjfWgzrjhlOU8pEJ6t6Uccn1bQt
         sYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514254; x=1784119054;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        b=WF/JIrZHjoouXwsSrBIw9Mu74+bE8cX9jfGntV1P/2ZCQdA+hpGlJ28gvm5PzZfLsI
         a1iUsUr+etrfkoNwt99WSWXcN09uV0MRxTupVRtGhZ+16SSfjjxLDcIY++qBfBe7qTyD
         ldd/g1F77vsvu/GqcHeh+YRQ4dAEjPMkmIG0aYud5wNy2Hip8uleT+Gkx2FymrDV6/8l
         IcEHTNZHHIlSqyPG/e9WvXvUOKEVGPabVy54YtofyJe9xoy0aNdHiBNJTQldaod4Bo7B
         fxz5VUBeF1HIrhALvh2AkoaSmn60n4avvF44A/nHK8KF/HRJzwRiQSiXryt/ZsNgmVyA
         ccAA==
X-Forwarded-Encrypted: i=1; AHgh+RrAx3l2OH5oQUJGrdMO1JlFXbnMJ7B2d2FdKUcdqRyaj4/ky/ERDlqCJ2O2GRpj9UUGbl4/I/g7EpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xuOspzaOoH/J9h29HKZJquRb23r/5DidcH7gIv/eF1kqt0l8
	7thwGbQM4oKilKNULeAXWK7clWbaKpu4A2kP3/66ZEix4p1acZabXC51x3lwvDE2hgRsycGY01T
	VoPKbJKz2CZt4YjLk1tWaAZrRjNB4Wgw=
X-Gm-Gg: AfdE7cl9e3j8fQAe0kqMe1Q7gx4Dou9xligXtw4HxhJyjYffWTRRqX8owC7Wg3FRwXl
	AtjMXkGYiZRgyConOkUyagaUlXbPeh8mzZuwuDbdaHXQr8xzbyyODnh3emRLTh+K8pgonf3CKSb
	Wi20gaDqLzjd3S92NiNU0UJYxOyXuOKbXZMD/VkYoGCdQb+D04bL4yGKMm8MtqlcG/wNDtNcsmt
	vaAjJeV8Z/wywa2iD8XmGHlIaHD51P0YAG5vRI/CGXa9YF0FL1JArEt2BOne1nzwEJMag7A7tu2
	irX997C3FUUpbLY9BwbxKaUu9hQUIr6Sv6zOLbqdkA==
X-Received: by 2002:a2e:bc11:0:b0:39b:2df2:901c with SMTP id
 38308e7fff4ca-39c79870073mr5222991fa.16.1783514254053; Wed, 08 Jul 2026
 05:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com> <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
In-Reply-To: <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 8 Jul 2026 19:37:22 +0700
X-Gm-Features: AVVi8Cc2__SbyiWeUKOd2eZf6DwFxVexg1Yun7S0NV1eIyHrGLZ-6Z4DPn_Uk_s
Message-ID: <CAO26r3S=0UBOwSetC3cqqCZqwsoj=F3ff_o0_2YknG11+g_z=w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] iio: position: add Rust driver for ams AS5600
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jul 7, 2026 at 5:17 PM Muchamad Coirul Anwar
> <muchamadcoirulanwar@gmail.com> wrote:
> >
> > This is v4 of the Rust driver for the ams AS5600 12-bit magnetic rotary
> > position sensor. v3 hardened the IIO abstraction layer and introduced
> > kernel synchronisation primitives. This revision simplifies the driver
> > substantially based on review feedback, removes components that were
> > over-engineered for a single-bus 12-bit sensor, and validates the result
> > with comprehensive hardware testing.
>
> Please Cc rust-for-linux as well for patch series that contain Rust -- thanks!
>
> Cheers,
> Miguel

Thanks Miguel, I missed it.

Coirul
