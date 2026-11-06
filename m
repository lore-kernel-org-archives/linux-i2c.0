Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997246;
	b=3uFAuJrCKBfJX78tJHc8ovfubwzpXaRl+NYLMKvaX9eFDKvOFKLzBsijDntXigGfj+kT
	 tYAuSrt/HowwwLK1ZHDrAuX3i/Cmf+2w5+9JzSY5qHcNN1eLps9bFJvUKqEqddl6IcHyK
	 ibuFAtDoYGQI1ZJXIVSO1aAP28jxcqqflnS1mm3CadbVvw7YO7hvYtCWcmqpfRpl5u7U1
	 CxZQYleAf803pwTYCNlE3masFvDJ3vNn/01rVEpB8KQdCayq89cDm8Zhj9xrFDjlVdODY
	 kVOarjUzZnyHR0BzSNUxj76GKMjlJW1+UhPFi3CTx3EOAie1m26zicwr8JVoph95RCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lf4/8nx82WCQx07flCrOKeUURdG0c0aNEb7IfhxSuaM=;
	b=SKJRPbL4tYm/oCx+SKC2c8XeTiPYpUhsRdkGVZOZkap4iKjQPrha1Bv/LH1kdtfuJU4T
	 X9WM7/WnCHNPGelNDU/pHUfmfyqMDSijzT6Uu0xmq6Yt0x6YgLXChjHhTNmZr/vRyNvtx
	 qDM6q2thHrtXNtuvVe8dSO5lVeysYEH+xxBXbt9xEqdQ89t7h3wIZV73v8U8g7fIo7ijP
	 ptveI7fUreS7UEOHHvkDGe9uW5jXdKnKHmKXcvUvu9ZrDLWnYooSIr8Qu8GQfDBXbxHxK
	 npN8+rBcaWS8jAg9zr1WDVCqeMHAlKg9QKLkWo9C3vniTFleHtKy6DKMW+EsMOyx/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kLLmz3LU;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37C606A326;
	Fri,  6 Nov 2026 20:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F37C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kLLmz3LU
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jLrVv3760zlfvps;
	Fri,  6 Nov 2026 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793997237; x=1796589238; bh=Lf4/8nx82WCQx07flCrOKeUURdG0c0aNEb7
	IfhxSuaM=; b=kLLmz3LUQjzFeK6nTVh1TmkfH48cTZX6q4j5FiMpDltyQ5p6FWx
	mn/pRbIx0UqNGSpm7iGwKoPMHEbGNq77locmu15aE5cPALuY6mVn/vqsUcmscEAK
	O9dVGrDKnHwTpR+1bhrE1j6xOn4heNYZyZmn7w0MzVAXnU6bLrs3cAzyOHS0zSJS
	KO7PyVj14I09EUsvbQcpk2KR+EcLq0Yv+PSo8mIEuFkDavmWd4IE9nTGcRyNbPXA
	qhap5jl3e4hFTf+2oJfFKu/siGnykgDply2J5H5E6qEbLszHqThIeeAY3Oze6Ddh
	wpCf2UQ0UnzTpSnrWOXm8YQPUuxqINuoZ5Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ppmzsRS5ENq3; Fri,  6 Nov 2026 20:33:57 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jLrVr6hzszlfvpH;
	Fri,  6 Nov 2026 20:33:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] i2c: mux: pca954x: Track unknown mux state and report deselect failures
Date: Fri,  6 Nov 2026 12:33:19 -0800
Message-ID: <cover.1793997098.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

If a control register write to a pca954x mux fails (e.g. if only the ACK
was lost), the write may still have reached the hardware, leaving the
mux in an unknown state. Currently the driver records last_chan as 0
(disconnected) after any failed write, which causes idle_state_store()
to skip the disconnect write if the idle state is updated to
MUX_IDLE_DISCONNECT. In addition, failures in pca954x_deselect_mux() go
unnoticed because the i2c-mux core ignores the deselect return value.
Track an unknown mux state by setting last_chan to -1 after any failed
control register write, split out pca954x_set_idle_state() from
pca954x_deselect_mux(), and log a rate-limited warning when deselecting
a channel fails.

Please consider this series for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  i2c: mux: pca954x: Track unknown channel state
  i2c: mux: pca954x: Introduce pca954x_set_idle_state()
  i2c: mux: pca954x: Report deselect failures

 drivers/i2c/muxes/i2c-mux-pca954x.c | 60 +++++++++++++++++++----------
 1 file changed, 40 insertions(+), 20 deletions(-)

