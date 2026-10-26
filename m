Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035732;
	b=Ew7HtDhVjwvQqT0ErX+g06c+KuZqAOTAbWFRUrkJsp3m3ue/jlIxWa4/Q0dkgpPNGf7G
	 l8bahfBZ70L//Hf3vN0GD5nBOClo7GIA840F08IgaJ45RtlbnX9xDL8thCD3jam3QG3Gl
	 P/MFZukEE1kOlY2JL/yRe5Hbq5Tri6j/yOJ4kpqpABJRVs5t706Gld98pzyXBbCsxxrOZ
	 3qy10tDnROkkwH7jX1kG86Oc05dldELpmhhUGDKlV9+PuYth9BsCE6RmUt//WEMvrDDPb
	 9onsKUa3Fq/6iZkl1mOaKyAYWPLEjxL9KI5mPSyNCzXuHRFL7o41wpYx+gcHfaAAMqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035732;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+lCTSAbi8cX9pHfQLYDt44NEA4LWVg3IQeWAlP7pGyU=;
	b=UVOCcEJjdh6k2nRORqOoQd1CjSR/8i8q+KgyvpM+iEkZMmkUqN+LVVKCnoYnthPnp7gD
	 ubWLcEQ5FUG1IKoPG96SqTImO4bHuu6ffCcY3pmGpeRSiD7YpRqFyoCvYvS0A6SRcVBMm
	 TSpWgLGNOFlKGrCb9aHanXsaxo421KSD1bEPZnAbqHmhINmiWcI4S1GSbtmuPNMMNhPjI
	 M9mboW1ISeZuGj3mQX2frVdMjhtlfaJU9kH9wKqzlFAebfisaxPLyiS7NAYOvyUTsmsS2
	 CtscRAiyKvvBaC4ylbZYHfIfPbQ3CtuxBen9FlsG8NqyKv6ePB/gv0hN5L57W1q+X/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=LDbyScMG;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A7606A31A;
	Mon, 26 Oct 2026 17:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=LDbyScMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793035723; x=1793640523; i=markus.elfring@web.de;
	bh=+lCTSAbi8cX9pHfQLYDt44NEA4LWVg3IQeWAlP7pGyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LDbyScMGZrNjegx+g+aZ2nDEsfs/4ZeieQ43vq5H5vqyAUfxErl9wQ03r4bHAxIt
	 hOS/QlKw36olZrM6x4147saI+Wo2PVbBZl1TcT1HWXUEq42JClCEWsD/1f1rryG7e
	 QNCEXEGyS1XTjqZisAhtqmXfaihRRasI9eYuc1hfocIoRrseGCl4FiGL8EwzQR2Sm
	 vvrFRES1L/X0t0w4Zumk7UAiRHLFUQfAS68l/CvG5rEKJLFVSSs9VfFLXicDqi2Zu
	 HJVpiBbYhFCrfHM9Kq6sQUtZBsPCj6Rf4WtXFD09SMH6oXNDiNrIRwX8e7boRGzJB
	 UzzodkcdQbg74reKLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1xPIWf0R7K-00DoRZ; Mon, 26
 Oct 2026 18:28:43 +0100
Message-ID: <7015dc55-5f19-4a6a-89aa-d11da0190b7e@web.de>
Date: Mon, 26 Oct 2026 18:28:40 +0100
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
To: Junyi Zhao <junyi.zhao@amlogic.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>,
 Xianwei Zhao <xianwei.zhaol@amlogic.com>, LKML <linux-kernel@vger.kernel.org>
References: <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>
Subject: Re: [PATCH v2 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsEvfj0gLzH3jy08RmUl0s8GvuO9WXocDLI3f043GRMkbuFeuwg
 3ulmii39PrsIGjsvuHRrd/+aRcqdsNWWv5V5Nnq0XgXUm7bxo/u6S59TNrjjFoY3HX+eToJ
 fwos27UbDIjTx6lkwnvrVJMF1a0a8bS/pwmoOv3RXhqpHsF8n+YPb6xqa/w7Z7WIp7wTpnp
 eAu/KZ30UUpTSOry/OX7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KpNCWp9D9EQ=;296HRCSyQAq2f5oelEA/cPq5gbq
 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
 +LSOt097AI5hm3e

=E2=80=A6
> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
> @@ -0,0 +1,469 @@
=E2=80=A6

How do you think about to avoid a bit of duplicate source code?


=E2=80=A6
> +static void aml_i2c_prepare_xfer(struct aml_i2c *i2c, enum fifo_fill_mo=
de mode)
> +{
=E2=80=A6
> +	if (mode =3D=3D A9_FIFO_FILL_FULL)
> +		i2c->count =3D min(i2c->msg->len - i2c->pos, A9_I2C_FIFO_DEPTH);
> +	else
> +		i2c->count =3D min(i2c->msg->len - i2c->pos, A9_I2C_HALF_FIFO);
=E2=80=A6

+	i2c->count =3D min(i2c->msg->len - i2c->pos,
+			 (mode =3D=3D A9_FIFO_FILL_FULL ? A9_I2C_FIFO_DEPTH : A9_I2C_HALF_FIFO=
));


=E2=80=A6
> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, b=
ool last)
> +{
=E2=80=A6
> +	if (last)
> +		aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, 0);
> +	else
> +		aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, BUS_NO_STOP);
=E2=80=A6

+	aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, (last ? 0 : BUS_NO_STOP)=
);


Regards,
Markus
