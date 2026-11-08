Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158666;
	b=4eGzS1QQi0BDZnMiWzB+YQGo0rhkWJk80AydqGifxgJ1wyfn3bqr95BM3MbnZOUSAve2
	 PyPskA+mr5pT0SgKegq2G5z185Is5aiHWDqBJvSH6dN8Y2n/hdmBlqUzu4HwsdUtNZIIm
	 jFrgNbgSn6pl2bBItjaDFEe+dmYkKFQUVFxudZ+wWFuYiT9hq6WlEJFKCl1LUKryxxH94
	 RkB78cz8l3/+/2EdRRiUJ2axHGwyTFq5748vXz4uCpwZakk1opZE0NxiITeqVQHrjlhx9
	 sCy6KpPl19em9ZZiHav4m/GiOd/AYVMddawNefy8k3Sc1qr1toMVbiB0Hur/WTSl+WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158666;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Uph41UkqGjQUP560n01miDrOMT1K32aU3ytT2ZOEJi8=;
	b=Fy1RI/4GSaxLVP0q7yyWYOln4CbcHGqAj6yPeZPF1j1k9dLS/Day+2SZy711/bMUbyXD
	 tJoVLw1YsesJaQ6zFi5q9euqv5VLps6FYSFwrxPTotZxD7NDA7Gh+i4yPPBdbmZCdLH3z
	 PK8xascl2HfT+oxmeLipWm2bxygiURYHANF7wFlaMO0J8NwhquvtM/D3h4f7HWzVv7O0X
	 bfx7aoReokt0GAsrnSKM1vf9BL5NO52HtxerIfllU1IkknKnsvj+cV+JDoU1SS6ufeNYw
	 JJP6D0k7C2T6cXbdOZ8jT7SAZnVaLN1T4AeyhYXhkTMiqsQSYl2KDoMBDXcOkMLf+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GTQkV0ma;
	arc=none smtp.remote-ip=203.205.221.245
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDA606A322;
	Sun,  8 Nov 2026 17:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FEDA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GTQkV0ma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158647; bh=Uph41UkqGjQUP560n01miDrOMT1K32aU3ytT2ZOEJi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GTQkV0ma1+kymlQV4NILc6hlv5x7VL2Xv9t5qJDEo/46W7cSjWakGHSN4rVzOSLIF
	 w0q4c6Vp1bsm1gyRPWhy1niHaLR3j2E4Hu31R929N2+DesA1Sb568F5uPiIrBPN4Iw
	 nJkzoMtkGdW1sqoNfbrNHr+WufqhQYN80Swf9nXc=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158644tu8hfzrb5
Message-ID: <tencent_11CF2A63EA538A0E205F74A39C4000BB7F09@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJGSzjYY2IEl9ePvvG2kWUhZ183zFD0kw2L6B+33AdEX0FZFFhhf
	 X3TtxeNaAmOnFUZ1En1MvPGRsNdXnnisuPN/Otw0nT7/zMNBS68rl3/5UdvwUvtVwEgkTReOqC4l
	 gwq5PbXRL+7x44ibyOu97tEXzMoFAuuuow1csCiHEU3MYT2i397At9sL4mkmjm14GQGBS5eE09t3
	 Z/agsENXtp/6Tmw5LHg+6tTWinlTkOX67A0Mv0pu5iOo+qLtWlFT6Qwyp2yeiG1TRS6SFHqenxpI
	 Ryl7QWhrdLvmPHEaw08iJ5uIZiQS22+mEotAg72yPuSj9IOWyM8ROL1Ep4h9K4CQk9h1nGd6L/Lk
	 MzF+2VE2Xj1eK4DQYhPGius02uXMXWlsACDsrc27ynrcx6K7BLAgxiqUhVaX2t5FazcbJS4gGaKm
	 OUcUHMORhLxnWtrsHy4Z/C5wTla1Eo+UHMUJNZfyHcKlji/4yYU/LTmTrlt5FZ9PAbOXttWnrMKx
	 D41AjtjuBq1AaYb/am1KpQTukq9+sbXoSTb+L72xfhOxy8j9qRM9KsymVWydslRrd9DilGQYc5bw
	 0JPIXWJ0Amx0tAZ0bHgU2roVjEQaCDr6nhpwc7SeMv6iV/4yGAXL24CMhlz8+beE2j0YPzW3PkCy
	 Dq5ZKOOL5+f+20dRly8Hz71uLTOoQ08V+TeqdFhz+e1xTLgs9rw0X+qZUelO/h5Ymk2QWmUE7zwN
	 OqYr7fh2evEi0yfrpNyFKR8l3d3tO13JaqXwUqtgWks4BpX/MHzpTytI94nZyGfstnaGV5hpy9Tm
	 XVGecZbZGXz3zrD38BWd8ZV8dozKB/yUnPFl6UaIfBLYFhj1O483ErouJaUXvXOC0cYItHgYLU6S
	 N7c9Q4QFEWJapcYDKQ6UmRp9d8N+f9WIy/n+wD3vCF6ybgYl3OIKgNssCi+XxFNThoT5jQxEhNYx
	 e3LaUvTohi7ouzn+2UiyrfPbhRhuhcbBF0yGeoxn6vvGSjXddJPZPjRD4vK2WN2EmvvpSOmc4DJV
	 BzrzoOMqhWHqMpHiw6rvb6sOjt3uygVepJGWZSG1IyrcaOIPClFlujmX6TaFq9FFNvmjdEVw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jiawen Liu <1298662399@qq.com>
To: Andi Shyti <andi.shyti@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-rzv2m: fix runtime PM cleanup
In-Reply-To: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
References: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853265.5.6235275888247384277@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Andi, Geert,

Thanks for the review. The description was too vague.

The probe path calls pm_runtime_get_sync() without checking its result before
initializing the controller. My proposed failure path drops the usage count,
but returns with runtime PM still enabled. I'll review the managed-resource
option and the complete unwind before preparing an update, and explain the
failure path explicitly.

Thanks,
Jiawen

