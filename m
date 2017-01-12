From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Thu, 12 Jan 2017 19:01:22 +0200
Message-ID: <1484240482.2133.92.camel@linux.intel.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
         <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
         <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
         <b5788d1d-c951-0fc3-eed8-88457df1f27e@mleia.com>
         <CAHp75Ve7zNN3m1ngLGi-81mFehKzZG07mh5H2T5+_k-=jJqqNA@mail.gmail.com>
         <3748130b-5321-12eb-ec75-e2637dd9fc54@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3748130b-5321-12eb-ec75-e2637dd9fc54@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Sat, 2017-01-07 at 03:24 +0200, Vladimir Zapolskiy wrote:
> On 01/07/2017 02:19 AM, Andy Shevchenko wrote:
> > On Sat, Jan 7, 2017 at 1:43 AM, Vladimir Zapolskiy <vz@mleia.com>
> > wrote:
> > > On 01/07/2017 12:45 AM, Andy Shevchenko wrote:

> > > > +             }
> > > > > > +     } else if (IS_BUILTIN(CONFIG_ACPI) &&
> > > > > > ACPI_HANDLE(dev)) {
> > > > > > +             dev_dbg(dev, "ACPI slave is not supported
> > > > > > yet\n");
> > > > > > +     }
> > > > > 
> > > > > If so, then it might be better to drop else-if stub for now.
> > > > 
> > > > Please, don't.
> > > > 
> > > 
> > > Why do you ask for this stub to be added?
> > 
> > 1. Exactly the reason you asked above. Here is the code which has
> > built differently on different platforms. x86 usually is not using
> > CONFIG_OF, ARM doesn't ACPI (versus ARM64). Check GPIO library for
> > existing examples.
> 
> From the context by the stub I mean dev_dbg() in
> i2c_slave_mode_detect()
> function, I don't see a connection to GPIO library, please clarify.

I agree that is not good proof for using IS_ENABLED/IS_BUILTIN macro.

> > 2. We might add that support later, but here is again, just no-op.
> > 
> > So, what is your strong argument here against that?
> 
> When the support is ready for ACPI case, you'll remove the added
> dev_dbg(), and I don't see a good point by adding it temporarily.

It would remind me to look at it at some point.

> What is wrong with the approach of adding the ACPI case handling
> branch when it is ready and remove any kind of stubs right now?

I will not object. Here is maintainer, let him speak.

> On ACPI platforms the function returns 'false' always, will the
> function work correctly (= corresponding to its description) as is?

Yes.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
