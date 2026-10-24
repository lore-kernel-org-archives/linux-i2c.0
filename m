Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854054;
	b=Gd2zcVlJhvbZ3YKL5Et6oz7cRHijFA4h2LNkGt0LkFl2bMnwdzE1Lzj+VLnZ7OkqmlDY
	 s0+p6JGG9xlvcu5XQ+iThV2PmpBh+0I3FDp92zyT/R4aCj68VRxJWy9mgTdVKjNKqXgCP
	 sbmjYwgsWTNqZACOowI7t6QjCU0sXCCvPZ8k1s6oZtrOKZ68lzLkOBDS8R6mYTH9HYaSH
	 WBM6Nt329bj9PpQNqFTgvyxe3KcCUhDLZtnweVGh9byldhLVBUly96+MOthW6F5k5Nxw4
	 jFPBENW39pr5OW7xdeg1DNwv1UMnmCgtb4iHMQuuy+z6eLrYq+pmMgM1W/RrwP+JGpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854054;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=QiyEV8UWMWLkheJJHjCp7+d/KfIAS/e/TZ17qThK+/U=;
	b=VRfYZO8/nBwyh/rHR0C+d6IppGzJbWXZoMBZzGCzP2WLOf7Egl4duTW5PecoDES77xgj
	 L1wLIkZHGIffjowtQUrmP8nDw7gK1O3NznLeoB7hSyORl1AW5QeVSI8g7XTCeaFOU1xZ9
	 gp776hWZBIfhcL35JbxYUWohT6lELTDu3RmImPHIpIKH+FEBHCnBfcvuYeSLLd2HaZY4P
	 foRUicxYGc47ivzpp9a/BOcFPCT2y9a0n2KxI4mkKOTME5RJnJ0iL1O6osFvidSLvrBg8
	 PjIgg1up5LtmS9hEBTdmocxr8LCNvE8fOm9qwYmwFWS13t3nffp+fYPbzF1YG3dRQNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=g+1dNdTq;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lslHi2VL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D606A31A;
	Sat, 24 Oct 2026 15:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1335D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=g+1dNdTq;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lslHi2VL
ARC-Seal: i=1; a=rsa-sha256; t=1792854035; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ryfyafyvl/m2nmf6sg0gFdnmww+ZEGv7mUqVrGTIhYo60Wwm4ZYmvFANn3FuK070Pj
    NsCTS47Qsd4aNeAOn1IvBMzttsndLvigNX763aai03idiajNChRjEbdPZGQDLxGrqlaz
    1Nb2tZBBI4f8HnzaimdqDysbEuKkHktiIw7cIr0muFVSse+3Wlup1Y2gsWgIvGD9kTpj
    p+3WdpnpkL/DwlEWxlx8/h1Qc61mjk7U8WCVHvn5oD+k/CrMW15WepCbY/dzXysa9vkR
    ORSCN6xckWCYoeMY4WN0sHijo14peg5pyuBUAT+eRlp4X63XtX/2T69KnRtZ8khyoqTr
    Stlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792854035;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=QiyEV8UWMWLkheJJHjCp7+d/KfIAS/e/TZ17qThK+/U=;
    b=TNidOws0J0eNpLiXF7LuYSqX7woFCqrcrdul9xobtrDj0PlrJFAxmh2LcItVDI7P7+
    56EDzebItDc5bhxDd7oDHkpcjqkbtFIX1cnVLoty5EzpcHdu/72NYCAnoWL+D3nUaiOO
    wPRW1Z6VcAL7tL6CSs9/wT9PR885zydN4st5O/IDiomDGLGCJyCVbNB3lZQGI4H1rJ/4
    r+/k5k7fxzG5LOqryyilhLmzPWb0wScIafuUp5KdnmwJX8DPXkUECMCgIqc13ThgoBqo
    yBl6rXZFTYtj/s6xkPmwGN+AviTVWbjepKGzI5lcMKAEqMDf0A3Ku64iiwYnIWHUwyiO
    gWrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792854035;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=QiyEV8UWMWLkheJJHjCp7+d/KfIAS/e/TZ17qThK+/U=;
    b=g+1dNdTqv85e8RZmLE0r+HL3hD8jCQe4bGPXwUlVc9QSJ1YKISjqUEIP/RIDYjjYxH
    WSz+Uo32habvW+qGQ75G8kTXF/chrpf9nUHRF1DFWluNnTR79IcyW9oSErJ4l7HO55TA
    EdlgKf632n+5k+9e6WKImptZurviKFwpULDXnU9re9vIu7nsrq1QP6XO11hYofzHMl2B
    7YuzgQjG8zuCtv0iJwZJkk4xUflvJ5daZf9BZK7ROwu6c5Yv5sAMxYY6DLctY/8UzLbG
    9vsycQYubN+L1MKOPmwc2Mz0q0JGumj8arLfYjF17VUOVUmMVqMef0I3chxzFGqo5X2j
    /z7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792854035;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=QiyEV8UWMWLkheJJHjCp7+d/KfIAS/e/TZ17qThK+/U=;
    b=lslHi2VLgqBvS75X6jGUeWpYtn505e+B/8qV5pQcySGuWpZLa6QVIF2ZsyBPe8A6ld
    LjpRNFuZIBunqBTaMaBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzptYNlV1C1yk7253raiyx+O3Hxli"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229OF0Zwd7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 17:00:35 +0200 (CEST)
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
Subject: Re: [PATCH 1/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261023081452.44118-1-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 17:00:04 +0200
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69466985-424B-49E3-ADE8-1C2D94986988@goldelico.com>
References: <20261023081452.44118-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 23.10.2026 um 10:14 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's I2C controller is the X1000's, except for the register =
that
> holds the SDA set-up time (see the next patch). Give it its own
> compatible, with no fallback: a driver that doesn't know the X1600 =
would
> program the wrong register.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml =
b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
> index b61fdc9548d8..43de2856bf0e 100644
> --- a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
> @@ -21,6 +21,7 @@ properties:
>       - enum:
>           - ingenic,jz4770-i2c
>           - ingenic,x1000-i2c
> +          - ingenic,x1600-i2c
>       - items:
>           - const: ingenic,jz4780-i2c
>           - const: ingenic,jz4770-i2c
>=20
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b

isolated, it looks good for me.

But see review of PATCH 2/2.

BR, H. Nikolaus Schaller <hns@goldelico.com>

