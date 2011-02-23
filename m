From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] i2c: xiic: Use 32bit accesses only
Date: Wed, 23 Feb 2011 09:36:09 +0100
Message-ID: <201102230936.09921.arnd@arndb.de>
References: <1298396971-611-1-git-send-email-monstr@monstr.eu> <AANLkTinRVKMdOU-8DYLHe5q92nb3ysKnnG-jq8f++AEs@mail.gmail.com> <4D64C08F.5030604@monstr.eu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D64C08F.5030604@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, monstr@monstr.eu
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-i2c@vger.kernel.org, john.williams@petalogix.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 23 February 2011 09:08:47 Michal Simek wrote:
> 
> Grant Likely wrote:
> > On Tue, Feb 22, 2011 at 10:49 AM, Michal Simek <monstr@monstr.eu> wrote:
> >> i2c driver is used for LE/BE that's why is useful to use
> >> 32bit accesses. Then it is not necessary to solve any
> >> endian issues.
> > 
> > Are you sure?  I would expect the BE version needs to use
> > io{read,write}32be variants of the accessors.  What platforms have you
> > tested on?
> 
> iowrite32 is the same with iowrite32be for Microblaze.
> I have no problem to change it to iowrite32be if you like.
> 
> I have tested it on microblaze big and little endian platforms.

I think what Grant was saying is that iowrite32 being the same as
iowrite32be is a bug, because iowrite32 is documented to be little-endian.

This is probably fine as long as you don't have any PCI devices,
but if you ever get PCI support, it won't work.

Also, it heavily confuses other developers such as Grant and me
if one architecture defines things to mean something completely
different from the other architectures.

	Arnd
