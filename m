Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470226;
	b=tLr3X4Ph6R7rocjzOndfioO+vkfdkPansKm0d303oiHSUQYhUPiRuta+Q29EL/mrhWn3
	 hI6ZD/fvACL/AuQB9YRfXXx6H2zxEzg3w72TqgrMQCAI8L+WLvg16+NBSNbN6Za5G9Cey
	 mTawMG2/jxv39AmxILmvt3eqaXHQ6TB/vkZlIcCNH99sDpoMTB/kY+5v/rcRZCMtQuwxZ
	 7ljsNtCrDt4ZviJ7EtkWqOaYifx6cZkBTtjgvDrLZi/HF/E4vI7HJnuOYJZnoIfJCrQdo
	 rz/1Wds/vuXP2eSFgxm4mv+pEBc9LZx5l4E5r8tWqIS2/H1gxsqqXMtar09bnO3GfSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470226;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yXljFrMHuNZdAD8pJZ58StWeAWXC+mtlKfyCWGcsFDE=;
	b=VIW862WejswwEVuAKt6zpIg1mwsam7s5QIjvfH5SXJk181U3B36Q8e4/yWVgOp8wcvQe
	 aEarCbJdVY3mnbc1z3grHcSwMqlimK9xBFS2U5bP5DmrsdYduCQwEyk3Xl6q4pLb/fVcq
	 57vGE8XXxWY15AM2KTIpXDf3Q0h4hAWKcqf/1aIsWVPYbv3zSFXArZewQ0efXWsw11h93
	 dEBKRTwLoA4rRTy6v7ZhX+QUtcPV8CI30CxuzCMp96T6+y2dFuHFPDSqnLG0rNNC3VK8P
	 YW8mJlJzqUnIotk0boby1QQb+nqvmfydUAhaWRAXSzxCzAvCT5DKT2i4y/PVQZX++Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD6606A88D;
	Thu, 12 Nov 2026 07:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BD6606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:f2fc:6c6d:98d8:5537:56be]
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xRPft-002Bve-0y;
	Thu, 12 Nov 2026 08:56:49 +0100
Message-ID: <651220fc-f1ea-49f2-9992-a1b3e31d1bb1@phrozen.org>
Date: Thu, 12 Nov 2026 08:56:48 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: i2c: mt7621: add Airoha AN7589
To: Conor Dooley <conor@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Marangi <ansuelsmth@gmail.com>, devicetree@vger.kernel.org,
 lei.dong@airoha.com, Linqi.zhang@airoha.com,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Rajeev.kumar@airoha.com, upstream@airoha.com, Weifeng.xu@airoha.com,
 zhengping.zhang@airoha.com
References: <20261111093941.691801-1-john@phrozen.org>
 <20261111093941.691801-2-john@phrozen.org>
 <20261111-federal-pleat-191852ed2822@spud>
Content-Language: en-GB
From: John Crispin <john@phrozen.org>
In-Reply-To: <20261111-federal-pleat-191852ed2822@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.11.26 19:11, Conor Dooley wrote:
> I assume a fallback is not suitable here because setting this wider
> divider is a requirement?

The new registers offer a wider frequency range. I checked that the
old MT7621 registers work on the AN7589. They do, so v2 will have the
"airoha,an7589-i2c", "mediatek,mt7621-i2c" fallback.

Thanks,
  John
