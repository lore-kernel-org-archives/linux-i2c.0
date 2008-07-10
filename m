From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Thu, 10 Jul 2008 14:31:50 +0100
Message-ID: <20080710133150.GH30539@fluff.org.uk>
References: <486B9E30.80806@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <486B9E30.80806@cam.ac.uk>
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
Cc: linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 02, 2008 at 04:26:40PM +0100, Jonathan Cameron wrote:
> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
> different normal and fast frequencies.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Unfortuantely due to the problem of all the registers in
one place, this really will need to be applied by RMK. However
due to the current amount of work in the PXA tree, and the
number of patches he is carrying for merging this is going
to be too late for this kernel merge.

I would like to see the pxa-regs.h split up further so that
subsystems can issue patches to it without causing problems
for Russell... I will bring this up for the next round of
development.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
