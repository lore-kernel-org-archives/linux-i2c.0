Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478034;
	b=iL8brdzciOu430SqY6sR/agFdGJPqKLK+RCFptaKihIz52newiOeuoYRw0iRdz9HJCGn
	 NM6FVUwRVtU1fzkNYY0c5hzYZdg4P4k2p7NFy2xDGjsAtr1cVzssOFcXMc4EiFKLPW1PM
	 xcOjv/OgZZLPYL4pnCkHRZO0KUOZySQBvD2Y2n60JFy+EBp58OeMfGme+BlP4k3Mtr2p0
	 udzN3c6uMyXWwZS3zay2xi/D184PUw1/vUl5xRdB4EHFpMlSDqnF82aSwpuuqk8xQ0pOs
	 WaK5IplXn2iGK7OVk8rlXsqTSt9G1reyTakxRwPkb1sIQ0BK18AvcvgrV0YoKTqobOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478034;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=RA3Z10wD7RDLkl1LQhXqveUCzhHEJEYzO4jR3113zUk=;
	b=pnWTPziWXyCR8ILn0f3L+6RkG+D+bJDK+VQ6MpSXWuyofIC3FB/OwlAHUo1Z+TiWrkIj
	 zJmG/fUVQ1F0Dmq1OnAtHxfUhkhx0klK8G4ZsdRrTmN0iSsXap+x4/P05K904h57nOOHg
	 kIrqyI9KwBWheRfiRo3MqKB1aINIDI43624wF6fl8QGp2HnOBmBuqjRKKux7j+Lb4rYog
	 axQvt1bekF9k7IyEwmduD4Ka+P96qleCUtcc5ViEKsGBz3hXWyDtfXkVGc/ijOLhx46Os
	 1QJgAobS60PAtb+vvWrbS1AfPiM8GUVwZFzjaAbtrPn4AUV9ri57hjcYBn3iSGV/KFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=A1A38LOW;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=voTzo6s7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49BB606A333;
	Thu, 12 Nov 2026 10:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49BB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=A1A38LOW;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=voTzo6s7
ARC-Seal: i=1; a=rsa-sha256; t=1794478030; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XWV0fGqYErWZql2iGhouFxsrUOFN60KTxfYsJG7LqCJORolfiKRcs6UiMxrKS9Gf16
    nZ2FdiYiF8R2tCdrykHZldEo86i/REhsnDKyjuoCjfpts6cy0yKUDtRfY4OWrZ82I57l
    qAOHjGKCIFmq6TfL9j3BnYAGnV6NyU6g6tbfQssdG80+nmFxLcYwAK0Xm0DsumALoU9n
    nTwjkKfZtKLqZd+aigWiNDJwX3cA0Wvon7dE5Z4BF2MvFv9TkCNbO9cRj/MaQCvtLgyC
    3R+w68/Lk3PiY5l+02NR2Olp749FpL3QutsUVI0JFMcG/onnXoTw3D8rMbfb/WhqFxrW
    telA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794478030;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RA3Z10wD7RDLkl1LQhXqveUCzhHEJEYzO4jR3113zUk=;
    b=mxvzKQbYJkVWWg7RjGeQMJzha8VN85CbpSSnBYv5scZ+EGbLuV6pUTTJf0SW3syJMW
    bCv4GwltsuaUb7Bkr5OdsZZwd4avwmNeaD/iTkk9Th6EQlJeEuvyf//v5he+cksZTIC9
    7aPuS4AL3Q3LDTs8MVPjvY2snz6clnP52GRy71cG288B6j5SSG35uLt0k4/Ryc1ekNn2
    vgitjbs9Oy+qmb4k3vVvy9dgcf4JtrR4tQHUkCmtLKOXJpD8mqzfGchEwS8uJTo8lfWA
    M4kJ2ZY4m3P+2PdFT6DQrFHRUOSXkMZcTVooUeaAbb+UVptW+jk0bE644xvewYZouT9D
    soiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794478030;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RA3Z10wD7RDLkl1LQhXqveUCzhHEJEYzO4jR3113zUk=;
    b=A1A38LOW9F6acPfut8wGJ8aC+WvmOo+Vqn05JE+or/SKWrZMWCSKSssFjdCcnLLAiK
    KCrTReoL4EatVmgBOB3SXX77xf7Ks+Dk4oNPT3cFW1sLhkAxEfh2ltsZ6ZgUrh6N13fO
    f6gQzsvTVHAsy3rLn9hxKBklEyOYM9oi/4ZGOz4qDton9OOfNbxSc9IumRBksjlKJXJh
    vSmDM1Ak8Mnikk/tF38KLdbGDppzjhAQhEWalsIifjCHsLnsR8Io73Ftxb7iTL5Dj0IP
    MGvxsd8Svm5BpuDX0siAn8TIH2Jjo4IZ2/dk0m68qOXnW+PEAIlMRxuj+UG7CY8JyrWW
    29VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794478030;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RA3Z10wD7RDLkl1LQhXqveUCzhHEJEYzO4jR3113zUk=;
    b=voTzo6s7h+H1VwoU6pbBx1a/Pc1ZqpXa3mZnT1Tz4SsT3iWuML6wzSSohLNGdIuqMR
    o2hg8YF+0STgY/mfKGCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV35pZz8iNKp1rK7chac7b5mVucO+Qp4KTQNe8"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22ACA79BFM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 12 Nov 2026 11:07:09 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
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
In-Reply-To: <384F58FF-41C4-46AC-8B2A-1B6ABCDA6981@goldelico.com>
Date: Thu, 12 Nov 2026 11:06:39 +0100
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <C17AD04D-6EE7-4CF8-8DB1-FED4A16C66AB@goldelico.com>
References: <20261024212520.91401-1-olivier@mgcrea.io>
 <20261024212520.91401-3-olivier@mgcrea.io>
 <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org>
 <at8jCGfp9dKjieoo@zenone.zhora.eu> <20261109190345.61480-1-olivier@mgcrea.io>
 <384F58FF-41C4-46AC-8B2A-1B6ABCDA6981@goldelico.com>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi Olivier,

> Am 10.11.2026 um 07:31 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Olivier,
>=20
>> Am 09.11.2026 um 20:03 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>>=20
>> Hi Nikolaus,
>>=20
>> On Mon, Oct 26, 2026 at 10:54:49AM +0100, Andi Shyti wrote:
>>> I'll wait for Nikolaus ack/r-b for applying the patches.
>>=20
>> Could you have a look at v2 when you have a moment? It is the version
>> after your review of v1: the spike filter programmed on the X1000 and
>> later, and the X1600 falling back to ingenic,x1000-i2c. It still =
applies
>> on i2c-host and on v7.4-rc1.
>=20
> Yes, it is not forgotten.
> I just have to solve another issue before.

I have tried to test that. Unfortunately the x2600 board (which is the =
only
one where we use I2C for the RTC chip) does not run reliably and =
randomly
crashes and damages the =C2=B5SD card contents. I wasn't able to find =
out yet if it
is mmc/dma or dma or a bug in the x2600-sdhci driver or something with =
cpu
caches or a hardware issue with RAM timings.=20

So at the moment I have no device using I2C at high speed to do real =
tests.

Please go ahead and if I find something we can write updates later on.

BR and thanks,
Nikolaus


