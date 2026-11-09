Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256746;
	b=PmQetEtMfPSobMxFP5JenfKz9r6c7nuzzQ3d/tIh8JXX7+5pvf7lvaXE6AZAVIjEd90f
	 GbFRmeBm2w0cY18P/I/5v/rYjrbwyZ2h88g9StA9V8F7Xvk//HLLdrqdP9Om7NxND/0ls
	 d6i+hOhs5GZ7MpHQds+CUnEw6AaUtqF2ybTwpF1RfM0L4MwC7JuwwTAqXU7Cpl/wm6JC4
	 uGADYweQVh/FRYgZS2Zk2qBo57UGaJS7YA3XISElrNoPpoNrM0dduRA1tmOdZ7LPKFL6u
	 35F2GIRvs8Nprwpn56mivaM3oE+2aYaIJUqW0nTmyY7DyftCuI1BDW3D/Dd0Ci6gzwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256746;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KXTKxpvQmG4qWI9EEs3gz14VI5DReG+qhWlAxe45/Nc=;
	b=jRBmaQ5uC2EWEeCwP3V11RvfZID02zD7LWEnoIOyahUjyl49qFPjuI6XZuw91kgv3DSo
	 2F8MjWCgRr9CYbWb+yoMpnvj/+ovLzby+Clh/atiPRB1F9hQgRzCrjwt2B6DNZ1F/s3HR
	 rP8TZgUZ2e3Oq877eeWxppzZpUnvQhXcZKfwZaSwFNOX+oxgwyKhf98YqtQQuZ6qTTV6Q
	 9Zs2UMCzxecA4zQnd7GCWNs2VyoppkyJUv+QNWokSJsTitVdim/0H0fnca15hJN7L/JoQ
	 9C1YdXVqQj/bIfdgH6sXsmi25VQKt2tZNSZK+3bEn3L5e6CrNaJwR/81QgOh9VC5Tww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=iv63CrR+;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84737606A31C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 20:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84737606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=iv63CrR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KXTK
	xpvQmG4qWI9EEs3gz14VI5DReG+qhWlAxe45/Nc=; b=iv63CrR+NkxkquUtgPAq
	xEKCX7A9CKbbZWNdTu2lcZahuFZDtMGnqQQ74Y5qcP5fyoa0paj0o/gfo0jeMsZ6
	PUhWd1+03dTf4bDg/7g13tuVG0PJyP69YOLSYVc6vscb0Esftjgpico9K2F0e2xU
	gvPI1j2AzUtP8sFgOGxN5+wrZK9aRo7OODlLLtmbTavBpp4cc+f3ayz56AjDrTM7
	aIr0jOIJewj/VJVAAKUhDiEPrqOdvMOCfJ5VhEGGkSH+TSBpt13R0IfL+HDHvTnx
	8+eFb37xTHxQT6+/hxTCIVsdO15/jY1Sm9fqCbGQtGVpZU1gjvbCe1rBSfuvlv6E
	QQ==
Received: (qmail 3406806 invoked from network); 9 Nov 2026 21:38:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Nov 2026 21:38:58 +0100
X-UD-Smtp-Session: l3s3148p1@1JSC891fWJ0ujntg
Date: Mon, 9 Nov 2026 21:38:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-ID: <avIvYMDqQtyBVIWI@ninjato>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
 <avFwLctRcnJHtINQ@ninjato>
 <avFzEaxgam-UuZH0@ninjato>
 <20261109100606.493ca48095bcc3527be18573@mobileye.com>
 <avICFAh07d7XrAIY@shikoro>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avICFAh07d7XrAIY@shikoro>


> Having a leak less and cleaner code? Yes, I am sold :)

Can you please resend an updated patch? The code change is easy for a
rebase but the commit message needs to be rewritten completely which
calls for a new version of the patch, I'd think.

