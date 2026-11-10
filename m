Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794292333;
	b=p4Y1MnJ6Hz1iFx8TqlnPK29XsU/X8IMmwUOSrDbzyis5tsP/jBhDEI6aaMiKaoQEU57J
	 JLSAZt7+dOZjftZxPkwtDwpRv2vpNj3rlvWI65Q5ZgkVZvpUQbzURYywTUwZKdageRdpB
	 cRqhpkicHQVFFTB2dI2lRnb7g2ODXX8LuWMtg7HvQLl5J2MIQlS1BZLx3VXMLcLmt7g+c
	 hHmthE6Px3rjSumO/oGHLLMUDXP0xb09wCmHRifF6uuUKObAi6xCc3wqQhXJJOvdpR6j9
	 puAzhUBDHwu4cy2t70PIqlL98Ss+KLxc1StjKI2eEio8CSsGE97UQ/iQH3qypWSE86A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292333;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=zIeUCbrWL2otG3jWvVxAJl75ky18Wd1uPMPZj3Tbo5Q=;
	b=ZwIxJKPIQ+1+PsA3gOZXT7mRbjAAIygd9Bl/cClHbICMvR8wRPc1ebDsmNzUBuCEFWUO
	 rjAORtnRQf3rfN+wFCsbJz8Jl5sA+DLk91n3d6L2QeKmVRPC8VKyt+vu23ae6lc3NhkzT
	 BBjkw1qpxNC4yVbLsCLtbh7HhqGtzZSkigO5hniUBSSPSyxnX0uCxxXRi2YzfKsSs8K33
	 rrOGfkGUv84lfJ8eOy7bpmxhoRn/WVFeFHrJ9p1noa8bW9DK0ADkFc7YhMYYjb5POHOUb
	 tNZqI3nVHwglvXhudvE+rbzzuMfSi6OYevFXtxIXSrhLt7Oob3Mp++mxesuXlKsgHPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ClFyTW6r;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Xjo64+AO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9A606A325;
	Tue, 10 Nov 2026 06:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB9A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ClFyTW6r;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Xjo64+AO
ARC-Seal: i=1; a=rsa-sha256; t=1794292320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QPAQkbaQzTsdjgKdlzRRC8KGCRND6s6ght+Xfv3xNz/whL7snq7wksYlW5oRxjeI7N
    cVyMALkVngdtJ2vVfeBdPIf6JV2/VoEUOX+3qk1RtZ3bYrnr2HEAxUYjvZ0J5tXJ9hZw
    lWzehFTI5MV0TYKLFgVtjQczgTTq6wzSnse6Pakt+oppGBA7ojRDTRPmujM7YmOMo6gA
    pJe4UTImP9RNEpEaxhY0CRolJCN3kJ0ToP90zIWw30V3UFRqMsQJr3/1i77CFiicJtxL
    czMHp8iFedkjbjoNDnv6kZY19lW9WssMi2bZPacC8h1NHKvvldn5K/GKMcwCehJShFHi
    A/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794292320;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zIeUCbrWL2otG3jWvVxAJl75ky18Wd1uPMPZj3Tbo5Q=;
    b=jUSWHBah2R8OU1JrSK7ofZ70Cr2srslHtf/IbMBLlmSR5LqVfWpPGluxC7sAGtQ/3P
    B14SCP+hvRnFJgotDBOHtE6lCq+J5memm6wQVse+Ibt7UTqatBq2UEn6+GANgOU5+CmP
    CE+MefAYQZ8dGjntUMgcrLEla2ye1MW3Er+gO+kDTNd3njsw5ZhVQyM0JFUw3JOdEkD3
    Kz8+Dg3yoMeV8syUuNQjxfMgCR1xi7IRfd1vbPKDm9JAfYIFVL96U153pwT2HcS3+ozC
    0BveaFkBltAK1vQlwtL/DfaljaiPZTK9Tf0TO51PDGRncjz7C6KlZeyg3s+Nvphijl0U
    GbHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794292320;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zIeUCbrWL2otG3jWvVxAJl75ky18Wd1uPMPZj3Tbo5Q=;
    b=ClFyTW6rFAShb2ZEZTRyTL88MdUoFU8PB6YTkg7aAuc1avwCjdjjgoaCSsoHtLqC4z
    /qGEDCCt9sHkclyPYihKIfZzhXV7Rpyr8DuQ4I6i10i4NJQiL5xFdaP4ewyWnmPSZy/M
    0DFMV0a/iOuEaC28cTRe0NwUc617hzwpWb/zuL9rWtlnzjk5w0AlIfBml6c3YYnuQ+Wm
    Zok4N83x3+9lZsMye3HW6bJ+nq20SYThidGFCcgDoi+7c7Tzh7//y/dlSxuvjvjGzrzy
    q78oauLe92RoRd25l70inWAz491HdY7nZM0hJ/hVlNfTdVHUAUbarG/zHuama7HBLxsN
    wuQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794292320;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zIeUCbrWL2otG3jWvVxAJl75ky18Wd1uPMPZj3Tbo5Q=;
    b=Xjo64+AOfGqMUYgW2NM37V+kCo5lPlDWaHKMX24Ixjl1ZjGzPvIewVloiQ+FWUF14e
    O/II7zE5X71F8cyMa7Aw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25pZm8iNLlWLhMfIu14x/UU8X8YOyRO3gSBU"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AA6W00Fm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 07:32:00 +0100 (CET)
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
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261109190345.61480-1-olivier@mgcrea.io>
Date: Tue, 10 Nov 2026 07:31:29 +0100
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <384F58FF-41C4-46AC-8B2A-1B6ABCDA6981@goldelico.com>
References: <20261024212520.91401-1-olivier@mgcrea.io>
 <20261024212520.91401-3-olivier@mgcrea.io>
 <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org>
 <at8jCGfp9dKjieoo@zenone.zhora.eu> <20261109190345.61480-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi Olivier,

> Am 09.11.2026 um 20:03 schrieb Olivier Louvignes <olivier@mgcrea.io>:
> 
> Hi Nikolaus,
> 
> On Mon, Oct 26, 2026 at 10:54:49AM +0100, Andi Shyti wrote:
>> I'll wait for Nikolaus ack/r-b for applying the patches.
> 
> Could you have a look at v2 when you have a moment? It is the version
> after your review of v1: the spike filter programmed on the X1000 and
> later, and the X1600 falling back to ingenic,x1000-i2c. It still applies
> on i2c-host and on v7.4-rc1.

Yes, it is not forgotten.
I just have to solve another issue before.

BR,
Nikolaus

