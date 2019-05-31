From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date: Fri, 31 May 2019 14:05:13 +0200
Message-ID: <20190531120513.GB18608@lunn.ch>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190529094818.GF2781@lahna.fi.intel.com>
 <20190529155132.GZ18059@lunn.ch>
 <20190531062740.GQ2781@lahna.fi.intel.com>
 <20190531064842.GA1058@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190531064842.GA1058@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Ruslan Babayev <ruslan@babayev.com>, linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 31, 2019 at 08:48:42AM +0200, Wolfram Sang wrote:
> 
> > > Are you happy for the i2c patch to be merged via net-next?
> > 
> > Yes, that's fine my me.
> > 
> > Wolfram do you have any objections?
> 
> That's fine with me, I'd like an immutable branch, though. There are
> likely other changes to i2c.h coming and that would avoid merge
> conflicts.

Hi Wolfram

Davids Millers net-next is immutable, but large.

Maybe he can create a smaller immutable branch for you.

      Andrew
