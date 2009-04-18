From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] [ARM] pxa: lx: add PCON i2c driver
Date: Sat, 18 Apr 2009 19:10:30 +0100
Message-ID: <20090418181030.GC1236@n2100.arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk>
	<1240064452-14691-1-git-send-email-linux@arm.linux.org.uk>
	<20090418162900.0dc16531@hyperion.delvare>
	<20090418144234.GB1236@n2100.arm.linux.org.uk>
	<20090418173406.GA16195@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20090418173406.GA16195@sirena.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jean Delvare <khali@linux-fr.org>, linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Apr 18, 2009 at 06:34:06PM +0100, Mark Brown wrote:
> On Sat, Apr 18, 2009 at 03:42:34PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Apr 18, 2009 at 04:29:00PM +0200, Jean Delvare wrote:
> 
> > > > The PCON device on the LX platform is the heart of the platform,
> > > > managing the power, providing battery information, booting, suspend/
> > > > resume and keyboard services to the PXA CPU.
> 
> > > Nack. Really, people, please read the files you modify, it isn't that
> > > hard.
> 
> > Maybe you can suggest a better place for it?
> 
> drivers/mfd?

It's not a multifunction device.  It's a microcontroller.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
