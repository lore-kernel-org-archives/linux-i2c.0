From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date: Fri, 31 May 2019 19:33:20 +0100
Message-ID: <20190531183320.vrle32ps5jga37pn@shell.armlinux.org.uk>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190530.112759.2023290429676344968.davem@davemloft.net>
 <20190531125751.GB951@kunai>
 <20190531.112208.2148170988874389736.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190531.112208.2148170988874389736.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: wsa@the-dreams.de, ruslan@babayev.com, mika.westerberg@linux.intel.com, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 31, 2019 at 11:22:08AM -0700, David Miller wrote:
> From: Wolfram Sang <wsa@the-dreams.de>
> Date: Fri, 31 May 2019 14:57:52 +0200
> 
> >> Series applied.
> > 
> > Could you make a small immutable branch for me to pull into my I2C tree?
> > I have some changes for i2c.h pending and want to minimize merge
> > conflicts.
> 
> I already put other changes into net-next and also just merged 'net'
> into 'net-next' and pushed that out to git.kernel.org, so I don't know
> how I can still do that for you.
> 
> If it's still possible I'm willing to learn just show me what to do :)

i don't think it's possible - not with the changes having already
been merged yesterday, and presumably published shortly thereafter.

The tree contains 231 other changes wrt 5.2-rc2 up to the requested
point, which I doubt Wolfram will want.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
