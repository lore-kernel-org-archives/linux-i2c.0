From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 v2 1/3] dt-bindings: i2c: extend existing opencore
 bindings.
Date: Tue, 14 May 2019 15:01:13 +0200
Message-ID: <20190514130113.GB5892@lunn.ch>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
 <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
 <20190513205615.GA5844@bogus>
 <CAARK3HkTCGWg4CAo1LmQHmf4_NFukjTwO1LAHjgSTS+R_5CRSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAARK3HkTCGWg4CAo1LmQHmf4_NFukjTwO1LAHjgSTS+R_5CRSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Kadam <sagar.kadam@sifive.com>
Cc: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> > > +     */
> > > +     i2c@10030000 {
> > > +                     compatible = "sifive,i2c0","sifive,fu540-c000-i2c";
> > > +                     reg = <0x0 0x10030000 0x0 0x1000>;
> > > +                     reg-names = "i2c-control";
> >
> > Not doucmented.
> In v1, I had added a new binding file as sifive-i2c-ocores.txt for
> SiFive i2c core.
> After Andrew's suggestion,  extending the available i2c-ocores.txt
> seemed to be a better idea rather than adding a new file.
> so added an example node which is HiFive specific in the existing file.
> Please let me know if I need to handle this in a different way.

Hi Sagar

Is reg-names actually needed?

   Andrew
