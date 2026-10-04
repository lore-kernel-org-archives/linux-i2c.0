Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59C72602
	for <linux-i2c@vger.kernel.org>; Sun,  4 Oct 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791082627; cv=none; b=iMrRj7MRrjg4wbhwcbkorOMnJoTlDTTPJ4F15QCpZNui4RLc9dYue0BoG95FFxMexu04G4+jKr68+BJTV9/q2PaHDaxTtuuGKXHFrIgeJrJpub0jpaaPBPl95K7tmwcWp/NwB5TfLWEVZRpIPXgQUEQazX3AIU1RKRbvhbs07uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791082627; c=relaxed/simple;
	bh=fG5QMpMo3ggEv2hmyOpwXOgMxbSbtZRjj5e0jGGueoc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=afIpTmg/5GZ9LIgrYGrihkTfmHsBH/nd3z0z3TcjG8cFnRK+rbpAQRgcA7x+IDnzbEZEjEPa8tqjeJYc1YCPaqqmdYHQnqzhRwm1WoK0uLUemU+9MDnSVq+2lWDEKlvpNL7Bw7rJ1JQjcDjGo/7kQN52WQmWdST1l5IOuT2v7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=APHMV5+w; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="APHMV5+w"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso424670eec.2
        for <linux-i2c@vger.kernel.org>; Sat, 03 Oct 2026 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1791082626; x=1791687426; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fG5QMpMo3ggEv2hmyOpwXOgMxbSbtZRjj5e0jGGueoc=;
        b=APHMV5+wU+gFYz7Y8TkYANXG/jSWkBr3FkKF1KQRyRQ3D2CMLtiss+woDkKoDZoI08
         Jg7r1R82z+GKV2XNfwjopTPdFw31qn7WooKwpVayMMRFM3nUH7lnIOfMRA9ZUiahThTW
         sVxkoNBRN6Ee9Nvqx+Kk8dUalvvsr2NpJhyGKwUGPINs9DOlkuCK2mjGz0xhyUotV1IX
         ggg0bwrnxWolETINCe29lTdAgWKiN2y2HfaIGS1vzUEabWTR/ZxjTbBHOH3VbPNtXRtc
         ZZawQAuFajZcFuMy9+96vs3gWgOtqxO/PdF9G4sU+1iaXzl5UX5JYlIVUmkaXkMgAsvm
         axkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791082626; x=1791687426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fG5QMpMo3ggEv2hmyOpwXOgMxbSbtZRjj5e0jGGueoc=;
        b=sSnfu8dcrO3+ZzLqxRfIq4D9SK3a32ekkTcosSxgbt6Uts+I7fE6EZzZQimalMFkEX
         bnlrfxC+stNcBkWs8kmExa/NSDETRxPZ3ch2CD7ruNYLgHk3WqqcFeI5RJQ6VUrdYQKi
         INzvoharU5WApsV/aXJK6c2zSKOXiiLz9UEvK2csX9IrLda5/yXvkPrGghHa7ZunbN0p
         QFWin+a2CMpbFSU8zQ6mYqApI1C2LaIPr5NewL8EBUtItm14hMhAq7KxhpzCdsB5X0LH
         0KAEqbXENVvvtyFRi65US4IGkh3swOYz67pvuScKWbJV8+Ub6DUzkZz2qO89lCTCR+1L
         dAMw==
X-Forwarded-Encrypted: i=1; AKwUvBy2rD0AGZsbt97I6aouV8VALeCaAdN4CNzjZu002nKhLSkZjExtZppfKVIHM1ZPUULIIcE30s5uA7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYILDC1VeXg/OlXvbdtY6HXqFWr1iDl0MMeq4sjY7bNVluBVF3QE
	iUtfoZ5aVCHzkxRsgGaQMyJtTVb2IaTRpIC/p/jai3OLfhVX6u9TcJ/L5i9CveyW53o=
X-Gm-Gg: AYBFou1/D0i2iZdFq2c8tJMvJ1wjdKC75bV/6s7yWuFq8/sDCNU2uFNZ47SWVs6k3Mk
	WS8Wup2/f5t2u9yehcDRleOcPwS6RkIQbCyEMNPbc0p9g1iBNAdiSNsiUGlcRtwBaeZdsRXwyIs
	IzhXqdHnG6sViaPp5DQZBLPnT8LK4sP9k6xkzURqdNOp8WJS6YXSdBQgTpBFGTb4EteKxANuDQA
	QoTnn/ntAnjoxO16ogAZ1r+X140xIUB2ByGWWv2IKHHqFigf3SGXzEH/YzhD1+tXuwRtlZ5jEik
	toJvB1OYH8LcS5NOqEyU4a3Pmiem1Z9SRNvUKKSVtX+/BOML+91q98x/joB9W9UV0X1gO4nUbqE
	fJkqaBLPhRdpkk0FkC4qz3YvLoJlT+sy9hGER/vyp9ul9DJMJ5PWanX1dc5zH5i8lTeoGBgBDAK
	YQVp0UnYJr561jvowFJp6VCniGbblZbhTpYyr5R8Sol7YYYwM38685KIcQsIndozmYF7iLPfQ1E
	3i+xPRQ9rCYCwHtDlw7t+YoBEi7SiaZZFUHrnioyKJJ
X-Received: by 2002:a05:7300:e9cd:10b0:33c:e82:70c7 with SMTP id 5a478bee46e88-34f21985077mr8684717eec.30.1791082625507;
        Sat, 03 Oct 2026 19:57:05 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9328:12b0:aafb:5758])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351273aaed6sm961680eec.29.2026.10.03.19.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 19:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 20:57:01 -0600
Message-Id: <DLVPSTHQJ2F9.1HPIUXJ2EW5RU@brighamcampbell.com>
Cc: "Jean Delvare" <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>,
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 0/2] i2c-tools: Make tools accept bus path
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com> <DL9EB60C2IIA.228Z11CQM65Q3@brighamcampbell.com> <ark-AXt29OBT5hbg@ninjato>
In-Reply-To: <ark-AXt29OBT5hbg@ninjato>

On Sun Sep 27, 2026 at 10:02 AM MDT, Wolfram Sang wrote:
> The main problem here is time :( I have important conferences coming up,
> so I can only schedule this to the second half of October, I am afraid.

No worries at all. I understand. I hope you enjoy the conferences!

> What would help a little is maybe a description what cases you tested?

I tested as I was developing the patch, but that was a while ago now.
I'll test some more and report back with the details.

By the way, I'm happy to review (and test, when I can) other patches if
it would help. If so, feel free to send me some lore links or msgids.

--=20
Brigham Campbell
https://brighamcampbell.com

