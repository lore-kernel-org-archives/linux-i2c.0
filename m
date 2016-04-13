From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: add i2c nodes RK3228 SoCs
Date: Wed, 13 Apr 2016 22:57:01 +0200
Message-ID: <5295818.srcnokibua@diego>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com> <1457925102-30476-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:39676 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbcDMU5O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 13 Apr 2016 16:57:14 -0400
In-Reply-To: <1457925102-30476-1-git-send-email-ykk@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yakir Yang <ykk@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

Am Montag, 14. M=E4rz 2016, 11:11:42 schrieb Yakir Yang:
> This patch add the i2c dt nodes for rk3228 SoCs.
>=20
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

applied to my dts32 branch for 4.7, after moving the i2c pinctrl nodes =
in=20
between emmc and pwm* (please try to keep alphabetical ordering there)


Heiko
