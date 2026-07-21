Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1B1E47C5;
	Tue, 21 Jul 2026 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620885; cv=none; b=UnewJyJ3OzYupQQR0wPxULFwE2yNPBOcgn3rm11AUyHnLmE/oOTmruYZN4L1cGW6KF4zeguDDB5J2a3QLE7VGnnkvSLF110aevXtGSwg0JzApIRwGPV/DG6qfK8/7pMRCbIdZRBPZNu+jPxkZaL467nfeF9cCahXyipd7gSuZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620885; c=relaxed/simple;
	bh=5SM9NsOwtuQW0KSV6fPdrF5SSQb+vnwKSLSkMeWaGa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRs22HCLoDaKx0Khmf6S656VG0R7PNlVVNmVOAk++50n82v11iC5Mlj4y8kLAeRU62XAGk+3GV1JGvkHKEzUwivOdPz1YZ8P6F6ZCTcFrIFhUiKtwrW9H/JjiW85EKFK1SXr5iFoks1pCgZX80nQS4fvPI1NsU2XuoPCB+JUcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=mSr2frTm; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="mSr2frTm"
X-UUID: 57e1d77484da11f181a149c3f3c08161-20260721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=5SM9NsOwtuQW0KSV6fPdrF5SSQb+vnwKSLSkMeWaGa8=;
	b=mSr2frTmpn9+fTat5gFbpOw0KSRwVCbQU43PvLC+7gP1mFoS71ge/WbMt12602O7dy6XkZZFvyjuVODjK4YHg0BKkUM3rN/d9iV+JZ3T0mOrTQA51ONbSvEduK9qJJ09b7UPhHPfjNPLjm5gW+It2AKNFHbGDlb7UWTEdh52miE=;
X-UUID: 57e1d77484da11f181a149c3f3c08161-20260721
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 371194608; Tue, 21 Jul 2026 16:01:13 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id B9F761A1E1C;
	Tue, 21 Jul 2026 16:01:13 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 9D626C600CC; Tue, 21 Jul 2026 16:01:12 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
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
Date: Tue, 21 Jul 2026 16:00:43 +0800
Message-Id: <20260721080042.472564-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <65492810-a5ae-4686-b7e9-2cd43afd47df@kernel.org>
References: <65492810-a5ae-4686-b7e9-2cd43afd47df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi,

Thanks for your reviewing.

Sorry about the same mistake. This is the first time for
submitting kernel patches.
To fix this problem, shall I put all modifications into 1 patch
file? Please correct me if I'm wrong.

In the patch series, MAINTAINERS is in the first patch (1/3),
related .yaml (2/3) and .c (3/3) files are in the subsequent
patches.
If only MAINTAINTERS patch is applied, neither .yaml nor .c can
be found under kernel source codes. I think this is the question
you mentioned. Please correct me if I'm wrong.

Sincerely,
Ben Huang
