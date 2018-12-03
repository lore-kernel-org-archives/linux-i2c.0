From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
Date: Mon, 3 Dec 2018 09:21:32 -0200
Message-ID: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
References: <m3o9a2hni5.fsf@t19.piap.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m3o9a2hni5.fsf@t19.piap.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Hi Krzysztof,

On Mon, Dec 3, 2018 at 9:13 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrot=
e:
>
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

Please provide a commit log, giving some context to your fix.

Is this a regression?
