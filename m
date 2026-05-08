Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDB37D12D
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233525; cv=none; b=SfjeNqgoTHHS5nTiA8wmEXkQ4jk0UuAzq8cLCwGbtBhO/Jt/mmD5RBnhJUBXbsbilWDGQ6QPjY+La4TLAtMG/qRLHakC2A62rEOG/Gj3WoEMmTNh0T6D13zD5kDS3l6W4SY8DgboetPCidY7Chp4KvWvYfOMODAYvhayw1IkC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233525; c=relaxed/simple;
	bh=7o0a2ooTOrXhr6IHzg8WgMkQFz+9SrmX8Gzqe2tcSac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=LssLkVtpduoDoaM5KIQrQij87XvZcpDzhI5eFHRUIH/U8sufs2ZRJOehLa2PAOLNbfz8/FycSa03i1fqvJQL06alpkOyzVhqjNQKwJ2bjIKy8vEZhlc40JFmo+lYoFpJ6kp8yWOEawa2dhKOkM53cMVlrXN/6y59lW+G9yzWlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ppwsqxgt; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ppwsqxgt"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260508094517euoutp01d36bbdaf6f62f60bf762b080407e00d5~tjfZi2_Sf1890418904euoutp01G
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 09:45:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260508094517euoutp01d36bbdaf6f62f60bf762b080407e00d5~tjfZi2_Sf1890418904euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778233517;
	bh=gxQW6IaAVHIWOFCSuA1dtUKpx2jMGyN8kHb9f+xDjA8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PpwsqxgtPS4xIJ6UqzgNJm1b+SOz83XG3y61EIlXZ57T5+1O63GTCLsc5K9why5sr
	 sdoqjTELGFZvD2y9Ki6kO2gg0K4m3haPKniTa+zMSuPx3GdOib3IJKM1giG2rpyAjY
	 PfoB3dqPmljqeslV1Q4oNkw7qWXQXn8ARH7tt9AE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260508094516eucas1p1b1e6d7218fc5c399092e59e32cbc7b63~tjfZMcr7v2446824468eucas1p1T;
	Fri,  8 May 2026 09:45:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260508094516eusmtip258e3387552835438b345118010637fb6~tjfYvEdtp2070420704eusmtip2F;
	Fri,  8 May 2026 09:45:16 +0000 (GMT)
Message-ID: <03c06142-12eb-45b7-8d22-ce12fab6e132@samsung.com>
Date: Fri, 8 May 2026 11:45:15 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [BUG] exynos5_i2c_xfer_atomic() can sleep.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-i2c@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, Andi
	Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim
	Akhtar <alim.akhtar@samsung.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260506065110.sY3jKS7G@linutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260508094516eucas1p1b1e6d7218fc5c399092e59e32cbc7b63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260506065541eucas1p2f986355d0a06ac1f72aa00e8d3148ad0
X-EPHeader: CA
X-CMS-RootMailID: 20260506065541eucas1p2f986355d0a06ac1f72aa00e8d3148ad0
References: <CGME20260506065541eucas1p2f986355d0a06ac1f72aa00e8d3148ad0@eucas1p2.samsung.com>
	<20260506065110.sY3jKS7G@linutronix.de>

On 06.05.2026 08:51, Sebastian Andrzej Siewior wrote:
> While looking into the xfer_atomic i2c thingy, I've been looking at the
> exynos5_i2c_xfer_atomic() function and noticed that it has a
> disable_irq() invocation. Given that i2c_algorithm::xfer_atomic is
> called from atomic context (with either preemption or interrupts
> disabled) the might_sleep() in disable_irq() must lead to splat here.

Its me, who added that code, commit 445094c8a9fb1. I've tested that in the reboot/shutdown path and I'm quite sure that I've copied that irq_disable/enable from some other driver. I also cannot locate that might_sleep() in disable_irq(), where exactly it is?


> This looks very light tested because exynos5_i2c_poll_irqs_timeout()
> which should be invoked from atomic context has usleep_range(). This
> will schedule from atomic context is not good. I *think* this gets back
> with enabled interrupts.

Indeed this should be replaced with udelay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

