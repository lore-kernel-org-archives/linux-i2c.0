From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [RFC 3/3] dts: beaglebone: Portable connector BB_RELAY_4PORT definition
Date: Mon, 27 Jun 2016 21:52:39 +0300
Message-ID: <7FD05D1D-6827-476B-A4A2-304A7FE7A1D2@konsulko.com>
References: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com> <1464986273-12039-4-git-send-email-pantelis.antoniou@konsulko.com> <577168BD.5030409@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38548 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbcF0Swo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jun 2016 14:52:44 -0400
Received: by mail-wm0-f48.google.com with SMTP id r201so127923708wme.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jun 2016 11:52:44 -0700 (PDT)
In-Reply-To: <577168BD.5030409@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <stephen.boyd@linaro.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

Hi Frank,

> On Jun 27, 2016, at 20:56 , Frank Rowand <frowand.list@gmail.com> wro=
te:
>=20
> On 06/03/16 13:37, Pantelis Antoniou wrote:
>> Example of a portable connector port for the BB_RELAY_4PORT cape
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> ---
>> arch/arm/boot/dts/am335x-bone-common.dtsi | 48 +++++++++++++++++++++=
++++++++++
>> 1 file changed, 48 insertions(+)
>=20
> Pantelis,
>=20
> Can you provide a pointer to information about the cape?
>=20

This is the cape in question.

http://elinux.org/CircuitCo:Relay_Cape

The standard overlay for it is at:

https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB=
-RELAY-4PORT-00A0.dts

> Thanks,
>=20
> Frank
>=20

Regards

=97 Pantelis
