From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Mon, 15 Jun 2015 12:29:03 +0300
Message-ID: <20150615092903.GG1478@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150610075555.GO1478@lahna.fi.intel.com>
 <CAKi4VA+6UBD8BeT-a0H=UiPM8OFiTD9cfTSEhX5scE+3EJPRfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKi4VA+6UBD8BeT-a0H=UiPM8OFiTD9cfTSEhX5scE+3EJPRfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Fabio Mello <fabio.mello@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 12, 2015 at 07:45:00PM -0300, Lucas De Marchi wrote:
> Hi Mika,
> 
> On Wed, Jun 10, 2015 at 4:55 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Mon, Jun 08, 2015 at 02:50:28PM -0300, lucas.de.marchi@gmail.com wrote:
> >> @@ -320,7 +320,7 @@ static int dw_i2c_resume(struct device *dev)
> >>       clk_prepare_enable(i_dev->clk);
> >>
> >>       if (!i_dev->pm_runtime_disabled)
> >> -             i2c_dw_init(i_dev);
> >> +             i2c_dw_enable(i_dev);
> >
> > This will not work if the device power gets removed (for example being
> > put to D3cold) as it looses context.
> 
> Do you mean we should keep the i2c_dw_init() here?

Yes, that's safer if the controller power gets removed.
