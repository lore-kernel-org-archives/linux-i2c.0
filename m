Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEB440A2B
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656871; cv=pass; b=JT1bST8VYWF4BN0Uym7kmVDosCOCnGyCp/QfF5o3lG5KWJARry408Ln6+YLHFnUDBVxrg9Op+nc0SQnAlbu9hwYECvRAfYoGYJVf+lTfNrrtd49n/V/GtJZD68FY0XZPaDq5/bhty0nCKWWr2TcVPSYbAtWG2R3H6YDGsEfP8aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656871; c=relaxed/simple;
	bh=Q+qqtzZlFMhaFTYRGJVb+0/1oy02LH2vilVUpIiMSBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZntgLvWvb5te9TcYk9IoJJNoUPWekSYMvzUd868oMAfLtGvnfilMBMoheage4yz5tbKG2ASk3TegHk3uvwJ6/yHMZlbpOCJIH7fQU1dFxEtW9VEXS22QCQuoDFHz2DmiwSSSIPq1s48rMpl5vnUtadfqX7oNQcCFdMks7SUSFa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsuqP/UG; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsuqP/UG"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c05dcdf49so4404101cf.0
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 14:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786656866; cv=none;
        d=google.com; s=arc-20260327;
        b=foLIYU+Ke+F3+e2xZaugazGc6fDIajNT4JwV75bUQa/MqDdy+IpixjNjU3i/Mu3i2k
         gAw3/+QCF2KAmrn9ziR6dvFoJrZkL7JgjLhIVrVn4UC7zCZ5Der0ji9Gxe16grtvQfRU
         eEfZQNO/XbTxPA5bollNLfwWQ9gT7l/j39LdUwluc8TNa/+BCVDbFIosBusACRWNp8wG
         Q7+beVo9G/4P0UAyGy4ISwe7zEmsGBs5Li2dD5T6+uH17zsqukQk/FRCoFlbbhpn0lCt
         g2hdkGUEJU/3xDeLbi/smsZMrzkWu8VfmJf+45/GBk3w8F732RcDwPOTGDGoCvDplSlh
         0icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25a+cvoO2VhtKTKZQ63NiSPCXKyIZootzuoHvg0BcyY=;
        fh=Vm3gq11ZqKjEr6roV+UOP3c34bFX/Pk2qvGfsOe5j/U=;
        b=SZw9hjXUNkE8uUnuQMN77Mi9HgmrmbjHLGp4hVgmSLvgoXKgW0Q9yXL461mvqtAibQ
         XyTQPmmG83Wm2GEMSpr1TaYeEJX6+AxekRQ9HOfrPUQ6Z4i0pcdVjxtMgekdLUZTEiMV
         rnzawdnopfuDYpt5EenwknOn+nOtxGMniHafhJC7qNoVsPoxfF+8GMxIOPBxC1Ie5J3O
         X4nKrghz/qZgO2yNgb2yttG7SkZaa5bC0UiqIm1MQo/spwbi9B9t5amB5qs+CahHBVBu
         1H5kF6n0VwvJOFflcRm5zvtzPvdqWeTRWmfVwhvSAQAKyRry6QVI6J3DFedvIFqn385z
         itHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786656866; x=1787261666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25a+cvoO2VhtKTKZQ63NiSPCXKyIZootzuoHvg0BcyY=;
        b=fsuqP/UGVWFlcsgDdqXaRDIcCeKGv26Y7OA6Zgu1gXlVKQQtXGSKPrgqWXXEzuddss
         UrMdJnnYSA9QdDjsZ5eWKKxf6xIuqyewLqXW3Su+z5Q/vv1RCUiN/R/JHwsmIRY7SS4Y
         NttJ/BpJt6srGabI9KEIsO09acfaevaAEDuMW3Z1nU/GJiY2kzPWd37FCx+9KISjTFfu
         a4VjiAF7aejljiyTVxqAZyJlUdB7HXTtp3+nNkONXzPEEzzyYPnRP/SBKELaVAMpFTDM
         wdyAFYr+K19HoFZnxgSDXAfRw9asSTU2BDGBd2mgfMEQmvg4XHIFrFWpQcQ+IdWfSmiu
         4ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656866; x=1787261666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25a+cvoO2VhtKTKZQ63NiSPCXKyIZootzuoHvg0BcyY=;
        b=c5CHnv+/b8HNmzqJbeLR7Ky3VMdHE5vRb88CRBeVsrGdVYlrhuEhbuzcvy/KMnAEcC
         U67fDREZczwQUvrsaPrY9LU/5y9OhEV7zJH1eq6pCncA7bP6kKe6MyBOCKOXL62by9tj
         65CaUYLed5vzN2Rwxy2ouVtPQzs9J4wUzpKx+51Fd5t07S5hvR/oh9Brp1hMzI+q6nQP
         E5SpswacIYNlov1D3pHcoGvT6lA1Wc1+1gZdS83DEn6o/b3opJIkLp7RcygZGKtgmCh2
         idjjy9D47KVtZ1ZqQMNbEoSdIVSf78ZUTFQbljIHANqb3xPTfo9GPNnxgwkYDWb8HDeY
         KaBQ==
X-Gm-Message-State: AOJu0YyWbs+CSfUEyLh+ix2AKpS1gBOVufXlXHCqG3NEqZ75Xzh9XnLY
	kWICxGWt9Q9w0ZCt1inlsJsuoAA4mrN854EqRG5zbkE3wGYWrg+Ii4pnS86fTqxuAmEgTwD5Sc2
	hXK7h5wYeAKkcnXFd5fdJZCJpkbz70/M=
X-Gm-Gg: AR+sD10xxxj38p/ys8OWu7lYFcnZNDKMnHNbtl+ArXRCAY18KI1XgmToIFTyiyMqPMw
	V6FtYlq3N7DMqKL0g2t5VmlaK2HbMo5ab6FP0QAHBxg8nSi1CftXYkQYkUp6XZhM0/9dxSZqRY/
	W4fJllz4NWL4IrWgIKJBm3rVgixON3rdL1aa4DfzUal8pP4OUm1gpxSPTWALJbeelqxhrz3kU1H
	l7bWldFttvk69/z5o4El++IDcl/BmMcoLkvnMwVuco848r+3OVzkk16LWspKYYEyNbeSMVHzUTo
	TzjgUL01frz+yobvV9Be7GRjelczVyeEoI+yTEEILfRa+59DkjxsZMsngRA1SHAWs1tboVMgglE
	r4oujAofMMrZZtI5TZwfSYaKfAEYFBetUT2FFZY77B40Du7HuVrkMv3Vx96b+gb0=
X-Received: by 2002:ac8:5fd5:0:b0:51b:f98f:ea5e with SMTP id
 d75a77b69052e-52d8542c3c0mr12184881cf.22.1786656866355; Thu, 13 Aug 2026
 14:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813153155.3953577-1-ruoyuw560@gmail.com>
In-Reply-To: <20260813153155.3953577-1-ruoyuw560@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 13 Aug 2026 14:34:14 -0700
X-Gm-Features: AUfX_myC1TbgPC4JHhRRnffeuEBndadC85IECm9UndzxwlV_K4KYcHoRns0UMgY
Message-ID: <CAMo8BfJpittF0accyBWPHaDt6M816Jj-btp1=raZG7aAC6Kbzg@mail.gmail.com>
Subject: Re: [PATCH] i2c: ocores: Disable clock on failed resume
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: linux-i2c@vger.kernel.org, peter@korsgaard.com, andrew@lunn.ch, 
	andi.shyti@kernel.org, wsa@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 8:32=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> wr=
ote:
>
> ocores_i2c_resume() enables the controller clock before reinitializing
> the hardware. If the clock rate changed while the device was suspended,
> ocores_init() may reject the resulting prescaler. The callback then
> returns an error with the clock still enabled, while the controller
> itself remains disabled.
>
> Disable and unprepare the clock when ocores_init() fails so the failed
> resume path balances the successful clk_prepare_enable() call.
>
> This issue was found by a static analysis checker and confirmed by manual
> source review.
>
> Fixes: e961a094afe0 ("i2c: ocores: add common clock support")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
