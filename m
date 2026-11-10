Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309940;
	b=ONndqf5Jv4RJ2Bpll3WYuyjfmrfdtaKbhAlnKcZIdPzUqcZXOWY5Eakcvy+xB56dc/vm
	 oU26Lyc5qvwiamfGi2vQwtfSQRUHcEzrg+NzciCK5GtRtZ0de9JIKAKa96c9ptRA+R/QK
	 bvzSTYqqBltmvttjSLe74NEeutQEWWLSRJW5WqlE29yFHiJFCF2oz+gSdENViCbnlTxF9
	 P9i5gjmTl4KxxFG/76jknlJtnN1OUziDTSDecNoOLSVHjaEWS1t/p7tzcaTIPzmbOQaQE
	 vWlp46NtKHeRuZ0sa3vUZdm/PJErzbTT5REST1zd+Mr2vs3fvnMQE3+Qgu8wi1jzU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309940;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Qg+S1T/e+Zoz4FEz/2Ax5PBXiBkavSDjIEMgsAhVa/s=;
	b=QNv1qvTwb1n3ntBi8+7O8VAkrDyULUN8fjsaw1jfQ13hEaaOZl4vGCzGc9yZ+MHWhVwO
	 vOumBGWTNQGGnbuseIDSoVExcP6tFfg4nFI9+igqQSjheBGHuCXm9ysTNy+wy+dz0DD+T
	 YPV+jrzsKnH0OXZ0P0IhngNO2tviX7dkxR/Gx6xLreSoi3H6tjLEml2Mayji5PN1vfM8k
	 uQ611nywIGeL8hLMg0ogIPSLsY+J2AoNNI2kaEta/yircQDy5e40sU814HsDiPOqXCBHA
	 bel0N4VcWiyDWDE8HYTLqCNmNuNF0tlBZ+Tr0m/nxznCbTbtZCqFdQh8UcAjNRnzMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bUCgqnTO;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2160A3835
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC2160A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bUCgqnTO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Qg+S
	1T/e+Zoz4FEz/2Ax5PBXiBkavSDjIEMgsAhVa/s=; b=bUCgqnTOn84GD+oLcWH5
	MfALaS0iCSjACuqkekHSTi0wZrPCdof1G1P7VHCiXT9pd+G2ZEyKFIBzA3MQVMq8
	lVW/F4CjalifNZujc2/SFmRDHArACuOmP+A+zdMXJmI6eM8aP23si5LIDR5HsDva
	iMhHO+/UZ+cD7RB+W4PlkTr83gWByIds4aMKrqia1QNpFYMzs0jLoV2r/FkGsAVj
	TuS+h+i2XlaVTYCc8kgV0lQuIguAuruUF/4r+4o2sLYnhQ3Xr3sRG8cvjiY64zCt
	DSfumNWY1g6dxc2/s3nFK7DMHW5vuGMO/msPNMBWOHNgRj74az0tAayvnNHt706H
	AA==
Received: (qmail 210108 invoked from network); 10 Nov 2026 12:25:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:25:34 +0100
X-UD-Smtp-Session: l3s3148p1@4JNFVupfCKgujnsO
Date: Tue, 10 Nov 2026 12:25:34 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
Message-ID: <avL_LiNnRVELGDN3@shikoro>
References: <20261106030203.15709-1-wanghongliang@loongson.cn>
 <20261106030203.15709-2-wanghongliang@loongson.cn>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106030203.15709-2-wanghongliang@loongson.cn>

On Fri, Nov 06, 2026 at 11:02:02AM +0800, Hongliang Wang wrote:
> Add clocks and clock-frequency properties to examples.
> 
> Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>

Applied to my for-andi branch, thanks!

