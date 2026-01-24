Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C493EBF21;
	Sat, 24 Jan 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769232778; cv=none; b=hUVhwUR7AS7Hzn4qyylj65gODPkNLwICwqGq7ZUdPshT5DxuuVOTezSjSaWd8h0OLdQdKxk0g2FW+570org29WTpw1wjpmFmgBcBPRAjJehttvsmmYS8nr5jlHZdG8GMCGsm/nUJLJ1Y/WotsglO+2P8M5mNGlvPu4I6I/etmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769232778; c=relaxed/simple;
	bh=UCLgtgZ54n5NC1eGMdczx4XogBpfLFQ7S9rkRDHMlYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tM2PM1wOdZ2Tn+FjRB9FGIDew4Cl/XoxuHScggX5jJe27KQw3leKvQGJXQdYvYLsqEsw6lSJkan0NkYToHhbPLrdvLcOA0QHM3/IOtLVrqlWGYMd9uuB9KNTd6ZdhyHrZVoecog0PfJ1oIwj6stHh8ozJKMUYpa8O/s83CnNcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Vhl9gpbC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Vhl9gpbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769232766;
	bh=UCLgtgZ54n5NC1eGMdczx4XogBpfLFQ7S9rkRDHMlYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vhl9gpbC9sgtOr6CkkzlY4P4aIMHuYpU9yKfM1NHyKDqBI7jKYtNKeuiOR/Qd+mc4
	 DsxSqkt1Bfcqbi98HuhBccZU+XjWy03FADqTRJzbrwxXtRyDB/hXVCaKIEFmDHRjoA
	 tu+0vOfVG3AWTGhcnDoeyWU7W7+tHio0djAov+0L5qCopEV9LDQTjuw9X96KEBS7yU
	 hgfsdkIPTBYfynl6HSorot3hJI1kGprLYNn3NCgceZSTQ/Jna9kTO484pbF8VNMSSm
	 4eWpsm5rIcmvgQNqiBMe8artT6mgGIZWnrAvgFxcSAlxOlTtnPiKangP9ycfRQTTmf
	 iYYy/cXc167BQ==
Received: from [10.2.99.28] (115-64-72-106.static.tpgi.com.au [115.64.72.106])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D3F00789DC;
	Sat, 24 Jan 2026 13:32:44 +0800 (AWST)
Message-ID: <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang
	 <wsa+renesas@sang-engineering.com>
Cc: Matt Johnston <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 16:32:42 +1100
In-Reply-To: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Heikki,

Thanks for submitting these. Supporting SMBus ARP for MCTP has been on
my wishlist for a while, so it's great to have a solid proposal here.

I'm curious about why you're proposing a kernel approach though; the
actual ARP protocol implementation would likely be implementable in
userspace. I think the only kernel facility we would need is a
notification facility for the possible presence of ARP-able devices (ie,
through a Notify ARP Master, or another mechanism described by 5.6.3.9).
I *think* we have existing interfaces for the rest of the ARP process.

It's entirely possible I've missed something there; perhaps it's neater
with the match tables and address allocation being all in-kernel. I'm
keen to hear a bit of the rationale for the in-kernel implementation
overall.

Cheers,


Jeremy
