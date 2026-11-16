Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853271;
	b=SBv7GjmInBgysSMDDkUEZ9UthUXiI6MCbvYY/ZkojstJNp36YIS+i7f/ZiUx6EI4BCNU
	 6dsliXbcTPbVMDJeyfzpX1+aNU9bBXOQ7Yz6prhfbyYVTMlDczinKOGbEwg4SY18EYiwT
	 XdHjkZ0eYno60w83UuaDq+uO/PkONRks9URsx7ARn1+gDriholyYxs5K3Qfea/bXe9XE1
	 SLbMnxQh1lpTmj7rAesZmy++Ugi1ti+T7OOdft0OubfynkSV/ORYqJwNBncGpOQW/Hh8y
	 H5kPDdsw58Qm/tNF+01nYSgmXMGBu6lebZU5RxYfBwRodyPVu7mjQ6xDE9km9XvnJuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WPqbI4E7aPhF78xzJBa631u/COojzZ+RvMgbm6UKZ2I=;
	b=klu09szPwdcpwHR0TzSFmgCB+TvVUniPx6EckRXPyXmHajiJnFUA9uZuqceCmc/XN4Kr
	 SHJuQ4jrsjvD+3kFrtM69adgxRjOVzHdHecvmYsUCTPZ8+5QMLSVRzx7SnUO4cqJlyBJH
	 iL9oQ6yiFYJyAYchCswriQxpsVKVy7GhYoOBNajr9YrAi8iHP7AGx0yA2XYqZ8tWDQFoI
	 mr7kbo6qh0mi4U2xMIWRXi0AdtHmdvkH+e27AWyGfpMYzk4t6bxFKfwEhV09I/MvGEJyF
	 ZEw7XfS6m8qiP64+8Hu2gv1zuiKyVRVxW3Qrhx+HE3l7uHc6GThadQJadumoGvWPjLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PbHWy/OO";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF0606A322
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDF0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbHWy/OO
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2eddafe648aso24012885ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853270; x=1795458070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPqbI4E7aPhF78xzJBa631u/COojzZ+RvMgbm6UKZ2I=;
        b=PbHWy/OO/p6lbs9pGg3i2CMxwEbrtuKliGLYdedBT6TXPPbt31Hgd/M6eFVsm2cldq
         h/4UZo4BITMQgH9DqV475AKu2iBD4n5ShUSaey4NSQy1MBq6O9ic96YTyTn1naEhZ3Q/
         CHS3RIQLxlzHcMGTdN5QRK1+ct/dvIuqAIJcQImStiZ2WNSLAF0ThwL7iCbiywDeptYg
         rDUzR60dRlDSBJk3QmV87gRKa//yp4ipS6/WIzFogO1wVoWwDpPqUvQlqhOEdP6tOI4J
         FVNihNhKN5WkszEhxRgVRTq3i/gIDCjWjzwu9ue0EyPPGAnGaxngVKAQa4xAAf0tkueb
         +GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853270; x=1795458070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WPqbI4E7aPhF78xzJBa631u/COojzZ+RvMgbm6UKZ2I=;
        b=YdvfYo8lAGaurvUIeOw1krX+lvK45GG9g7wPRMcKCGjI0UukgQXggTDhwXkGOEZ6+S
         uUHNYj4Hxd+yNjlVj1my/YuHfsl2UL0YwBE6KJE7isY2a22Slk6q+OkBB33j2lqxrZok
         1wyHZnuhCAhv0IgW/29ir9XD7ceYF1t3jfGzZG5fqrerYDTCMliQwP+hviZS5DwBD2kR
         fvoYr+E9U7JO9sKXEeo5ZAEN25Q2kDVg0GbKVP8b35CuVSPSnk5HCFeoW/1iuAwb68bh
         sYPJEswIVkEv4NQieEjZAYADcrgHnu0vpQgCzkP7UtSXsbkWc7RxRy08Bxdx74msbMVS
         znzg==
X-Forwarded-Encrypted: i=1; AL+hErGUkJbuR5knE4DPg4ffpcZKu+hJOxh5K6S/+09v2d4tU9DkyCTbDMgZtd7ccia6Rb47aS1QDdZ8iHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ivL+B5dlOc47jx5d8larWpJYh9zf60xXnLXinxNdMKLVPDiCt
	oqQX/64c1L/DEQrLrMOXjz6Uc9UfiEeLfti5R9DwK2qM/u5SVtE0OiWl
X-Gm-Gg: AZFdTZf1WgVJzIIl6jzhjqkp1RuKJqMaoHdRefSfJ6+f8da89GnepDoelur7tvRKT2U
	WByb77PuipU/6RFxmpyi2ZM2ypVOtzJTeB9g0YjyPSZuEzArtvN+Be3u3n6mw/GxP0PvO5OWiTO
	WDvN4HUddprRLi364AYlRXIcvZ4nABpZPJjlsCrd9kC5g1fG/Eh4p4+KvtmpvbKmV2dAzYg8xVl
	nPGotmje8aVrht3K/ze18tbCtrHKMzQza0I05qaX9FfS6NQ9teyAkrMDc60m4s72RiDZ9t/Eltd
	SSveoYW+FoVIpVVc1CIS/lqnMSljngz02RNi8Fjtvw3UZ5GLh56X+GrVfdBJuBF4zsC4bt5gb84
	03I3NWbeYd8zmwWbzr1ZPX6Y+wrq/TPBsMhJARuw7HHxJigrjqHxtcKRApBXj4Dpv/EX13J+xxD
	1tmDvI2N+78SENueVTLkSR7PhTKYEwh7VA1lUEHhWE0yXOvxTDB6j69XFVxMJgJhC9/KmrdbVwR
	EbUME90DDIbpl9H3milR3LKyUR+56x3aV6YuwyxsPSKrp2ZXiRooW6cGz7AkGZM1eJsLL4qDf+u
	Sn8/Rq2EIveG9RieqOW1L4XKNHM60lObnIm8CudjTIokNr0yC4so9Wx43v2amhO8sHsSP8BZYYN
	YcozkW6fG++dQ/rI8jJeiWL09TDQcYZHQR/YASGjGqekSelcYzcCQxlmeWQ==
X-Received: by 2002:a17:903:41c4:b0:2ed:cab:e977 with SMTP id d9443c01a7336-2ee0da966e7mr123690405ad.12.1794853270245;
        Mon, 16 Nov 2026 10:21:10 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a161a3sm2885265ad.18.2026.11.16.10.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:21:09 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 3/3] ptp: ocp: add WiWi Time Card production image support
Date: Mon, 16 Nov 2026 10:21:06 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-r3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179456532138.2199510.9610534349392524646@kernel.org>
References: <20261111041904.48916-4-ahmadexp@gmail.com> <179456532138.2199510.9610534349392524646@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WiWi shares the peripheral layout, not the PCI transport, with the legacy
Celestica entry. Only the WiWi match uses these offsets, vector mapping
and gate.

I have not verified whether this FPGA replays a masked event. Instead, the
proposed change refuses requests to arm a timestamp, PPS or generator
until probe reads back the open gate. A request made too early gets
-EAGAIN and can be retried. Disable remains available for cleanup. There
is no speculative acknowledgement after opening the gate. The mock-MMIO
test covers early refusal and a successful retry; it is not an MSI-X
delivery test.

v3:
https://lore.kernel.org/r/20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com
