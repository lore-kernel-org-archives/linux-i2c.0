Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696254;
	b=DzO7BVGX+8ZpqqN1J+NbIrs0/xkVS/cYm+ONFVJC/3Heu2NrLbUSjAXfllRMLgAJtM8N
	 S0+L+0nqb9wHOzurpv34HWLPIJ7yXSgmEqRxPUyLkfiBirKiUWUBj63k25Hbpkv9zNz1S
	 qUSW+v4C1yUerTmKf9gl24+AY5pviKcalkkTbI6gz6RvlL25jqElN0vXLFYIqvivOB8hc
	 UyEC+W1QnJ7v9Fk7nuEZjwfad3daeYD+BXKknQEZ0KpT+kqcd1Pf5hl+cBcExfLl14gxG
	 JdgjdSO7O0F3g7D6DrSTbRo2scPLmAp6v2Qqh52CzLcsLIJfhAjIfeeSd/0cifaIBng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696254;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=LBpbPyy84moXNdY7tc+0KvDrkVszqQmPPSCUw6D3d1U=;
	b=KRk1f3s4lpvWJT5gWxW39psjZUmwmNWfqHEJDGX9tGUIRtS4MHyXkHOFMd871zhO8kai
	 BeN0kj50N1voClh0fyYKPgMvx7utfUNSiBa/2lbIpaepebS/F1mXSL4ENhU2OmYmpJ8Ft
	 fmvHyEJRbByuWkVqdcbMNi2d8pPp+Xd3PZW0EO4f/JHTzB44VPAP79P5m3PQlr75bEKLU
	 5oEdNZVq9mKXY0Wu8B20oNhhKMnua3n3oVAH9TBGCrmTeRnu1Ocm0I3dj3eT4zGHmeWmV
	 1lUgwtvk2hzVRVzBDq+ibNfRTDiaKFD8qbJXxWUQa+L1gOrnSJzncLY8qLJyGgMTYow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=horFFdPm;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA91606A331;
	Tue,  3 Nov 2026 08:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA91606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=horFFdPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793696251; x=1794301051; i=samuel.tirwa@web.de;
	bh=LBpbPyy84moXNdY7tc+0KvDrkVszqQmPPSCUw6D3d1U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=horFFdPmEsDkgnnCHdGu44lm8Hz+8wK6gg5Q/Ak3WvyR8C4q0wIwAZlkQOIM17mu
	 tomA4IxACILt7eDuIAuNgU56la0BBKyHjQL1ILL1oRTm/ksVMI3k6I8MXi57xZKJ2
	 uCQeXDYGhWnfrt2Lyn4fClc8FxsMGKmXFTaTOBTWr3Uny9FJe+lViPcPBXMDBWG1+
	 uyo7I2WynylLQPNf9BHRmf1RlxOGcCKIqdJIhFSxUtyIDHt/cHN/mnxjL0m936m/5
	 EY/3Q5wYNFygP22lg2Ae5TzYUp7liQ2s4mRAl6RXLYiL9BAsiWSjYnYUqwkLZHlgm
	 jySY3kseJw8GVMhFUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1x4zon0rd4-00KeNm; Tue, 03
 Nov 2026 09:57:31 +0100
From: Samuel Tirwa <samuel.tirwa@web.de>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fix Agent <fix@kernel.org>
Subject: [PATCH 2/2] i2c: designware: use polling when IRQ resource is 0
Date: Tue,  3 Nov 2026 09:57:19 +0100
Message-ID: <20261103085719.440-2-samuel.tirwa@web.de>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261103085719.440-1-samuel.tirwa@web.de>
References: <20261103085719.440-1-samuel.tirwa@web.de>
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
X-Provags-ID: V03:K1:8VLrc+L1WUJvLtUU6XvJ1qZfMJ2/CDe7B/zCQKXgvgfSNi5UCI+
 GThB/NaJnNqBuztCbXenATuVu8yzLX8vLQPrtdU1ysmdAM0M7zP7MvyooCGgD5fM/jiqJuV
 Zm/N7rYQ/j+xDNLZcQicdDNyq8aRw9et0UTYskB5XJ3qPlGv+YSeKwwuw4qsp89tpEVuCJI
 G7eEs5BQCxQyCK3X4NJ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xfx7o5P8DTU=;FrUMAdf5V/1cCTRteBHMdIl+ccE
 U2KoJEg4uVwxkHhWO6dmqLBgsKzuMIv1E0JAvGRY1Z99DXh83VUCpQya+A8NQlZVRQBvNAA27
 +E3+COqgR3C1iC3V3ilnuOez+U8rN+KZ3irfry5GwLsGBaW1sbU5EuyKgTopFwuNN+1qp0uoe
 4AwV96FQgZVaWmOMcEqOGDtnqGk4YUHFqHkugSjpNN0INE2FHGcDuV1cJ0vrGNOzUgV8GL5GR
 R36H2NAmGafiQgaoM3ZjoOzG2wbMt729fLgSdha+wSrkbUW2UM1O3u6T7a/8AHEhdqiKeCpMX
 iI0GphdV7gMp8vX5J9PcWFaIUY8gw2N16ifdJviRz3CKiI4jSb6hUBdvRNM0J8ufrCDpYUueF
 3XyBrVDcdVJ6BDSWEU0gGhRxHAeJPXhThzhpxMwlhVBGSH5tNMDY/pJir/a/kaE6+u+5MyPcM
 E/ScPkicZnLD8vUq/80FDCO5WJHyocclR5uWWx7y+Z1PeGpXk09sQYXSBR/+uTkpBzSGaLRPC
 sl3q18BMI6qJtQOgOKvwovdSwdfJhT7anpAqlb9uFcR+A8xSQHztCfAkxu2tTC58HVI4pCZcv
 80Mfzx7EIZ5fRChUh2plq1EbxaRPPJ6+9rhBADB8xUgr9gszOaH/bfOvMDuvkZu9tTCnuISz8
 lmwHuU+hWZbWGOgoIHGasyIBncH7bkM1o+1An69BxzJ9xDkRmSn0xP4lC/IqyqyX+J/2gIxAb
 jdaf/cFsdVaxaZ9Giu2nUvmwu8TmoVJpXLiExbDChpKRJCabfvN6Y2WNMOTwg9dpoOw5GNiU9
 kmfJ47KqJpWllKv/NpBHeZPnXHG8EntWJRMopnOueGg91jPLWt4u0cCzagNJZTBKaUtBYWQgg
 D+41LYPvCVM8/UCbBaw7/NDmA1W9M1KVoDpPxxzVmVRKSPC5tC4NM9Sd9XEzQKY2shk5LonVr
 HD2Yg7QAEb68Q4L0A25Vh63iMlSMfDQ/JzkazNFV71dmTBSb6HpLSvDtSaEsY4g4+2b+Of0/z
 miSrvjfFqfXzqVvCWeUaz0EPCP8pCqLhLCpuk/ZZ9fJVMThnREeg+27dlRzylpPoMqpGyISCY
 0xl7251wClZQ+o5fW8ri8wg7IJ6H6CH3+aQi4eHqo1VTaoMNFpv1Xh8iyg1nlwQ/QGBp03c2N
 IEyuUV7Nsv2AsCFrOokxPHdky4JLB0AOlkMfXmpgvufGyEKWbdf/xoZGqo5utKK83J2fblGsJ
 15VVvq3Ia/5LPTViTIOIQi3CTsydyFrnfkL7quXTPof7Dp2gTw4Z2O7xvJ/I4ijc/RxzLoeHg
 MGYNhlidNNjOTyZgEgZr1Z+lRUbNakaUL83rQT+ZkCKPcG30c4xNGTP7knxSTNJpgtThvZTpt
 MsJCtW8Vb8pTm8KFEFOyui2vltA+3inePntwgRm8EqF3ZH4VZiVqWE20udr2nszL5jWzQqnj2
 o4ZtsdsSfmRqWLjr9fSnKtKTuot+wSx3LGWISDn0AkHPHrpaxZGHUps7A/La8ay4yrMs7EQsx
 jH6IPIDU0LKZFxKU+LtRKm/aLIiQUOwQiukNpIJ4/pbPbRXyJbZGBsmjBNGPfSiy/Lw3MGOBB
 +r3RiViHJFDCUZ7pR3Xng/0PNsOAxT6XP3FRsQVzQD5vU1HNHDTkZv11jYP/RtFC/brB4Ko2Q
 eZGU0nuFtfCVMYULVxqihIjp+mbQZBzjZlT1tyfv8EPGgxwbvVqcoxeQJKheVFVzxrnntCRwE
 mbEFG/8HPhQcPqhOGd6XFVzvfmTnqrGyP7M7rNBEfs7ZDtmJj69XztDJg3orLPj4A1TUaluRL
 sOOpCf/fUsE+8+LMD5im61AiKLa3nkSu3YGw0kK368mVTlKV3zTtzax+g1u7y6NKN43xdBtOX
 sKp/hE4iLHPx9OuMByUFLOUwminipd9WZEu5bvwePwRTuM7dkYudAdjPrN+samBAjItF0fttB
 Wp4sqKjlm6q1dTccUV3t0XCuVggryABy2Nf/UokjMlGX2zaCnOBFhc+/kcYNPkYbVI7xhpSQW
 kj7lRKZqMq1hKCYxdsmXZi9Bt1Ta4xU5msaeLcYVPn1uQ58WUPnZuMZ/YUkKgRisXXS1eBkx6
 DsiQapw+01lfJcMktdxdnShGSdNdb+xqKlqOpaZp0PUkNI6Sh5GTOGYvgVRPaXaQJHZ52I1de
 hR0NQJZB3y2NXbMQrPuzbh8ZqBc/pDNLNPbik4zecYYlpNjTfhO5ywvtkdYyvubL+SVGnmOIC
 rGZMeJr+2tT6rZNOCr9p8FEXKYAkJu35UaelQLgFQr9SK/RI1PIqJJNTsJVugvsHcxLAml0xE
 iv1w/kqFPPzc/9m8ZetI1JwnIji7C7D6SYdeUTrb+Xly9iLqxEn+6IGghv+xcnyv6sJdEAq4x
 2o7W1GBvaOwJ8+KAB0MArgoYl8/0i7G7eTr+9ErFoDldzAl/QCnQwAqF/9RKpipVpO0HZohEU
 ChGgKGWRV45JFoTDSHEXPaYhI0MfjaYYM1pWzW+io8QFc9XcCEoiFmYqRFuVdHZ29Zv0LVAXE
 UgV4Ggu6NpXDt+C+oQXrTU2cil93xYuzyJJYp7ffRUTVZJzfNJ2nAfYRMz9zEMagiaWoi5Lzp
 iB8OmhM8msDfvw6XQRc08s1kaKwSKdPVIu3ZxiwpZEM1hDl8JBq5pQYEJzK9yQX1jNNUGptsZ
 eJpunHqGd2we3fpFf4Rzj1KgjWAuoSRopwtVMbTicwSMltL7AtV70kv6s1ubosOCJusKK1DS2
 S63dgs7MgnPyMoGeatqTJRu+mKS35BGFJbiLWDfWujr/l58s6zQevGh+TucpdOWLUZFWxZG2H
 h/7b5RKgblGdW8eFiybGyI28Tz82N6faYQMPMYsfzYVyWpJm0ZfT14/rP+FfqrhPbm2y8gXwa
 5DILDKKI/AoxwjIzRUIUbxf7MZTmJt/+rp+o2LyELB0xXtE48FTZb6xvFAGd9/ivS2WdtX/pm
 K1JsAPMsqfq2oBoBuRLpTylq4Rk5ukIFKPYgOZ5hLr4hAXF02pnlf28k+IGpFpIFkkCQEdMpQ
 2BW4aEGmcgTNgTRs9L0zIbsVg+W+VGmBZgI+0t9EfZ7qcuo3YG/G25rzU8PKSc6VqLSGILYy/
 SGpgvHKcH1ygZ3ZgULmc+rIoX/PHcxVpcqqxLN4qmpqhormQ8cj/gXU1JHuJnVsJm6pbvg38z
 xebfIr4nifbsrBbvxbX1T4c86XMMFtT3l7ZbAuHjK8SkBxQh7gZwN1ZxHehiHg7rNWU3fijof
 Q4cGSp111sPhFiAF8ODyWNpkO/hDgPa9o9ey2bfL64V/MRs/oo6PIecabcOxuoOXoSg2kF2XB
 569mRrqCmCRKQDfxfXs0UCAc+4rYEyLX+lnJ/uFiWakVskzpYTxmwToKFpyGvN2mk20Jp2vbt
 euchm3TX75uHvJ2VlFCdVTRmg1QW82CB0jZdD5AYN3KGJtsY3acf2heLp5mpl2E0Ntxm6/Rd/
 NF0mUctuRpJEPDLyYCDMvbR5ZMC23GZphotPOlHmyjMMVAvsxYOG4MhQmdma+zeeVsBu877de
 7jOI4LKiszHQM7FnXbZjD1/EMoj6sXtFPtkF6dJpz6kLB0YKE+dY0849PaSwR3NVP3nLV3pTv
 6gwqHaK5O+zEf5OtIvZV+JnZswnxXIXOP/gyXWsCpGGSnyzJ+VAbSjUnQEzZnOjVi8FmUERJx
 tJVsKoQbVbz1C79D0oLboQd6TMQyNsSuf8G0gPEK2I6ZJP09jTEsxApdlOp1ccxIltuEkHOfp
 WmDZzCR2DR1fvnpLRa/H7OfkQ/h/jkQBaaaTsbsMNINzscJNFsNK+THdtrJkM6rGXy0tocGjK
 IyH/3m2Svwy4S+0f5OQuxpgaYzatkLjgS28eBaDLC1ScjsG72gVKhFCpgpL+aEMsMtWCJrOCg
 C23AHh/7G3dJEMTLH7GnhXqTeCGTEE0ekITI484iCh5WGT14m9I7hcHniSH9Ay3iJXeFYGnIH
 UXsbmUKUTXhSY5CHkGt4ysqfR3aHCvEBjaTtWSdXyEbVFy2SeTrTzAOFRDiiLT53WE1QtLbFS
 o08dwwpSpEZ1hmzc22GRIPou1KYE2xzGwt9JkkdxrEPc94+pnI0pOfx0ACr5rntheGNilvqsC
 4ui9mS4ze2JhqnVAC3acfbJsolfdd1FwA4Cjq0PeUzd68F0djpNE7OT3Peby8z0n+23m8UBAF
 Plw7vnJtt0MXGu9desuw05H8W91JytGbh85+oR//ebNSHnK/z7r0pNNYf2sNwBnI4TINtGm0o
 h41S++MWZYOg3+mahvWbOMJJjUO5Tl87atK4V/bPG2ZVZD431V238G/qjLqDrlIZ4BCVfyLVv
 Y06F5RmNP3wOg+Sayy9u5vm+RodGYHh1Bk4QJrKsY/JcJUq2RixGwhVCzKjoc0ffKn00x7EZP
 wFbubo5Fdoe8FpwHNtkLI8FKww+IupfNuDvQSRnbNR3Pm56fuZpwbQyGAWKyTiIqMzQH8Gn5f
 789EjtsUVHtpoB7T/SHNH5ErNNyrZ+y2qRlxLQ3TMZOTWpi3aqTAllJ8vqk8kW1wQMd/rNkBC
 yhWL1gY12KWI5yCdu9pi9PL2hoAM9rW+MEWQhw/d/OwngYqi4/lk4sT93bKnP0GVxEFwRXdT/
 pYV5X6HRBkXpk8AorjmuhhikueefUFlSMirE1ckDz+ENb3JghXwyE8ZT5ZrpiBIzAFxzhNmOd
 eby1g5wTg36dJMFK5BC7+OYLD/sZu+hhv61xxUYC0i3MMXQYK0oSIRopBMHAopFAL03OHI4lw
 wk/sRJLLABNwJAWOT3wsbKvtNWIdWNN384whyJiVRRdXkpdMKa8Bk7vYupkrTjLTJBiEZpdaz
 +Bgd5qFqWtvrn6FN3fbKCCwAQR9ji4W2dFwd6qNYjGL2fYFq/98pGhpt7xUBfZ4Ff5m90qees
 fn3s6DernW9qo7+LxCIuRuO4kc9YSylg9magJRXSZCyIZxVuy80zgjkXGr7E8eKT36uEpbIGn
 U8ZD2QiwKwFabaUM2sU8TxlAq91yNf0NmKGvmX6h00Oi1AejlfIYZF+L1z2x8w44viNuM7z/H
 6W8eKqLGShfAU7QU5CkF9L/adK+QCHrHvoA0wfUhMBZ4CBy2IVeN5/x8W7kCfkN+t41MAX53L
 W/t90rsviJiIc0IhqZM+pB1AWauCiiLd8GccDdcwOdCWzQcCo7QrI3fqVP8JVTmsYrI0P07+9
 G8a6jHnpXC+SBNbxpNfSFPGvby26PnPA+OnMUqpVX9t8dXfhpj8LlHq/C7TBIwGU9IGJuiFCX
 XUSw/oQp2gKCs00zu77cAuXQfQB2+BxVdouQLV4gT5speAzUh/Rbi8MUiLtVeP3ZL6xCoI2A7
 NYAbRtpf0vdDcjuXBuXiQZBrwoidXmTZ/AxVK3UkTznurM28uxUWeAVbzd2lpRklUNueKzoTq
 fgHoxeLylzOG8nhrBabgR1ERy4sy88CzDUfFvsZ4Se+bmVNajLXbS8ITqiYXsMTiIBMSs+yQs
 IcoFEMRCK/AW+7DkA8jv/BjCWqmSuYFYFHJ6T7l4pKVR1LMNqrlI+iJLRRuPcpdhEvgYS10um
 J1yWaBj6e7bqXqzGU5recwXQWGTImJtH8je1RTgGYg4wl2hEY7QFNwSltjrCYqSGiF0bUlCmT
 2a1UWErJk8qGkPutWKfJrK4K7YHGLubQAEK809S+xOxD9IiwgyWM0i4lrRQWhokv7cjqrARQs
 JR3Ch/sO2uTHQ70lHHYjwMJbTJ85OgQDTvKdN3H9kVmaMzqnIb24ngx8dqq8xHA33DjlvWEs4
 qOO61wKY257P/2dHnlsFLehCAVA+5Pt4h+LHky9UnZzaGFA2FZ5wpifiTpbb+vWQ20FQWiaUk
 S4+XHk2VdBOpfL/nhi6UEqdi0jn5D/SHb9RB4PCwJlN4XvutHivFhVLsUnslKL7AriC3pcJPM
 3EQF0EmdZ0NYACnK7pRs/qcoZpL2lr0L9Jn1EfGTmUW1xG7BnT2qdWMhbzL31efCAFATSj23F
 qx1fKkejIIusc6eu6Rfim1XsrRc+0E3SjsOyOGsMwZVEEpigG+AFqnQ24UlXyOKbaewT0wBRG
 CwGGRUwp6ro808PWccxxnYC93qPsS3KiirAFUslzjrWSlQNzhNieUjzmJcMfYE4huhCn4AWgA
 M/WHPjcmBfpqVUfUBxux2xSqajcde5OjZPs302PTjxduaI+DKbAM7e+YRlTTweWVEHMHlzPO+
 /o6/JCFBvAfwTNlygV/NhuXk1ukihl2MzeP4cioVhzoe7aksWweWrxaL8ZDqrliyZ1d3AjdCX
 YcEFGUQrLsvEhEfpy9Ua5SGF4FkmLNiAdliMUw51CD/chWUQQ150dVcN8vupGbbuzQ38wsdfK
 KSzkstdUUo6jjli0sEAB2lazYnw65rzZBsW2GpOrGdIr8/B3x/R5DFV1vvhjWQfTgY6IlKQQb
 DZHEaaYvGcD+0ySRDu5rF+0XwcOGuaIILDmz/FOTjphTvaJDwkdGGWjFPmPiwKjS8hMkERNkU
 yQ/jiGqWorLYgau0ni98QA4GOVssdS6jBKmnDrIhkBvcxrqJjCrFN6EdToD2enxC0YXfVyqWd
 9NY75ZWRAv8rfaCBAPpo6VH07aAu1puraEAUBoczIHCjNo/DApK9IvOaeHL3xIJkLMDs+4NwK
 uADSmFUp1FGwyBcD6GKkcqIG0vtKrgSbIa6em4VnJQ2Tyn0mPbIvjRQ2n4bj4Xcqxr9PwgDGo
 Szs0SDl46Zw4Vw7UTj6xX42dWc/vQu1veNuPYec8ljCzks4XJ+5OkTgFmESyckE9oBhuTlJzk
 DnA0g5/yER0aq9k5TeptzjV

From: Fix Agent <fix@kernel.org>

When an Intel LPSS I2C controller has no usable interrupt (firmware
reports PCI INTx as not connected), intel-lpss passes 0 as the IRQ base,
which leaves the child device with an IRQ resource whose start is 0.
platform_get_irq_optional() then returns 0 instead of -ENXIO, so the
DesignWare driver never enabled ACCESS_POLLING and request_irq(0, ...)
failed.

Treat an IRQ number of 0 the same as 'no IRQ resource' and enable
polling mode.

Signed-off-by: Fix Agent <fix@kernel.org>
=2D--
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bus=
ses/i2c-designware-platdrv.c
index ca63b74..035ec92 100644
=2D-- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -4,7 +4,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	int irq, ret;
=20
 	irq =3D platform_get_irq_optional(pdev, 0);
-	if (irq =3D=3D -ENXIO)
+	if (irq =3D=3D -ENXIO || irq =3D=3D 0)
 		flags |=3D ACCESS_POLLING;
 	else if (irq < 0)
 		return irq;
=2D-=20
2.56.0.windows.4

