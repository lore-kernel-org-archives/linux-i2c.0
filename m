From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Thu, 6 Nov 2014 15:58:18 -0600
Message-ID: <1415311098.23458.405.camel@snotra.buserror.net>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
	 <1414537731.23458.120.camel@snotra.buserror.net>
	 <5450AC85.40302@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5450AC85.40302-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Linux PowerPC Kernel <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brunck, Holger" <Holger.Brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-10-29 at 09:59 +0100, Valentin Longchamp wrote:
> On 10/29/2014 12:08 AM, Scott Wood wrote:
> > On Fri, 2014-10-17 at 11:27 +0200, Valentin Longchamp wrote:
> >> With "fsl-i2c" compatibility the i2c frequency is not set
> >> correctly, because it sets no prescaler. According to the AN2919 from
> >> Freescale and the QorIQ (P2041) documentation, the source clock is 1/2
> >> the platform clock. This implies that a prescaler of 2 must be used.
> >>
> >> This changes the compatibility of the qoriq-i2c .dtsi files to pick the
> >> mpc8543, which uses the same driver but sets the correct prescaler.
> >>
> >> Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> >> ---
> >>
> >>  arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi | 4 ++--
> >>  arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> >> index 5f9bf7d..aa6c366 100644
> >> --- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> >> +++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> >> @@ -36,7 +36,7 @@ i2c@118000 {
> >>  	#address-cells = <1>;
> >>  	#size-cells = <0>;
> >>  	cell-index = <0>;
> >> -	compatible = "fsl-i2c";
> >> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
> >>  	reg = <0x118000 0x100>;
> >>  	interrupts = <38 2 0 0>;
> >>  	dfsrr;
> >> @@ -46,7 +46,7 @@ i2c@118100 {
> >>  	#address-cells = <1>;
> >>  	#size-cells = <0>;
> >>  	cell-index = <1>;
> >> -	compatible = "fsl-i2c";
> >> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
> >>  	reg = <0x118100 0x100>;
> >>  	interrupts = <38 2 0 0>;
> >>  	dfsrr;
> > 
> > Are all chips that use this dtsi 100% compatible with mpc8543's i2c, or
> > just in ways the Linux driver cares about?
> 
> I have just looked briefly at the mpc8548 RM (covers mpc8543) and its i2c
> controller looks the same as the qoriq's. I cannot however state if they are
> 100% compatible.
> 
> If we wanted to be on the safe side and strict (since we are not sure that the
> hardware is 100% compatible), we maybe should add a fsl,qoriq-i2c compatible to
> the driver that does the same as mpc8543-i2c.

If we're going to change the device tree I'd rather just add a property
to say what the prescaler is.

-Scott
