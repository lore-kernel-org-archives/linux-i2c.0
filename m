Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BD48A2D1
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156876; cv=none; b=ssL3Uo5xOIQIZX8Hl5sJ/EUw2BMXXdZSmcutVGu32UuoD4V6z+ce0Pi+yaGGoxx4i/hgHSaVJ27Al2E7bONPkkYFgZUysnp2i/Nqh/hQCi0b02REZ6jQI9IHifos11Hor32tsPEWABYwWINQKZ83IkMLKgGqrdsDpVmiMGSAecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156876; c=relaxed/simple;
	bh=OIBEI+0fMCxI7Yswc19lvMAmd7xOGLTNwGEmrNKGrbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=actCN/JcSgb5Xs/Qn78aDIb0M0PrrsEcdmprexhleo8XpKTKWykdvE/pjvdN5vLCdtE7W/vkkNu6occJxIrTIG3wgPmGgiTc1UTVwnBmqny4QlE/J8stlAhGpoBP82RPM3WvUltNlL7ZfDEHe/qNVuhU4RTZG32FP5Kxuu1KOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=El5IutHp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="El5IutHp"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so175987a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787156869; x=1787761669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xB5cV/IpUwGGn95R+d7ZWsJZCR4HYoIRYae+bPf2q1A=;
        b=El5IutHp2TZ0WVk48r7JpuJZbTZITDhZaw8r9toiQRKvCo5YjaZi16pG2pUxTTedqP
         EltwgZZ5yHBJBZQ8d03igzvD8es5t0UKnzn9PvDiTkls6t8ALhxi2rCv+V5b+wZEN5Fz
         vtkO9Oa/TncroV7hCAMlL+acirHOSrl/TG2uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156869; x=1787761669;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xB5cV/IpUwGGn95R+d7ZWsJZCR4HYoIRYae+bPf2q1A=;
        b=L7V+sV96YDfCB6ZpC2epIIUIeaLACpJYKAL0YCq7XwnJlT4Sn+83lOgdRh9OeDKsJL
         fvaMmRa25MvKFlaXG9b8J8Bov/iadxFu+8ejNsXx+GeA6GciDB6ZvBG03ly3DxuxKvek
         JoiKOOO3Ma1tv5ZN0GqwD3fzIll8P33Q5Bfqxfi39dxB8RmFEz28ZnChgDyUfBCtIL/E
         akCfsFa+Og8e8lKxh8XTYlboX5zh6t5dWl/m6O+4mGQaXsqjT5L/HRMTWrZefawxKiLL
         jMkWylambc9asxpF2VQdTdx0+HDZeg37nG+8vwqCA15GUC7YqDAWw9BoH/XHB57qAkr3
         0hTw==
X-Forwarded-Encrypted: i=1; AHgh+RphKZ9fQJLPHxuGHsFYBwnzFmPMTy307ZF7RrPwAhFijk47MC6SbayMTA7DUbq5z0SeGgefaYYHRBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNUEGVWpTO144O70is3kzWGNtcBZy7rzB3H9aTVqx6b+Vzp9n
	alXAnSSdBS+elZxUDBfExTfXU2Jd6j/1sdPEmV+BZIhXSAPNu83lPaPnz6McjXAjOeJd9D2kMSY
	2aqg7Mik=
X-Gm-Gg: AR+sD13q8qrzRJn/kmglXxpRRvPjRVqTmfSjS0LnOAJKnHr88LbwovXjWnGEFpCw/36
	aczPstbgJnx/FHHHW4qc8igd39DJV+X9X5DdE1lWj3VwiUv5NVZI3EN8l3YDLIy78ejwUIay+1h
	fk8R+JCGsiJVCOtP+D599g8uPrOKzPXh+z36WNBSHOlqwQoLelfxp7ahF/emnGPuilu1FXVGOpC
	IVjqf2+2J2GlkIeIcmlh/yGEriIANyoOiRm86zfre91KtF+MHb+UDfb3dqCCAgMPhev7XLF7rUk
	qFLOPj/hTy+0mSFaWyYA5dxTQTAKGSESDKNG+1RkaJKfxlAphlcF/kjEuvzpViwGEwcLLIY4+GM
	oNQ6g292mvEhW5Xft5u5Tr1OnYlEv4IT1FndYZB1zMXKHR8xTrWDeNc3LdZ5EqHxtImHrRNwRNP
	QLtVy82DSeuJWukAjNLgrmau2C4NhyMP4tRlrCr3semj1hyYnuBNz05zAtxG7beI4u/icwjbzZq
	Fq7wlbhU+W1Y+tEeLN780xaF00O2lU87XvyMKwhaAOYaJ+5SKIzZw==
X-Received: by 2002:a05:6402:4609:b0:6a1:1742:ac22 with SMTP id 4fb4d7f45d1cf-6a4112442b3mr328160a12.2.1787156868704;
        Wed, 19 Aug 2026 09:27:48 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c315dsm1117211a12.9.2026.08.19.09.27.48
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 09:27:48 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so109162a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 09:27:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdxvQynb9kTIrvGbeUNKQ1/la2T3twOfFHWjgaf3T957Xgg+M4ooY08IwPqzVpJHFUJnZpG4aA0I4=@vger.kernel.org
X-Received: by 2002:a17:907:a0cd:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c244d74f75emr17501066b.10.1787156867854; Wed, 19 Aug 2026
 09:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
In-Reply-To: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 09:27:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmXanEnJZ9C-r8SFPSU-8Jpsnz7YDJfduZCkF-CG0BZA@mail.gmail.com>
X-Gm-Features: AcwNN1XYG2fvzzoZcQqLVn-EiBzfWy0bZfNb75LglQ6jfN-rQ599B7V3VjIAR9Y
Message-ID: <CAHk-=wjmXanEnJZ9C-r8SFPSU-8Jpsnz7YDJfduZCkF-CG0BZA@mail.gmail.com>
Subject: Re: [GIT PULL] i2c for v7.3, part 1
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Aug 2026 at 03:38, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> The main changes are support for shared SCL lines in i2c-gpio,

Christ, that's a horrible hack. The hardware designers that did that
should be put in a padded room together with a hungry crocodile and a
webcam. That is _not_ how you should do i2c.

            Linus
