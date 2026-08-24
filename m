Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71C377AA7
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558064; cv=none; b=IodoxUPL3xKBRdAJEBi6yJc4XGOqD0AXVwfa5dtdZkQG3d78Ox7GTyMbb8K4a5tH+JprXSClJ7K/Pd1Q79on1OwI1xc/wakaOKv7YNSQ04A0tSKNnMyK6ScCb1pF91ZRfoyJQcvdbHKLj1HiIH+KvgSq3XbELyp3OgPWrh1mhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558064; c=relaxed/simple;
	bh=pVaBD5XeVFKzR/nzIhX1y78kFiAIAE4Si0mkkB+YkBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnH8Kn6T0svoMJEuyfVG47RPezC4KoW5hVp6X/pd/RpqXZYtn4lrT3jCQBLPcs5gwGhSGHC7IrNqrkfSEIdvol5rMxS3lZ5pD+NqnfBwogjG7KNufQbjN06EuW/21AcAXg5PQi2bgsfS5PJC1grxyZqZxnPuL95CXFCFm9ASkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bf8e1edc3aso2079223e0c.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 00:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558062; x=1788162862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1aIm9XjIXXH2zqdDd0cwInqM7oJgviEDGweWd67RcWg=;
        b=D+n/k1ijRFVg5KC+MGHxsNLWrV163EhydXJaTEqjpnbSuvZMcHDgl/I2Zq3NgWQbmZ
         Oy/OWPQyU2iSDG+Bp6AV69vH9Q/n69NrrWmhXUJPsbVIVFRSQc9tHSfnS0jZehwBVcpr
         2Lz5ZUohyif7WQoIGWwD4ZFoJaufiBU9vWXJbJHnPCSevXsw/on7wZkIZTJjhNvTjS/N
         TtwyxePdasf5jzGlNcJtbVwbtSheW2R0qwWrhL8SAVRHvegC9UzPypwdjmYJpKpS0PK5
         8J0KNsRkEDMEHMprqMVSUgV7+/K34Y13A7OGa2k0+QuPTdsolhDt8sh4AL+FfSUt5CE1
         7Ftg==
X-Forwarded-Encrypted: i=1; AHgh+RpSPWqllep3fyZAe6LTn/NCyWMVn7Ra3qh49P2DMgWFQ/vDTBfTkMYu4v62dSbVk68NoEevWl/QyiI=@vger.kernel.org
X-Gm-Message-State: AFuF++kTH9/auVTevL9+fxGnHdXBZSfkjYC7NufT71seRLDRBrLGb/zi
	FI7Tn/jH1WXrpnAaUmKDi4zOZkor3WzjiHRSPyFXUl8OZV0vgtupPgsfAmeox/rk
X-Gm-Gg: AR+sD10ic+Rw0Vog3kSDnh+3m9d2PB+vctaucrgQtTNDrVo55vrAbX/4TeETcZNTBVh
	xM/XbTrrG74tcnpAtYmeUsyPOlGmGhxFe9f21S8EvozVRXp0fOcEi2zO/5Pgnqkp1EwJGAl3tbe
	kBGkyMe7t/ufquMbzDVUqULUk7iGcC4sziIdzJnxb0Bjv5Uv1QWblPXeO60SwwlD1Bs3WFPA8jm
	JXkXA8O/46ml3FFrYwNVWarFkAIThnoamZps9NfXURZURoo87uIXGY059VNUnu8VWs7rGPoNXhg
	pPYJxYNdeqRmfaXELljhrBfW13dUS9CYqW77e7yeJXXhpWTymgFw3NkSSoyt6vycG/taKhgQ6bL
	mE04ELy3q10eTs5QMOD3z+tzUVLB33qyVoCav0YQd0Q7tl0mQNQyK6RwOJTHv6R5iSLu58NvFr2
	d0tSUDr8aC7jGZrZ3+xS3yIjfC9QwbmfNOiKb+5iAxEaNa4C+LcTernhlHc3Q4mgGY0FKagofcc
	n8R0m0epMdM59wSoaKqzeVR7gYeBOvSw7pK
X-Received: by 2002:a05:6122:488a:b0:5c5:ad20:1fc3 with SMTP id 71dfb90a1353d-5c5ff7dc334mr11735409e0c.5.1787558061927;
        Mon, 24 Aug 2026 00:54:21 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623d30a93sm2874405e0c.7.2026.08.24.00.54.20
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 00:54:20 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-966e7380109so2593477241.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 00:54:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8F3tfyUs3l0kHwVGMYYTpV0Qdj5+DqFHnQBvD9kb7m+l2tDIOpFYvrx2hT3UX5pVvDKlrtH9eFpE=@vger.kernel.org
X-Received: by 2002:a05:6102:5689:b0:779:aedc:88c6 with SMTP id
 ada2fe7eead31-77a5f8ee20cmr9748423137.0.1787558060441; Mon, 24 Aug 2026
 00:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178717488339.2840.16053648973983973210@linux.dev>
 <aodUPU8RGR1ZJlQm@zenone.zhora.eu> <178739872719.9834.5401695033021882071@linux.dev>
 <aomUXhYE0M37I-hI@zenone.zhora.eu>
In-Reply-To: <aomUXhYE0M37I-hI@zenone.zhora.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2026 09:54:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxosPBAAO-kTKRLDH3o8Cqsx8bf+G28qJxQmPuQXwwhQ@mail.gmail.com>
X-Gm-Features: AcwNN1XLjF22Umd37v0r0BWZAgbgWAw7cnYFuC-tcnbbGTr80M1Z9qUcxHYSgBw
Message-ID: <CAMuHMdXxosPBAAO-kTKRLDH3o8Cqsx8bf+G28qJxQmPuQXwwhQ@mail.gmail.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.3
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Igor Korotin <igor.korotin@linux.dev>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andi,

On Mon, 24 Aug 2026 at 01:30, Andi Shyti <andi.shyti@kernel.org> wrote:
> > No problem, rebased on i2c/i2c. Updated pull below.
>
> Thank you!
>
> > Thanks
> > Igor
> >
> > The following changes since commit 7a79b02dd1b09c235c3cf6075bccca2160d1b826:
> >
> >   i2c: rcar: fix reset handling for Gen5 (2026-08-19 22:07:13 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3
> >
> > for you to fetch changes up to b5fa55ad007059547c9139d4c4872e158ae255f2:
> >
> >   i2c: rust: mark I2cAdapter methods as inline (2026-08-22 12:22:27 +0100)
>
> merged to i2c/i2c.

Apparently you merged both branches, now having the same commit twice:

+ 61ddec70c9bcc3d4 i2c: rust: mark I2cAdapter methods as inline
+ b5fa55ad00705954 i2c: rust: mark I2cAdapter methods as inline

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
