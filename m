Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBC43D4E1
	for <linux-i2c@vger.kernel.org>; Wed,  6 May 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078471; cv=pass; b=Wa1v6LFd0pw+vT6jpdtgYZvY9w5QHqBx8Uz71k8mNxqKOyZRtJMr1yfjxt5ci/DLLDS0xw7nkmB2zL1M+nOSEItp6lvDZmmqaD6SRXMqSZV0kqVr+ndP0Ws9G9K6URFXVR3xiQ4jejfkYKTm1vVnjl4B52ykrKCyWBuPH/96QFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078471; c=relaxed/simple;
	bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG7efesTnA7hDr/MfnPqJWzj6Nl+J4eoMDYLrH8JqaSGMt879acMshyjqMGNIlE16Fiv8JjWHjDwDh1a3khcbWDMbkTPORZvjUBo52hEdhTUYmSo9qnUwreVd9ZUlFMGvCJsUqDZBBH7SkebT3gKMF4lnuUxtb+3w+aOeG9tGvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4RzOK1j; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4RzOK1j"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so11269236d6.1
        for <linux-i2c@vger.kernel.org>; Wed, 06 May 2026 07:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778078464; cv=none;
        d=google.com; s=arc-20240605;
        b=KHw0XlfPi34+d3t/57yLan2GUYjgPTzCu2C3z417gMf0Nxqwq6KORHOWqbV2Y9JJ9J
         pyeuFAHndyTUpxRhl+7o/Cyo5/2LbeHR3RlJLYfApw/e25U7hlKH9f3oy3JtxHKtqSL+
         /Wslk+mx9IycQapUhde7LK0bxOVaNUvggpNROmL4f+2CuGe8L8qZsMQoVcFh4hNIhwKJ
         74p433xW9xXS6azmiUkwo6urSsZ30nSpcr26GJkpnVJ6PDTCtmvnLptrJR3xwof4vgvd
         t2Fdx1RXyeYqWgXhLEjGGXbpur9ZWVInqBWcOekg7wbANP15A5MyBuSw7TeThMWfkoQd
         kh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        fh=DTtIfH0unRweCQTyHfbEPqAdgYGtIH3bzjkQoWq/Hiw=;
        b=ia581HP+xDrln6Yf8d9sBWndMzQIA3y5ZjXQ6sRlCnChs4+IPqSFZ7eWK7mhuv1Dad
         Ve8moZ/948FJIh333V4vFfwygpDEMED0My+havVknXJJjFFlRwMyh+u8FV6L7B0HyeXw
         hiwsyvKtJzsrj2pQpb/YMOKOiWbIfAGFt2mE5rFr+6jOB0gdKAJOguxsqfTw76uYShRt
         LnFrnpu8XnsanVQdQmik6o4sTx0eyfExggvpU7M+++ft+rJTYP3l2XKBmaB41q1sKPiE
         YD/V/Ec0XKCHWecMplwLTVbwXER4/AmbbBDFkzxfb75d1n71X5HwIsWt9PG7gv5Fzozz
         HFTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778078464; x=1778683264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        b=G4RzOK1jPvFj16I4JBAoLV7wEu8ZC5fzzMQHl/bCkqLBnOAzzuGNSmeJf8nSC+1TpM
         gmt0jlDriRemYfWrW2vsqk9e3x69kmh/W9HuH/HlbHAMYvV7ArKU8ov3A4cdt62+XWjm
         Iss/Em+w7Fi+CEVEUBR30xyDvrDVvIMOJixAIPaAqsYOvzUHQc3b+t6lvD4MqAG1LYZD
         7JxOoF3KkVxB66VXZOP2bgV2p6LMWTCbZJe/Zc2qIL3g4eGHUmizWFCbZIdDcQxWlVs4
         pIiTF88IhOcH+3NCSJcjyMbOXi9UFqFlv/wlxPp6jMWjASbtQKu+Wqhu8ljF2KioRmyG
         jWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078464; x=1778683264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        b=C99z4QTKhPsYtwFaPGMqearDSihb214hdHcrcfQ+WOSAw/fcdBnClNNLbKymHlaMy4
         gRTVfNn5IWxtt9aW2y9b83/GuK16iw8okdxmLcCOAX4FxtOhZAdc8k30HWixGnm/9haa
         OkwI/t1/eiPh1/C4AVHos5WCgDJbXBGIZHr0nt+4JS2yKBTYdW7gctcSkqqf7Xfkq36P
         9ZJjKXbht8Mdnmulf0OHImLQrRzCYoBrOmgVxHdHlWGMTydES6GEvYCJS57lvLw6KFfu
         eU2pE+lFxiq9M4WAchxcmljcIAJDp+VgTGYCyHFjFOnq73lV+iF4cCg09wezZ9YnhIfn
         JRAw==
X-Gm-Message-State: AOJu0YwZH/TrT13oKa35uL+vEXRn9FaWG1qLPGrOMdzggtT1E25ETg2w
	wwQs4Oy1uyU1K3LvWnuVnb/uSslW+o6mRxAeeSJ8L4QnIUx4rNTYioV+l1MRdwVdfBfuyKvZ4JE
	lFP+eUel7RKR8XPkzTBECNA2N2KbjFprth8IXN/aZ
X-Gm-Gg: AeBDiesLnqJlmeMXFSE7uOE1Lrw9lBzR54g9pufSlgB1lPli1i0qnYhAk2iYa78cu8P
	S3QaKRu6SrDA62RX7xzI0JygteDYRZc6YH3Qj+PJj0C31wfyQ0wzB/XFTv1oDb2Vgs/NZzVt1CT
	BZ+QfoExCa3ax3qKWsBfZfOdYlQSm99011pfOmMXUw0oWB5fo8y5KPi+KoWvVdXVs2CgHvTJJ9T
	7XZkOqK61Aa7Mmm2hKBfjbczFN8HoPjsmFcerXiO07/z+PVRpyXlthuRXGj/XpzLRQf7LLeui5m
	edd2ST5RXmKVGgE2CbvuO4JvOAIUw/pkUbBIHxXLeoa/iMVBBW5IqmcsAxYftg==
X-Received: by 2002:ad4:5d4a:0:b0:8ba:7e7f:956 with SMTP id
 6a1803df08f44-8bc43df4e67mr53101336d6.26.1778078463580; Wed, 06 May 2026
 07:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415114752.1181079-1-bsevens@google.com>
In-Reply-To: <20260415114752.1181079-1-bsevens@google.com>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Wed, 6 May 2026 16:40:52 +0200
X-Gm-Features: AVHnY4Jo39U_2RZihXMgVdQ4rhs9ShEG8ptg7JggISStymij-sTqDRWTDgcuu_A
Message-ID: <CAGCho0VO4kcYRkHhTH9qV6c_8xsKXX=t9YK_oLcUtUpDNDTPtA@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: Fix heap buffer overflow in mcp2221_raw_event()
To: Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just checking in to see if anyone had a chance to look at this patch,
or if there is any feedback I can address.

Thanks!
