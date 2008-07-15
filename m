From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [i2c] [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Tue, 15 Jul 2008 11:51:38 +0100
Message-ID: <20080715105138.GC8494@flint.arm.linux.org.uk>
References: <486B9E30.80806@cam.ac.uk> <20080710133150.GH30539@fluff.org.uk>
	<f17812d70807100648m13896650xdafab02b5dc448ec@mail.gmail.com>
	<487A21EB.9050304@cam.ac.uk> <20080715094324.GJ30539@fluff.org.uk>
	<20080715095443.GB8494@flint.arm.linux.org.uk>
	<20080715103725.GB16952@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080715103725.GB16952@digi.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: "i2c@lm-sensors.org" <i2c@lm-sensors.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 15, 2008 at 12:37:25PM +0200, Uwe Kleine-K=F6nig wrote:
> Hm, I don't see that with your current tree:
> =

> 	ukleinek@zentaur:~/gsrc/linux-2.6$ git merge-base --all rmk/pxa rmk/mast=
er
> 	543cf4cb3fe6f6cae3651ba918b9c56200b257d0

That's because you're not looking at the right master.  My master branch
is now Linus' tip, but I'm not pushing that update out because my scripts
will also push out the patch and mbox files (which, because of this, for
PXA and devel will be empty.)

I fully understand why this happens, it's just annoying when it does that
we lose the ability to have a nice clean patch.

It'll all resolve itself in the fullness of time (iow, after the SPI tree
has been merged followed by the remainder of the PXA tree.)

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
