From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7] i2c-designware: make SDA hold time configurable
Date: Fri, 17 May 2013 11:44:37 +0300
Message-ID: <20130517084437.GD11878@intel.com>
References: <20130327084158.GB11010@ab42.lan>
 <1364373760-12469-1-git-send-email-christian.ruppert@abilis.com>
 <20130514110745.GA10906@intel.com>
 <20130517082925.GB17056@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130517082925.GB17056@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Ruppert <christian.ruppert@abilis.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 17, 2013 at 10:29:28AM +0200, Wolfram Sang wrote:
> On Tue, May 14, 2013 at 02:07:45PM +0300, Mika Westerberg wrote:
> > On Tue, Apr 09, 2013 at 12:59:54PM +0200, Christian Ruppert wrote:
> > > This patch makes the SDA hold time configurable through device tree.
> > > 
> > > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.com>
> > 
> > Hi Wolfram,
> > 
> > What happened to this patch? I don't see it merged for 3.10.
> > 
> > The reason I'm asking is that I would like to add ACPI support for the SDA
> > hold time parameter analogous to the DT version.
> 
> New bindings are complicated. I need to check if there is an
> existing/similar one, check if it is generic enough for drivers still to
> come, etc. I didn't have the time to do this for 3.10, so it is
> 3.11 material.

OK, thanks. I just wanted to be sure this patch wasn't forgotten as it is
useful for Haswell/Lynxpoint as well.
