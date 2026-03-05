Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC879273803;
	Thu,  5 Mar 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751865; cv=none; b=ONLkGs31GZkwWaSgYXQTCVfiuztS+LZmbkEAmK0eeBM+5Lpp/FG1fhVl/mS9kNqz6Ipz3KUzLKn73Hpmt5Aio6aYauOwrj69YEoa7olijbh0IgJfFO3izObyMPogkbdlJOqSVbyEiUsIVzEx/4oWcjsRk3NRyokaF+MCA94ZADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751865; c=relaxed/simple;
	bh=/0kba3yxfUqwaSAnoA80f5IIY1lldujW3iPmvxGpWB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy2meUUcM+A+eEwNH6pzJjlYSgj1GTBoTAbROg0648sRNZXgQQ/K0s7gTTOIXE1swbfHBTiobZYafoL5WOJTo0ThefGzjSZJmzVYJyALu55TKRfa8euU0Ix5uPIdAT/lPMrGZH4aTKVOPhIsFvXO8HXd7TEO2hLzyEHRxtASIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IUWxdW9p; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IUWxdW9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772751863; x=1804287863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jp0nCbo9VuN7v0sbmFrKCoZLNJnFOUrvs9a8rJZulQc=;
  b=IUWxdW9pi1OBzrK95sKBM+qi76Z4DAjBqunHGOo0EyNf2oc50XTVvhmd
   iYUjf0K3ffo9mlCTsr4lah5qjBMxddpcV2ZasvCbfZEDA7jjvd55UrCfv
   7sOBmgDrhGwdvtl0rC93IsOJLwiqv292LtTBIYQGcsbrMHUI4wHVC9obf
   6scefNmyakmlLMZZEJGrCb7LGysxbriTouEoLCO7hXA20ehGjQaBsqqef
   eyaSbbVsdc/cIAN/zmSz2QnjQqFOQIBjBCciuvpHuLzgc/q/yotB+dRdf
   u9QQICV126KMsik2rzMt/XqloOjSabW8MyoBzb/IWk/banJG71UrmbsWZ
   g==;
X-CSE-ConnectionGUID: GPzwQt/TT0iOD0xMfCvibQ==
X-CSE-MsgGUID: Ej99UXOgRfKZ0IRND+UNIg==
X-IronPort-AV: E=Sophos;i="6.23,103,1770595200"; 
   d="scan'208";a="14301774"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 23:04:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:25988]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.108:2525] with esmtp (Farcaster)
 id 15524b2a-2129-45ef-8ea3-d1d184f4e4ed; Thu, 5 Mar 2026 23:04:23 +0000 (UTC)
X-Farcaster-Flow-ID: 15524b2a-2129-45ef-8ea3-d1d184f4e4ed
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 5 Mar 2026 23:04:21 +0000
Received: from localhost (10.187.171.36) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 5 Mar 2026
 23:04:21 +0000
Date: Thu, 5 Mar 2026 15:04:21 -0800
From: Cory Keitz <ckeitz@amazon.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
	<rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: qcom-cci: Document
 qcom,scl-stretch-enable property
Message-ID: <aaoL9fftV-jqfgIc@bcd074ae11bb.ant.amazon.com>
References: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
 <20260305-cci-scl-stretch-v1-1-8412abc65745@amazon.com>
 <7b8585de-38ce-4d87-aa12-4a2cc420402e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <7b8585de-38ce-4d87-aa12-4a2cc420402e@kernel.org>
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Mar 05, 2026 at 04:18:11PM +0100, Krzysztof Kozlowski wrote:
> I don't understand why only Qualcomm needs per-controller property and
> no others need to static configuration. Maybe this is just already solved?
> 
> And I actually found this:
> https://lore.kernel.org/all/20230312131933.248715-2-andi.shyti@kernel.org/
> 
> so this is all done.

Thanks, I hadn't seen this. The two properties there aren't quite the
same but the point about it being a general property is well taken. I
plan to follow Loic's suggestion and hardcode instead of using a DT
property.
