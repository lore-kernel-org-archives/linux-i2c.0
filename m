Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643C246774;
	Tue, 28 Jul 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252687; cv=none; b=hk8Vx6bj3qsbvO/wuTqbOLz+ESo4X94zC6J6E0cEQ4f2ZN/80Fq31HnMhsdDZprPUlMcj4384J9QKHP77DZ+5jfthasMjUsli3giJa8ZuQWxkpnx5kgCe8NypVYjRJ/N6tPaWUaav+bwL916XSke/DtlfqgUwYObhvEq8JkE8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252687; c=relaxed/simple;
	bh=CHNvCkmfd8EdNX1pjJTwgGPABpKlUokYb4jnuzUYOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLbIpA5ONAxEnLumtpJ9xWRR3L0CdRGRWKTZETC13/OAxCOJGf9HCEvcVqxSwSWRGALt6XB2/+SCBcDwouutOKhXnPRW7wnDBQrRg+0+laIgEl7Ybhp58iQS9KhmnUia7pgcaXrxxeFCw+cTYZ5uN/aXrW9eScBtUVEIStkHlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLsjD2Tl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLsjD2Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AAB1F000E9;
	Tue, 28 Jul 2026 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252686;
	bh=qe/VHo0JpOcsH0dSANJYDgEFC/+HxxxcdtUQi76Gx1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OLsjD2TlWP71fvKmSoATb2P+cUoB5VaaRUx18FrT+NJy7edgGKU5PI7+SB46bl1bc
	 BV27cTs1gwn73vujMlFTNp5U/7KUFGs+jzGuB0iW+6irht1rY7TK/77FxpcIGrRsxv
	 4c3CllsUWf9GUmvi0I5b2R9Y5Xldsz/ZyH9UN1kxpwqQswCmrlr+CLZuJkckv/moX2
	 ZeZF8wJ3MImVy/vLpo/Sq5ctYU8QYubnyBC0sJG0a2aJG9bpDEvpOfFlgRjxqH7jZa
	 aj4tAI9W4xs78tjFclcWxC08+4aANSHkvFUHEqdhBkRocKf0Wt6LUeVIcSXAo9gGvr
	 5r6dJ1TbvFyHQ==
Date: Tue, 28 Jul 2026 17:31:21 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: carlos.song@oss.nxp.com
Cc: Markus.Elfring@web.de, aisheng.dong@nxp.com, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v6 0/2] i2c: imx-lpi2c: fix probe error handling and
 reset controller
Message-ID: <amjLJuBPDA7TQqpR@zenone.zhora.eu>
References: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716071957.2670263-1-carlos.song@oss.nxp.com>

Hi Carlos,

> Carlos Song (2):
>   i2c: imx-lpi2c: properly unwind resources on probe failure
>   i2c: imx-lpi2c: reset controller in probe stage

merged to i2c/i2c-2.

Thanks,
Andi
