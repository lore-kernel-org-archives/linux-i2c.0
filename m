Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460783;
	b=gMkp8Crr0XEkSCo5vJqIoYbsSN+R7MUngMyp3t/yn/R756kzjs6ZC5phVkHcRfp1FfrP
	 kSJ3cjEevjOzugxrGwIbD1DKE2GOQTM4gmzhRZn6c6VRhyJNZ7S+OoGpDaYiFyU2jUgrR
	 foG/zVGvNrPTKd1URkgWNvEaj2Y1s056/GnBYCEuiwF4nrTpSwcRqmE7dAdi/lzx/FbT7
	 nGslZiQtoEqPRJ0TJxDjr1ZxVRgD1BnXX3QJ1F69qt6eduwgFDiNB9a4nXBucDksv28K+
	 L33h+CF+rjWaV0ZJLQNr5pJHaGC5Ic1hhdsPt2asuIV5INV1KIyOzE+dV1pLuPhH7+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZXMGETsC9In5OHuZKA5+0j1fdxY6lC4P1HFXTVDB2us=;
	b=QOg+5FUTDelFDaP1q6zTEWs1XM5UwqCzK9XjVSV3WrUpU4mRNsk2CJFMaCnEIsVdR76S
	 iCcUNIFe9ZxyJwpzT/dIgBQxA1X9/giuzMvDPinv4dgHb6unSTnlhH6snq1eTinY936TL
	 EbcK2tTY1F+R8eQV3yiS8QCBr5oE+c2gkelvC9pyRC95OAOCNOGUFiAlrWykXVS8CmJJF
	 fHu72egZyp+bCQzBtxJq+mBdJbXPgoA9bzBcL1EoxmJxWSlxt87/KebuLjh5S7fIPe6t6
	 jlFWCJ1NErBVY4nvxAxmqMpX3OKez3XGXom+8Pn0RFiwxVnvnXGWZ/U9nRejaUYPAuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yG5ytjDk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C60606A31E
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 19:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C60606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yG5ytjDk
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679a2b5fe87so3542727d50.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 11:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795460782; cv=none;
        d=google.com; s=arc-20260327;
        b=SjpWmfTxKW3q1Cf4j+/BvdnMTG0jCnidoA5+IhqVo+dzcr57m55AFUETqem1fqvZcr
         VRQEpzoUyuw9qq+jsEgQGkuXSkaDHlplb+wM4GICD5z9VROHtEfgm5RM+7yZ68gmWCRX
         GZRUoxE8RQAO5Q3PnS+GoU1CUTDXWFeigfQyGErSxcEA2oLLMhbC/XlC8QUuwbWpSZKc
         Dq0UHQgntmiPVkMfSqyQ3Wy/Xjid5FB95q7Ll/gZq55C30QRciGqAXHbCvcPwWUsiNSU
         Eu1EtOgjdVkjmtvgXuxN/I7/2OPd7saL5sY7N75QcFcLc3c71jTAXUfMqzAYk75t4GIq
         ohlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXMGETsC9In5OHuZKA5+0j1fdxY6lC4P1HFXTVDB2us=;
        fh=pxrXQwiraSS4FvsHPbmVzkNbNSqIKfjcpe0pqnRKnlM=;
        b=KisLteIt0Wh6KKSKcavlUMMke/yHLfIy20wEySm8lQA2rjK+wUqe4TTDcURD9tFvD6
         FsQ87FjnNAR4lZgest+lkd2jsmJ5SLWqCU9CyZb3I06CaDzdm//jZyaoLuh9UVccyKNj
         nhlIwH9uDADBA0EXtJ1fJ9vI5hJpP3f4l7bRtGqLk+Ym/sCNRYDEoYnquEnkT+co59LK
         wmVyoiThCOdu7+mVk7Eb7bD+6A9g29hVqlW4YYIdBFdAj5AdEPehsxl3sSKMZbkO0EI3
         7bILPbd8ATNAvAoujJeJgQkX/xyLx+jYNR6BiX5co0S6Ow48mwLXafWlTjq7FaheO8Z4
         vylg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795460782; x=1796065582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXMGETsC9In5OHuZKA5+0j1fdxY6lC4P1HFXTVDB2us=;
        b=yG5ytjDk3DBIOAAOhEEJ7a87ul/fSrNc4i2/k3//e5lkl5CyATwwvG15RJuHRs3Iwp
         2o/ln5eQbsqXJ0S9URzbgrVgrMVANPn9G4H92UEKcinFuKe6lsZiE5/SrpXmKLvJP+yJ
         h+06e8/bM/OytbmotVwaGrgWrBkEIr2JFIBkFRFtzQPl3zjvgBdu+3vPSoD7hKKfCnv+
         8I25rMwBxDJd7UaPMjjn7QZxPPvrLEF+ACTEVd1XhqGNYCGj6qj3IxmoJpucaUDwIuOU
         9iKyyiCb/WOic3G8LJ8L4X+Km3BCUtq9v7hfUcVtDtEO5S7F5XNXmk4xb9XxMa+38Vj0
         derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460782; x=1796065582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXMGETsC9In5OHuZKA5+0j1fdxY6lC4P1HFXTVDB2us=;
        b=2ME6MEVylk+hcUPKu+laryfKH8U4mN9vmd/rp6/3+hs4YP++buWFChFMWYU86FMhc1
         5pMOjKZfblp9CNm9OQVbqDY1Hbhwwzz02wbDEaUSEeDsFI/8hXsXlHuCmpvdm1rNR405
         ucCA4TUyvVRru1SNinrI8culq76ckyrM2Q3J2FDFszoo81YZ9IQJriznBcahfGHIyjfu
         qpQ3c1fi/PaK1R9JmWcjw4MN4XXow8n9Hpi2avkvR/KH4BkOat3aZoPbjzIlLjLJieC3
         bcpVXCNViisnHzv+KDlRMK7t+GHlAXDO61yuhO+qsQ2tWxmBeA0XZlM3lR83sfcXnLmP
         ty7g==
X-Forwarded-Encrypted: i=1; AL+hErFfK/vp+8+lmDaGjoayaB/lGxmnySGZwKlNzexNQNG7NMmHu8ZBsW+6OSdLpIBMt8uPrRPGcHsUlLY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FrbKCEvEYvoJgkvPqa3aKjrHN5hiZ/VN8mEO4jGDvcUJ9U+Q7
	noeoZ6hkNiJD/LhAi7oI0StrmksEkwcrOmCsxO9NAkQL541B1rYEJ5fKx589lzmsJnysiAxp7pd
	7ggzbxku1HcTEcakl0c+Rof4hJFoAMD4=
X-Gm-Gg: AZFdTZdBN5c+6cajH1bbrENoXaTY3XUM/O5Kamjoa91Ybt2NUIrOL4Q31zranNQ8IeR
	1Ji0sxH4yKa5m7LEpj7jLoNongRaEQvc9em9nE2idv6w0ZN12R0hDIW9gD5Z4LV0Bfx5fks31ZR
	mPpyQ5Gv2Keml0tG49IlILTKEQHTS2u9/eO6q1IY9XKkG/YLX+/Bwq36Umkvq98giqeiZlBM+Em
	HZdqldL02I/roJ3I1zYRA8Ah0ApFMMGcZV7LqYDIAcaEDj9G5XjIQ5stMI2OlSnaIdU1ND04rym
	MujUMS5/k1r8BahXAj4+SvxmVzdPr03L3zxPL0qJ424rl/PgMbYEZT0+0dnUMMsOHbo1YEefy7K
	zIk8xL55rrAWxbafD1pt57lqQfh0eDCxWj8ugYyyy9GxR4KWQBMwtYWgwBTca
X-Received: by 2002:a05:690e:168e:b0:67b:f3b8:aef2 with SMTP id
 956f58d0204a3-67df4425a32mr4425732d50.25.1795460781865; Mon, 23 Nov 2026
 11:06:21 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123085351.3415122-2-thi.zirnstein@gmail.com> <20261123085351.3415122-4-thi.zirnstein@gmail.com>
In-Reply-To: <20261123085351.3415122-4-thi.zirnstein@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Tue, 24 Nov 2026 00:36:10 +0530
X-Gm-Features: Aa3M54q7qggItqO2nWN8m27kiDXSWPUp3jrrfb_cbuCo6wTR6DNactR6aMlLEKg
Message-ID: <CAKfKVtFDez0kDJp0Kx4WbJ4BwqV8-0hb6eeRNjQ8YDFm917_UA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, andi.shyti@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:25=E2=80=AFPM Thilo Zirnstein <thi.zirnstein@gmai=
l.com> wrote:
>
> Use non jiffies based waiting functions,
> if in atomic context.
>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
