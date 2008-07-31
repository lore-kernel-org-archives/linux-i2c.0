From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable	via FDT
Date: Thu, 31 Jul 2008 12:21:42 -0600
Message-ID: <20080731182141.GA29097@secretlab.ca>
References: <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <4891FF51.4020701@grandegger.com>
	<fa686aa40807311107m44ce7fbk35e94d1a24b992fb@mail.gmail.com>
	<48920016.5000506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48920016.5000506-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 31, 2008 at 01:10:30PM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> > On Thu, Jul 31, 2008 at 12:07 PM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
> >> We could add a property "source-clock-divider = <2/3>" if it's needed!?
> > 
> > fsl,source-clock-divider
> > 
> > But, yes, this is a good solution (assuming that it is a board or SoC
> > characteristic, and not just a choice that the driver has the option
> > of making on it's own).
> 
> I was going to suggest the actual clock frequency of the I2C device.  It would
> be value of gd->i2c1_clk or gd->i2c2_clk from U-Boot.  The actual divider value
> is meaningless.

I'm cool with that too, as long as it gets documented

g.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
