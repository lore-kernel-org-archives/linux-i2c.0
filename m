Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5510A1E
	for <linux-i2c@vger.kernel.org>; Tue, 16 Jan 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Tq6wSFYI"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3DE332C025A;
	Tue, 16 Jan 2024 14:38:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1705369088;
	bh=7GHoTeKYfcgBq8P3j8Vvbrp1wPpvsnpu+kMyaTJguIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tq6wSFYIopua0N3Gp1vu596Uv3TSL4yIC5Z0P39tEoiYmhZaCBn/3vk4wJZTjm0nC
	 1TwHNIaRSWBI/o2hn12zIr4r9vm9rxZumhgrLm2A0/vfvsM1ZVxcUzj55fPFEbXeba
	 ylLta7TYaPrN56MRUyg+0U4A8xvavP4eb9Gof7b7m7fPd6oPwrEvU7JygKy6jJYtcd
	 JNMeC5QyOsk7DJ9P2L9UYoNcn2PKF1qH3W+Ztw9kt+eBuveWohvYNVr2vpcNhnyEhh
	 OzqSraYxkfrAjL0uT9TVd2WRjfzBXWhfJh4gkFAoEHv9bxC+Aike/4DjXUgjJ2AL1n
	 TLdo247mBsemg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65a5de000000>; Tue, 16 Jan 2024 14:38:08 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.26])
	by pat.atlnz.lc (Postfix) with ESMTP id 19EDE13ED7B;
	Tue, 16 Jan 2024 14:38:08 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 13FBF200482; Tue, 16 Jan 2024 14:38:08 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: aryan.srivastava@alliedtelesis.co.nz
Cc: andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: octeon: Add block-mode r/w
Date: Tue, 16 Jan 2024 14:38:08 +1300
Message-ID: <20240116013808.440485-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912011633.2401616-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20230912011633.2401616-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dEuoMetlWLkA:10 a=XRUlxUASmzIDtQXyq5EA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Andi,

Did you have any more comments on my patch?

Thank you,
Aryan.
