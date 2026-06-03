Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF43A3830
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471420; cv=pass; b=UYQFMNL9xtC7eM+L6bwX2sFmQnzIaYoYtBLSZKMyUGKM5to8WHZwpK/T6xz4EybTkqqYuASUE2ApYxCieJsLwDPLPrhILqYNn6vP5zthOwRD6O5vqS3SzzFSGJUdKlUL1sVcrulxpuVXVogT8hZfiZhWLNnstqT8iWh0AsYFI8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471420; c=relaxed/simple;
	bh=dn4PhtVBZbHd+OEFsc/QHJ+TIDhy5J3acmm7qbaZ+vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBeATy+YZYwuZ1h7UjJTqQYTBf8tY323vwS6EDafglfeXA2AKKmllrUJQZ+peObadTYeGFGl0T6SeE5sPdgUakqb8HO5Ajd3cXL8YgzH3DO8XuA7y9GnjcRJfn5SE3Ey20NPsoldQUg2UZeV95ud4iBtj5JZY0IbUQoBdSHC5es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2cvCa94; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2cvCa94"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dc73a56b5aso46401027b3.1
        for <linux-i2c@vger.kernel.org>; Wed, 03 Jun 2026 00:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780471418; cv=none;
        d=google.com; s=arc-20240605;
        b=GGy7WumrkSJXpncGPjisTeRteBKIrm9pkRfJJ85BhDxip38IdpAn2FDxsozlo9zuQD
         eqkcuAPvwEBGO+soXnCXyQ48BZ1MA5ANCefuk9Wf1TxaiBJBD86yxtHejPl1lWfIibv+
         pp7BzWsIorRmFMf2WdsLg1yPJkkkvk9D5VMdDy9GQbKrAhi7sIGGyn489QPywCIie8+3
         LYquQP0lMivF/rwM5ztCvV2fQe6W6J39lxrCwSIMMhjj63eWusFjVpsXHOoh2BMSPb78
         Jik5PQVQZNUZUcW3py1JWZ+G4l6eTmHJrQye1u3skOUEV+j51qBK45lYstv9uEvQQ5rX
         VGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T4GVVEekQoNIGbLibhWR4xkJpEpqVIIm8XMGr+5PR0w=;
        fh=P+EK6UmYUheupL7oiLbt335fHKwUU450x6zxY10PEic=;
        b=auVdXajYn1SjE/3/Fa3s6tiEKgtM72TXrFJJXCHNFTq4Vx/0PM6cIMEWtUjJA+nppt
         wgxox8Jv2iekB0J3QFUfr25Gfx49mhXQ5ujV5+HTCH8B3M798DFnFM1Q9BnUp86uVsOj
         mp20/K7OoCsNIDxj5bSNjWT+FrY5LRpyH/wZm4W1nOcsChyADmAfzHT2arwpbfu0Vs6R
         22q9vmCmjyuW81B1gIfiSSCgu1ApBV6wet49F7e8beQOtDPcNSyDR50L4MZLqOUXSbmw
         1eDvNEtVf+e3tIyl2eBir3hZVtL3yDf6Z3LIQYpP4U60q37/mdAAYDclKClMxdZVUUO6
         LA6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780471418; x=1781076218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4GVVEekQoNIGbLibhWR4xkJpEpqVIIm8XMGr+5PR0w=;
        b=a2cvCa94x0sjL9u9x/YUXNQbw4p1hltXSw3xAuOXvfh43/gkXFXFFqCDoqWFg2gQOb
         uUKqh2JENxs6738rX67fLHawY6st22k5hfhuVviWf6uGlOeZ1iW4vzk8pYf+gB+h9Pzt
         n4LfJGYEeCylpUWAr8OdsJlkAjaQm+Id9MPo1O80Lj2kkGjhnXRt1vPriQUu0VSoGOPo
         +OOJ/MDLt8K+YTyLftMrxfglfKhC6i5BQgr6/+hwNUKAa41zzHoB+jNm+grAHYd4xQjV
         nmHsAxRVNbBGOUoiuC4yR+zEnFpTKH2jQl7xwmK+oHYlj7cFRSXnJX7MesgYMkQMJqYP
         vb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471418; x=1781076218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4GVVEekQoNIGbLibhWR4xkJpEpqVIIm8XMGr+5PR0w=;
        b=DWbr01mBfXtifgBagflzbCedhx/REoJv7Xy9Oz/ysFXdvF8uP+Qme7b2MkiykpX2Bf
         ubGK+Z9ii92qsrpu12RktG2+XSeX5qOmS2BnejY2Hra+x1oxpKGpTLAE2zutYYnFAP7s
         oltKHtNp0aQr+up7MkKXDHUivwA1EIwcgrnrldEFj/MvFjp/zEMcF1qDPwdiWp1l6a5a
         1zGXu3EFF5RTN4lwodfmjrrWzX4ukt48LV4PY6kmyoLYjr3dsLsCCjOo/Z9qAmMlku1N
         taLZJ9qY+eLM6sBPXPfqC25wDM401AjZtV0PDihMS9UxivjcOXU32alhPjvvkEOWEkeo
         FUsA==
X-Forwarded-Encrypted: i=1; AFNElJ+MJQK/TKb4b5lx1W6UWwU0xHjPuYt5ShdPQ3FrEONjmiS4Nnl3amb4m8J2sJbtNNKQBIxlG1OTQhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjWph6Dp8xfvM6zefq5CMviWXPF03J24zIlG9ZdmvDZNAeoLj
	eC47rbH1zqevAsC0XJf8S5AI64y4C0iYKwn++3llQWsIwkmQRLZFBOQw21peIRzUvdfNa906WsZ
	nJboFntCNt+ayHA7soCqAvE8eG3qaGoU=
X-Gm-Gg: Acq92OEzOGBSx/XFl0x/SLDg25u3oAnnFEjRlGGBQ0pHyjXlFJfsBEWBdTiFBdQu9Ug
	7WNpwpv+3pS6YdqP7CLzvyODfg2olBHhgoa6rfeTqC+N9IUq6eS6b+Xf9v8B9C0PILvUpdGOuPq
	6XCxns4PIL+TCJQJFNcjNgocBPCMIeKt/EAuqURUZDlSMI8eE3P2JADMdBb1t8thy798/YecO+Q
	J5aoSGXrdJ8QSbIPaC/Vm/uRrYz8GKfaq+GEsBQu7iirftbDsYLeKTVfLxjKxPoELjFoSLBBPf7
	+gSv7WlOwh0I39CxCwizjjPzDZxHPRVUEBVKcytpFqytCYAEWEh+JyBbtgBaMKjVWo/GZNh8gCR
	fvTpucdOt8VfxmJbHkfOJuxrKGRld8yVxuNxv2ou3lv7lxLjJRZVsfHpbLshE+pYBk2ccRfAnYp
	utyjx5
X-Received: by 2002:a05:690c:64c9:b0:7cf:af41:50b0 with SMTP id
 00721157ae682-7ea4a6439e0mr19278747b3.36.1780471417863; Wed, 03 Jun 2026
 00:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <20260602185339.GA404948@ax162>
 <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com>
 <ah9frnHDuIjF_1Su@ashevche-desk.local> <CANTFpSXAXP16TUK7n+pTBgZOYRqCyF4kqkf9X-TK9O_rKWY1VQ@mail.gmail.com>
In-Reply-To: <CANTFpSXAXP16TUK7n+pTBgZOYRqCyF4kqkf9X-TK9O_rKWY1VQ@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 3 Jun 2026 12:53:26 +0530
X-Gm-Features: AVHnY4KXPpnT8RNq2l5Bx5vXvOHXRel-hX108osiwi8UFQMXKpH1RyRslwThOJ8
Message-ID: <CANTFpSVCjK_JDB-1GhzomnK+c3PqeHGGMPA19-tDRX6_HK=vig@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, mario.limonciello@amd.com, 
	brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 03, 2026 at 04:25, Andy Shevchenko wrote:
> Useless data type. You can use list_head directly as a context.
> ...
> Again, a lot of duplication with gpiolib-acpi-core.c. Please, find a
> way how to reuse the code.

1. Remove gpio_dep_ctx, pass struct list_head * directly as void *data
2. const char *path in gpio_controller_ref
3. Use acpi_gpio_get_irq_resource() instead of open-coding the type
   checks -- this removes the duplication with gpiolib-acpi-core.c and
   also requires changing #ifdef CONFIG_ACPI to
   #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
4. Add NULL check for resource_source.string_ptr
5. Use return value of acpi_dev_get_resources() in check_child_gpioint()
   instead of ctx->ret
6. Ensure cleanup of partially filled list on all error paths
7. Remove Reported-by and Closes tags (carried over from a previous patch)
8. Fixes: tag on one line
9. {} instead of { .ret = 0 } for zero initialisation
10. Split adev declaration and assignment
11. Remove unneeded blank line after acpi_dev_put()
12. For "Redundant parentheses" on scoped_guard -- I believe you mean
    the bool bound pattern is unnecessary and we should return/goto
    directly from inside the guard instead?

Please correct me if I've misunderstood any point.

Thanks,
Hardik
