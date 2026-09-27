Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4554421223
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534902; cv=none; b=iPaGbiQus6FmTUXYAi1my8NZlHdfVs39JniJMBBSC+3vFGWTMGONTko1DJu3Bill0tRCtgVuL2lQ/FrxRDrfl98K1IrJNYxxdD9q/S+R/Ol2UDJYM7WiX3D/OfAk1vccEsK1ZIgZ5Ul3qXRA0yOaO6yv7NmlKty/1JgKXO16EGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534902; c=relaxed/simple;
	bh=soXokHFCzmLIi+VJ1I3iTtbX0+pzsLftTokWbQ9P6Cg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HhBTlCJa4JBs/oOab1UhVo0owAQZfeurfn9aHYgcxL+D7C4jEDqASiLkK+SEISxZZEFg5t3l0++zmo7X3E0pjHbHxMtTN/HP7rnt0kJ4qoe1p1vpdV3ZFSHAeu4Ax3XJSN+OOFNHc337cJB/8kySdLB2WUbYuOSniUr5aTTMqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k+RmNbcm; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k+RmNbcm"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-343479e6005so563346eec.0
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790534900; x=1791139700; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yqlZZ1RhSPYEVPxxu8nVXKmxPulry40jU+yUEBcr1Ew=;
        b=k+RmNbcmk2D7AP0kteNYpcaZdc/OxOoy8fVJMwEAKZurJAThwJr5YJOZ8NitnpImVB
         htLitsit0bfiW+cFgggLx5SZGCgVZ33wVyQIqpPA7OXzBXDiDFwyZwEVYao7D9AEVetl
         M3uAwn8dDROWtN2sjqzmbid8rTJjyeXbVa2Sr+LP+d0g7sxLpMCHIVT3rKPyifrM/PKe
         /cqbOOeUGoqFIka2VzrgEwWH9LMR2FmsIDGxzZObx2Ok7MGVyYeUsbJFh3PF8mgPPpf9
         dBqVwmjmD5Am3UcUIDfBG2EXGAtCgHKUBzgeppUALzldMB3nQJ9aYBGj0B99nh5rdgun
         7jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790534900; x=1791139700;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqlZZ1RhSPYEVPxxu8nVXKmxPulry40jU+yUEBcr1Ew=;
        b=PDR8X97aDOmRmBnDoe22TOdHRk87AO19nRK4PT9wip1UJ7dUxkSH9MhLFRukcfcvfl
         rcQV2oGQM9Udy+564fKdeKyymAOwE3bPUE2QaAC4ni+u0Z/efi2vB4fXh2Rz8IaRoSBM
         glFfoHWrffXGvMiiT98LI65rCWKYrfiEF1UMd2R9+7bjMhoe6Cxtjj74DyTrudh/LVrq
         J8soGEBOmoYYL+faBq3FUI9A3XxeEnzGm8veP11syXBxvspIKh6jt+bEs8P11TRcwW6I
         xsxd7ScnL696f0cCVI2r3QZjOIySVdSF0O4ZUNh3EXcAmqqRCELJzlySPjr3Gvk46wHR
         mZbg==
X-Forwarded-Encrypted: i=1; AKwUvBxrpsSMRzgMcf8NhnxEyRe6IegB52qlxgjI4+FZX/om/2z31Sn0jjqyxXf/zqwPd5PwJicGp0A4BHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd1ce0zUMGdPtgBIRQro16KqpLlx2t2QD+PeXoT6WRdvGNdYno
	qxr3g/7k3qMqM3VhGo1+LOtvKtmpUpodYym7huWYYFOtUma3sK8cCwP8VWkLrUKp15E=
X-Gm-Gg: AYBFou05k39TfOKC73vvBg8ymYuJ+ePqWwvWsA1ko9xeiby9YHRhuyZmEfbLVZVYk9y
	+/OOoFVniHLL9svMkFVa2ZaBIotsLW9j3yTK2Dy4BsSq8+xzX8PrLGo1CD8KHvHGhQpj5ZRKDpd
	t1+2UwsuTFPlxtsVfL9lQraOTGr9Jrzi7QG7z85H9BTovPFjuf0d5MTSHm+aUgfPwj7xsUh+yaH
	n7tutL9vRJcDFG/ispNcGQnNlI5vqEy4TYLq/R12tkuFX/enHPomo6UiYn2tqRU8JXjkWbEmFDd
	nvkPpDicmUJnaDfmG30jZ6LodVgBJj+4nvX001wnxD+OW4wSme1xT68F+FrosRjf+fuA7Kr1DQv
	XYBiRjMMkn7aPlrOC6mDKkC+dVXh69sxvnX+yNjb6SPU9m0fkCoK4vi6m2OurkwYki/7/qKQjap
	VH1pSlfJIUKLO14aPU+x6rUeSclSs7QsntxJCf/xHpcN8oFp3Hrb54UrEa7IqFADTKwJLXd7Y=
X-Received: by 2002:a05:693c:62dc:b0:332:946c:4778 with SMTP id 5a478bee46e88-342721805c8mr5904589eec.14.1790534899604;
        Sun, 27 Sep 2026 11:48:19 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm2044300eec.15.2026.09.27.11.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 11:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 11:48:18 -0700
Message-Id: <DLQBNCNNWZNO.1AIPW6NRU3GWS@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Raviteja Narayanam"
 <raviteja.narayanam@xilinx.com>, "Wolfram Sang" <wsa@kernel.org>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [SPAM] [PATCH v7 0/3] i2c: xiic: fix SMBus block read and PEC
 support
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.22.0
References: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
 <arkAZJEJTtNsCjmF@zenone.zhora.eu>
In-Reply-To: <arkAZJEJTtNsCjmF@zenone.zhora.eu>

On Sun Sep 27, 2026 at 4:40 AM PDT, Andi Shyti wrote:
> Hi Abdurraham,
>
>> Abdurrahman Hussain (3):
>>       i2c: xiic: preserve PEC byte length in SMBus block read setup
>>       i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>>       i2c: xiic: don't clobber msg->len to signal block-read completion
>
> pushed to i2c/i2c-fixes-2.
>
> Thanks,
> Andi

Thanks a lot!
Abdurrahman
