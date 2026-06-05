Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585124C77C5;
	Fri,  5 Jun 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655985; cv=none; b=Qquio4sUkrPc7M7nk0ydAfsZ9zSmzJ/MkR3ZLQdzVuytkw1NrE9V/MjtX9U/vtRXScahFexgTl672oWWJ05/wTOKC8k9eBS0sP45c+VVEPPQu9vRuWOqghD0vaBlU5N1C5HIkt7YXjGeySNHYxWjpzeDgyAFhtRFPEkdL32t7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655985; c=relaxed/simple;
	bh=dgdJlH6Ak9FiMF6QdlLGxYCo+6OzqYVCUHbdFuYq5LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jl2TFvNkH67vytXPFf91h3Zq0IP/fodGNA4e8DzgPy/rqBrFWqmg4qYpQJqLpBlJ7t62+petNMHP84wjyC70r7P5JDpf59GiQccalfzdVYEPDptmQ9fRU1lTXxe1JYn4xhX76o4JIWMv9FbFuueErfBKhHjSfDhNcsMOoUh8jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=zN0I83DD; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="zN0I83DD"
X-UUID: db633d2e60ca11f183c5f7e20ac2d237-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=dgdJlH6Ak9FiMF6QdlLGxYCo+6OzqYVCUHbdFuYq5LE=;
	b=zN0I83DDSbliAeL7g68740KEfchKiCxvBzJtD8RnvtR33tsc8/ALgQNdG3weo9tNjTRDgLEIW7BykIOIgGt+md45g12ghYChRF3cFvQDZqRqCb3BLUMFX273O5QLrAl+k+SSpUs8KPYc8OhzdLwyAdiSL1tz44RXNL7r9dpeVjM=;
X-UUID: db633d2e60ca11f183c5f7e20ac2d237-20260605
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1874209996; Fri, 05 Jun 2026 18:39:40 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 8DC4F1B315E;
	Fri,  5 Jun 2026 18:39:40 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 5E22AC60082; Fri,  5 Jun 2026 18:39:40 +0800 (CST)
From: SP_ISW1_AT@novatek.com.tw
To: krzk@kernel.org
Cc: Ben_Huang@novatek.com.tw,
	SP_ISW1_AT@novatek.com.tw,
	Shihpei_Hsu@novatek.com.tw,
	Toby_Chui@novatek.com.tw,
	andi.shyti@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC i2c driver.
Date: Fri,  5 Jun 2026 18:39:35 +0800
Message-Id: <20260605103935.397609-1-SP_ISW1_AT@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <41d72453-10cf-4ccd-87da-575b04532f08@kernel.org>
References: <41d72453-10cf-4ccd-87da-575b04532f08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Thanks for your kind suggestion.
Fixing the vulnerabilities is in progress. v2 patches will be sent later.

Sincerely,
Ben Huang
