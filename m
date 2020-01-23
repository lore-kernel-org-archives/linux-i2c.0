From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] i2c: Enable compile testing for some of drivers
Date: Thu, 23 Jan 2020 11:00:39 +0100
Message-ID: <20200123100039.GA2465@pi3>
References: <1578384779-15487-1-git-send-email-krzk@kernel.org>
 <20200123091228.GB1105@ninjato>
 <20200123093120.GA2365@pi3>
 <20200123094107.GD1105@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200123094107.GD1105@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Next Mailing List <linux-next@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 23, 2020 at 10:41:07AM +0100, Wolfram Sang wrote:
> On Thu, Jan 23, 2020 at 10:31:20AM +0100, Krzysztof Kozlowski wrote:
> > On Thu, Jan 23, 2020 at 10:12:28AM +0100, Wolfram Sang wrote:
> > > 
> > > >  config I2C_ZX2967
> > > >  	tristate "ZTE ZX2967 I2C support"
> > > > -	depends on ARCH_ZX
> > > > -	default y
> > > > +	depends on ARCH_ZX || (COMPILE_TEST && (ARC || ARM || ARM64 || M68K || RISCV || SUPERH || SPARC))
> > > > +	# COMPILE_TEST needs architectures with readsX()/writesX() primitives
> > > 
> > > The list of archs neither looks pretty nor very maintainable. My
> > > suggestion is that we leave this out of COMPILE_TEST until we have
> > > something like ARCH_HAS_READS or something. What do you think?
> > 
> > Indeed it does not look good. However having compile testing allows
> > kbuild to run sparse and smatch which already started pointing minor
> > issues in existing drivers.
> > 
> > Yeah... pros and cons... I don't have a strong opinion to keep it. Since
> > patch is important, maybe let's just skip this part?
> 
> Yeah, let's skip it for now. If you or someone is keen on having it,
> something like ARCH_HAS_READS (<- needs better name) should be
> introduced so we can use it here. But that can/should be handled
> incrementally.

Shall I send v3 or mayybe can you apply without this hunk?

Best regards,
Krzysztof
