Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4F3ACA79;
	Wed, 22 Jul 2026 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701952; cv=none; b=g97W3ngJWc30Wchzszd1s2TAu/98D8cOTj2nNud9mPw2xiZwQcYkWCTQp8M6EuI+p4Z48TVG//5U/tHTH1BYmhif3LogGG/ikq3UOiYMZ+mGCmng9bGR/xAp0ef/pmObdeVqJd8gU2H33q/d/zNExh/jwOf2pdk8kc2zPM7cDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701952; c=relaxed/simple;
	bh=goAb6jmqkn4rbQbDd3avqu2XFE5QLB8KZyPuggkz4kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxeqCODwYJ5sdpf96eFWAJ/0TeJHdu1q/YgGhX+ZSiVQvbG++kTiWtBz2STOH8THaUvaPQJYSnnCpwoZ+98xgcvNdf+ulrlwvAZQT62oY9cr2SsobKwJ/bIbzrPXa4lEcCOmpbVblz7O5N1qDeBlaULzUOGX8y+ZqbF9Xj+tB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=UFGnqjPs; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="UFGnqjPs"
X-UUID: 1a83869e859711f1b694ffd7d3467620-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=goAb6jmqkn4rbQbDd3avqu2XFE5QLB8KZyPuggkz4kc=;
	b=UFGnqjPsVXMvPiR22qfgpw2KiEinBpcm3acyN1C6Nj68X7c0lM57BPLBtnJlErjK/q7JTkApWJlNmqo5XltU2ofdvCbR4J0X0hUlqyHQVbcwlP7NFMuFwSG5htUHxH3/aW3BNouHOkoLVfPv5SsStb7HupXEUBrtH//5vhLWmJA=;
X-UUID: 1a83869e859711f1b694ffd7d3467620-20260722
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1015380996; Wed, 22 Jul 2026 14:32:25 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id A3C161A1E1C;
	Wed, 22 Jul 2026 14:32:25 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id EA7ABC600CC; Wed, 22 Jul 2026 14:32:24 +0800 (CST)
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
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c: Add Novatek NT726xx SoC I2C controller
Date: Wed, 22 Jul 2026 14:29:34 +0800
Message-Id: <20260722062932.543004-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <7c6d1cef-1337-4645-b3cf-94085997cb4d@kernel.org>
References: <7c6d1cef-1337-4645-b3cf-94085997cb4d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Wed, July 22, 2026 at 2:12 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> No. Read the comment again.
>
> Please follow writing bindings document. What does it say about wild cards?

Understood.
Compatible strings will be re-defined without any wildcards or device-family names.

Thank you!

Sincerely,
Ben Huang
