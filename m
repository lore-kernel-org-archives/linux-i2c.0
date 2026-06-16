Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE53BBFAA
	for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576122; cv=none; b=rO6BvNRnkgaOmmB11uVWlxow6dOdiBqtDgj/plFrmzNAUh4lf1u5thlazBpw6J752m6SXdAqH3RzYzgna9gxQP2hgpohdr8X/c3P0dAOfxvx4MLF0TpunfLqmBfuSpFHkRrVYBODkXWLDB1RShCs994xfqBa6g5Tesg/GY00XYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576122; c=relaxed/simple;
	bh=mst/SnqA8GTr4/cGz2T3fBm+dAyMHjrfyjLP2HPQd9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI2cCpnrMSUKJWZMmjRMN1V5edIjZ8xqRdYTwMz5IiS35wVm5sXeAJUFI04hZIjCiOxN5/F3bicvlJPMJSyEgl0Y8sxeBEbWeH3q3O8rurpp8MDh/VFif38zHYU5dW25d3fLC7wHS7g1jr/c6hL5a9GWvB/LUH8K87hA8dG9g+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RxOagzh/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RxOagzh/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so7830066a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781576119; x=1782180919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uITTN+lfgwm25AsFADp5kbZtSKCTzS6u1I4aOLTV1Vk=;
        b=RxOagzh/sfohNTPNgPJz8/12NPZPxMeZvSh/48RFrEl+qO1YHli5CD5eYkjQwYiibp
         gZ9yUdEZPiK2GP0MRZOjpGLP3BzhEUhzT2XxxAQNTsYPzNb6azzkI99VgOmjOKLefN4w
         QTrztGNZfW6kV2QeOWSgnPTtRiCApjIjJp71c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781576119; x=1782180919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uITTN+lfgwm25AsFADp5kbZtSKCTzS6u1I4aOLTV1Vk=;
        b=ltegfgVb6nDrXwpYqOIBEWHmESYdd99lRjPs1Cy4q+uRDF+Ft6Au0VivwkJWrOPttm
         3ekYSb2LnEcODgA5qN5j9oxqfu6fLMJziMUnObj8q17Q5LTh2uM3PS7gkT50XOm9ALLb
         cTDt1aIBZYh+1faq7eQjik5o6lS6kUtRCKpVB6AFix6ts/Ow9D9PcEJrQwGD3B6iCleS
         8MJ96ySy1UNlAAKCfOjDcuxgzX4HEEojt5kI2qCcT/Xm116tbB+Og5IPSTgZzgKMm6Hc
         S/UaX1QBevumEVXF4mCqFm2r+bH12gAFemNQuTxuc30CDQelUSFZkFcOxlhddsZALzyH
         ZrTA==
X-Forwarded-Encrypted: i=1; AFNElJ+eeS2Zr/ssLXtXYvUxyESwvlqLj9fBw/hXDEQQNKZcO7EtUKvQ5VQKqt0K65zu/k4cr3vCJBycRd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8NcPtRBPLXOYFykb3jagXKtAcgLMstIeNjjruAIjO+eCeV7N
	dsZs+EBeXswlL3yrGVG3nxyC/plJmE4dMTmQltr2easdPMwYWRmUcp921Cc5SsaaU8doCRApplA
	Zrs4wWjCWuw==
X-Gm-Gg: Acq92OGAO0hCSWrNAjbsXs1cB/WUShOYw9ioV4fydlkN+YxqCoBF4AK+YbxcMGkIoZU
	xl2rXlcQ4yhhOMYoIvsZOq7iJrrxkoJLwLZ9u5cbnTMSSdGq/wTw9Gg35emQVgOQLvyjR8xx65R
	eA3cpmgKmtcyxr+tnwFvvZLGxzArhsTjCI8oDNByJcvaV0OYIVUQpfgxLEIaWuWbjUfZrEwFROn
	7uJF4tKbNrGTF3N6bW76RIR3uBHOPMfbOIWSkeUcKez9fPs5ROpsZRiqjS4VLeG10eDUXs6X/tI
	CXdH6MDUeH+v3nxeCpQHbHCUUltHM9o53HBPFMXD0W+6Sbkx2HQbJbSNyV1zJGk6v37ylBLIUrg
	jOi+m/YKA2HoWjcFe8mnMyGUSH1YFT9FC2OC5yt1tYHTDbRzl2x4cskJjwr6O/bA7ARIJouEEN1
	0aZ7DayxioZHlSwl61Yf5rsVXIGNo4QAxf8iN9w4c6LnWtnl3/Cv9w1YsJCoYQ1ZYQSWsSbHrH
X-Received: by 2002:a17:906:cc4e:b0:bef:db4:296e with SMTP id a640c23a62f3a-bfe27830103mr569930166b.10.1781576119671;
        Mon, 15 Jun 2026 19:15:19 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb83428a8sm563765966b.44.2026.06.15.19.15.19
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 19:15:19 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso826047566b.3
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 19:15:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3snVBOkefAeFkKde6TKsPB9F1AGXLxl/xuvZ2wIaA0genC9NRRmsbr3YGuVJ2pYCAMIuC3p4jio8=@vger.kernel.org
X-Received: by 2002:a17:907:75d6:b0:bea:2fbc:4ef5 with SMTP id
 a640c23a62f3a-bfe2b9d3914mr584794866b.44.1781576119063; Mon, 15 Jun 2026
 19:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
In-Reply-To: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jun 2026 07:45:02 +0530
X-Gmail-Original-Message-ID: <CAHk-=wh8CXM57dcyh17qf-Wzmv+u4KZNsUMpG9n3DiKKc-yAjw@mail.gmail.com>
X-Gm-Features: AVVi8CcVpbpYSeToXlfmh4FaS7pgPcQOSc19T9jA68AZ8cnlGRyhjHSBboPTCE8
Message-ID: <CAHk-=wh8CXM57dcyh17qf-Wzmv+u4KZNsUMpG9n3DiKKc-yAjw@mail.gmail.com>
Subject: Re: [GIT PULL] i2c for v7.2
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jun 2026 at 16:24, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> this is my first pull request sent to you, and I hope I have
> learned enough from Wolfram over the years not to make a mess of
> things.

Looks fine to me from a quick check. Thanks,

              Linus
