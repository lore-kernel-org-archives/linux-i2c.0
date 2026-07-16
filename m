Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C3424D75
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211334; cv=none; b=okf+4NB29IvJzextUUQvuUZcPMA0giu7bmWlHqmqTX+sScNGRWk1bi6qrygKqPxv3WcNfaoZiJJ0YDRVdrFHItSVwJi3lXUt5EasNnMloUsEiTlrvpXN1kwox/lVaCdam2+X0hecM5rDEoVO4jnSE1QJpVbKmqE/qZD40zzJaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211334; c=relaxed/simple;
	bh=8Hu3ocB3ixg+/nWeepTsve1NcwSSy6x9sU20Ktj12Js=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=knsLf0e57IajLlMK8k2qtkDDwnN9m/FIPIo4teyfvoW38DAZVL0BTYJ8JbuWIXXYFzDlvoULrC9d4cVeGyrrjBgyV0/q6bTZKEXZIMMTxE78BVK/3TPGQZOIetVXP3tuxfv/B3rCxe2Ri+GhoU0z9MeYj3oZMa8CDfRiceN+Pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=iAKFZHTP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="iAKFZHTP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381ed661712so7023664a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784211332; x=1784816132; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IAiHsz4HQuvo0Nw78qJZ5n5qKizzxDNYVIKL8fArGOA=;
        b=iAKFZHTPvEYjzw34/mczxQCoeWt0hTeLd7POkCzB3UmizlHwSmVcBcDz8CD8u/OAF0
         eWegi9YVm18vfIbJRELH1VshR4OnS/eUYpiH4xtvRHP7F2gz7Kb8xvUlt8CBCcFqx803
         FjXETF3GXhJjScTGLVscbIDl9BdsQZpkGzIhTqFYOCc+20ZPaQvrxTBezIHzeA2tYYbW
         acUHqHPRRAGZxOiykWXidr/s9+lxI6ANZ8g5IR/7imEMHmkWb01z1ZJN5dcbBZQ4ndft
         K/hEQSNneB8LqrXs4/Lu06DFbySGyP/W+hsQ2BkJDMs6YJZMtR3BMPIHC2vcOWc6kmXG
         NJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211332; x=1784816132;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IAiHsz4HQuvo0Nw78qJZ5n5qKizzxDNYVIKL8fArGOA=;
        b=MEmKLxOdwiocSmUzLjXMcI/mze2wdvkuqzCr7im3OJspgOnmnDTQBJUYE1Pv6RBw4h
         HJtJlo6gkUqHZGRgGoEzXcDclReQrIFXuX6RdX3ag+9HTg3oI2Ta8z38IVd/EvhyUs/S
         nvUIpltV9p5iKz7maBYcPh7bvWDjP0ayKdKat5SdfaynH6u/Qti/62qzIRY6M48AHT5B
         7QirK6qEwkgGpX3v1/Bq0dZcxS2c7Q4iBIrYyFrLwxIGE+TGAjfoT20Ubf7Cv0pAp/ad
         CxMQs58HMnob3rLR4cJBCTjcwGELuKdBE4YY3FeIrK13LxpvepwPoijepmC3Uz/iVrE3
         esAQ==
X-Forwarded-Encrypted: i=1; AHgh+RouH/2FG313I7iE85jSr6p1x50m8ON+Q++j+hof6ratwFtaG/4BZfCvKpV6bwd2HdQzsCtgFj0pxAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczUOKNuT8S1E4m/DJkGhJdWSvkqScDrKFC4wA9/acOo3iJexL
	mh4lvU9uatNr1Gew0rWj0YiLVjbtxTnvjq9wXb9ZK/WSj4HfaRthyb19UN2Qh3bX5VY=
X-Gm-Gg: AfdE7ckBiSekqu9dO0VGT3sQZUUZ2E+StP63NSC7Fw7EbaK/b1BFOsiBFE9vdyoRjTa
	wZwU/cH1xtpmHghg2e/R7rBIFxAf8VI2rmltn9j8aUqL24TH3kK+CKw2GDNjL8ICgsf3b1GTOFj
	Pi6ep3ICixwFLIyYHSenib75/lQc9abHzcmEWEERM29JkctVvkJHCEjDMUYVTvVUxcVQn/adSYB
	RDn/IvEt/zW/GJ4kzLyQqS317WSTHAFIY2JfgWTPE60+ug2B4e5ME3q8kU4QkPhKRLGyEga67lk
	42M7umcMFRvzV0ljnRG7NYKbzxaCgotnWar339KwaqCaHWxOprkhUnULqNiSnXBKAYby+DJpDfl
	Q902uvFrUFhgSOlcMC8FrUP6Uckod0nxOLZvFP8FsV/4cD4y5X2yIXrck7aBsWeTmFV/5OT71m1
	Ai8/+mShdiQ65EC+dFz0qyYYHtqxP0pcJ3wnvbDhG23sFNRlY=
X-Received: by 2002:a17:90b:562f:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-38e1ac86732mr8350187a91.0.1784211332411;
        Thu, 16 Jul 2026 07:15:32 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6a626bsm12711655eec.19.2026.07.16.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 08:17:55 -0600
Message-Id: <DK026KAMHWFW.1R61HGD0MFI9B@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
 "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJXCC2TLMKGV.GQPIOKMUNXD4@sevenlab.de> <DJXK0VTX8680.10EZPJHF4UJN6@brighamcampbell.com> <DJY72ONUKYLD.3D0U14SM219BI@sevenlab.de>
In-Reply-To: <DJY72ONUKYLD.3D0U14SM219BI@sevenlab.de>

Hi Gero,

On Tue Jul 14, 2026 at 3:42 AM MDT, Gero Schw=C3=A4ricke wrote:
> On Mon Jul 13, 2026 at 5:38 PM CEST, Brigham Campbell wrote:
>> Maybe it would be easier to understand an approach which simply
>> increases the size of the filename buffer to PATH_MAX from limits.h and
>> just copies the path directly into the buffer via strcpy? I had
>> considered this approach. In this case, I might consider moving the
>> (much bigger) buffer from the stack to the heap so as not to overrun the
>> stack frame...
>
> hm, simpler to understand indeed, but 4k is a significant allocation for
> smaller targets. I'm a bit torn. In the end both are valid options, but
> I think your implementation is fine as is. Maybe just add a comment why
> we assign the pointer instead of copying into the buffer, so the intent
> is made clear.

I'll keep it as-is and add a comment for the next revision, then.

>>                                                I appreciate the feedback
>> I've received from you and Gero.

Woops, I meant to say you and Wolfram. I went backpacking last weekend.
Clearly, the Utah heat wave fried my brain!

--=20
Brigham Campbell
https://brighamcampbell.com

