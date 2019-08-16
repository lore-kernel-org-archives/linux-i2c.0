From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: mv64xxx: Add compatible for the
 H6 i2c node.
Date: Fri, 16 Aug 2019 13:44:53 -0600
Message-ID: <CAL_JsqK_j_AK5wa3cOw_SpVZAX+m_iSvnR+Sgh0dbqxYxHKr=Q@mail.gmail.com>
References: <20190816064710.18280-1-bshah@kde.org> <20190816084309.27440-1-bshah@kde.org>
 <20190816084309.27440-2-bshah@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816084309.27440-2-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhushan Shah <bshah@kde.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 16, 2019 at 2:44 AM Bhushan Shah <bshah@kde.org> wrote:
>
> Allwinner H6 have a mv64xxx i2c interface available to be used.
>
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> ---
>
>  Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
