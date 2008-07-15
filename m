From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [i2c] [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Tue, 15 Jul 2008 10:54:43 +0100
Message-ID: <20080715095443.GB8494@flint.arm.linux.org.uk>
References: <486B9E30.80806@cam.ac.uk> <20080710133150.GH30539@fluff.org.uk>
	<f17812d70807100648m13896650xdafab02b5dc448ec@mail.gmail.com>
	<487A21EB.9050304@cam.ac.uk> <20080715094324.GJ30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080715094324.GJ30539@fluff.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 15, 2008 at 10:43:24AM +0100, Ben Dooks wrote:
> I think most of RMK's pxa tree has been merged, so a diff
> against a current -git release should give you a better
> starting point.

There's still around 300K of PXA stuff outstanding - but unfortunately
I can't update the 'nightly' snapshots with the outstanding commits
because I can't get a reasonable patch out of git:

$ git-diff -u master...pxa |less
diff --cc MAINTAINERS
index 1528e58,8f0ec46,c68a118..20aef95
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@@ -481,11 -475,11 -475,11 +475,28 @@@@ M:    kernel@wantstofly.or
   L:   linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
   S:   Maintained

+++ARM/COMPULAB CM-X270/EM-X270 MACHINE SUPPORT
+++P:   Mike Rapoport
+++M:   mike@compulab.co.il
+++L:   linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
+++S:   Maintained
+++

This is basically because 'master...pxa' has multiple common ancestors.

You can get a diff from 'master..pxa' but that will be a patch which
removes changes in master but not pxa, and applies changes in pxa but
not master, which isn't useful.

Of course, those with git can get the full tree and there isn't a
problem moving through the history... those using the patches, however,
are going to be facing a problem for the time being.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
