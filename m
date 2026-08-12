Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7134379C5E;
	Wed, 12 Aug 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563871; cv=none; b=qTY19GhmS/U41XTQbGfcK7fCnw7fi2linMa50s9Lnj9yRZcSgKvjPDjBRuJrLbM4exXsUs7mDd5fvYZOnM9XPoBDo6nvdpdzGSJMqHX0MqRDSD37VGE7dFiWLhVD0kJf1BfHqzJ2IhM2taVd6UQUsMa9O+oZd9lvR4Huv8xBxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563871; c=relaxed/simple;
	bh=Gh9v9arV+AA5L9lbrpbqXH67R8Y8ZcLwr29YLXWFfVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjQQhfqBj9alfpifu4uQbl8CHJEC3X/sJTSi4M9Mw4PHRb9Y+jxu5d3gTYULbkBdeY2m0ZN74K8S/slG0fZ3XAFCuqFhspBsfPqaqzHLYhxDYsBvzE2MKvi6zr2IKVVyQvhCHdjD1g0dcFUp2G3YwqrSQh4lM+ft4F0H8F922nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Qmp7I944; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Qmp7I944"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id A0DF04CF77;
	Wed, 12 Aug 2026 21:37:15 +0200 (CEST)
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:f846:40e6:d9d0:ef5a])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 17475780368;
	Wed, 12 Aug 2026 21:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1786563428;
	bh=Gh9v9arV+AA5L9lbrpbqXH67R8Y8ZcLwr29YLXWFfVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qmp7I944J+iQHWP4pbdlxSrc0gSEXFqR9BlLSTuthMW8y6UUa4NoXTjqWaC9fiD0R
	 t3Z2nQiHuL3pkUrKvpVHp9iX2n4Ka2riv+KN00edPBUneNQesRBTDtLA6X8jX8FcFO
	 cHTxImLGeZHtIAYcfIdZf/0hvucldnI0EZQlpRGZsTBi+wW+IEAEIrnPrkLiZQsMpj
	 iKxV6y1jesTqRSGDWaRM8lXHe7uIHEZi9CK8Sx8wVfG1LGlBuKmK51zSebzdDfTunO
	 7xM5CL2rkGpt8e4qVMDT+0RKJ0WzG/5zAJi/Bo3IDVb4Fok/nwujm0Kkl1gXVrXmdD
	 bRjviZ4/zz9Tw==
Date: Wed, 12 Aug 2026 21:36:55 +0200
From: Vincent Jardin <vjardin@free.fr>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <anzLV--D6z-QB_iF@L30177.local>
References: <20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr>
 <AM0PR04MB6802658862C4E2ED8628FFA8E8DD2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <anwI6qnsikPrd80W@L30177.local>
 <AM0PR04MB680259939B7ED9AF5BA5957BE8DC2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB680259939B7ED9AF5BA5957BE8DC2@AM0PR04MB6802.eurprd04.prod.outlook.com>

Hi Carlos,

> Do I understand right?

Yes

> Only change the r/w bit, other data flow keep write logic.

Yes

> About code, Could this part of the code be improved?

Yes, done into v2 per your suggestion. I did squeeze a bit the comments.

See, https://lore.kernel.org/r/20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr

If you are fine with it, your/NXP Reviewed by or Ack would be very welcomed ;)

best regards,
  Vincent
