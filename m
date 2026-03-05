Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D980273803;
	Thu,  5 Mar 2026 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751708; cv=none; b=YSJmY3hDmIftXRjC9uWj3Lwuh704LvnDTiaHutJ6r3agO77Pb1t4GV8Qu1JHz9wt+7xxAUx23Kj7iqZrWnzWowA5ipmLCR/zIPu9MqF78n+Rtv4gqy0uE+PQ/+JNc/US3lSlAeRW6wqt3LttnZdl+jjUQ7W2ze8cHnLOAVFFDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751708; c=relaxed/simple;
	bh=9J5Zj6NdgqbfM4MzVVAxnLzy8MksTLvO/4JRlBcSRsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5b06rZaqeIB60V7qeFO+sGZDeQa4vosUTTSDEwkP2L6MDbRzJuNFco++DbHCu9QRdwgJSjV0ZT7mab6D+EtkUlXYvude3CKDGt43CN4wXVdJBpnxkm6JXB11N23+mac5/9pRxmMBGIpuQVH0hMfLUhzn7YswEvzOM192PY/JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cHbH/Hjn; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cHbH/Hjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772751707; x=1804287707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9J5Zj6NdgqbfM4MzVVAxnLzy8MksTLvO/4JRlBcSRsA=;
  b=cHbH/HjnPKggP5J42qB/bDLHA3uyX9LipPhaPWhdd79fKjU0Z6HKZms7
   oJpKBfpeUOeVtaRzASxoxHGiUJYF0mJokeYsnuG0TGJEJdx7331MDEKQp
   zN8DPEcpLZdcIobRbTqa7bcFpSgZEaVqCv3lOCRqFyzlgz6yDG89uOw0d
   cJ30Ca3H0MbOmYFFBKKGSCV4SMOenPZSmNj79/aEAcq+o0w0LD+gZ7/7X
   M5MfVC6gZ3yuIX1Ugxe0XbL7RaYXn9ENU8X/5jEGGrhH9b25FYgRnuWIn
   UEmq+1VuEcmrkEiXvILx1VKNmS8vJivHRuFNLkVqI0YxhSwKYRpVkPtCi
   A==;
X-CSE-ConnectionGUID: jcVVHuvORC2VqbdEp8WxAA==
X-CSE-MsgGUID: SBCtrfpaRo+76DraRJKxng==
X-IronPort-AV: E=Sophos;i="6.23,103,1770595200"; 
   d="scan'208";a="14307667"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 23:01:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:28960]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.143:2525] with esmtp (Farcaster)
 id 0500c0ce-fc0c-46ef-aa88-02fabb1d8dd1; Thu, 5 Mar 2026 23:01:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0500c0ce-fc0c-46ef-aa88-02fabb1d8dd1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 5 Mar 2026 23:01:43 +0000
Received: from localhost (10.187.171.36) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 5 Mar 2026
 23:01:43 +0000
Date: Thu, 5 Mar 2026 15:01:42 -0800
From: Cory Keitz <ckeitz@amazon.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
CC: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] i2c: qcom-cci: Add DT property for SCL clock
 stretching
Message-ID: <aaoGonc1zcTMKCgE@bcd074ae11bb>
References: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
 <CAFEp6-3ZuSOW4apj2Ww2DJ5_5Gw-CDXV_9Qc2=wW-JLP8Vbatg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFEp6-3ZuSOW4apj2Ww2DJ5_5Gw-CDXV_9Qc2=wW-JLP8Vbatg@mail.gmail.com>
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Mar 05, 2026 at 04:16:31PM +0100, Loic Poulain wrote:
> I'm not convinced this kind of hardware behaviour belongs in
> devicetree. As far as I understand, clock stretching is part of the
> I2C specification, and slaves are allowed to use it whenever they need
> additional time. Masters are therefore expected to tolerate
> stretching. Given that, why not enable it unconditionally in the
> driver? Is there any downside to doing so?

Fair point. I wasn't sure of implications across the platforms, so my
preference was to make the change opt-in to preserve behavior for
existing systems. This is probably an overly-cautious approach though.
I'm happy to submit a v2 that forces it on, and remove the new DT
binding.

Cory
