Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43E3438B7;
	Wed, 30 Sep 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731871; cv=none; b=GCYm1EaddE4RyqYmY87lwCbuoEGLg89suEYpGMmsETcZLMyYKvMldJ4COv2nvU40ALyv3j/nai+Puxry8kAKwgN2qzosZb/V4ZNa0frZIpX1Z/E1GSpiOYQBUBw8Oq+X4TqoX01kn39xMVt2Huh95qaCRw+wV9Zpzf6ivjPYOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731871; c=relaxed/simple;
	bh=ZJQZa9fBtDrsBGxdSvvFN1Ftjl3HNg+h0YX8nf/XsxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnhRsFooLpA9QBVrcT8Um/t/rSUwwGa5mA/PC8VjhNdiYBD6+V/s0D1ujVor93eKjF+RvN5jfWygMwT9ND1lNbB1Trl1rF/PZDBKx7i+svIGB7Ru/J0Ef+F2MvukARfJiyhR3M4cRI2HaaQwQxidCnjPiKfiBDvN92Mhq67aauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=dz3NANWb; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="dz3NANWb"
X-UUID: e2338f4cbc6d11f198e94de09bb89237-20260930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ZJQZa9fBtDrsBGxdSvvFN1Ftjl3HNg+h0YX8nf/XsxI=;
	b=dz3NANWbinMcn02+7WUHau3HQ9yZIkE41XwmxZzYA4gjMhSNFEAVvktImP0qJYqjy1Z6zsacNfniH0Sm9klzE1nq/d/pqxpb75FV1jol/TkHX/GdSBf5jCn0MRCxNYyBBJFJhb9z0fRC31RGroSauQrlA37SbUQ6EXkJ1rE0YQU=;
X-UUID: e2338f4cbc6d11f198e94de09bb89237-20260930
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 170437113; Wed, 30 Sep 2026 09:25:55 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id BB3FA1A1E1C;
	Wed, 30 Sep 2026 09:25:55 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id B73C8C600E1; Wed, 30 Sep 2026 09:25:54 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Cc: shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	f_y_pai@novatek.com.tw,
	jason_jj_wu@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v9 2/3] i2c: nt72676: Add Novatek NT72676 I2C controller driver
Date: Wed, 30 Sep 2026 09:24:57 +0800
Message-Id: <20260930012456.804329-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260910030123.215609-3-nina_kuo@novatek.com.tw>
References: <20260910030123.215609-3-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi reviewers of Linux I2C subsystems,

On Thursday, September 10, 2026 11:01 AM, nina_kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
>
> This driver performs the fundamental read/write functions as an I2C controller and supports Standard-mode and Fast-mode.
> Default operation is Standard-mode.
>
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>

This v9 patch was submitted about three weeks ago, and I have not seen
any review comments yet.
May I kindly ask if anyone is reviewing this patch? Any feedback would
be appreciated.

Thank you for your time.

Sincerely,
Ben Huang
