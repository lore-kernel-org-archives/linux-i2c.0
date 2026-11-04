Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787623;
	b=EmPTa98MNNegbrhaCv1K0cgmh5NtTPNzaxHZpxcNac/hJ7TGvdQ0gzBww3OFo5e9qudG
	 EvKNUSwrOjwij37ugO4tUCJNj5cwx48bOwqXeZ6SXbaWnBPtHGnlSwRfvg/CHEYIMSZwO
	 Bz46INfqvZyZ2+SI71sOugnNlVtyLYXg9MTkpyZbn6g80SsR4UPCz2VwQ24+qBY4CmLd8
	 9T881pJ6/Vhj4/XMgBQ6/g0k6Sqz0zKaZOtl1V5cSbaWLFrm+BCR1wUMBXLCghOaac0iR
	 eb+9O1wlVpGeGe9d6R+nQC5FNYhVN29E71tw5hKOMSuma/Bq7xUFn2onMH0lXu50zDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787623;
	h=DMARC-Filter:DKIM-Signature:Feedback-ID:X-Pm-Original-To:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HQjd+1H8WpsONY0rXjJFwfRM3FYkWY+gH+b8NQqgQWk=;
	b=IvTkv0Cy5OzWQqCWVIr7PHvU4tsldoVSwMkiIxvQmXzkhug2QB1leD9NQDXV9br7SufL
	 cWJvVAO5sY4c5AtRJjZKpEC/xphlam4/5R0Bluo+8eO48lgS68t97kUnyUh0jNB08LQIS
	 A1h7E7rWiyhBIZfzfLByvAbTxnCGxOL5YKsBs9/efdO2/0Fi/rUq/bjSidYobOS5jfnvz
	 CBQPG4dt8ucuYDZDXy/dRguAfFrB34LlDj5qNX6qVv7W3OZpU/UZMzx9p9gNR5DTnOx7A
	 3A0kGvCkcyqRCUnI7axpa737FkHowZ8U3OprjUO11HzSxSSnDfepvB4keIukuORw1FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=korsgaard.com;
	spf=pass smtp.mailfrom=korsgaard.com;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=Q8S3ccGU;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44BD606A31B
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44BD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=Q8S3ccGU
DKIM-Signature: a=rsa-sha256; b=Q8S3ccGUZF3jjo+d3PH7vqx2W45KJX9Ined5TkYxw+Dd+zNxeqaA669U1n9m9qeKzHfRxVq4u6r58YlUIxjshmt9NUs0vCS2uprB1Y6Wc+I03mxcxbdUWN6hoQ2Viz4pgXdmgJ73sqVibByLIGYvQnve357LFNumIyoVZ1jzyxCY+cJFq+ogmG9YfGmz2JpE5kuCfVjQnDImaWlx/HasXQCKjGG6C2Pv9Odj86EA9U4QBwdOcwZz7TNBAd/IpCczQEq4s10BlwEqecFRVvUOBdcIFeWDPB2x2LEcNl7PgQP77UKLlxLj4pPUuq2OIJckxowg54VsK0s6dObWg4n2oQ==; s=purelymail2; d=purelymail.com; v=1; bh=1LTjVjxkniOdPSf3cAHKoq7Q/H/LQdaxRAFw2a07OTo=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-i2c@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -906447370;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 04 Nov 2026 10:20:11 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1xOY6D-000000006dc-0vNF;
	Wed, 04 Nov 2026 11:20:09 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,  Andi Shyti <andi.shyti@kernel.org>,
  linux-i2c@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: ocores: delete adapter before disabling controller
In-Reply-To: <20261102080327.1466598-1-matthias.goergens@gmail.com> (Matthias
	Goergens's message of "Mon, 2 Nov 2026 16:03:27 +0800")
References: <20261102080327.1466598-1-matthias.goergens@gmail.com>
Date: Wed, 04 Nov 2026 11:20:09 +0100
Message-ID: <87pkwkkiee.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Matthias" == Matthias Goergens <matthias.goergens@gmail.com> writes:

 > ocores_i2c_remove() clears the core's enable bits before it calls
 > i2c_del_adapter().  Deleting the adapter removes its client devices,
 > and some client drivers talk to their device while being removed:
 > lm75_remove(), for example, tries to write the sensor's original
 > configuration back.  With the core disabled, such a transfer cannot
 > work; in interrupt mode it times out after a second and the write is
 > lost.

 > Delete the adapter first, then disable the core.

 > Sashiko, the AI review bot, pointed this out while reviewing an
 > unrelated ocores patch.

 > Link: https://lore.kernel.org/all/20260813153155.3953577-1-ruoyuw560@gmail.com/
 > Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@gmail.com
 > Fixes: 18f98b1e3147 ("[PATCH] i2c: New bus driver for the OpenCores I2C controller")
 > Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
