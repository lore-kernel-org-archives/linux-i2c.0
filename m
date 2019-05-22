From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date: Wed, 22 May 2019 10:21:47 +0530
Message-ID: <CAARK3HmAYjnBH6Aa_R_uKQPs5JAdBAEt1=dvPz1mLmGaKKpP9w@mail.gmail.com>
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-2-git-send-email-sagar.kadam@sifive.com> <20190521135625.GN22024@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521135625.GN22024@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Tue, May 21, 2019 at 7:26 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  Required properties:
> > -- compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> > +- compatible      : "opencores,i2c-ocores",
> > +                 "aeroflexgaisler,i2cmst",
> > +                    "sifive,fu540-c000-i2c","sifive,i2c0".
> > +                 For Opencore based I2C IP block reimplemented in
>
> It looks like there are some tabs vs space issues here.

Ohh. It was not catched in checkpatch.pl. I will update it.

Thanks,
Sagar Kadam


>    Andrew
