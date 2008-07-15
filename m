From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Tue, 15 Jul 2008 10:43:24 +0100
Message-ID: <20080715094324.GJ30539@fluff.org.uk>
References: <486B9E30.80806@cam.ac.uk> <20080710133150.GH30539@fluff.org.uk>
	<f17812d70807100648m13896650xdafab02b5dc448ec@mail.gmail.com>
	<487A21EB.9050304@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <487A21EB.9050304@cam.ac.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 13, 2008 at 04:40:27PM +0100, Jonathan Cameron wrote:
> eric miao wrote:
> > On Thu, Jul 10, 2008 at 9:31 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> >> On Wed, Jul 02, 2008 at 04:26:40PM +0100, Jonathan Cameron wrote:
> >>> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
> >>> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
> >>> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
> >>> different normal and fast frequencies.
> >>>
> >>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> >> Unfortuantely due to the problem of all the registers in
> >> one place, this really will need to be applied by RMK. However
> >> due to the current amount of work in the PXA tree, and the
> >> number of patches he is carrying for merging this is going
> >> to be too late for this kernel merge.
> >>
> > 
> > Actually, this round of separation work of the pxa-regs.h has been
> > done several weeks ago, so I don't see this patch is likely to
> > cause any merge conflict.
> > 
> > But Russell is going to freeze the pxa branch, I see little chance
> > this be fixed quickly and get into :(
> > 
> Dear all, thanks for the comments.
> 
> I'll switch the use_pio and fast_mode flags to bit fields and resend 
> when next kernel merge begins.
> 
> As I'm maintaining rather a lot of platform specific stuff anyway for
> my use, one more won't do any harm for a few weeks!

I think most of RMK's pxa tree has been merged, so a diff
against a current -git release should give you a better
starting point.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
