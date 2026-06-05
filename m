Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8763F7ABE;
	Fri,  5 Jun 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655029; cv=none; b=AaNQuXpOAT4CTP0RHJA+wEaoYmIHZdHlAeJ83jj069F6ihsvDK6x6Lio9zDZKATWfzcIT9lIyhYGdrsFilFOILhBoNl4nHghZBrk/jPHx6zmOwMcHDNz9fjsMvJsGkQWUQvJbQ1tiBES0DUy+hUgn5tSKnJSn7cngA9X40+hNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655029; c=relaxed/simple;
	bh=Yk5RhYWbIMWV3oDQ1MmMBnVw/nT3Lwp3NroxK+zreDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NoxpnQxVo0HhI0CfrEIoVJqRJxoZgBzHRKEo4ISp9pjpae5sDfyN2EaupQCCAW87JeOFGyzo3m+Y25sWF5bHLcEh9XA3Tvs53OnVMh8RQyPrZEiBm3MXtPxa7P5+BTZs52jGtMoGJsEsylENLLPy9qjC+FqEG/sVZkQNz4ttemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=ZqtyA6Kv; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="ZqtyA6Kv"
X-UUID: a088ad1260c811f183c5f7e20ac2d237-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Yk5RhYWbIMWV3oDQ1MmMBnVw/nT3Lwp3NroxK+zreDM=;
	b=ZqtyA6KvsvdN453tNqc7u9Z6/HSoa4NC5fwDdp+GTqZk+uNUtIvnbVv8mMwwBIqpHkzgfTzYFdupBh7263fu0fcmUjUoQ5AK7nBtH9vt49bfcDNM9Yz96agvVot/5nWvjl+dq+zXVPjZLLmVoAqJ5JICZGcfDnWexcifeF5hCIo=;
X-UUID: a088ad1260c811f183c5f7e20ac2d237-20260605
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 157656841; Fri, 05 Jun 2026 18:23:42 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id C72521B315E;
	Fri,  5 Jun 2026 18:23:42 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id A90C7C60082; Fri,  5 Jun 2026 18:23:42 +0800 (CST)
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
Date: Fri,  5 Jun 2026 18:23:31 +0800
Message-Id: <20260605102330.397329-1-SP_ISW1_AT@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <be15f8f5-0826-4851-a5b6-788f3be3007a@kernel.org>
References: <be15f8f5-0826-4851-a5b6-788f3be3007a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi,

Apologies for attaching the confidential messages in these patches.
Since received potential code vulnerabilities from code reviews, may I send next patches for your review? No confidential messages will be added.

Sincerely,
Ben Huang
