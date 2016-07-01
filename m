From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Thu, 30 Jun 2016 20:20:44 -0500
Message-ID: <20160701012044.GA5619@rob-hp-laptop>
References: <1467022282-21062-1-git-send-email-peda@axentia.se>
 <57712770.3040204@roeck-us.net>
 <d7476000-e50c-b840-00a5-7eab1a0823fb@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34002 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbcGABjb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Jun 2016 21:39:31 -0400
Content-Disposition: inline
In-Reply-To: <d7476000-e50c-b840-00a5-7eab1a0823fb@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Mon, Jun 27, 2016 at 06:27:21PM +0200, Peter Rosin wrote:
> On 2016-06-27 15:17, Guenter Roeck wrote:
> > On 06/27/2016 03:11 AM, Peter Rosin wrote:
> >> Fill the gap for this pre-existing driver.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>   .../devicetree/bindings/i2c/i2c-arb-pca9541.txt    | 33 ++++++++++++++++++++++
> >>   MAINTAINERS                                        |  1 +
> >>   2 files changed, 34 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
> >>
> >> Hi!
> >>
> >> I'm wondering about this driver. It is not a trivial device, and yet it
> >> has historically relied on the i2c core matching the chip w/o vendor
> >> prefix. This is not ideal. But what to do about the driver implementing
> >> this in terms of an i2c-mux, somthing which the chip is not; It is an
> >> i2c arbitrator. It just happens to rely on the i2c mux core also handling
> >> i2c gates and i2c arbitrators. But that seems like a Linux detail. So I
> >> don't know what to do here?
> >>
> > 
> > The concept of arbitrators didn't exist when I wrote the driver. I would not
> > have a problem with renaming the file if that is what you are asking for.
> 
> No, that was not my issue, I just wanted to document bindings for pca9541,
> and I didn't like how it turned out.
> 
> I don't really care if the bindings doc is named i2c-mux-pca9541.txt (that
> would match the name of the driver, but it still wouldn't make the chip a mux).

So name it i2c-pca9541.txt or the somewhat standard nxp,pca9541.txt 
following the compatible.

> 
> >> That is, the patch - as is - describes something that would be trivial to
> >> support today, but at the same time it seems to be too tied to Linux.
> >>
> >> The problem is that the i2c@0 intermediate node is not really needed, but
> >> at the same time removing it would cause a disruption for the driver since
> >> it can't really use the i2c mux core if that node isn't there. I don't
> >> see a simple way to fix that in the i2c mux core either (but admittedly
> >> haven't given it too much thought).
> >>
> > 
> > The gpio arbitrator uses the same principle as well. Why not just leave it
> > alone ? Besides, I think it is a good idea to have it, since it groups
> > the i2c devices behind the chip together. I would not consider that to be
> > a Linuxism, but a design choice.
> 
> The grouping argument would make sense if there was anything outside the
> group. Also, the required reg property and the extra #address-cells and
> #size-cells doesn't add anything and just gets in the way, and is indeed
> the result of Linuxisms leaking back into device trees.
> 
> If there were no muxes and this was a new driver, the example bindings
> would almost certainly have been something like:
> 
> 	i2c-arbitrator@74 {
> 		compatible = "nxp,pca9541";
> 		reg = <0x74>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		eeprom@54 {
> 			compatible = "at,24c08";
> 			reg = <0x54>;
> 		};
> 	};
> 
> which I find much nicer.

Yes.

> But, I can't find a way to implement that and keep backwards compatibility
> with old existing device trees.

I don't see any in the kernel tree nor is it documented, so there is not 
compatibility to worry about.

> 
> Which is why I submitted the patch I did. It documents the pca9541 bindings,
> something which is lacking, in terms of i2c-mux as the driver is written.
> At the same time, this feels ugly and exposes linuxism and I wanted to make
> that clear up front. The above simply looks better than the example in the
> patch.
> 
> I intended to mark the submission [RFC PATCH], but I now realize that that
> went missing along the way, sorry.
