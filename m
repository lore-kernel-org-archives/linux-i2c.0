From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
 configurable via FDT
Date: Thu, 31 Jul 2008 16:32:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca> <4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891E06A.4070608@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4891E06A.4070608-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jul 2008, Timur Tabi wrote:
> Jon Smirl wrote:
>
> > Aren't the tables in the manual there just to make it easy for a human
> > to pick out the line they want? For a computer you'd program the
> > formula that was used to create the tables.
>
> Actually, the tables in the manuals are just an example of what can be
> programmed.  They don't cover all cases.  The tables assume a specific value of
> DFSR.
>
> For 8xxx, you want to use AN2919 to figure out how to really program the device.
>
> The table I generated for U-Boot is based on the calculations outlined in
> AN2919.  I debated trying to implement the actual algorithm, but decided that
> pre-calculating the values was better.  The algorithm is very convoluted.

And I decided to program the algorithm.  It's not that complex and overall
compiles to less total size than the table method.  It doesn't involve some
black box table either.

The real problem, which kept me from making a patch to do this months ago,
is that the source clock that the I2C freq divider applies to is different
for just about every MPC8xxx platform.  Not just a different value, but a
totally different internal clock.  Sometimes is CCB, sometimes CCB/2,
sometimes tsec2's clock, etc.  Sometimes the two i2c controllers don't even
have the same clock.  I didn't see any easy way to get this information.
In U-Boot I get it from the global board info struct, but I didn't see
anything like this in Linux.

> > I agree that it took me half an hour to figure out the formula that
> > was needed to compute the i2s clocks, but once you figure out the
> > formula it solves all of the cases and no one needs to read the manual
> > any more. The i2c formula may even need a small loop which compares
> > different solutions looking for the smallest error term. But it's a
> > small space to search.

Yes, I needed a loop.  The divider ends up having the form (a + c) << b,
where a is from some set of eight integers between 2 and 15, b has a range
of like 5 to 12, and c is usually zero.

So, I find the divider I want to get, loop over each b, shift the divider
right by b and find the closest (a+c) to that, calculate the error, and
then use the best one.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
