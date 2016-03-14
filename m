From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v3 03/14] i2c-octeon: Cleanup resource allocation code
Date: Mon, 14 Mar 2016 10:21:41 +0100
Message-ID: <20160314092141.GB2503@hardcore>
References: <cover.1457362545.git.jglauber@cavium.com>
 <f33c059a7df4d76768c4b9345c341bdeea2b6484.1457362545.git.jglauber@cavium.com>
 <20160312153715.GF1661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160312153715.GF1661@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 12, 2016 at 04:37:15PM +0100, Wolfram Sang wrote:
> On Mon, Mar 07, 2016 at 04:10:46PM +0100, Jan Glauber wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Use resource start and size directly.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> What about converting to devm_ioremap_resource()?
> 

Nice. I'll use that.
