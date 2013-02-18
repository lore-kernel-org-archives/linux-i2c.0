From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] i2c-designware: make SDA hold time configurable
Date: Mon, 18 Feb 2013 15:28:44 +0200
Message-ID: <20130218132843.GA2439@intel.com>
References: <20130218105742.GK20771@intel.com>
 <1361191905-30099-1-git-send-email-christian.ruppert@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361191905-30099-1-git-send-email-christian.ruppert@abilis.com>
Sender: linux-doc-owner@vger.kernel.org
To: Christian Ruppert <christian.ruppert@abilis.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 18, 2013 at 01:51:45PM +0100, Christian Ruppert wrote:
> This patch makes the SDA hold time configurable through device tree.
> It was tested on a hybrid of i2c/next and arc-3.8-baseline (see
> https://github.com/foss-for-synopsys-dwc-arc-processors/linux/commits/arc-3.8-baseline) since our platform is ARC based and this architecture is not yet
> supported by i2c/next.
> 
> Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
