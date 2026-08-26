Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A33B71A2
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731459; cv=pass; b=PD5dWlDsOpCsR1P+q1VY8hpWMr4Rxi0oEo5W8rvDAwjj+KknO2XjbejtizWE7Xnorkhk2DsnqufMGwAS/QWx8R8eelerOvpA/J8ixpNO9A58fyLgGqUO9lsN5j2U89V5VrCJmsanz9pzMjYMWBsxUBI5AhUL3x3wbd8OBmpz67s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731459; c=relaxed/simple;
	bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzWMcamxnPd3zGksS1+SuVKU+W+zKdH8+tGWHWjyQiDjtZNRijIYV0aaUeIqNwEWXVrgHhzBvoJl4pDvzSNAhLU5a00+pU9kX1QdxhKGna3ti1E6E98yyW3FgYsYWYvffXyBx6pZLfdwAZz2gMdBXxIs4NRKOMBHpJ6eEA3oKVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB5TxhS6; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB5TxhS6"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c7127a73dso873609d50.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 01:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731456; cv=none;
        d=google.com; s=arc-20260327;
        b=qfFRDSdBoozTS0//jo93OckikYYnZi5oHF83bCWrhue29ldv6nbPMxnWK6kpU91he8
         Od8OEwcNl0zQ3APk2nnZB9ye8iV5KUOvL7ipf9vIgELyM2WmOm5WWH2QsAMsY/IZnsD/
         JHifLnWD/NoMfWalfK6pl8xIYGhhZfJLRqrzC/M0ScLd+Vlduru4fNl8gnUAPmBUEpf5
         ztCidgoRG34syMiyhqP0XCEQ+wnn+Ep6hF6b6TXuM8IcFgcsQYuNKFmGOwVcIsdQWpIl
         eM2S7fWfBjDMKzPBQhteUSiVYtFDEtwBvauGtLMK3GK8RlQcUXg0E5PyxjMlnwXJcaC0
         PAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        fh=CbTpW9+I6L64c4qB6dd8n1y3SEdT/S5e4Sce7mqN0xw=;
        b=D8J3vNfpr3GsCMdBsjPrxsgwOF8IQq/Vz9StKuQFqqQ7xd9eEbR17OJ/vFuZpJWwFS
         R8mheo34Juu+SlpwUU0oYuR7Ubwouy3EGTBicwj4BUWPfgxeBTkA+iJFCSofH/cg7f+B
         rRvLXoOTifwMpUIvOt0Uvg6i6kVQGCs9XeUZsuY0ndggZnkc0XZYxHid1ef4oxzogs+x
         zLOE3Uz1RUMJqlHMA+I8QpOk1JciDHD/Hpbm3DYjY1L1zpKPjj/6dScvPAkwoIX6TEEj
         haLsv9zMPv5rch8yyqaKEOIV/EeNKUPtpvyxp/KC2kHTtnRUlaF9nkitwKLxcP+ruD6Q
         6uHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731456; x=1788336256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        b=fB5TxhS65xz708KQVMljrC1emhQwLXzArjVEzxDLcRCUjsNt+pW4uWKW1I3GsdRu9d
         hjKXzwNcqKXLjTwq5OVjPcbJR//6rNHuNXlXnAhU3RHqZV0jESIA+A6t5g1gfZFV5N0m
         4sJAniOV/Y/4pj2DiDqQ1folhk/9654BLHYV5j85KI6YQKV/hhvLbGtYYxMYHvWAArRL
         ZjIoSt95cAP3HsfEhIsOYYdT0FLnUsa7xSsgYb+L8bAjk1EKmIQ8mzIWqk6XFFqJyIDO
         6Wrccod3Yl/TYE9p2k9JcjFKZvq5aCtvhwo5+Mws2BrkqrUMUd9Lw3hbuYcubLYSM4CE
         bCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731456; x=1788336256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        b=CSNl/FKMmVhdNYY7+qyuNJl6koBACq0k2sHE5B7mTe+vPTYI1qH3mCCWg0juw9rm5n
         HPB2j2UcijI0QZ4jX+aVh3dUFosW2Alsm9O4GMiGlk0XwoIrrtBE51NsCiur6N9oWDfr
         hJ31JPmIVByZwYG68NhswZFBQFYIId3birXm9V9Tx4UOvwGu0W/L7fQj4CQtk9Bn7+IY
         4tEudu+zcEGKj1H6ORTjntNQlGxdxZ6yXUOGew/fStFLd01CpO0UJ/8gp+q8fCaNSoWB
         LjbhhObe+kXb2ifxppkchLM76a92b1EmI0kj3DtlPqZ9TRV/qvBHOhvtjRLG5m1YN1zQ
         Io4g==
X-Forwarded-Encrypted: i=1; AHgh+RrpEHIkvpumFzTPP9GQeBaA46Vup+J2PWdF36M7kG57uztbwFQLEb8AI2YwFdpgQNI7Pf+4ioXmkJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kKwTMfvbZ2sbCgCLCuDR9J2Nm+LciB062sD4oEVzxmC/mKfqxw
	SzeyCUPJYVmvKhihT4dqAX+TfiY2r2PT/kZ+uxpBmR0rj99ZGKjFOvPOKwMZUJwR77YBN0j7DPM
	ohNyqv1lX0rpgNgM1FLh4dcr0jQUpmyY=
X-Gm-Gg: AR+sD10VPSkB5tflGQ4GCsbczAph4lFEwzQFH4IRRyFqNvjVixa/DgyxyqsPJTaiWAC
	zY3LAEUMK5dEQ1jeQbx8KgDFClsnCjFbQnNuRjn2RNH/ZGU6a6KLbemKq7Oow54xz9O1APbApdc
	y6iAA1bTxHP5qw9Gs2vWA9lDBbdIssqXheaa2eAlcunVsqaFw9s4eo99hoXVFlRWgv0f2Rk4MDo
	oNGJVu0obA6ly1lsb+HDfwG7IQh4pkdS2+dE/7S8q+QPgBqCwLF5ZQtgoMNQ7rbQLHWPusZCbsY
	/5nvCyrXSWrmFlciB4NTqz53qqEP57x3gLEmPl+FTUwUVc0=
X-Received: by 2002:a05:690e:4147:b0:66c:7dee:aa64 with SMTP id
 956f58d0204a3-66d2565d769mr1316085d50.4.1787731456528; Wed, 26 Aug 2026
 01:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812092322.3423217-1-lgs201920130244@gmail.com> <c2434012-7bcb-42fc-b520-8fbc71db196f@kernel.org>
In-Reply-To: <c2434012-7bcb-42fc-b520-8fbc71db196f@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:04:04 +0800
X-Gm-Features: AcwNN1UUkOd0ofctlZQa_UPVnhnAktZX_7rWwJDJ4MDJ_lmFWo9NXdickmLMju0
Message-ID: <CANUHTR9LDcnLh_gw4TQULZcBoiK8W+Y+eS0h9=Bh_4yrzzD2+A@mail.gmail.com>
Subject: Re: [PATCH] i2c: nvidia-gpu: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ajay Gupta <ajayg@nvidia.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 11:23, Guangshuo Li wrote:
> > gpu_i2c_probe() calls pm_runtime_use_autosuspend(), but the remove
> > path does not call the matching pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Call pm_runtime_dont_use_autosuspend() during driver removal to
> > properly undo the autosuspend setting.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d4a4f927e4dd ("i2c: nvidia-gpu: add runtime pm support")
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
