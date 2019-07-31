From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 18/57] i2c: Remove dev_err() usage after platform_get_irq()
Date: Wed, 31 Jul 2019 07:46:47 -0700
Message-ID: <5d41a9d8.1c69fb81.bdbb9.bea3@mx.google.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-19-swboyd@chromium.org> <20190731143011.GB1680@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731143011.GB1680@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang (2019-07-31 07:30:11)
> > -dev_err(...);
>=20
> What about pr_err, ...?

Sure. I haven't tried to find these ones or pr_warn(), etc.

>=20
> > While we're here, remove braces on if statements that only have one
> > statement (manually).
>=20
> You can let cocci do this for you, too. From the top of my head:
>=20
> if (...)
> - {
>  S
> - }
>=20
> with S being a statement and this rule depending on the matching rule.
>=20

Cool thanks for the tip! I'll have to try it out.
