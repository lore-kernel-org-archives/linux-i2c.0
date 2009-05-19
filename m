From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v2
Date: Tue, 19 May 2009 19:40:59 +0100
Message-ID: <20090519184059.GB4476@sirena.org.uk>
References: <63386a3d0905181340y42ad1868k6b2978e586abc18d@mail.gmail.com> <4A12C3B5.2050100@compulab.co.il> <63386a3d0905190923t36d301c5hf245c06db00b6127@mail.gmail.com> <5d5443650905191026w22b0ff95j992e09923f55dd0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754989AbZESSlR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650905191026w22b0ff95j992e09923f55dd0a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Mike Rapoport <mike@compulab.co.il>, linux-kernel@vger.kernel.org, sameo@linux.intel.com, linux-i2c@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 19, 2009 at 10:56:16PM +0530, Trilok Soni wrote:

> I don't know but why people are not encouraging to use mfd_xxx apis
> here? Lot's of drivers are available under drivers/mfd, but only
> couple of them are using real mfd_xxx apis? Is there anything missing
> in those apis?

The mfd_ APIs only really help with memory mapped platform devices but a
lot of MFD devices are controlled using I2C and SPI interfaces instead.
On registration they need to at least do something extra to allow the
client devices to access the I2C or SPI control structure, or the client
drivers have to do something like fish around using their parent
pointer.

It's not so much that there's something wrong with the MFD APIs as
issues with splitting up I2C and SPI devices for access in a generic
manner.  With things mapped through struct resource the MFD API is able
to provide some help.
