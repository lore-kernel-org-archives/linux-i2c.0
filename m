Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4623AD52A
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731936; cv=pass; b=TZR8H8KNZgeiitPk2l9EcTwCyzVTCQvI0EMBVIUFlE5C74dPHWenXwOtzuNhf4prJ74Rr2Ca6DX/PhT2IATvlfbUyE5M5OK1LWLsC+Xu8/dIfwLAky9GCQQq+SCWlLe+gxzta9njaywxU5uTpUVvKbU1mPshivh9nr4LnTRj6oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731936; c=relaxed/simple;
	bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQy1Lvc1JpmUdfKVFajKD9+cF8OfjzemoSQj2t9uE5L156UqogzN3t0uriBwhobTX2lfofupNKu7MBrIGIIQ3MRFCl14BeRPEKWPBv33ihTBlVXkkBiTkPXmVgxS2Slj1c6NTppJjaJ2HBFkBE/SJJ1xgcVO7bgAti3GBLoRB9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5l1aymp; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5l1aymp"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d06b5f023so998484d50.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 01:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731930; cv=none;
        d=google.com; s=arc-20260327;
        b=CdlDQSOWrixVkDqn2ZO4SG9bdchw0iKggzGN/32ojU5WkZ9n0wlohXeHgESzNFszS/
         1tCI6JA67EqqXmlvm0zDwAFq5/L2gxrcch5MaSN4wtutHCEGU7lpe7cz3BGs/vXCWDF1
         BRqUXuo+88Ncq/vooKjS31btr5We0zcLnZFxrPZ1VfhwY5QR9897NYrDmaFCJUw3oRxG
         2YjQCLqFEiPSgeJSaTO/Chte25WeDfD9W0gGmlEqSBpE8qbo1SMS5HF6TVSYPUdUaT4E
         +dqLnuJLJwrTh+R97ExiSfAJtBbz3UDgpsKK2EgCCODf8SS/ZYujvSgX0zL6vM10M+TA
         TT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        fh=iZIBzLbN337vs7qhRtucbko8+Z7ChbuNT02sBx9XMgo=;
        b=HbmX6/w4zn6LRsHSHmaGbYD6uV3g8DVoYQl4rpI8EVhPX/MAC2NM2seg9zdizRYiww
         koAefFwe9dJCyGFgIcdoyVIUOyf0UvKt+iFOrvZk49v7oc6cIsaXfXxcr6YHSef8HU7D
         nRE7klIeYvSujg/6xyGzpjCGOr3NbmLaMm0EwE7jBnfclZGieg923lAeClhnmFb2Y//p
         YaV+88EhAMaQ4o3NB1/Nf28k45Phjd93u3awzoMMXR6Y0vGLit0/sCHrdoC6pdP5LRfB
         Fd6aZM03hbC1I0Nvj/82QYDVvbbUFjmCyiB47luv77FXI0xJyKeqfmlzAyIqYDNr1hmN
         VXVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731930; x=1788336730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        b=U5l1aymp+WuwBOuCCbnmwrAOwZxhd6SSyuq2tePFoaFPQ2YP538mhmlpKMUDE8Xvco
         YunlRT/QfGFQOZvwLQ4/VnBJEYKn5IIvJRVL+VQdllELyA9B+kDWkM6JDDcKwqRiu+yV
         UptSuvdGXiWJyvOQ5Y8MF3lc2zGgdfWYqELMH+Y1t+8Jfh1ReAUH9OE//SKS15583KPX
         ZtioN/PiNMq+hFM5KfDAV+IIz9A90vnkW4DSyZKm3wZ0UiEEQjfbuziRI4v3t842uTl1
         kF5rBOQV2jGQL1QYuni3t11nHUT4KQawzM3/In/cFUmqVKLlOfBlc6XQ3Glonjm/pC1R
         0t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731930; x=1788336730;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        b=NcCOpPauZ0o6czS21h8RRVA6zgkoo95N6+5d08t7OWHkdvrpSi1sCPj61JMSDvcPrL
         bLTA3cUL0lAsbsGdTjogmlqjGg/cVx/n/iUHqURYUkOSYFSuNs0CpSFxeIyWysCywWfq
         Zr5r2mi3DgkTV9RNnANAug8p7jfXurZfntvM66Lw0gPKxoKzlLCQnpBJsufVQZ8Q5n/g
         TqKlAP2iJauh0lHHKcS84KphmoIdzrwGSFWXLePgGbc49sCoWPLbCSep1yzg6oZfSts/
         ViOLiJaABx+CGT7lORWwbdjbfpQ+Zg1T/ImgZQ+YGuIPi/CIAgHJ7ak3oxuFttzK5lUI
         O6Zw==
X-Forwarded-Encrypted: i=1; AHgh+RppJvEJ4l2rO/wJIWihT0KP0sKmLgJ9ppd0zgB6IR+I0t9fRYz7gn8ERF3j0MG/BJVlI5EBGS7BRAE=@vger.kernel.org
X-Gm-Message-State: AFuF++msImM8TjZH1gz9YCWks34BsHaEp1f7L89n68iXPHQMGYL7lJq5
	7O6huyLU4F3fCrl047046q5I7e0kMaHbnd0O2LcJfK85lLK7pqm1S0p4rLZCQlgWK0aRXqCJ70V
	FnYzQjUiLGRGFC9DJFDkn5hCnmp7qkGU=
X-Gm-Gg: AR+sD10sAAnT+RlAKktlcr9U6twz+zF7/RL8+oRUfCKsofa1Iqn7WnXRglJLCS5vbiF
	zBw41GKkUBzBv8Gs+coIthi1WVZrAIdln0Yk2yDNYiMP6tHc2XcRx4B+EDC/gK9beUyNSXqTtm4
	/MbyA9bthvuD+A25+nR5Sxcl5cCoEcNKmoUSEAEeA8pkBH3V5w6XlJ35Nt6OEuqlSM2QSJ4/8VR
	4VHs3SwenpMghSaVcl4q0y9WHUNUlIH7Br8qPgr6rQIJeJc2ESP5zghu4AToPhCyj9ZsoGIeA9S
	q4+b8zpIpNjt5f4+jGSUizZyp7mjFDMUDYA0bBhlWvMOqWk=
X-Received: by 2002:a53:d009:0:b0:668:713d:893 with SMTP id
 956f58d0204a3-66d256571b2mr1358761d50.4.1787731930255; Wed, 26 Aug 2026
 01:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809073055.2980971-1-lgs201920130244@gmail.com> <5364b64a-f4d1-45af-ae67-f7cc1779cdf4@kernel.org>
In-Reply-To: <5364b64a-f4d1-45af-ae67-f7cc1779cdf4@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:11:58 +0800
X-Gm-Features: AcwNN1VpJeinnGKw4tuGLUqqDDN5XTtkgza0_JQMxp0Jlx59svEIm7ca6TXZWUo
Message-ID: <CANUHTR_RXWiM7enzFg=Q-jNywZXgcfBD8ATsiuegTAFHjC1y_w@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware-pci: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Ben Dooks <ben-linux@fluff.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 09/08/2026 09:30, Guangshuo Li wrote:
> > i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
> > i2c_dw_pci_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> > remove path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
