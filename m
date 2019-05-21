From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v5 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
Date: Tue, 21 May 2019 14:27:54 +0530
Message-ID: <CAARK3Hn4-amRV-knDa5UR8J68DKxWaBnC3O98KvciNpbwbsAGA@mail.gmail.com>
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
 <1558361478-4381-4-git-send-email-sagar.kadam@sifive.com> <mvm7eakjjf7.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvm7eakjjf7.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com, Andrew Lunn <andrew@lunn.ch>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thanks Andreas,
Yes, I rebased to v5.2-rc1 and observed that there have been changes
in polling interface, and i2c->flags is not longer being used for
setting the polling mode. I am working on a way to hook in the fix for
broken IRQ and will submit it in v6.

Thanks & BR,
Sagar Kadam

On Tue, May 21, 2019 at 2:03 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 20 2019, Sagar Shrikant Kadam <sagar.kadam@sifive.com> wrote:
>
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
>
> After commit dd7dbf0eb090 this no longer fits.
>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
