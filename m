Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF93451A9
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760699; cv=pass; b=ItcQ97+nMilYAwtZPnDUlBkKXhEjHdrhqswHTO2qKNhKcmRg5gSRPjl/auqwlgigntgeP/4JED/GixHm0zvPn20TbeCy/Tc6CIq+qfXqkI8+sxdK6oI2QKfUVof4xUsaRAru4okNR31BHCtbOOWTpzwc1pMGC+VzVCvtLgSACK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760699; c=relaxed/simple;
	bh=sSCgviBed8zHf2g3xfsl2lv3eFzl+hoXf/vZ34TkSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzJU0A+FsceY5HLMnBohsk2P/YluizZ1D4h2uSowl+Ozokk/w2IC0PJhPhGhSdXa7XEs8Qu6x8KVscUEZhejhZI3pwR1hCV8M2geh4G69ZYfn+tGBwS2toSxv5lsuRfTTeRGpISoIj2iNXmFx5nMQYm9DBhr9iHTBdLXLj5m52A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=b2d8MHbI; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="b2d8MHbI"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so1718511b3a.2
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 02:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760697; cv=none;
        d=google.com; s=arc-20260327;
        b=CDU1Naa8fRXMlO+/z4RJaC9Ac03JF5Pcdi8UDoWXnbkPxAk8r201y0qP3P4xUM8bHk
         dywGLatX5vLBYu9phLMbsTOD24PpdnHeUq3s5KWxQxzRumxblIa+2TJEZ3lyZUB/+EBD
         K8WEQMFs1D4lkitzWpYHpX1ADQ1QWzUG+3sDyPGJoJHRVx2oDfGjHWrUUQWd/+aLDvR4
         qepJLCr9XKkUf6a+Rt5RSA5iBZ3E52HZIiJqv0/jK5DyNbWNh8Rpjph6YAKZ0n32iQMq
         NXwESnA4N469Rd68D3QH4GrvD2hPzmVZaAPyMcgsTi8zrD1DC3vbdeDFt1C9EVjIzX8I
         Tfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        fh=BzWV+cjl191vc4X6ewIAgmNX2TxzeWf5Qw/ZM1WQvEA=;
        b=YRsg2fGPFyb3WgKpnOn5IjgooBp19v+ldL8/PlzwHWRkjNuZyivxqgni53Qi1w2FA2
         MOqS9tsYRDaXzAHE6bXAjbToobvn/meLNtMbBhdvWIl9NAeRto9Wy6tR77/5trbxewPH
         rwwIZT158O0ZJm3tyI7gN3GeCNR2YLBT2/MmVfyLU1+cmYOBIJ+rmsDil2vAfKrqYXLe
         KWxvsF7R8jJGwCWD0TYyG4Qp9ghGoknm8MQJeMZWKnu6lmM5UWq2VsUUryGj0UvL5TrV
         F3i92ANg6wmnR/ZmUmrCW4SK8B0FZC1QRsvjrQaFnoK8pujVrQTzoLYPEXp0nVgrD6D2
         Fm/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1790760697; x=1791365497; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        b=b2d8MHbI/K2msxANIAUSGWXRSD3g+5IUfmA27J8SV/04s9iV0+KsuZX5Li5UiXboef
         Wdff3WdMdsHQUQDCTaVv5ggfVJK8iCIjpiXJ+OYjGYWv11Psi2r9KQeBS7qIhvGCu6nx
         jb64DZXN9rdOnehgUbQngI5VT46cKm1HcrgCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760697; x=1791365497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        b=Kb4B6AEsayJD0PcqC3v+Fh050kcb7pAID+gavJ9+IW9jUIt2OUCA0pqSKCuh3v0Cv3
         gUakRkrA36zDFLpjFoljni9IcsNBVLzBrMDDLrwwxYZZdbIjWOyW3Z9EMijVx6pUZD96
         kin4HlAOFefdDHTZnJN+9RARfRWHFbA60gsyTJvcselaxi9HdDzec/yOp6bxr/5cuL8a
         MsgI9nT6waydWm4nMM5gjOqVX902cour9JzHr9iEKJqKgo9+25mPdjaFZdWQdUkRhCwa
         7jpCo01hcPvUPq34kAKkhMlCcY86wATDuI1yZdrGZtvEqp7kMII0TDUD0+5YZw2jwQql
         9/Ow==
X-Forwarded-Encrypted: i=1; AKwUvBzjrpRAzirq8PrZ42s2X66odFfTT/wIDNoKDSnPtDirvpbdBYsCTbGdjb9NBd/RHfvk9XA0d+Glq9k=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ+TtBj/RD3sZOXpQGRksrFzpNED37ON8A5riW5Z5DufU7D+cK
	Xvcvc+B+bwIP5PNcgPg66VB9LFgY+KDxWFcew+CZJI3lu/WnhSNw0plj3CYH7xUWdbgY9Upc3+b
	ORRxDf3ghB9QpjMdNG2L8o4XU3kJRPAwEw+dt4zYf9A==
X-Gm-Gg: AYBFou2zJHLswQTC5Bd6tArufJtwP+zEZBCpyL63PKSixtEQKnj/mm2XdyAxGCqIJRI
	kb65JThNGSJsluP+OjkWugCGOK8XqELm+4cenE0rDp0Q5HERJuuxibCsG5LYTzX08vToq1ccobD
	iEEs7trT+jQKQ9XQLX5HSEeZLOejy4pWGu1Oy4tO0+SO6oAovkUJORLQDXq/SEpUILicTcnnPPH
	e8fyH0Am5O+Kycgg7cm+OLKMVf2Wly1lR2WfAniQa8B2jtJsAspEtJRYm0T14dYRCnhyQ6azUGT
	v7218WDlEkNubg5++pfahl83YhSJfMB1A//30VtRUfKUqMT1yHC+Ivp66NMjJ1DisstkOr0ZnSr
	KfQmwDY6563Kw/AEu1nXH/PW1PUYCDUe9PuKO0TiJMlimfq54twKNbLX6GmQNxs1dB2KdZNXWX/
	HaNxtEQZl/JrkhfJ49+7QBeGAZdMB73YCkficrqHtn4DGsl/9JoGAK6YqcByscJMHDtdrqGU707
	aS1UWbfJRk18IZ2q/i6MXXKbNg/kfg7M8g=
X-Received: by 2002:a05:6a00:1d93:b0:86a:c062:8af2 with SMTP id
 d2e1a72fcca58-887475beb20mr572280b3a.3.1790760696692; Wed, 30 Sep 2026
 02:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929041444.9837-1-daniel@quora.org> <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
In-Reply-To: <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 30 Sep 2026 17:31:25 +0800
X-Gm-Features: AclHuK8EAJhwPODS-uwXrHzCTd7v9hqYYiYnc0-_fOmkD3ZLxi8pO4B443j8vUk
Message-ID: <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 15:19, Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
> Thanks Daniel !
>
> On 9/29/2026 9:44 AM, Daniel J Blueman wrote:
> > Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
> > SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
> > timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
> > on all boots, and touchpad unusable on some boots, resulting in:
> >
> >    i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
> >    i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> >
> > With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
> > versus the previous default of 521ns, however the I2C spec has a
> > minimum tSCL of 600ns.
> >
> > Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
> > verified on Lenovo Yoga Slim 7x X1E-80100.
> >
>
> There might be a final count which i should get and update back.
> Since this fix is working though not suggested per hardware guidance,
> should we consider as temporary fix and move ahead to prevent failing
> usecase ?

If you can get the final values into a patch for the next -rc instead
of my fix here, that would be the minimal path for everyone. You or
the hardware team can cross-check against the I2C standard as I did
[1, p44].

I would revert the original patch if there is hardware that uses the
I2C 1MHz fast-mode, since the current timings aren't to spec, but also
weren't before.

Thanks,
  Dan

-- [1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf
-- 
Daniel J Blueman
