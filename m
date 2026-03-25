Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9783D666F
	for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451455; cv=none; b=j9gqEt2oQqoobr4fiUaRHfY+mEy8PDS9nY1iwkv7q16UpVXZTurEa7ZVuY+oBSP5OsIXRli/PtawnLlODtSKVN3Cn0YxpZZaf9SKNdWQy2sBLlwwLuDI8HAHUXBGa5qAUmsCRE2Y3TUS5wEcIF+X8uy1WMTuat1R0gA6bv1XFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451455; c=relaxed/simple;
	bh=BZGGufgX0i80QOP5QxdXC8NEtX7e9nkLE2X0Sj3u1YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2l2n01MXgRtZOBI31AcKGg8NCehUgwgnm0sNUgvkm1Rr8iPlLA1Nv6psROp6XjZhtLwXl/WaTfXDbfeWsX1186BOv2S0yFelNtgSr2GKuIX0IxLiiLl3+dUR30i1AdPfgXqFN5kobJtAJYueXOZ/Hql/hVf6kjY90lsv1aTwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+/Bb4Zi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+/Bb4Zi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1578184a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774451453; x=1775056253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8WzrX2hzPXJ1j9AbxoRyE/tbN7PT5lnxfJP5D79TMk=;
        b=f+/Bb4ZiFnmUzjUKkFs8NSaixluI8FxGqe8GEsvRanwXgQCsI3csc9T7jaSWLdyEAb
         gni7LAdF+7020jv8XTRT8JKA/r3ZWzdc4AWJUEOU3QOk+5OI9lzvdXvDqq1ix3EhM9SL
         hvSXUDaKYaSt00cMu/IHohnf1P0mijwtlOHtj3rM5YHHceKbMl1YQxwbayXRT5gthvcR
         yxtYwW9+VUojspJcYV8hHb5W8D2o0i1U6E0bybSRy8CgTvDw1XERKmY4p007Xc1I/E9b
         o8LbtK5YxwoqQ5telb3Yhne1oqfZiYk+BS8Ix+rtTgVeH55A0NDKECRTMnlMKhpBFp8L
         alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451453; x=1775056253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8WzrX2hzPXJ1j9AbxoRyE/tbN7PT5lnxfJP5D79TMk=;
        b=jcOx+RX5BiESt/cyMmrTHBOfWR7ji0zZDmzbH2ncaIs+/OMGkpCkapMVo4hMkFpdv6
         6ro0kEV5egatpTO2SYiSN5VCsXAor6MJm96UJ6zd+tpjXi/iSTBPrpMRKH+bxw42C/xU
         5icOchWmsAysgDQklmwsM49ojQgVS0svjo9r8lzQMcSuhxME4ObJOthOAs205yh23Xru
         SVuYt1j8WVxPOsFXkcxot1A8WMSDQM/8f0QxvNnHM4VQY72lmIgd778VWwGoUGltZb5f
         jIXVpdiN1qocUHthi5+EdlYnxJFG5190KcBXTHodRZ0QPB6RQf3udDRmBiTIxq09DbQG
         Tu/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbzOe29X7DX31hj+IKyxGPffiMys+pyRQfUEjUy+sLLKlVd/GRMxovc7U0kxJsLluZWrnZ8q+QSGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxop9xFsBVcyhUxu6VrARzI13Bumjs39DGMrrFKrBGMeS6o5WU5
	m8A9YmxgtgUn06YfEevnWKk1UUO5DUollq9kOwpNhTrzSHd3jNSJ9hqJ
X-Gm-Gg: ATEYQzxLrWe7sXXPwpqfqR8JkkIOltRRfnyhtn3glw7dbtGsc/JFyqVCw1hlJTRRjVC
	aWRxo3qGUfT9vyQE6wUVv0VHF6em+bTskKkY1K/jaLSIX8kahyMhkyYQDcYhKpvBi1j/8/1qG+X
	Tj8yFGlYBygkRrasgsZgs+kVMjvKE73r0tN574oF6QrqzlWljvITpTR1GBmUrtWq7IesjWR2HaA
	JpiatBU2ybyI8fL2bVFHC6wsWUVBosKPf8HX7X4I5Za1lvTv7+iLgVU+n4v83qZzeuhNw3e3zYK
	ZhzXtJEBAlfQienIZMT1MKdEGTm9oUvw2OSl3La6nNFG01g2q9bhnEAeaHukzSx6UvMkQ86Mjgl
	/Q+bdQILDn7U9d39p1tcAEfBtox8dK9s7PP09kOf6PnbO24jyZfXTCpI6kBon3S2ybw4UreCIfj
	jqYSF4ut0LJLq0kEN0UYaDwCQ=
X-Received: by 2002:a17:90b:570c:b0:35b:9896:cbd0 with SMTP id 98e67ed59e1d1-35c0ddc7c64mr3761784a91.25.1774451453060;
        Wed, 25 Mar 2026 08:10:53 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:22d3:4161:93a:b87c:36eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1a022db8sm181861a91.3.2026.03.25.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:10:52 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:40:45 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andi.shyti@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to Dt schema
Message-ID: <acP69aM-euL7wl87@fedora>
References: <20260324135010.17730-1-i.shihao.999@gmail.com>
 <20260325-bulky-mushroom-of-science-8c95c4@quoll>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325-bulky-mushroom-of-science-8c95c4@quoll>

On Wed, Mar 25, 2026 at 12:16:27PM +0100, Krzysztof Kozlowski wrote:

> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 

Hello Krzysztof, 

      Once again thank you for your time. Those warnings are from running
      checkpatch.pl without the --strict option i myself discovered when you
      said that because i only use it with --strict option. I thought
      checkpatch.pl --strict  was more strict then checkpatch.pl but i guess
      it is not so strict as i thought it was. But apart from this i mean
      why in the first place there is the --strict option when it is actually
      not so strict it must have shown all errors, checks and warnings but it
      does not Anyway i will make sure to run both from now on thanks for pointing
      it.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - intel,ixp4xx-i2c
> > +      - intel,iop3xx-i2c
> 
> Alphabetical order. Dunno why you reversed it from original binding.
> 
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> This wasn't in the original binding.
> 
> What does my guideline/expectations for GSoC say? Did you read it?
> 
> 

 I will make sure to fix these issues in the next version. Also
 i did not read any guidelines so, please provide some resources
 to the GSoC guidlines you mentioned. I texted on IRC but Daniel
 said email is where i should ask for it. Thanks for your time.

Kind regards
Shihao
