Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823094;
	b=kzINhVeM7lsRDl0UlmJiZCez5Hlb3xTpOM+1VpUQ5OCzWDgOUTnMMEIt30A2oedlHzii
	 J0QhRQSJ2AZEiZ5LOLz8ThzeKwd9yUKQpve7FHmFCQrJ/m5rUlgFg5Jcy/BVhTrpualPd
	 MxxAF/ms2fsWPOd3kQrPl+k09oLPtzgBabPWd+d6OxeXFe7eD4NObVUOAIV2hVqsk4SET
	 jEGELZhM5ho+N4qJs2a8zWJvQJpzhUtCcS2aCveV9m5LgW09XqHfj5pyNwgcRI188BV8q
	 i6QcH2Vtf1YZcp6dzdoEzrzOpBfqOXVObLQJDTQGh9zR+/Ah7yK7lEpi5Fr+4zA6wKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823094;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=uhSDJq8Wyhd+N3+fjmtrEANcukfKqwNL8O8VlAwpkNQ=;
	b=1sVTm2GJio8yhovCN7kY9z0sDLhyzlXsUS5fKZOK0H/W1weQ0xaX2CKanQjKfcClKnKQ
	 7tbfY5NYBsemfNj/MOLuIkOn4dDrx6Oflw4K5GRIzRF1aTqazR6s8Vvq5t5l7u4GeAwTK
	 8fs731TNUGXEoBk5nG/cWZLc02KXc/G/4ontZP9KFs3/aCcTVX6eGjHz/yvnvNc2jElFg
	 +5QLW4nz13bCBcdOPd9kISk6ZIp6DcsxC8ZetyDaY/ZyejFSFcqpm3vFC1QhC3f6cOAGT
	 IZk4vRDrrWrA0/i62c9tdLUbCkJNCsEBz6eR7DnfFqpLYQPv5WbG4lLhxSuuFPYYqRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Nfj9yFHs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7E606A31C;
	Mon, 16 Nov 2026 09:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Nfj9yFHs
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D7F6820067C;
	Mon, 16 Nov 2026 10:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794823091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhSDJq8Wyhd+N3+fjmtrEANcukfKqwNL8O8VlAwpkNQ=;
	b=Nfj9yFHsKUQv4cHudGDJEL+q3z8JZRRr9ANqmBM7EW/79T7CxGm8Drh0XCJJI/wa1hmohw
	T3+rSTCXWTF8YvPo2yLIDRo5/TqDZ4N0KFPGXhb/bv3xIhw+I450FTf8xCgCI4bEL9H5sO
	WmPZGGbYyUp/K+lolD4ZY9YgeQfBTYDjCYvDyF/jbF769GjzwT0mXVglmup/olPnDvqeGd
	QygsLgOKBdgyo3IgmUUiXvLj3js2zj1kcM4QS/pCTSFhlGBMFpuMHTHrbp+u13s0/eoN6P
	PrxF2za+Xv791qmU2cHnlLUz8rTUfcw2s6jW0uKEvshgIKyAcBZBh6Z06VrXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794823091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhSDJq8Wyhd+N3+fjmtrEANcukfKqwNL8O8VlAwpkNQ=;
	b=QozebcUAt/4IMf/YCQjsdk73VG3/GsHIei8rxaKdBJbS5aXwv3vuF9xisKEIqD0pIX7eEb
	NuinsMemnUuEL3xZQg6ujIIhHRLeJvrw8P24UNnGEAqk5ogdhvfzGiu0V6bcLN1Z9FD2BG
	bw0fbTkzYJ5rqsIW6rySLYk8albeiTgry8Pcw+LXH5mXNOGJNDJwmDiKRpR8IlKuv2PJ+i
	vt5Hf/gaGioWpDAUNKMe7pG64YrVyJEuN3a808o41wjNot/G+uSQV5tDfavEvaRPhRAM2F
	ijq20Q8vmFg+iX4t2OC4geVbf7Eo6KyJmYg7ue1iKgNCSxvmRo39z1aOGS4Uqg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794823091; a=rsa-sha256;
	cv=none;
	b=fIC3DWTY5n+ooj0zrJfsLtukqPmNMEUK+BVrmHdsPJlrOPWL0TZzUH14N6iawtAiw8+IhP
	3Oo7/nSvu+rDv8CC4ui3xYAxuIoxOU7+YCf/I49smR4mR1y8dXwNmw6JACMVx/gqJ4sOYg
	X27YskizZJANXVpMuXiKePA3ghDRzhdfGe/lmj8Xughb+eGVybR6eDtygiLdCL8OOzhO2k
	DGfEvX9+B2oR0/EoTp9vxpTsgby0rPXOOzTL97CGVjEPS8foZwMyQzcF6hfefX7xhkA9lj
	nt2+Bkdvwbp8Ckrd14Oa14LsvaVcMmYy0t5mUbW2jV7SBq8lVlqOxFOtZhkrKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <5ea675380093047ea19951a31005e3c1e5ca0e04.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] i2c: mt7621: assert and deassert the reset line
From: Philipp Zabel <p.zabel@pengutronix.de>
To: John Crispin <john@phrozen.org>, Stefan Roese <sr@denx.de>, Andi Shyti	
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, devicetree@vger.kernel.org, 
	lei.dong@airoha.com, Linqi.zhang@airoha.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Rajeev.kumar@airoha.com, upstream@airoha.com, Weifeng.xu@airoha.com, 
	zhengping.zhang@airoha.com
Date: Mon, 16 Nov 2026 10:58:11 +0100
In-Reply-To: <20261112185820.1315718-2-john@phrozen.org>
References: <20261112185820.1315718-1-john@phrozen.org>
	 <20261112185820.1315718-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Do, 2026-11-12 at 19:58 +0100, John Crispin wrote:
> The driver resets the controller with device_reset(), which needs a
> .reset operation in the reset controller. The EN7581 reset controller
> implements assert and deassert only, so there every call fails, logs
> "I2C reset failed!" and leaves the controller as it is, also after a
> transfer timeout.
>=20
> Get the optional reset line at probe and assert and deassert it. The
> MT7621 and MT7628 reset controller does the same in its .reset
> operation, with no delay in between, so nothing changes there. A board
> without a reset line no longer logs an error, and a reset controller
> that is not ready yet defers the probe.
>=20
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: John Crispin <john@phrozen.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
