From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v5 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
Date: Mon, 20 May 2019 20:50:06 +0530
Message-ID: <CAARK3HnG4qg64cc_fjffxGp5EVTLdmWdkMVDx3YvK=coGAuqHw@mail.gmail.com>
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
 <1558361478-4381-4-git-send-email-sagar.kadam@sifive.com> <20190520145216.GD22024@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520145216.GD22024@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 20, 2019 at 8:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 20, 2019 at 07:41:18PM +0530, Sagar Shrikant Kadam wrote:
> > The i2c-ocore driver already has a polling mode interface.But it needs
> > a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
> > There is an erratum in FU540 chip that prevents interrupt driven i2c
> > transfers from working, and also the I2C controller's interrupt bit
> > cannot be cleared if set, due to this the existing i2c polling mode
> > interface added in mainline earlier doesn't work, and CPU stall's
> > infinitely, when-ever i2c transfer is initiated.
> >
> > Ref:previous polling mode support in mainline
> >
> >       commit 69c8c0c0efa8 ("i2c: ocores: add polling interface")
> >
> > The workaround / fix under OCORES_FLAG_BROKEN_IRQ is particularly for
> > FU540-COOO SoC.
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
>
> Much better, thanks.
My pleasure Andrew.
Appreciate your timely review and response.

>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

Thanks,
Sagar
