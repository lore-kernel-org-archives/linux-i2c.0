From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH V3] I2C driver for IMX
Date: Thu, 10 Apr 2008 12:01:41 +0200
Message-ID: <20080410120141.4d220d27@hyperion.delvare>
References: <ftf8ud$pl6$1@ger.gmane.org>
	<20080409232834.GG1197@trinity.fluff.org>
	<Pine.LNX.4.64.0804092223540.10428@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0804092223540.10428@gate.crashing.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Darius <augulis.darius@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org, Ben Dooks <ben-linux-arm@fluff.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Apr 2008 22:25:39 -0500 (CDT), Kumar Gala wrote:
> 
> On Thu, 10 Apr 2008, Ben Dooks wrote:
> 
> > On Tue, Apr 08, 2008 at 11:01:25AM +0300, Darius wrote:
> > > changes:
> > > 1. Removed hardcoded constants
> > > 2. Fixed bug in chip hardware
> > > 3. Added i2c device for mx1ads
> > >
> > > Tested with mx1ads v2.0 board and LCD on I2C interface driver
> > >
> > > Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> > > ---
> >
> > Hmm, this hasn't appeared on the i2c list where it should be being
> > reviewed before submission. Not bothered to look or snip the rest.
> 
> looking at this it seems the HW is identical to the driver handled by
> i2c-mpc.c.  (which is used on Motorola and now Freescale PPC chips).

Then I guess that we want to add support to the i2c-mpc driver rather
than adding another driver to the kernel tree?

-- 
Jean Delvare

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
