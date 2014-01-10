From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
Date: Fri, 10 Jan 2014 12:05:21 -0700
Message-ID: <20140110190521.GI18269@obsidianresearch.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140110182240.GK19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:

> Do we create new compatible strings to indicate errata, or to indicate
> 'from this version forward there are new features'?  The former would
> indicate as Gregory has written '...-a0-i2c', the latter would warrant
> '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.

IMHO the compatible string should represent a specific HW/SW ABI. So
you need a unique compatible string for every variation of that ABI.

We already have a compatible string defined for the ABI that B0
presents.

Jason
