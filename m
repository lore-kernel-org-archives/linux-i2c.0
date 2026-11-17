Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906397;
	b=WkunVClt2UERsgATZsOgpROeq1vi88XVTkU1P7IfU8Alfb/E70rdBNwCNKevXu90K8VF
	 q3EfkxSiCjt0/pp8goDQe3JC+knATZ0/ii8U8l0ksYYb8P8UT/ub+zKlyYH4L28Tt9rqG
	 szYTS8hPuid6Tdg3tHsGeXedtrKbnyirwBAoct97PsvMiak/S/W8qvTbonGKTgDoy0ZOv
	 cAp1p5b3DjrASiUA5nPeQK6uAnn3evbuQwoRJQSWTQdaeh8Clwv+X9P7z/5a8lcEPVxIL
	 eMr5irfyitvuQcbShFf0oqSNqFOaWOkBEhEnnhskIVAaMiQXrKn5+iJXdJ/v+EgvfQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906397;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=I+8yEespg5XcBcsaY7vFGb3gfFdCmuKAkx6YE7pAxYk=;
	b=DndyHaEbzSthB5r461GIPk9rmmirEExrE+SW1u6zqxLbm2CdKAKDPTtZNOtS1thjErQf
	 Hus08DMghpUEtVQfRTK1O/pBy3gV5QHdMNSTi/2Teo07jofz3W8gtlYH9TT2h6TZLm06Z
	 eGBVhDvDxMUQYddvLY7nCGhdi8VOlSZic3r+Rdvr7FR2K6HOx2jYxMh6Fy94VQ1T5qFTr
	 2XW6BK3satEFIpD7jvajOFznlQMWiEOG5PCW8Swo47ZvFWiR42FU+UQ9Kg5Enk5B1QGb3
	 JXIR2FRMlKxefyWiKgs+RIDABZLZQ7tSk0IErl9CzgbdxRWuWPOxcsTMYxkpqnnHsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=DsNVrXNi;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584AF606A333
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 584AF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=DsNVrXNi
DKIM2-Signature:  i=1; m=1; t=1794906377;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:dObeKoBa5i5eM0YGHl84blKvRSm2
   PX7x7szdnrIEFINpftejlrya3J7qoeCm7jbtZmp7bsAqF31zAV+b+iR3CDyCC7BJJD6yklKoiG7
   vdFeXkhRaQEKhBnz04oItRmcZEHbTcdAid0sobUfDuvUIVr8twsJZ6n18pKChqBdYBlB8lVZzbU
   O4d+8/PsRSf8IsFdi9fYFYAXmzUt3KzgPTsoiUMVLOBJmW0vDj34jteud614Rrjua6AE9pB1LHx
   SP/p8hRX33nerGDzFeuC0JS8+yV0Q76oZFyBa/zy+2MbpwtPa1iXiX9TOeJmx6OkofQQkGCf/Sv
   o01b/1H+UcMbdQ==;
Message-Instance:  m=1;
 h=sha256:
   buoo5jp7CVGQnLr0nuK0eWOHi8ROH9+CqwTX4J+0R2A=:
   kuTk6/qCmdBJKUBPXIadJIVpWR+ITdopUOAkM1KmmSg=,
  sha512:
   sxFUKM41psveZtbWCbp6BUb9RAqS0l+DBg55ROWw77UAMHEtnK9jFVL+4cKYxuaT95+gpBbni0nJcvGbb5T9+A==:
   cHLWenvFIawDiZyN1V8INX59tOnfx5l5XFtEbvDFl0zk1yS1jA/DfE+MSlXzdVgstCQcvri2ltbihjxapEynRA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794906334; x=1795511134; i=markus.elfring@web.de;
	bh=I+8yEespg5XcBcsaY7vFGb3gfFdCmuKAkx6YE7pAxYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DsNVrXNis3Z3eRRBXYnyh4tDh5i57Ble8/8OpKXLa9ukIuGEsd6igWAf1AMMiy2/
	 WnT3WJOygZ3Kt1hYn0RkgenW4/9zK933bxp+ynORVrvyVrjNl+f53ef1zcono4TYh
	 9M5s+HylM6Pwokd1/zzyltT1lkUi1fYKJybWqHS5jvoH+0LAy8F23tfprj1hBlky3
	 g0lTSthfjf9M278+cz3JN/2AlMsknRCZt57eHdV4cr8zQzQju9YrhwFKt6FX4b2KE
	 cxFGPxFjxn/svcGYSQWgTh7UJbK75sBBrwOPoWhBj49zc1GdseRBQsLnA1AReDNlz
	 SfOtFF8O7lg7GQJxyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1xRaR2398E-00FL6n; Tue, 17
 Nov 2026 10:05:34 +0100
Message-ID: <78d4a042-d9e0-4b88-8788-30310462dbdb@web.de>
Date: Tue, 17 Nov 2026 10:05:22 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
To: Junyi Zhao <junyi.zhao@amlogic.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
 <20261117-a9-i2c-v9-1-7b303c894fea@amlogic.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261117-a9-i2c-v9-1-7b303c894fea@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vIkcQNGvqAq86yvYzVxpFg+9WCNqqkcgnuS13D3on90e8sqkpQW
 O05bJfmzzpXtomkSqatcM8bM/be02Rum08y14OMpjSrVNKWtmNxPqNm/3m4Bruq4gN/dtIU
 rPDNagjBdvWowhnVB4u2EbnHWHIoB/32jqrt8e0fBB/SQSlgp6eJMMxDmOv6SLqq3GoXIS3
 ufYe8ZI6NAs1kyYxZiXgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MB1U+g2ClI0=;85idkiRJJsaVHn+9NDQ5d/aZvsq
 KmO2beUV6cCeyF5E06lIche72GRsHLIqybBGUZYHj7eF9YmVIJmBPo+L8Gvg8Hv8/abcCWl9C
 vjWPfA8OXEA+1kF/imrAMfPA2G3NsS5ovLGAD/RnbLb7+rptWBY89Q6+H3gKwrAo71MuXhlU3
 vw7YJWu/LtiSfcO+l4kwtqAzUuwsYhMIfkdNsfi/TQnLaqRreRxLJi0n9Y2W9fcLLKTRTwXVa
 wH29AepkW8Pu7yHtzicPoXNLb68nWaEEWEYyL1OKPjW20irgOBamyAqnjgnWXNs+Ifzvmpt/z
 JsuQEnj1sU8zkv44oJxgtpDJyX9EwmVspYg8uI3x1B53JkG0p6XOwyNHd/KnQ+n6NoyY1dWRO
 hjSeLL69yAr/zuCl9TaCsENV9W+3rn1PHr/jyT62blfhWUg3I7fWbaxfmobp1RQjH60uG1OyC
 ZHHXxNeYG9Gi9/uEHsSxBXThHbLAfeOCrTWninFqM6hhdE7a0nVfctpq8eoBm6zRMZ+Q+XQ/G
 Cb09pTw6XLbsunbWaGe9RbgAk938EjkszcvAxQZgURf6KLQ3Wc00IXnDsFPa/+KIaozXp64CW
 WGvphnRNQAiuAWP1U2qiU+sMmJoEQ4XJmF68DCqUhWRgkLWTC2eGglTdP8uypa7+N/oVYxWSL
 I2Gg1+6OPZH86TlsOTRK7xaY5D2y9XZFIoFQnlcF3PTyGVFeyfbCUYupcSRb4uknWjGUpcEG0
 jfiP6ycowyMkDt2nc5yhq34FzFAjVGeAJqXGYXh1IbWo2eINmZgPG7W4g2zj4I8MiDTjyBcvE
 44tflW1PfHSImWG2lDdKcVjPi5c6zd72/sMT9t5vY9lcTcz4t7pOEdyQsGfVbnx8sDuQwqKRY
 +csRRbu+8UAMybuCUSomuoLyFVCyi4kHReJ6iDGscv6+jONTqHEk1rmx2g3hOmGVMWywAdXPA
 i4euIzPda65HL71RPZDzKwCSBII2bjDYHzCptzl70fgK5Z5Jl2FiCEomjhiXmd1kDS47m64DB
 OjdFtWNckMiQiSDsrwcIqi4vWahhTGzsC3NuCCF14B9uPv2sdowod43Nh/RbNrvu3yqsgaOhv
 Qei8m4Vaetdrv9E8dCJEBnsbOASuttRjTVhry559lh2nHDm/M0ttA5j2bJTP9vKrE4aYqrZJi
 rl6Y/qmPHdyRFAECpn6DkvezVfTDv8Gb58x8n/3FkoVEJiIIvLHs5+ef0n2Tzzv5+z1Cz10V6
 MQYaknlcAZ7pQf3U56QQNuTqbaWUK8mR/tAanBrX9kf5Jn9kuLo3g3ntIv/5w4LDq7Xougv2T
 yYdfpVgqVKMZCJ5xHJG95ac6m03M1/zcbEBejsYZ7Jr5VyP24cqZE1Ur2un2tMnN6bBrWXapf
 qYC1nmg4t3UA51ub7ZQHM3EKZfTe6kUODK4/P5/+i7/HatMdNCZc3bjT9xfXeYGJbfe+uIYlr
 Kf2OEiNY9Q22RBrZMokN9CTTrZHulkbV+54aG327ihNKa/jASMCIWU0YtENgQf3V0111MmAIr
 IGPNscCkztpD5AuIn8FINTWkd5NxURcy0yb8VmfB4/2f3AL+n1S3YnHuzSOr6Ahakse8QLsb/
 pvta5a/TGwkmJMonTt4bTZCg4TQT8YpabvHMVUZbohogrEyCHm1o3hbsgj2oMyEPUQhThXJJL
 YTtwI0bLlpKjcdLiQKxaYYedBTtHAFCg+sxTHAm1qXOmmeWdjfTvHT7GSo7Is6OAs/GVxLDJa
 f3siQxG25HMx2fzh5sQW/WpmYo60k6mkx0zYKMLykktPBcZdtaOHk2Aw4YqVA2S8dgEN2WMYq
 l5kyFwuj87TH8nvb0GiRIFjohSdI7REJFPYIrD5gy0i5VW9fQygMHLOfUA/c6HNGdzIW8XmNm
 8cwW5Z+LVdE2U8UNBAD/gulqerZ+hD6uVH+484Jwlex5IMKmFx+7HXkomRKPt5mUVRqJrU8j1
 jcBdm4it4fwF4fMYfIeZT4s66OUhuwiZn+3lyiFVNO4hPc0TOldSpMWRf+NN+v1rtus9zgdW+
 lV0uR/1I06IF0nXenO09Vwh3Q20AiPAKfNvXKRdbOmjcQqamCJ+EyeZ9q211ferLgLi4EQtL6
 9tG0T7129kfLJGbhOFWO5Yw83PKdbYLsECiwNb3viofJMKocBnZHVyDt+7YxOwtkjaImf7P5T
 32cgN0YE0sV1DXXWhUiWFzsHDuNvxKU2zmsIZSNpHmCgV+7EgyxXodXC8IdvFE72P9+UzzEGI
 cp/djapA9O4dZABLPbLmRRF/2hBrSf2chjeCDKKMpRMArm5oImRm/k8KSKgZX+0qkHojWoKzp
 Kxp8TESbwZhyoZ07mZrYSS9f8ibhMeULLZehD7HySZk0QMN9GSwcn0I5OJ+2QQRacVklTJ1uj
 I2CJ5Gz2zSaWstJRYQvPA/lMHXzHgjayOkUY2cEYsYxgpiBBu103fzul+7JU40pnyivaggr7q
 hhLICCVjliSFOI5y72YFDB0SkLwdbIjwXLjGQlP2McW6d30ygIDN5I0kZIOlsZMqYb6wqpzZQ
 BaPq0Up8JWtuu2NIgDOnpHyd7AOH+bU/3RQgUyE0qz+myRa8AdXoPqOxS7LSir7ui/cpMvR93
 UgUbStwfa7yKpmb7TYc2lyS731n1Z61ylrmQGWnHHFzIOoL/Hs7e5YThwDf0/on1e6t/fh728
 9BKMp3zNoKegNRfEvy+rRCXsJ6II4WkazlhKu/30j8nA2+W62diFrhWJckIY+gN4ZPWJ3DqtF
 K6Lf4XIfXag98kk8199TqCdZrM8rgdtZ6FIHiKZ5yOOOwjsu+Bnx6gm6Jg/eAvMelSII8YKa/
 aJONwGpMF9f8A7iUCxsN1EPXfqDi4hGW44tmfd17ZNqJ1jLa39n7iqJXGLeKJT/Th9WsXXtfo
 sYnS/1x6bjsaARhxQrok5auiKXADp7jZNs287sClui0BrPI0Gm+9RTVPxEJtKGnm8nfIPsDYh
 BdpsZOTTur7lp55LGiT2tj9CmQ4apMpmtLjiRN6jWSv6c/o3GNQOn7lr5YMFsyuJCqVya5nGi
 K8IwgTLLvjPvBbrfdBigIKqZWgwamyZ0AxY2s9v8Mo2nbdQgg26Ed8G/vRLqp5DMsGk+44nto
 6+JNuJ/xPkXeuHLu+fSm8Bk9DLUqoScWROPDXQgF/XHUA9MRRosac+N1IHwOGaW5rIYW6JBfI
 eV0yUvqdUeK8yRK2cOY9rv0ZpvXFC0NXIDB3zYW+NUauZ2/wPN/f6h+zxIlZ3Ah05BVRoAUyu
 0y97KZw+iA1pAw1NEXMmh1Mlr4C/46WzPUxfP0goLR9tCsyXE1+qwLNMuSmeIKSC3JQZZidmM
 pJEqbNXZHz9e+oxYIl11N11wV/mw0cjpqP6ZDIN4q3pT1vg6ifYHWRuKn/I+EnCwbZB8JAFQw
 eiVFYhqoduKwk3Wwfs4+Y8S+dO/UBYTH+M+lHMrhbo9NVnNRZPANjYm5DfTgxNyhlsHDainNe
 Z7S97p/O9FDNlxfn24jgNKc8vTx5j2JuG1SO+AEiMjKfKzGIRxxHHFsoYunOptDfTmhpwoyQB
 Cv3LTZsiLXlGKxGOodDvgkifTZ3AOYstk1PjMP4O7CdvS3AiOpgASYzbA/GI3FBzhbNTuElsG
 5m6zm3OYjZLH4kL0OAmRxYhZYHxeih2Oee5yAU3EZ8njTLuvTxi3fr6OZinrOrOYO+21IXqTO
 KXTgzhGhzQ2jHZEebH8wgaBTw9wIvtHF7/IHGzc6PIGRu7TsiOOnkkfMnvGw/66fcfie1CZZb
 2CN6G17PWjAfYce5Q40GUcR0odX0ffqbSKhuO79SK9aVvUyYu6mo7hbW+vUuSo1rDIAO2S5Gr
 CME87/N2mHujlloQNt+R4krElYA/srWZ2TsnKgUV+2Ija1AGY5u4LOWYRFTvHSTRvDaj5otej
 o40Z1IfIbvpbR/U9bqAnYO7cVTsZZ9Ow0GoGlqzBBw/3s0Qz1j7B+p5bLjQmdcbO6sHZmCC5F
 AcawoaUAiZ6xmts5OX53fRMwD8xWjXSFFP5aUalQfwxcdy8rT4GgtDoALYN7fdfaU4/Ks5j8o
 Og5zQwPrb5pmYZ6cuVrVNTJQuFQlTA7NLaMHt9HmhUWTljKDJ/GINw5xxGu5oEhhyAxNKYg56
 9SrdJ033xQeWO5jqfrc2gvlN3vjnTy+CxFH7+ZqrmXwbiREsHkjYPoNdzc6hvxetsJ98Hd8lP
 v83NlAgimajyqwYxrIl/yha5vIZmDVrok57hbxjWPCo2g+9ktYU/A+YuM2zZ3Zsb36Yzpp6EU
 achE39CFpADfdxQjXx0ja5OCi/OEHgd3doy9IUfJICJcVGZtGUDbvS2sjX0J6qAsa7pYeoCw6
 xvpA5lkSB4LpQX6eo9kgA7tRoYTctKc1n2u6dZsynyNyffhhJ5U7yCkfZCk0kXUhHv37u+X80
 f9c9rLJ6pfUfU51j9XTQy6WbO7sFWDRWC5jiHHbI5Wz1V01uaxmeVacJPj/HWLYCDURDGrrn4
 oAR5VKsqGGjIeiGOZzXfn0gybCwFPe0vHynWP71GNxbGwwGz/LwwEQ21fbD4rUkUbczRT17mY
 MvBA3aYlxABg71quBMw/o7rvBGqvTkM50bm7gM1LOS5/ec67sfifQI8ONp3y1oaQUVWbZk+np
 wGIkuOaY3nU/2Yh3KuWlS+i2UbnRfAq3rhPGdwZU3f67HGLHN7DkTWUsw4RdIdaC1PZagxl/8
 bcfF/1AkKJTs/Uexl9NGU5p4PKupmW63qyLtbQHR3jf3fKzBIP7CgJJf9ugQ/2ZIME4fc6RDE
 08DhUAUQ1S/f7lValCvMUREP534bUYD+DUnsp/8zVWim+z3ItgI83ElSa79eNRtCPr+4mLkS3
 O2LRJJaAMop0Sw2My0Es69y0cGqIDSiEG3m+ro2goa/qolzCgvDN4NBhMpMm8O5WI21RE0ogZ
 NHVB+pm36+QUPV0SvQakTQ0jOmL4dIsBse/2InzVXiQNr8jjVj7Z4KvneuQPGhC2c2vMqfGP9
 CPX2CgxD91ExQ2KB2+27o1DZth7pGTrxF0xmfJelmILoCsnDg5mvnb3ogAMzfDxma7RD52Tcm
 V27/XlMbwpaqgz/v/SDqpfhXXeSkQn7JuqcQbVJybX++sA/Jit+PNR18emGeW+WxDeEFSM9Su
 d//eaBDJF4EOfPThz7ejiKvw2uxgBiyToJ5gojZ715JAt3WkXIUaL5oqNRQlQgVEbPr2fki0a
 +rFssnv29mveVEQfl34XQJ4i18n4+4lhwXjzjmxjLblYMTWGfERukGI/iuKpO27GEuFaOkVh4
 c0vvWfVZZ92YWLnZIhBYgH0kZaC46/NAWLG4D2pE4+yhaXZHE2DmgCAWrXekLo+WXGE4FsFkr
 RtzleAxDZ7Kddcl8enIyFNX3cMoRQx2IlYcS7Ly59zUuGWGa1LWz4QEvxMIKgZYaBz5V6ybPn
 K5Pe5HTmsoy4/Q2Xd2CVWvdCcL1r+mVTff5jhWpISMhAnyk5sfnm/IQTs4iTQXXCK9tcoMcAG
 O59JD3CPm+XLnJHylS6TpqRBKcsZTg57GvWdhGH/lef3/AgY5MpmI1m82y5RJDNCfKv6wNjR7
 ksJ8AvtTPQ9knX9i1DOP3YPIGhMk5hOlVkD84W3+H0Uia+rDEyRK0mLTCC51i52PNCedRbgnA
 GiqKGUWduJcq0WCbClXNYNxiTk6J7MZ+GA5velqUezEzITYmJ5K5AV9x/tYWRlNbpwBduqELD
 9d0F6vXOWutKmwKBI1HkmK4QID89PsmOnpw7IX2fuBnsoZWAFabHOtTvCdevRyMTtGjdHU1Nq
 Sr7xGmn5/QSPUAB9KeFAiHpw18QdhL9xBbyuK24b+pb0y1jN2NhJOmgEci9O6hNMSkCDfZYVC
 DwRHtZUKM5udGYzg8Sbx4lqd3kNXZPuBp9/n05S5CsEGPlB9dc5nCSxWaAAUWWDVrB5QS9jZw
 7GK2Ri0Uq0YBcNmkgNC+ISmbeH7jnn6uBpqOgFyr+ducKu0HvxLXSHtK5QglZQOpxGSERnIi/
 VPjXLxrTZSAeuhTz8hq6ConFHMCYAem/yZEwqXY8FwN1IOrCW3oG09IakTP1Z2sdbIGBF2BCp
 SBsgWe9R3NLfj9lBg8nQTdZ5DIR50MDIfk7GABpsjdTf5gSE1I5lYTENdECVeMjqAkBpsvJCI
 uvc/Jjt7l90Dpiyq8A1Ynw7Nv4fSC7GVsK1IcBILJXeJUl8rT3RMq3OwzOnrsaMAovalTpVHP
 sL1IDIZEyfQdlURZzsIUayegmxUBIA1gwotG14qKZ9J6+62dkIkx/n7XSD5mv8zisgohZc3sk
 FCSR/U/2kUU8bdPGG9Zx+8DyulHuGhopUP3HxGWA1MYH+hXesUbJ/1duxDj7OXrZpD3DjQisb
 ceZPVV8H4nUFZf+/QbFTveEU9LtGeKpAPiySWx9453VawiTOumfeK52XhlBhjsNhRoYu1Xdwd
 PxUI1BYjIUA4EZAbALAiTaVK0VGaxsY5J4q/+LPQUJL3T7uUPBX4qr61tO2otprShMImhIsyU
 GAw7aCXM4OsnVmcGajDwMEieTjSvC6I8N+ADdn1NpGJGzlUnTWlBZ+B66cm6de4XQoOIxsGsF
 WFsskoNicuoj+Uyq5ZFXmffsfkjY5qFIX14hcdroscVV1v0Y5UwA18d9LsaYpniu8MIQ+GO90
 LbmfATuO8Ei7vORGJ4TT4U2qkwyVdJtTzuckFPb3wjBWYkboFxHbNspbrqwFuScnJs/Q2NSL6
 D3sAE4yY/085aeON/rmWHvYJtCMFlG4YrMWxKg2VKqfqUru8gWIJXafU0FZZA6WnnP2hrL+us
 T1rH0U0Rq+TCTYIhKkyvvZEcF6U0UaMynOR4gGOn8kAgz9J7CJHAKXXsEFdeDE0ATE=

> Add a Device Tree binding for the I2C controller found on the

        device tree?


> Amlogic A9 SoC.


Regards,
Markus
