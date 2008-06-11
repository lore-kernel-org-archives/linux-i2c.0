From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 22:31:27 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806112226060.14077@cliff.in.clinika.pl>
References: <200806091541.43899.u.luckas@road.de> <485031D5.3020606@bluewatersys.com>
 <20080611141852.3ccd89ea@hyperion.delvare> <200806111327.09298.david-b@pacbell.net>
 <20080611225416.169574a0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756744AbYFKVcf@vger.kernel.org>
In-Reply-To: <20080611225416.169574a0@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>, Ryan Mallon <ryan@bluewatersys.com>, Uli Luckas <u.luckas@road.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Jun 2008, Jean Delvare wrote:

> That being said, I'm not sure if the comparison with the PCI subsystem
> holds... I am under the impression that PCI bus handling doesn't
> require dedicated drivers? At least I can't see any under drivers/pci.

 Of course it does require them.  It is just due to their very nature they
tend to be placed under arch/, although there are some cases where the
same system controller can be used for a range of processors (e.g. some
Marvell chips can be used either with MIPS or PowerPC CPUs) and they might
be arguably put in a place more suitable for sharing between
architectures.  See arch/mips/pci/ for an example of a generous bunch of
PCI host drivers.

  Maciej
