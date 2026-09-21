Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC2376A12;
	Mon, 21 Sep 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973543; cv=none; b=Fqlm2xmjhiI+bMccH9xvOH0qNDMI1vP8Xovi9JhSZVYXrolk/1FB7/wtuVjaLeV9n/uzE+SLZDQB3c1nIbvExvixY4Tm4ES6Ulx05k6RJIIGtAignElNe5At5K+Bg4SZJQXNUrbOcInrQA+aqkAcn+RfGmEVIpaS0hRbam9y9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973543; c=relaxed/simple;
	bh=xJJwh/uSa9O0HL+0RnWkMAy/Q+hl+tSY0E0DE4F1PGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTNKRIS1Hd5xhuRwMCepUcv2hqkWIpA6ebnc9DnT4ms9cQzzijLEwHZWgoL0X56SrFG6jPFlzKooqXfau1GzvqGchzG170/610H7vkzfWka149+phn7G3PjMOwPitCHvv1yuapI4PDOBwg05wSue5ncKDPLBFnQ9FYe9loBXF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=Ji4y4rJR; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="Ji4y4rJR"
X-UUID: 445711eab58811f1b1aaad79f5fb1677-20260921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Wzk3FyWUHLwQgpzFqcp0G1JS/KnsFbHhVG6dgCYmkWI=;
	b=Ji4y4rJRhhps97yPKZV5Ejv+frBoWRRuoowcqQ0fI4GXHoZNL4O6FEW2rWi2OZ2MzsO/kBMv9pZS4gMD1jPAQfjOWwvwK1bxC4bUCEN9hqhTnTvfhlUoRoi4nRLoWb08QTf2lcm+fmKg5/iCiJHGctv39hZ3Xvv/wEo46TZqAjA=;
X-UUID: 445711eab58811f1b1aaad79f5fb1677-20260921
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1287419015; Mon, 21 Sep 2026 14:47:09 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id 363B31A1E1C;
	Mon, 21 Sep 2026 14:47:09 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 6A337C600DD; Mon, 21 Sep 2026 14:47:08 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: robh@kernel.org
Cc: andi.shyti@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	jason_jj_wu@novatek.com.tw,
	f_y_pai@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v9 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Mon, 21 Sep 2026 14:46:43 +0800
Message-Id: <20260921064642.564969-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <178975623902.1285316.4399627146278456114.robh@kernel.org>
References: <178975623902.1285316.4399627146278456114.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi,

On Saturday, September 19, 2026 2:31 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, 10 Sep 2026 11:01:20 +0800, nina_kuo@novatek.com.tw wrote:
>> From: Ben Huang <Ben_Huang@novatek.com.tw>
>> 
>> Add Devicetree binding documentation for Novatek NT72676 I2C
>> controller.
>> 
>> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
>> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
>> ---
>>  .../bindings/i2c/novatek,nt72676-i2c.yaml     | 76 +++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
>> 
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your kind review!

By the way, is anyone reviewing the driver code in PATCH 2/3 of this
series?

Sincerely,
Ben Huang
