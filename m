Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721803FF889
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588679; cv=none; b=FPpeciErbQbBetaL/dEwuNLgKAHxNzeLWeZy45R7UjkaPaODKfiNFoKqp/GLGOXmbBjfl+6PLyh9cvdRPPKS/kdH8muCSeVEASrf39V7kegdiHW9YWq/gP1EEFeqAbzayiiKAS3fTGKu+VpBS0q2jU6b039tF4Km7F1iluQV9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588679; c=relaxed/simple;
	bh=AsqWHUD3fknq6kvMOwmLLRy83GwDAJJfDfHuuECn8nM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnG8agS8Sz0pqIzv372K0LP46s2UV9K3uGtFx2Q5zevQ9VG6Z1uhsrsPn0TckFF9N9UntRbK0RwVXix4SAZnGEGnMa91ZR4A9mgxvwyOqZOrC3CPPGemLPs4tQO48qI/MhZRwuNmqgZxOxT2/mOmYK5ARMHMjqQ4KYk/ybxbDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NOdoSogq; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NOdoSogq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783588669; x=1783847869;
	bh=AsqWHUD3fknq6kvMOwmLLRy83GwDAJJfDfHuuECn8nM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NOdoSogqN9Ttm5QfIS+N4RKsilr9voDeQP0u6TF7B6VrOVbUItIv3Teyj/xgNfWwS
	 5vL1lVjWDKQc9maV0a0BNWi86CbbRoH6dUujnykoI4hl3Q1UiiSciKITJwMWKGrwWL
	 HcBCdbAV9AqVapiduJ+dx1KZVrpZcadK2vo5NAuf9Dfp4t7mrjALM880PnPMFkVqxs
	 yD4dSpQNlFXwXJee2Ed4I3ym0CfcqUzcYMYKcoZyh1VYqxHf/NS+9iGfH3nBwqetIQ
	 Ak6hTkFb5E7bS/rRCAKYIiG0nlCmmy6zjPUvbFtrsmJIohVVamvFEKp0LjXbCuly0/
	 P3CwOWp9c+LYg==
Date: Thu, 09 Jul 2026 09:17:43 +0000
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, rva333@protonmail.com
Subject: Re: [PATCH] i2c: mediatek: fix WRRD for SoCs without auto_restart option
Message-ID: <G11ljKsJ1-XZySyKn1d9mfw2Wwr4ip3RpX5HfqIPp0602tRxHV-1SG2L0VCEJHfEQ3WDlJ41vjMgd6Dy2ktSTa-QIWuE7RGkkGpVIYwtd0M=@protonmail.com>
In-Reply-To: <20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com>
References: <20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 12ce95e755351267cc6fbf3031b57ccc2bbe842d
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Just sending a gentle ping on this patch. It fixes broken I2C
functionality for mt65xx platforms.

Please let me know if you have any feedback.

Best regards,
Roman
