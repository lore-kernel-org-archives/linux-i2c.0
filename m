From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v6 0/5] i2c: ocores: improvements
Date: Thu, 14 Feb 2019 09:39:32 +0100
Message-ID: <4284641.8ec35d25Ci@pcbe13614>
References: <20190211164913.5988-1-federico.vaga@cern.ch> <20190214030733.GG24589@lunn.ch>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214030733.GG24589@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday, February 14, 2019 4:07:33 AM CET Andrew Lunn wrote:
> On Mon, Feb 11, 2019 at 05:49:08PM +0100, Federico Vaga wrote:
> > This patch set provides improvements to the i2c-ocore driver.
> > 
> > [V5 -> V6]
> > - remove redundant code introduced in V5 (double read control register)
> > 
> > [V4 -> V5]
> > - deterministic status of IEN bit in register "CONTROL" at the end of
> > 
> >   ocores_init()
> > 
> > - more style fixes
> > 
> > [V3 -> V4]
> > - add reviews-by/tested-by
> > - add comment to justify the formula in
> > 
> >     udelay((8 * 1000) / i2c->bus_clock_khz);
> 
> Hi Federico
> 
> It looks like all the reviewed-by: tags disappeared from v5.
> 
> Can you add them back again, and then we can probably merge this
> patchset.

v7 is coming (@wolfram) with SPDX tag in the header file

> 	Thanks
> 		Andrew
