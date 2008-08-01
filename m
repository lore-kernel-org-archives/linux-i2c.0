From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Date: Fri, 1 Aug 2008 12:05:32 -0400
Message-ID: <9e4733910808010905s2207ac4cn9cd7729045aa1908@mail.gmail.com>
References: <4889EFFE.2070201@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
	<9e4733910807311844p142b26ffyb4105df3e136f65@mail.gmail.com>
	<48932579.3040705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <48932579.3040705@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: linux-i2c@vger.kernel.org

On 8/1/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>
> > What about the Efika which is mpc5200 based and doesn't use uboot?
> >
>
>  How does the Efika handle the dozen other properties that U-Boot normally
> initializes in the device tree?

Efika is like the original OpenFirmware. It has a Forth interpreter
and builds the device tree itself. It doesn't use flat device trees
that get filled in by the boot firmware.

>
>  --
>  Timur Tabi
>  Linux Kernel Developer @ Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
