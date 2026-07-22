Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E563655E7;
	Wed, 22 Jul 2026 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684511; cv=none; b=uXxZIOytQhudnJjIDlgn0RKhaqFnoEnFOmr6uJi+1YXBVXMcMjBTLMX+WJYMmovcK2gBwCLCUib98rO4u5mOHRx1rP6ZgzrlYLeZmsWHBqieX+4oPFbyCthnxm2uTEa9kuI/yowZ6CKzUtkFzLMRZkHaVuhM8kXCvTlRsSX9NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684511; c=relaxed/simple;
	bh=KHXNBa2UYoPJtdSyKMFEcXggwzX77eVeH4VKKGrOksA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCGezTs5LRTC+UJfzA+zRbIM9dshAuOQ4ENRMWPjgM+MKSlZR30zFesiWKqYtzByvGLXUoJBCUy2pDAnNIZDmMqvFDPdHOQUIu4hrBwhbtJ5FQZyygw8CaRBc/Xmmi5klV5g4ugJPOSkJAERS2sRwdkEkyqTr2UOTd0uiE9gLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=rehAOy/1; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="rehAOy/1"
X-UUID: 7eb3f4d8856e11f1b694ffd7d3467620-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=KHXNBa2UYoPJtdSyKMFEcXggwzX77eVeH4VKKGrOksA=;
	b=rehAOy/158LrjgB7Kbt2qVFNAQVhPMoEsSQmbhFDewvtIpAT4IlxN6DZ/SQyRSTZ/ztN7AHlcjFFF7wupNsJqe+O80WrRc4gAKtxEBYt8HGckLoaeZ3VHcncxqo5yORBgb0mOmg4kvcSmyxNffGR3scdN7NZAFU75eaiKRt/M/w=;
X-UUID: 7eb3f4d8856e11f1b694ffd7d3467620-20260722
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1500547695; Wed, 22 Jul 2026 09:41:44 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 64E161A1E1C;
	Wed, 22 Jul 2026 09:41:44 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 60D5BC600CC; Wed, 22 Jul 2026 09:41:43 +0800 (CST)
From: SP_ISW1_AT@novatek.com.tw
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
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC I2C controller driver
Date: Wed, 22 Jul 2026 09:40:59 +0800
Message-Id: <20260722014058.522086-1-SP_ISW1_AT@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <25ae1ecc-b7f1-4132-81f9-7bb91f1a5d3d@kernel.org>
References: <25ae1ecc-b7f1-4132-81f9-7bb91f1a5d3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Tue, July 21, 2026 at 4:09 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Please do not top post or remove context you are replying to. I have
> like 200+ emails per day, so what is this about?

Apologies for removing the contents of reply mails.
Quotation of replied contents would be added in further reply and patch
mails.

> Please learn how Git works, how its history is organized, how commits
> link to each other. This is nothing specific to submitting patches or
> kernel development - this is basics of Git with combination of
> bisectability of software development cycles.

The organization of these patch series will be adjusted for next
submission.

Sincerely,
Ben Huang
