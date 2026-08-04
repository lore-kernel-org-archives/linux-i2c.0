Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FA32B10D;
	Tue,  4 Aug 2026 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827640; cv=none; b=QsBh7aJfl5VaYCD85skaOAClTuiZj6qaCnVANRGRKkz27OlOLhuwcI17z526MS0Xhmi6lo4qhY3Fx6gohgp2p1yYDKgLqQvsf4nX1eekMC44LMma1b+um2M0dw/OB1Phhbl05iYUHfmiR9XZqZBX6+xPXZfjVIQ6NXBzYDuqP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827640; c=relaxed/simple;
	bh=wMyhhx2JrwaYK0fhDaESYWCW/0/1xgN9+n0k4fjv238=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YooFxZrCzEY2BDAOfT2ftg/TI7xpAaw4FCMdP/LKiXJiuOTQFaBnwarWx08UdsuTGPR369zjifoD1vs9pUQa+keF8UXQrVOpMMlscPrlGXtwDAD14gH880UWLDDL96lNM0bwpEGw4YiH4IKu/ImdMlcYMF94a+9yXtR0lPFV2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=yXAGGiiA; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="yXAGGiiA"
X-UUID: 0c969c828fd411f1b694ffd7d3467620-20260804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=cGFbIbfpq6Zxiip8DJSFW1kIdNwm18WpuIXDUv/bezA=;
	b=yXAGGiiAv86CtzdlqmI7ZgjyLZlMeGJp/Iu3pH9IIsThCnoyMouKsIVsCZIEFicAmyDBSmv38ncNpkZNTRniXhJO6Y5icsMH4pcQDAoSu+6pR3noZPpGHz1oGop36f+btx9SPihnHWZh1Xify/LZqf7SK8R36mbJVarOYbKJFfg=;
X-UUID: 0c969c828fd411f1b694ffd7d3467620-20260804
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1626675240; Tue, 04 Aug 2026 15:13:53 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 2FC7F1A1E1C;
	Tue,  4 Aug 2026 15:13:53 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 48CDBC600CF; Tue,  4 Aug 2026 15:13:52 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: krzk@kernel.org
Cc: andi.shyti@kernel.org,
	ben_huang@novatek.com.tw,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v5 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Tue,  4 Aug 2026 15:11:39 +0800
Message-Id: <20260804071137.701934-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260804-uppish-abstract-starfish-32e1da@quoll>
References: <20260804-uppish-abstract-starfish-32e1da@quoll>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Tuesday, August 4, 2026 2:49 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Aug 04, 2026 at 11:34:17AM +0800, nina_kuo@novatek.com.tw wrote:
>> From: Ben Huang <Ben_Huang@novatek.com.tw>
>> 
>> Add Devicetree binding documentation for Novatek NT72676 I2C
>> controller.
>> 
>> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
>> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
>> ---
>>  .../bindings/i2c/novatek,nt72676-i2c.yaml     | 90 +++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thank you very much!
Appreciate your reviews of this patch series.

Sincerely,
Ben Huang
