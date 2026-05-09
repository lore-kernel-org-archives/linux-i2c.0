Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82E2F8EA5;
	Sat,  9 May 2026 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778325398; cv=none; b=NYlGmoL9CvE46B0r5QCKIhoBQIsRlA70+cwSqiEykeGyj9+BQ4Fiyg6ys+3cjfiMnVLRQS32LBZGi6GCF5iF6C0uLWLsGg3QuHCNb+VEBbF48iGRZ0AkRD2xXoo8IPVqQSjhTvK3RTG94pQWJ3xi60BDpiPMBPmNxW8ab4Y1hsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778325398; c=relaxed/simple;
	bh=ZggqwoVeMvkkJbMsPzwWP/UdVuYmsc++L6TUEQo+7DA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgeWyWl6rRMRou9HqEe25FTJ7E6/40GnTaBVxnc6eGbeEhtP6ZtGTx5kCSw4kdPsYQ3QixclHYKUYEK7MlRpTL3JRFawD6z2VfnhCiRlPe3OyPnMoeJ0qASMEPCB0oQ0gPAWfImActuEZG0AXrzYN4tA5Dv4deZno0+yUxfcFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=jGwHgJ+1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="jGwHgJ+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778325390; x=1778930190;
	i=markus.stockhausen@gmx.de;
	bh=TUHszCJjkuNHnG8SeOfSBEkYhtg2lNGMEiSuDJ/B88k=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jGwHgJ+167ZW5kQUYq2s4yWZtO0VJoxiANME0XjwKoeoyVyru4c3/49U3HMmBwLd
	 5bhC52VOvbmG1nM42lpqadHcHQ+PNbr1WiLu2czZ5BRdPnAHpri36XLG3H8QBkbPu
	 3YzNEDw/ES5d0btiS6tKznl5GbUT2V0f+KGFkqUq5AgQfsUVMtgcZ9T09GPQf5Avo
	 tnqTagVA2OkBL3JU00y5p9ZBj94t6LhyxarWVvXHKwCON3wiHAdDyTwh7DzP7N2Hh
	 q+kyhUITqJZSKqm2N/VYKu5u6ekQcI52VKBvg4bn/MBwBsvhOZOjN9Fj/wtJ5EsMa
	 DlZ9lf+ph2NZ2ggKog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1w1fqJ0UeX-00Tv00; Sat, 09
 May 2026 13:16:30 +0200
From: <markus.stockhausen@gmx.de>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <andi.shyti@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de> <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org>
In-Reply-To: <20260508131830.GA1135235-robh@kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Sat, 9 May 2026 13:16:29 +0200
Message-ID: <007301dcdfa5$490a1e30$db1e5a90$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKgUW0k0IN4HI9csbwIs8kp6Kp3wLKDayEAPY4WTC1jETtgA==
Content-Language: de
X-Provags-ID: V03:K1:OiJlsFSTmU95KgADqm+MwCka6vpr+8eNm6kuLu8vtZag3KzM4iJ
 2sZ4PBpkUIpR70FFd7oVdU7mmZ3jiWjxOVOJj4sT6fTng8XfwJRcwogB2mD8f4RBiT1v2yD
 ZnbEeASny0ZIji0mMQyy3cOK+LeVJusNq26xjgQAx4TIhLZtq5YKTmheTx2PYvcVRsVu+Vr
 X6nr6ZyfPe5Y6T1GOYeUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t1IUmPucOkk=;aCvs7sBEfRgYCVyT5hsDrZvJu0R
 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

> Von: Rob Herring <robh@kernel.org>=20
> Gesendet: Freitag, 8. Mai 2026 15:19
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: andi.shyti@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
linux-i2c@vger.kernel.org; devicetree@vger.kernel.org
> Betreff: Re: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
> ...
> > +      sda-gpios:
> > +        maxItems: 1
> > +        description:
> > +          GPIO used for the SDA signal of this I2C bus. Must be
> > +          configured as open-drain.
>
> I would move this to the parent and make it multiple entries.=20

Just to be sure. You are saying that the following is good way to go?

examples:
  - |
    #include <dt-bindings/gpio/gpio.h>

    i2c-gpio-shared {
        compatible =3D "i2c-gpio-shared";
        scl-gpios =3D <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
        sda-gpios =3D <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>,
                    <&gpio1 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        i2c@0 {
            reg =3D <0>;
            clock-frequency =3D <400000>;
        };

        i2c@1 {
            reg =3D <1>;
            clock-frequency =3D <400000>;
        };
    };



