Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910012;
	b=gD2w60DY73AteYh8mY3fs8FpHk1PB+J6hLIAe80KEFnRrwROf7IdJnUukLLG1fO9UG+3
	 1dUmjjfGfq22aXY860kqRh5Y0jhrFSiMKS7TKu/Yy4dzlgP1Gf2tCDRB6g64jAMdfMK/q
	 KpjmrJLQluhXoOaCJd43O3O9wvCGg8iu7p3gsdklQky2UqHUVoZIgUdx4aRYQSAxlQ0mX
	 3k1Pe4uHyPZmdgguixAxD5tJmaw2g38cm+iOsIsDzHz3rVD3UgTe2iJGh3oPaSoY4+vWA
	 3LBtTjUJGyxqTGAn5dx4O5UWSJEnO9h8NR2id6SK8Hk0vA0kWkBYzpdvZGhJK9D6cog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910012;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=Ntr8PEGmlRO3PYN06EGTXmyLQ8vwRW6LTHIMnPTPO0s=;
	b=rEyA+JFDZwEyjTSBo8nPAMkfeDYnxJEKuBpFXwdHBXYuXoM9kUACo3JI+kjYO/DqYchC
	 ZRvcxehnuVhVXCZl9+ZyYJ6awOaPDf5nbjUwL/eN8KDdkCU+kri6EjQb83u7WSQCyODLD
	 dXs9X1ySdXNZXxjg4+hk+mrKXSkTZhoOQTalExutT+nKOAUBoVJgjMsdQuwPnE3daVpCJ
	 qIiQtZmQxEJ4UQ6aQ6UidFAWdJKUWkbvLMvEIneSVZZGkZIO7OqsFJ48xNW9Eg8Bdj8wL
	 359Ni7j1GE0sJ5n7LrqnIqglBoVO2W0Zelr2n74VmYPc5PUVZU1KeKj8epZr2fou4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b="JhC/bJcM";
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE9606A323
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BE9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=JhC/bJcM
DKIM2-Signature:  i=1; m=1; t=1794910009;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:g+qFO2SHejJTQl4kHVaMp2i9/x5C
   8jrngzpVYdFqT9vV4Ci1YnlzOswSU4wM3D7RVqBdfvcTsuDS0dXgrQYPpHxOsF6NNjYuuC6+iLt
   GNHtQtODDKYpvRakIsJjZvubCIgt5Jn7I8XdF3Iy8tmuUwUQOsOW+pXGs9Efw8PESQEeID/Lt1k
   6mVaVpxrDA/kDNj0COgm2hNEy7MdjfbPjzljEwV2hLhvQ2lbr4NnvptAth+Qhn978SQ0OwShCTK
   VlNnn59uAJvWIm4cc5nPLFkPlRdahle4wrp0+P6crP1L40J8G1CQAWcMyyp7Ki3uylo8oTMkC/t
   BzyTIiEYY5qoQQ==;
Message-Instance:  m=1;
 h=sha256:
   NKwsYXHmqn45NZOrpyyw14aRH7lfrzYfSuBhd2u1XrE=:
   Ntr8PEGmlRO3PYN06EGTXmyLQ8vwRW6LTHIMnPTPO0s=,
  sha512:
   +K4LXoqaAUHdqNUnq7IWYxJswHnHQOsEjNgcQSPIqkwNcEMYzuaR7HvXKPJVf5LF+onQ5RZ/tgNw2x7HcwEx7A==:
   /KGLbByOwim0rlrxRqe9NvMW8BXKk72i6ciKjnbFhNtZ1jxjhiWpGYus6CgthVxcTy+TTHUP06kZuKZwMdmEPA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794909975; x=1795514775; i=markus.elfring@web.de;
	bh=Ntr8PEGmlRO3PYN06EGTXmyLQ8vwRW6LTHIMnPTPO0s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JhC/bJcMb0R/bGRDiJmM+ffSrmcNwTFQRG0c+1JUpC069/8riRDsqbxaOlJqtVkG
	 XEDBRg/bf4DM43ikshlBPYwJUMZLUN5a5+P1OBuH6LHzDq4qyTq+0QITY1B+ymjPn
	 0utOMalClBwKD6rNN+TwO8270NoLOaJgYWhNxICRlB0qY20seAbJ9qYqgo5vCL2tw
	 sHxg0fMxcNsH0c7+IuG3QeYIYYgrO4mGMbnRJWgSZ8tx0d5ZKqa8hg5xoXJIVsU4F
	 IpKtJHKISTxBBBH9MbEBqcmn4dRzrtIxYi2MF7DAAGhbI9UF5J5RM/4np7EV8CkVK
	 1jgUzT8e1UbDhySHxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1x9oLv1R7p-00LpF8; Tue, 17
 Nov 2026 11:06:14 +0100
Message-ID: <54461ef0-033d-4ea4-b160-7da5afd34a43@web.de>
Date: Tue, 17 Nov 2026 11:06:12 +0100
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
Subject: Re: [v9 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
 <20261117-a9-i2c-v9-2-7b303c894fea@amlogic.com>
 <7026e0f7-5d7a-4756-8783-4d8558f420d1@web.de>
 <cd3d821b-1cc7-4134-b902-1f05ca2526dc@amlogic.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd3d821b-1cc7-4134-b902-1f05ca2526dc@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:crGa4K7MsRhzUbJBxp8Ypw3rq1AOPWH2iznSBYKf4fNdq4wDBJ4
 UYZhuLGjiu5LIZ7CSYScYUnJLgLvdjk47lC6vHRLJADfPfwOQhH9BNvoKB05fZ9Mb3hwRI9
 ysfLQjbtVMHQngFhEo0LLjjTVgPYp0V7t27Wket/eJJZw0MrItacect57x1xLP6y9QjzHHG
 K1NFCKaoidZlu+C1HNdsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ajIHWB4FTEM=;2N2RvmtFDsr4MXt+swrX2YDyXGc
 kSlaiCD5mWW5dEioIm8rWviLfNMAMatT0ddgrkqA/78EJuKgUFF3Rn2v6gKWvnTM/UqFY39JF
 GXRGfAWJL7nP4UvAQQUiYOzmthOLrAF5mddvMWQNkAeAVpuUGItcyy1rzgzB8GG+4u4IIHkFv
 dmG966o12txBqACTE1fKgfglJf1K+xp/YfSv0ZES4OqaYrs2N0+4Mw8iUnWZgHTCpw/jyxTQw
 0i7TpV4F9nodwKRCwRBLyiOuQ0dyI+2ibfZfajTb2S2q0KcDLIRvU+o/T/eXrbm1VVhOlIHa6
 50mz8NmMPrIJxSHTQeIJ1uDbQu7CoH/53dNW6bboTFEJrsvNn39ba1Po/DIpfCW6uSvIGky+1
 iV89765rsFws2+X8H1feM6l3kpemwcifVwyUEtr4LMXt5M4qfmnVcvnVNylbjSj2qTaXhWiGE
 /MpfFSR1uzmW4FQbpl/4S8t9Jm8fbJJ0CQ1X2Ac+4rieQMFSvlzy5YzcZvaWX9ATJizKk5j+X
 cQkiGWcjKKLA+pIY1AkCwFEbO/OSESM0HePjUg7lCzl4TLiBX2mKxQ7VuGZNlDtpnjogbIFdc
 3RHjCHtiP7lRUCla22W0+sVDy/lMpIAVSBDFs0C+X6DlP3hyhygss0vBU9ZgQG+S37SYJqTSr
 qP04h7S27GtyB86hRA7cxLdhGwYCmwIlizBfN4R/S/8uB9FrKVGXTIwexdeLQFpGpTwu2dImC
 bu5LFxTgVsi4UNd9B8Z6XNmksY2NbfacsEqL0+tbjsd373IB4w7gHFQThSeP0Bbj7u65eWSLs
 yNkXXB0Ud8dmh8X6IIDscarb2j9vw+DUP1JM7LoC7v71Ydb8RKaM0RmSe5DUVyQRLSnfd7Yws
 BDhVBnjkOD6bkm0lh3Hzs6jIEJks6yCJYX9QlABqC+up9Iyc7czspu/Y2mJwF4HuwlExgX5Ke
 Bp2EeBKahbKqnHuxgVnQqX7+oKG9P57J7y8yhbOODgdrTAwYoi+Hy3TcVjMjW05YAcxacCKy0
 5XOU29RgYdfULjflgl6Q0qWvgmzBTX7TnePBw/9f2VtBSjw68Ma2CqYAsVLalKqtNatRaLvhD
 HiMohhD/h6UGp731dpgV+AL8OPpf8FA9uBVKzsJN05tTZfQc2fcbn0/kQtrsab687ZqtP7uvK
 lXehVjoG4ddzLXArR7U0QBFMtZ8eLVF5MRZdXqGBEs2RSggH6w98J5721k3VLUs6R4rcRofbD
 6vn6nGHcSqxrziHKEyCcN1TNNDbm112D0CJ0MncQaYjamsx316nXkCqANVn6a4Ud/6K/Skl2K
 pyp/tqcE2ahZ9/HnDYasAJ1vOWWdVGHVDKBaWKEqISnaG1zXTSo3TPmJqh6lRPe2OCWAkpxeL
 T7G5Gydh8FUkKWKiP9mtTJcshNwn0lYHLZZzxB+CwQimx76jpwY2PBmSFjtBDBgNEyFHS/w5m
 bikbxGYNMk53O32kJpvS9M5Ea04QV+BkiH+CcVhEcYcXXkPuCbQbExbObvze4EIeC/1/THgqi
 9JWUnBZ/bCSmPZZ3cHyMadajh2HyoARS4+lvUI1/hylfKWrp6+HlInPBi1kU92zdumEN5X4BF
 Wac2TXvSQMPEy/rt3Tv6HFBfaX9ZcnG6FZHDLGIY2OvL8M54ig4mzPt8Zce3LjDeZhtdf5C1e
 +FE+uvmp/+bBXNxVxZE8AsURGyXlmokv5GTmW+HNlPMVpz0AKKtkGbByzojFZ7zGDhVWzcEbc
 m/+X8fxjhghO8CdgRW/gLt6+GaChlMNqSRKL/WxkFtHl3o5u1ErSNu0v4jSaA0ioDX1eTwChH
 4tcUrmpO7R6+XwtmObnhZzS/SMosE61Jc/iGDhTdcjiZ2jsavyMclAUuvona8Gyl3xcNOugOW
 slCmqHLD86wA80Sney/UPZpxn/2BgiY4GojXFK8n0PIUcH/V3uEmJBpsfMdAm6UTEbkclEOsO
 C1fXrlonmAiAX+GJYa8/gclprhbXHJp24ldmTV6V3EqnAymqknH77P0X5RCHRMNCUfkB4R5pI
 cjEY91AAecel9v6loww7uzBMiRYvuYNXEvDkpmJGWvz9cGy7qwnBc65je+NPG95leJU8uTNQ5
 ryNSykplNkO8hvrgc9Oy1Pa273y40eYZAuv43IcjiqvlFojJsODoj+T8L8MT5xJjDeGGOI+5N
 F5vbnlUHuQqKNxlUeEZOdFyD8sfm+kfpReDwaw8PoOGAnefF5dkd5okDR9OH1jZ1n6GDxM+pl
 CGmitjzeUGOzJXSjVA0WGBQHQvfiQGmowuQglMhbQeM9H5JoAh8/cc2f6koIxpipTYt/3VGpH
 h68SzN/hxpylWW6aI0TcKZlG7Vfgb9uitMSYRU07fXHV/X5G1MZ6E9fti8T7GEu4QnUk1mk4z
 o7S3piuzWDOdPPIkB2cWtsMRDlO4UXnIuBe9QYFWhTYcE71jLtEUYenn0gT/biKvwoAfQVLE5
 PaS9FDNyC5OKtlFXqxQxLeBjxzrtap7SVaG0gVjcuqHRoeMrndfriszFeCJ0EGVAV70Tc9LlK
 7bnrb85Jdx2aAkkhOETWHliV2hZFXxAvNmKcT9ReeQkaHRm4Qk3Xt9ova9+wdor6FAkrhGIRT
 A7kNI1KsaoYhghFb4Ypig+koCUdA6UK2My1/B0DRTCnWM4Z742kC0VsGsJ+EvkTcdhPrTfQnT
 SqGXlNoTa2MoP5fBOdUbKGXjvs6/Q756HNd9RYDfmg0ShQ5WQxZG2zc9k0wxTNpnJlSYtTOX3
 vktK3A+mnDudRnSclIrqJspagXTo9JOumt2/cPhT4KD3m45ISiQXl39qdZyi9XCkcQlZXb7cn
 PN5/zRvXFGn6OqPXJMe68W+39pegz2iDviP2e/jOXcrPaPtJ5fmkrZ4WPxCJIH4wXW+MlzYf3
 yKXGLMqpLA4jkdA1LXObTwixJojelUvySN0oR3+NhhHNJUk9Z0d25bY94H0udvmFtCAC6ZIQE
 R5X0temIgFVuPMdiDRC2rkqUr6X+x8G/mgk4LCVUSf/aWqe5QBXPhV9jXOD3krT/CCXVWZ3pl
 a7CsdvrxQwFZh+jovoOVLDz0yVSmzzUwG5iBotDDnrkiFzIy3NlLSAb5S6Nw8Fz7XrKYRRjBC
 /v1A5aomYaQMYkDHN0xVZNFb/XdZvg6PORkgHE4DX7PHilLJM2zLrHIjKl1+zhblT9hvRr5dv
 tvwOMYbLGv3rZouUDg3f1sUQUMB8Rp3Vmi3+GsH858S7u5s9/d08eJ+Da32vrBNex/fIWmma+
 O0x7Y9moPAUOibZymv43NAYfIw/FRwAlIM13vEALrziJ7p8zPJo0PxrAln3R1PJFZmxP5qhGJ
 X/CvubNwnZuzRh/TOryM9NZfi8OxhllXnCjgSc4NMTqnFwhmn4wXA1whUcsoDReIqT1QqC9+3
 Ljh0ol1YCM5Jsxut87Nh+FzMn4r4vP+mczczu3JtF8QF9311s/OyggPshy8TcXiFKu0vGwatj
 x6N3lLYTAXBJT0iSpcBHcxsZioo2VHQv0PXiSWKVbq5e8Ew7TnE0P2aI2faLkMfOJt5/xKxfu
 rV6ZEGizwkZ9fPkMhP64DtMDse6nrhpPC6QKfYDUBnIgGC6A/q4ST+UkAOi3ZHaUzqx+j6/1S
 7uUx4yVmCwC0LATIfy5m+9TG45sOIRBWh4PLMmMzVi6GWU4W9nXEGhW7WT5kx2icK5A0639af
 oEjNe7y0ihRjG57MQhW2pcB1rmxIRI3ei69DbZS8x4Hzw3bAyJDsmFGJxtRoaTCm36hm7vZoD
 RqE4ZiXxe4LcSYAihaX+VMtMtzOwEirJh51aJ0Lvyg7Tu3to6phzNjLGWWVEeVrhW6eUVS/T0
 q7CaMZbBPyTrX5kUBWqHUzAj02Vfc6DcC2F1L47x4WZM6mZMwsmGj4W3avL1h0CCqd09Kpdqa
 KjVkEaRvbx9NoX82/wpPPMs3wDtwpl3lE0TtSVolyJI5BD205A/uf4ypMEB3CwxYcd3l5S/0E
 hOEf0U5Bm51LJqTAqOPC8Zb/oTld2f/WpgxsLShLyW7gHWa4l64pvoayFHLHcZ5Sbs/6Pt+bw
 DpxmLYPkCMEFL9QTZJXiiuABMTt6MUnyDmadPCGvKC4j/BS01jQQQokKVL504XafP6cEILIn9
 1XRv+rpPE+VKVJm10HFiRoP32p7JbMCn8cuDMjomoFeIa7eUOMK6/GkN4J8FkpC5rxlmMj3yS
 U2fb3MjImAZoDlmEdDK2aXm30AHpPnOGhoIGkSU3spPcJwncd7sAgxTD9fK00viWVR77Bxn7o
 1jrZlmDmKwignfz4vDO8M2VfrdmAXfxk1d9I2PqxM932WgOnCKJtdO9e0ZcQVFAzjKn7JCqJy
 ryFzCQiZA1hsQHCIUx+gEBnf1uKgiU99JqeVfvBOTVwiW5FQ/C/wrutLikaLGeSGmedm58Zx5
 HWt5TDpL9g70V4TeYrO3hRHjc40IqwhJajXFZyBa+6Qa176bER9xZmr7rhu1UnBLX2YMiSxQW
 FTgmU5rQWcRZ3VbvubN5cioaCVqZGgVfRKJsilz9puAt/jgdJ2cKnfTViyXlDcJK672RU8kqr
 OYnFtqLpMEhyr+z6BpzsBspofaQVOS1plov6pe0nWFtWECYLzMEDZHGBUi29mYJdI8fOlAK6X
 ZhZntvRxTzCNhc1y4XFqmULapD/12/JZyMSdbJUqO6JVEPmU3vgMzpq/Z5octyH3KaDqbuTfx
 qGwGX15gRALBA6Q5Sp6rZrdHjAUT1MhGZCFgLtvi/Eq4c5U19UEWti+NhkUxRBGfmfiXz2XkA
 lNdmHjdHhsJGQSpX11eSAnggfX0ZvjVX30Q8A5+txLk1ICIhjtjre8O10HZ+gpav51002TnK9
 OGmC9VQPhGdVyAXa8NTSKj4nsUa1pLHgjODggxzRfjjtmvH1mQdT2NKp4UmSZG6BbKP/A/fid
 oH6e6Pnp+gehUIhVIvtg5QhmGF1t+wjLcuxN6APFc1H/082xc2jxM6Cr1RH2OrtMoneSkcqeW
 84DCnopC3VG11G9XQ+Ws7D8QK/CmCayGQFM5YvTZDvbNcI6EQXGEjqiAftzGG6uRl4hqpeIOT
 96z0xFr0vKkWvSBtxOkg9wlNpj5+HbIB4NEF2V9F1Apla7kRaN+hETrVd8A0jqy/KUmL5sxmU
 CW22mG7fDfkSew6l7UzYFxfcYIveH97a6OfQ2fXuTKQf5KT4yPm8JVdi+vi4mePguDpb81GB4
 GbJdhhQF2vuWkC5QPf/Tw5BN0F+BUj55MdcWTdQur5OD19jY8LtLQKVekrVo9pZeWwJtysMxq
 EPuj/nlrRO35ulAAPjZZjsQnNhnB+w6cZzoXm0/7LUfvt2fB+6I6nYvg2Vg2UVpCZAvhz8zNo
 oSoEU9Yf5Xb1PKxxzVQ9mi1EMILkwVMpKlNEhx5cMq6EcLkUSMo7oYwS5ZO4IImoE6iXCqYWt
 UuA9e6M/lcn/cIYyHqhrYQV9E1B/8w3lWmcKaPG0xcaFcr7aTgn/eQNhmueSpTIOYj+Yc9Z3D
 apB71cJmZ+ruPYDpGZxCqkfHI/cVEG24iwQSibX2w/XQkiMW75eY5i91XSn/zYjZd4BjQc2hE
 VEWBfQHszM5fjsARLlePRGi/MJ874sm0nTn0p3pFKb0jDUy6fA3KGY/MsxZwvDDakxqhcA35D
 Pjn00fdzadfFYwUKaHxpeGbloV4dxRCzZ3OByOxmitR0CrAAI8U3NN8nG6sS8Yl4BGJ+47MBb
 QTHI3ryCyW/K1vX96DzzdjVa1LqdOaQZW9qfZI+xt0LIlFrEfLvwOvJLGUkZBrwX5BfWiOXQZ
 MtaJRF+GDEYSErjj+keUDw1O+Nt5bhpWsX6lrz0V5+/GOrbGGwAicfJD/R4VXtTIS+FzEvEbR
 Pfh2v3AOjPxN6qC2THFtwMpKc6ptvindVjq3GdM5fy/m6+d4spShiR6dtqD1t06VP7Lf5jqqG
 FedO6o74tow/Mmwe0J3jB3irWxz19TVFWzxLxnxZHQUKUN2Qly4bBbonKaP67a3ol7PhB1UC7
 HkEWP1zCYPg283Xa0m07EPhf87ghBJsepfJqMD6c+88CRB22yMTyCxdih5gUH4+nvDoWDnNlA
 0LxYb+7bUNjkDkWefzDaUec13k415k/2j+FEgEhe3pEC7NoMGZba0Aglr9Bb5ei5KcFmXlcrd
 hnhdfAqmrN8FcKN34Bm51gtTbqsbVPCAvn/dIj/9BMeHCl0K/GSd8r5xFZCKkr6VznZFjIt0v
 x3Ja87wgG016ye7cjvSZZ58UE4yR6E7j/ax3bM97Vk7JMsqSyLuETj/8Fha+ECs2MJZySLA7P
 22dS5pDgaapb/psrYKG4LjXLVWdxFTIGccj/u1w1wDvI1DVcWwgLUdArm7elcjmXkdGj5wJY9
 tALrToZJlHS1seQqcADXSPzJWAdW9HoQu6W9lY8jPWHYp33Co0UOatFmPHV2WxfOn73W3fWHO
 PWo+UlN8GyQYgYER90KR1c0nvce5ShqjitDA7kaL1NkD5MRvuBRpCNThJlxhr7EOzgiwpz5Ih
 Gqv8/F+wVvcYKzC3yd/k2z05/kVOg20hNyoNXC0CAFAizZ5BeGZ3tbI0stZxIUB5gPBMlc+qx
 FyZqr4itkGjSMlUh4jmfaiTIylHt6P6zFpTkWOiPsCJfX2GOv9s1vIYxh5frI7lpgsztnW8kB
 Wd+HB3c67F3O+WNYOWxHIkxtIMO34mgZ7Q8vNaa8lEqvh62AesuYCyjTiwDvvaBMTk/wKcrIN
 S9ZB0nVwTYCbc1aoBssUF5rxOW0pJGXK7FrhDS0um9gFL99RclemrR0DUbpTau+M7ToTQGHw1
 pKpNST78aTABsPjg8nJKyLZoIB68hOTPS06n5Ha0DY621KrqzF9/gUx1IUiZQMvZd3N/Q96FO
 6RfsgDoir2W73iPO13NtaTgqCElr1izcP+/nUzyAhv3eajrlemJwEDPCcHowmhs/RSGLCC/zO
 Ax4TeWe7CeoyZYw6aOat1HCkTF91GtFhdCboFmRKsmutY844dFhEVE9vIhmrbEr6QE1xG

>> =E2=80=A6
>>> +module_platform_driver(aml_i2c_driver);
>>> +
>>> +MODULE_DESCRIPTION("Amlogic I2C Bus driver");
>>> +MODULE_AUTHOR("Junyi Zhao<junyi.zhao@amlogic.com>");=E2=80=A6
>> Would another macro call =E2=80=9CMODULE_AUTHOR=E2=80=9D become helpful=
 here?
>> https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/module.h=
#L233-L236
>=20
> Do you mean put MODULE_AUTHOR in front of MODULE_DESCRIPTION?
No.

I suggest to call this macro multiple times (on demand).

Regards,
Markus
