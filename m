From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4/4] watchdog: Kontron PLD watchdog timer
Date: Sun, 26 May 2013 16:38:56 +0200
Message-ID: <20130526143856.GC7603@spo001.leaseweb.com>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com> <1365441321-21952-4-git-send-email-kevin.strasser@linux.intel.com> <20130410164717.GA19533@roeck-us.net> <20130410165733.GA2769@wrk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130410165733.GA2769@wrk>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Michael Brunner <michael.brunner@kontron.com>, Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-watchdog@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Michael Brunner <mibru@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kevin,

> On Wed, Apr 10, 2013 at 09:47:17AM -0700, Guenter Roeck wrote:
> > On Mon, Apr 08, 2013 at 10:15:21AM -0700, Kevin Strasser wrote:
> > > From: Michael Brunner <michael.brunner@kontron.com>
> > > 
> > > Add watchdog timer support for the on-board PLD found on some Kontron
> > > embedded modules.
> > > 
> > > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > > Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>
> > 
> > Personally I would prefer two separate patches for the two drivers,
> > and to have the drivers converted to the watchdog infrastructure.
> > Wim's call, of course.
> > 
> Thanks for the feedback. I'm happy to do both if Wim thinks it's
> necessary.

Yes, 2 patches with conversion to the new watchdog infrastructure please.

Kind regards,
Wim.
