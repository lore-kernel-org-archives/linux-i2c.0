Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FD39D6E8;
	Fri, 31 Jul 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493505; cv=none; b=LWpGBkS3l/eC1eB3Goqq/byCMnWQpJz5YSG7LlE2bqiyWTyzTAS8GfWDHrUj3gGXcGXbPO0BIsG8yK5fFyGcMvSPxX60/7/gTEum6JDv3piDATiZTCLMKdWEPCbQaP88teIeT/EuBJiOCXRsvMMA3eW+DJz9dQi/+xzirM9w8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493505; c=relaxed/simple;
	bh=CDhyAlQ8LlxFwM5ei8KjmtqKsphfSEYnEQigdSFJSyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIdMxNJNu0rNgrRRSMr3TB1eDfknChL0UjUyktFNxuHT3TlPQO6au8hL2Ez2dlPPCqAtXKRMcWoZpOYsCsQFUqjQyRNcGQjNFjMF1KZ0butHxtFztQTEtKdrUSeA43yCmkeSviJ878NdUJS/vuqJKx7+X5oiCsS2dDAOEI9mvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=vIJhoSjG; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="vIJhoSjG"
X-UUID: 12b9902c8cca11f181a149c3f3c08161-20260731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=CDhyAlQ8LlxFwM5ei8KjmtqKsphfSEYnEQigdSFJSyA=;
	b=vIJhoSjGTOrCKew+ztRyupSX309Tj+Pme23kS0c+JYvnKfwww7WzdgEaBGWIgi2V4uoNQgpMPS0H57z9KhWvHZUbyzEqx8qRkawfZnYt9a1DYmEXZC+tDRhSu9ae7r1yKTHJ5R+dXSOd4B+bVgwbGPtFR6lxEptZ7aGR0sJbutw=;
X-UUID: 12b9902c8cca11f181a149c3f3c08161-20260731
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 424491802; Fri, 31 Jul 2026 18:24:55 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 0D46A1A1E1C;
	Fri, 31 Jul 2026 18:24:55 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id E201BC600CF; Fri, 31 Jul 2026 18:24:54 +0800 (CST)
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
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Fri, 31 Jul 2026 18:24:27 +0800
Message-Id: <20260731102426.600500-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <a59c01f3-e930-41b6-bf6a-3cce92f301e6@kernel.org>
References: <a59c01f3-e930-41b6-bf6a-3cce92f301e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Friday, July 31, 2026 6:18 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Driver is irrelevant here.

Understood.
The clock property will be added in DT binding for the next iteration.

Thank you very much!

Sincerely,
Ben Huang
