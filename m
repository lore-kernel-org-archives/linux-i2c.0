From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC i2c/for-next] i2c: rcar: Add per-Generation fallback
 bindings
Date: Thu, 1 Dec 2016 16:32:08 +0100
Message-ID: <20161201153208.GA2389@verge.net.au>
References: <1480605494-32460-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480605494-32460-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 01, 2016 at 04:18:14PM +0100, Simon Horman wrote:
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the
> relationship between IP blocks might be. For example, I believe that
> r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> descendant of the former or vice versa.
> 
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
> 
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for
> drivers for Renesas SoCs.
> 
> Also deprecate renesas,i2c-rcar. It seems poorly named as it is only
> compatible with R-Car Gen 1. It also appears unused in mainline.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Sorry, I seem to have omitted the driver (C code) portion of this change.
I send v2.
