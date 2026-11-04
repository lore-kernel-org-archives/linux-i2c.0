Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774653;
	b=WBN15moNpcKTXbPooa2oPmz2UXBL4d8zHAMHv5rbnZqPrP81VFNnjrxbILdo8zf0A0Ba
	 m4x2TIKPpB4WcOV3r+oiS6hlCmrNSAgTUOkJbjEBhWFqdEhtlfNRfjXSnUAe3v97Aa1cN
	 /Apl3Y5IK/XQ/f+amU1cOuCrZtvdevxOp9RFa1G7cneDudnHneAqE7lY7tLST7Kmr8en1
	 Q0djoiFawbYYIDFWT2a8TYGchOnxSigt3pSFmq2Pp4U7s+Ad4qHRZOr1ekxW+ym4H3+E3
	 uFQHZ9Cy+2rDUzso1K4V6B/kA/ZLM5KlNVL9G/BYRwA2prtnicq6ffJpbZ6w11P6odw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774653;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=5FrnZXhgWerXcG8ymggsVZPGtznnjgT06atJ+YKwCsw=;
	b=hAy+Iicy5kFy8DPxpKqn8mo3ws/yblMOhyUOdyYISPD7TwR5xh8ztmj5whH0R8dqKIf3
	 swC+y6livrquA0wU2nYEat2IGZWF/HFWG9JxN7ODodwRlzKUfqiC1pidVMXAPBsPb8urp
	 /HM/KRtzDTJbNYr+K2SHL5/THt0JoETm9OgFcoEJq8BxNVGd+kG2VVvYJbPFMa5pwsILu
	 avN55q8U08dbA989mtkKgplsIfxK3FN4jOLwLZh//aaJLvsgQFhcc8nYmR7V5xXw10nRD
	 E1UfJgpzIee9lOoXwVTAK4CqF+gSQgkPAWvgtf2pF9hyDX6tuyHJHoZ/bwP9VTlyn+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XG6G26+s;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A6606A31B;
	Wed,  4 Nov 2026 06:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 721A6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XG6G26+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793774643;
	bh=5FrnZXhgWerXcG8ymggsVZPGtznnjgT06atJ+YKwCsw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XG6G26+s/bdq0EvP4046nZzifwVf8qL5acbkt2Nu7LMV1FHbmsRc2S6uCJx5Jll3V
	 eHy1N/xOS0SQT3B2Ix/p5Qe81kVZEkm/JoZD/LyiKNj81oh8C+P+EboW68cWki//63
	 dUQH+O7MwiuWdTiA/BqhnSKLNK6T+u9tQkD2S27/qQXrAVTBYRncWJEwS81JnH6xSq
	 qkRDgWRwW7vDHwCJQqPOPVbODQlWH7TzVOCtI3fhMlgWhx7MvwD8VBgfMi6Q3jF0Ss
	 NJ6ZTjdSzo6qh6Vxsv7e8oMcPo9eBvmu0DqjqMw86y8hYwcr0KeCyedkSk/dWIXXY8
	 DcJDCqieDCg0Q==
Received: from [192.168.14.220] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AD6156469B;
	Wed,  4 Nov 2026 14:44:01 +0800 (AWST)
Message-ID: <e89969f13177f2e7b3105851d0cf42eaf11bd98e.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "jk@codeconstruct.com.au"	 <jk@codeconstruct.com.au>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>,  "peda@lysator.liu.se"	
 <peda@lysator.liu.se>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "davem@davemloft.net"	 <davem@davemloft.net>, "edumazet@kernel.org"
 <edumazet@kernel.org>,  "kuba@kernel.org"	 <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,  "linux-i2c@vger.kernel.org"	
 <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Wed, 04 Nov 2026 14:44:01 +0800
In-Reply-To: <DM8PR02MB80878075D2520A9CAD7DF0928E692@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
		 <179239912623.3135.11352652156626817288@kernel.org>
		 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
	 <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
	 <DM8PR02MB80878075D2520A9CAD7DF0928E692@DM8PR02MB8087.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Kenny,

On Tue, 2026-11-03 at 14:47 +0000, Kenny Hsieh wrote:
> Hi Matt,
>=20
> On Mon, 2026-11-02 at 17:04 +0800, Matt Johnston wrote:
> > An alternative could be to create sysfs attributes under the mctp-i2c d=
evice
> > instance itself (the i2c slave).
> >=20
> > Mux buses could have mctp-i2c netdevs instantiated with
> >=20
> > echo "i2c-6" > /sys/bus/i2c/devices/2-1060/add_mctp_controller
> >=20
> > (where i2c-6 is a child mux bus of i2c-2, and i2c-2 0x60 is a mctp-i2c =
i2c
> > device).
> >=20
> > "echo i2c-6 > .../2-1060/remove_mctp_controller" would remove the mctp-=
i2c
> > netdev.
> > Setting a root node as an mctp controller would involve writing its own=
 name
> > to the attribute file.
> >=20
> > How does that look to you?
>=20
> I like that a lot better. Since the attributes live on the mctp-i2c
> device, they can just go in dev_groups and the driver core creates and
> removes them for us. So I can drop the per-adapter tracking list, and
> the remove ordering and probe walk races Sashiko found go away with it.
>=20
> Let me know if you'd rather have any of these differently:
>=20
>   - adding a bus that already has a netdev, or removing one that
>     doesn't, just returns success

Would it be better to return EEXIST (add) or ENODEV (remove) for those case=
s?
That could catch mistakes. Usually there'd be a single userspace program
managing it, so it doesn't need to be idempotent?

>   - a bus that isn't in this controller's mux tree gets -EINVAL
>   - a bus name that doesn't exist, e.g. i2c-9999, gets -ENODEV

Those look good.

Cheers,
Matt
