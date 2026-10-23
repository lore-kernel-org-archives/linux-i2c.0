Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792744250;
	b=uug9EGENzUGuocZGy+z8SVLxNYRs0XlxeUPv2IAC2Az8mFCZm02sN42oiH+C5n4tvtAx
	 f66KrMyuZccp5eUvTKrd3OMfU9sw+ncqMvTidZI8R3i3XzNlCRCHGrn03WrZ5EldzLjpX
	 U/9i40UVqyR6v7wB4IrhKKPf8NjNyUezeRmLZ0layWFBfn+XAMt267Sp/p6cMPBHJwcuB
	 c0pu2x94uVBRHU5R4d0c0cITgGPvfWoaBKl1sXeaRj1Q7BD19SjyhlHkFB9RNsUo327jD
	 yHQPOQ6XL4v/6Cr/PVbcP7PCrEgKFNG1UVJB4Vk4JY45/TBKyaq4U+fqtncZNVoWP0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744250;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=7Yiiu9vZePJUpddTNI5dZOHJsg90N3Sysyhvn5gfDjU=;
	b=JJXdGN7yglEVukMrsGiy30qpQyLAdo4uj2eNg9rsyfTtLM6/mXbIdjb2oo7aFF46VuhL
	 jwLuojX8Xr2c4soow0Vatz3H5YlRgPMv+Gs/61gMwVdZB5ixFKYSWSXFEw4j2dNUk3wQ0
	 2PV0VNlsHCqT5Q840NTmnEyvfBW+ar2yBzXG764EoI3J4k0366NXvOmYNLk7jZDsegY5/
	 4ghLmnvDXdzhUoGRwXWPY+hjb5cYgMcqMMvEB5NxJs4vHS9DeLyWmcqSCkvrVWicVOiFC
	 QMcm9YsyDPWvLM5TBqJrDnnTeLIxSybTqYwqrJB65+Ml9N3fck8QUusddj0KyVf8n1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OvfXCngs;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Gv+5GQBL;
	arc=fail smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E12606A31A;
	Fri, 23 Oct 2026 08:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OvfXCngs;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Gv+5GQBL
ARC-Seal: i=1; a=rsa-sha256; t=1792744232; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MjXz05mMbWdEt8z0XbGQ2T6tdStqbxi9prVHSd2bNc2BYwCSAPXifqQjKv0NIUZugd
    QcvhLbeuZUwgKXlzDqjfxB6wngVM6HwkZBvvlgbc0VV5vWJkF6yabqidbG9e4Trj9Ljn
    tdHTgBbU5vrhi5gTa4+Fln9QphdGi8bgv+kh+JHJltxQQV1ofoKgsmTdZQcgHkq2Kyop
    4/dnXljFvWN9loMY6JFVFZu+f6eDm1mtMGLVaDHkkJesHpqBXhb/+tiPw8tq0HA6/Osp
    gp7Uo6iGUDh5mqxOGCiv3BkGZXmTZHf8XalVwCKmnb9Yq0ub0YYYUifJgePr4K15H/oe
    WfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792744232;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7Yiiu9vZePJUpddTNI5dZOHJsg90N3Sysyhvn5gfDjU=;
    b=b2ladjck93FWgiO7rVjGec+er2coBpmqQosrRzWRm8x+LuSlxDcor2USRe2BfyhC+R
    4+/Phx3hWSnixBo5HjkCbIaEb1ht+lOaIsT2U+QQUt+i6HhM3lKBe2j2uJB2rtxb5UvV
    l9itIekZ2wqpAuZcimGEm7SKimavwVZJ5XddRdsciljtm7DAqVzmkPS5VG19MyrO7u1R
    KFvRpN+7r331AEzETJJXCgF4qPoNfxS95DO0eGRdjA+nbCcKhoh2FeFCjIJUf7KNgSqg
    Qm+AWFgbjUAg4IQVlDVvqmKTLVpxgyr96fsmYQN5XveLSCwzG77cPUGjNXVqd5rzy2bG
    GBwQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792744232;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7Yiiu9vZePJUpddTNI5dZOHJsg90N3Sysyhvn5gfDjU=;
    b=OvfXCngsBgtvATSN/JCSqUQCbMb0XgcMZFLfso44ltLp4kEui5JRWfUvh2FYjx2och
    fO1l5S+ibmBfWmB1AjiWkVX4HBKp1Y1aJ+2TIj99TxIrzI95Qo1H2mgtGIONu3e16W0+
    HSFWZcASMXxvDrfIadq0oLsTELHPPivk6le7YIMA+1Qnkvo4MzOf2kIvJO91W54vhpzK
    j9SFBgpsFoOq59uQACtlZVCENG4NYVSt+5gCD4KCBLUE7rPMBofL9yeHww2ctRtI/Bf2
    FUptjFcFXa+NsY4JM/A6+WGKZ9gbYVcMV8QFIw1skxo+MOeiZ16xFUre7L8WYqlxRd+D
    ZeIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792744232;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7Yiiu9vZePJUpddTNI5dZOHJsg90N3Sysyhvn5gfDjU=;
    b=Gv+5GQBL2OXx9ChXh74ldzz0bMCTsXAflZtO0MG9dMZEXUPgoLvkbRJb2p8bgtz9eD
    uxYZABv6goblWfyaOvBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ35oOlMiNQPdsKsFqTxJoSSO1s4n1No3nWrYA"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229N8UWsb3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 10:30:32 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH 2/2] i2c: jz4780: Add support for the X1600
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261023081452.44118-2-olivier@mgcrea.io>
Date: Fri, 23 Oct 2026 10:30:02 +0200
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <96473297-8939-4C89-A331-DD75DAA10DCF@goldelico.com>
References: <20261023081452.44118-1-olivier@mgcrea.io>
 <20261023081452.44118-2-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi Olivier,

> Am 23.10.2026 um 10:14 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's I2C controller is the X1000's, except that its SDA set-up
> time register (SDASU) is at 0xa0. At 0x94, where the driver writes it,
> the X1600 has the spike suppression length (FSSPKLEN), so the set-up
> time stays at its reset value: 116 cycles of the 140 MHz APB clock,
> about 830 ns. At 400 kHz every transfer to the touch panel of a HiBy =
R1
> ends in an abort with TXABRT 0x1000 (lost arbitration), and no
> transfer works. With the set-up time written at 0xa0, they do.
>=20
> Add an X1600 entry that writes SDASU there.
>=20
> Tested on a HiBy R1 (Ingenic X1600) with a Hynitron CST816S touch =
panel,
> on v7.3.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---

Cool.

I'll test asap on our LX16 board (where we may have a similar patch or =
not) and report.

BR,
Nikolaus

