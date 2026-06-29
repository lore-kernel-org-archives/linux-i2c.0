Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846C3FF1B9
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734544; cv=pass; b=d7iZ4sknXucrMmUuMGIvvfkvv0uqhrdM5e1Yhe54sgPJHrj0XCBAsYj4VHoKpBmwqBAK2NJmZ0b+yyPI2DID6B7cYML/gr/nDWQ+INwkkTRy+r+7r9gJk1GRH1Qi74R+9p0vLWNTjG7BXnUk0af2rRSXP97GjfhXqPiM4FnPBUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734544; c=relaxed/simple;
	bh=rQbESuYheK6jUDuCh/g82u8kja7PJY9po+thco8Pd64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arxqcFNZh06NmSfdbqMj7xtgJP5JxRZeosLLxA5XGROEQAH91P4x98g1t3xXOWYMSKEnDVKK9kFyl+cVtZg+9VLZEnfE5S6e9cI95Y38usIm3YxCLdceqo64sq8lXWiHie9PqAJcx3qDR0e29A+yL0N/Ko8gdT0TUTJrhmPlOTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQq5mnuR; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQq5mnuR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-461edb387ddso3089204f8f.3
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 05:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782734541; cv=none;
        d=google.com; s=arc-20260327;
        b=OmrwNXqnAkCrYiH7Qphu9wFVXxcm2kEQXZpB/IwWlInbFfepIS+UU8du9WcTPbiofh
         aI4co27NKvU9PAPoGVrF3OtozerYU7brebaOKuw3SHoFGcmQ+j3e6Dr2Kdka6yuh19+6
         /m6ejBcm0odAYttK3nG+th5bCdr4rA8lBu9fHBc6OUaA/h+R8oAa3gZSoseO2BIuWQXZ
         09J8X/AG+uLUAK7KTGAd8Vtsx1xB0ETk9zcCatgbZTk265AJahcppREl8SBNIPWdemL3
         ncG116bNFPTf/4gW9VxLpFRVKul1gmuzNU18gUMiHEjoVhfKwuLvlPTFjUsaaY5hDIPc
         u+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rQbESuYheK6jUDuCh/g82u8kja7PJY9po+thco8Pd64=;
        fh=CELGn72rnxHkHbFh6L2WA4t0I8VRKHq6ui8p4M/5s4M=;
        b=PLFSdj5uznqpMedW6s8CEedELw92WIDlhCSpnmgQIyquUEZ3SxR4kB04mNIQafmL3F
         4a5XKiETgQnqrDn3EI6l5tpfBqwkt5Pu8Twp0ki5WkhKIVyUJvE22LTR1LlNCM7sim/L
         DSfU6L6s6FWNa4eWH5EDQYiKFZU37TpgV/yEg8Zu0JKJKMaVhGk3QrUAA3dfebtU94PY
         d12OqLVSho+1nWBNhHOnFhjErPo4mWPJ+LVC9+XsKjBBDmRWnvTdI9Zut/YouyaKmLRD
         nkAK/Ympl5hwHO0KTnql6HyNyhb1HJJdSZyeeLhubucVVZBANqIRjHOUGtSsRyNzgXNk
         7TMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782734541; x=1783339341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rQbESuYheK6jUDuCh/g82u8kja7PJY9po+thco8Pd64=;
        b=MQq5mnuRx9gC51LqJgrn9Tl0cwHNcJgDKZUQ5sqIya+6yX2Lt63AS/fljweLbxKCcM
         pSEuvNy1nphQ8pSray3ySOiRLr7IXobPlPUtuXwj4ds6AJTZjWq57q9Q24EGzPT+dGai
         uvpSs6i1ahLGX6r2eggYRh81X2brcaGNbzGeZRujsAtgGE0A+Ede0/gsoxtmw/S+wunu
         ZFW/S72XhVzwqSKt3S9tZg+XoarGm4ignRaFCavBbu0hQpmwZ+tJe5DOPEPWNjMPL1L+
         tKOqajeqHIS54clRIDdsM6uMGRwfvsQ+4pSdzZXy24KYCezg4ONmKdxUi2SPSsIncpum
         0O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734541; x=1783339341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQbESuYheK6jUDuCh/g82u8kja7PJY9po+thco8Pd64=;
        b=rkUN0q3C1EaZe2XW9/79aTr7Yo1BBMLFzhARlxlJGRGHsxfoKQR1gwssvTOVxfKVKW
         YhrmcmO2UVqEUjx9eJFaXO01TeYYYPjEP8kG/6psAHt+9oMG6qWWq8d8YEhRQxKrZ1oD
         /OSL1OpFfCOPJAzXhZeD7Rcf9nx7ZoGn3zbi5qIGQrOaSzsqx2Mk6BtgN+Q3CSa/M63+
         XcSGPfI6Kdk+fR60RG3N236aXOfkNhuQQ8MyFLJtvfZXZokW5t7leHCoLW3MfR/z6/ii
         flMdSgQtzgh8SXEUV7DKuwERdw+D8mTpL07xHPp1m+IE1cjBdgnFdypoFRUTzVlurOXH
         fLBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqx8QurIIQXZ3KOZD/kpCHhj/Sopk0JOcMDGk80IoKmVNoVEHmLBskoOOrlfgLV5DJh7SeH2CTV0gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0XsCsluC9qSAP4WVSCBLWZt8NLspxb6GrjGiG9TkyqoJpHKq
	wF39Ol73cNKYNDwZtBuMCBTP2xWB607olE42CbFqjnZlqIz01iwWEk4T6kTW3hdNMua5NwBHWEE
	+3NkdoZiBVf6Sdfu26mKOaJya9A7p3CM=
X-Gm-Gg: AfdE7clgaIGd8KyrRYuxYkz+WqxMZIk1ndiuBvi0nion/49SNtDAJwSM5JeFrMu/5Hr
	fqdvOBLZlAFCGHkZInp8XRCawTlmumXK5pYi5T0SizvmKDWIu5kpj7uRggxH4r0QI+S8wqukxhu
	CP5iBltUS+9URb9g/9hpxVlgN7McLbza8Z53yagBTyt9hc8qHR/RZQeagNMgwGvrkMwFe+qxoEz
	C2E1i1pCR5C+7bNM/un/Hj7LBXcZ0cWvPFxwum1PaNdvRjwZ48xx/OFbBGr3ZWfm1Gwg2bUMlQL
	Klh23zc=
X-Received: by 2002:a05:6000:2c0a:b0:474:9991:60d0 with SMTP id
 ffacd0b85a97d-474999161d5mr2365901f8f.12.1782734540540; Mon, 29 Jun 2026
 05:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178177668382.3462209.6459868495361731106@maoyixie.com> <22e94aaa-0c11-45f4-8317-204ac4be66ec@kernel.org>
In-Reply-To: <22e94aaa-0c11-45f4-8317-204ac4be66ec@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 29 Jun 2026 20:02:08 +0800
X-Gm-Features: AVVi8CfRcDGHyE5oKsrPFowAqsoqZisos9Jouu34xU8psQ3Txs0kvK3ZSLGOs8U
Message-ID: <CAHPEe=EM57UhqZfXf4LNokNx=RizMTKx6WMjs_A270uwrY8UTQ@mail.gmail.com>
Subject: Re: w1: ds28e17: possible out of bounds write from a device length byte
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jan Kandziora <jjj@gmx.de>, Jakub Kicinski <kuba@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

> That's exactly the bug AI tends to find... Easy to spot pattern and then
> figuring out the logic leading to it. Maybe it is real, maybe not, but
> the AI feels like too big threat of wasting my time (and you did not
> even disclose it).

I used AI assistance on this report and did not say so. Sorry for that.

> Reading based on length supplied by device is of course risky, but isn't
> the rest of the master_xfer implementations doing the same? IOW, what is
> different here? Or they do not do it, so you have the answer to your
> question?

No. They bound it. i2c-algo-bit returns -EPROTO from readbytes() when the
device length is above I2C_SMBUS_BLOCK_MAX, before it copies. Several other
drivers do the same. w1_f19_i2c_read() only rejects a zero count, then
writes buf[0] bytes into &buf[1] with no upper bound. So ds28e17 is the
outlier.

> Malicious DS28E17? Feels like AI convinced you that it is a thing...

The length comes from the device behind the bridge, not the DS28E17 itself.

> How did you reproduce it? Do you have ds28e17?

No, I do not have the hardware. The KASAN result came from a small harness
that drives w1_f19_i2c_master_transfer() with a 255 length, not from a real
device. Sorry, I should have said that plainly.

> Did not investigate enough to judge. I am sorry but my expectation is not
> to investigate AI-based reports. Expectation is rather to get a human
> created and human validated patch, regardless whether human or AI produced
> the report.

Understood. Let me send a proper [PATCH] so you can judge the code, not my
report. It bounds the length at the two I2C_M_RECV_LEN sites and returns
-EPROTO, the same check i2c-algo-bit uses. It builds clean.

Thanks,
Maoyi
