Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51F3D4137
	for <linux-i2c@vger.kernel.org>; Thu,  5 Feb 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296272; cv=none; b=UYCewNbs96i+jYLjkXVBMiAWIm4VyZrn2+bQsYrz/dEYMqy/SWbynrEXtUmoYRgbrn3HBTWVazVqrvj1AqjlYZDoPBytumMonXW7VtgIvj837SQcv7qWTktUxk/ptFI7i/Un4UkhIQupEw0we8Q//3R8X6Y1JSHSZ/S0x0sWyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296272; c=relaxed/simple;
	bh=u408GEn+r7rpYool1ipTSvS5yUGjc6/mxdNfTwVEj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpYgVOlYE+bNwYoiNub0ek+EgR/0OSk1/D4WR1zjY9BmArAyQv/EysPPgexbJCjcz+jy84wXrPFTwEOQewUrd72aiPOJhx2zyy4hqOoa69NjTPNG7TgOtNMVHbqZqTj30jVSuWUX83a05t/8nVF/WbLW7aXszkvdjAIYiqXvCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt9xM+Fh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt9xM+Fh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435a517be33so624387f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Feb 2026 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296270; x=1770901070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w1syDhd5NfaU3goDOmun9W28zqJO0qiGwzzr5rkRfKM=;
        b=Pt9xM+FhVTCYSJHba6Pd1DerbcpE2xMJJjKsRnvAIsbWufGsHscy3IWgMa6c8Z2f0a
         hxq1RBypardq9CeLFVbXR6evB3TCpDpT7hHdnw8S0S0i7xASuBnMKquZhazZf5Kr/6MH
         mHYUR/SjFRuzwykB9zYIAuEyNxicGC5/I9dAeZeI5mVgkxPksnhEFZCLvL8Tm6E5Qt7F
         //Xio5pWUYxh1ZKij3lcDTnPEaKesfYz7WwPk3BD3ECWwwIHTqR8/hFV4QDDeIj0goFv
         sdU4JTj6CHAHsLeE9HaE6af/DLPUpRaQsEtImPQM8vziyAoepOARiprfI1YIKqhqHQsT
         vIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296270; x=1770901070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1syDhd5NfaU3goDOmun9W28zqJO0qiGwzzr5rkRfKM=;
        b=Xr01hUyFw7/FqxJRju+Qgjqwu24ZJcM6Aokx6NpeD26ZwSpF8JB04kxga2GNpmhUaU
         I0Su7RqJw2hOtsynuXopLfcK2x/Y6V1agAqD8EpfrSFvJFvam9kpBh0TxkWVPYCYiYtq
         U+rcnh0Zj+3OtVyZWovcNlfJMHpxevxNoot4gU02LDWyoLY32VHnuV7p0//Qjfn89Yqg
         VGgjGFjeNdRJx+2vre8KgoWUsTQiRm19k6ceWGqg3pssRCPCn+NcMeuKS6zFrRjhZ9tO
         vRNKoEPztX7eyiaj0T9zWQjR0gs0YvSrEt0q/0TZyUsCfciAtJnKTFPym270jPk6RNNc
         T+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUKM3hBCIUwhFQq3EkEcaBq6hMuSt9g7Vd9wouGPHqjlUXO93gzVufa+OAgZU5BORnnO8aLBgEPu2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlcW72jvyJx486wmW3AR70IeKD2vAlJNV9/5mlcdyzPFK5yYf
	uf+tnrMaJ2l26C0x2NYwzO4wouP7XWgV8Lie+qsbpOI8xVpSY9s9KLz5
X-Gm-Gg: AZuq6aKh5yEU9R3t9Xh14laGxwTZAQf/63jmVhIe0Ax02FqdAFiWYIHAiA3cHYe9Quy
	ZfOiyvRHQAqrY8/VU1JKk2vb4Cy+hbi8dC56I7mHRu0+a14YPoS9k+6ClNBxcQ8ATTZjVHJNbL4
	yiJ6l86XySCkq3K8fDi2U6GzsM1WUsOO6wpTmbJnwO6BGmIHkyBRv4a07F1hJde4Exstw0XTRA+
	I8ufLQ42Meuh8b6VNn5IfhNVRt18/s/B1oFRxsy1jA76zTLUYxde/Wyyziuh0Uj870795XbovW7
	KPFjkbwZdhPW3bbLGK4vsqsGExYSANC7O6ZxoerpyC/0OQUsRH4SpFxH/UYmrrGFO4sWUKWlkY6
	5m+x9w43snssTd51nY1Jb5uP6RY+yNHZDL5NxIHdVgCtAzebKS722WUqFiedhrTWcQiZ6GiBslZ
	Upa/SGOWqo9VBebAItd/wmyk0=
X-Received: by 2002:a05:6000:3110:b0:435:92d3:d9b4 with SMTP id ffacd0b85a97d-436180318bfmr9531080f8f.26.1770296269844;
        Thu, 05 Feb 2026 04:57:49 -0800 (PST)
Received: from fedora ([138.199.6.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618064844sm13730468f8f.42.2026.02.05.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:57:49 -0800 (PST)
Date: Thu, 5 Feb 2026 13:57:46 +0100
From: Filippo =?utf-8?B?TXVzY2hlcsOg?= <filippo.muschera@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: amd8111: switch to devm_ functions
Message-ID: <aYSTDkptTxxQARWV@fedora>
References: <20260202131304.8524-1-filippo.muschera@gmail.com>
 <20260202131304.8524-2-filippo.muschera@gmail.com>
 <aYR4E9UmuQ4Wx_ro@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYR4E9UmuQ4Wx_ro@zenone.zhora.eu>

On Thu, Feb 05, 2026 at 12:03:51PM +0100, Andi Shyti wrote:
> Hi Filippo,
> 
> On Mon, Feb 02, 2026 at 02:13:04PM +0100, Filippo Muscherà wrote:
> > Use devm_kzalloc() to manage the memory allocation of the smbus structure
> > and devm_request_region() to manage the I/O port region.
> 
> Merged to i2c/i2c-host-2.
> 
> Just a few notes for the next time:
> 
> 1. I prefer two different patches for devm_kzalloc() and
>    devm_request_region().
> 
> 2. For series with more than one patch, I'd like to have a cover
>    letter to introduce the series.
> 
> Thanks,
> Andi

Hi Andi,

Thanks for the review and the notes.
I'll make sure to follow these guidelines for my future submissions.

Thanks,
Filippo 
