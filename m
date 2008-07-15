From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: [i2c] [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Tue, 15 Jul 2008 12:37:25 +0200
Message-ID: <20080715103725.GB16952@digi.com>
References: <486B9E30.80806@cam.ac.uk> <20080710133150.GH30539@fluff.org.uk>
	<f17812d70807100648m13896650xdafab02b5dc448ec@mail.gmail.com>
	<487A21EB.9050304@cam.ac.uk> <20080715094324.GJ30539@fluff.org.uk>
	<20080715095443.GB8494@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080715095443.GB8494@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "i2c@lm-sensors.org" <i2c@lm-sensors.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

Hi Russell,

Russell King - ARM Linux wrote:
> On Tue, Jul 15, 2008 at 10:43:24AM +0100, Ben Dooks wrote:
> > I think most of RMK's pxa tree has been merged, so a diff
> > against a current -git release should give you a better
> > starting point.
> =

> There's still around 300K of PXA stuff outstanding - but unfortunately
> I can't update the 'nightly' snapshots with the outstanding commits
> because I can't get a reasonable patch out of git:
> =

> $ git-diff -u master...pxa |less
> diff --cc MAINTAINERS
> index 1528e58,8f0ec46,c68a118..20aef95
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@@ -481,11 -475,11 -475,11 +475,28 @@@@ M:    kernel@wantstofly.or
>    L:   linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
>    S:   Maintained
> =

> +++ARM/COMPULAB CM-X270/EM-X270 MACHINE SUPPORT
> +++P:   Mike Rapoport
> +++M:   mike@compulab.co.il
> +++L:   linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
> +++S:   Maintained
> +++
> =

> This is basically because 'master...pxa' has multiple common ancestors.
Hm, I don't see that with your current tree:

	ukleinek@zentaur:~/gsrc/linux-2.6$ git merge-base --all rmk/pxa rmk/master
	543cf4cb3fe6f6cae3651ba918b9c56200b257d0

and so git-diff -u rmk/master...rmk/pxa looks good here, too.

Anyway, IIRC you can apply the above patch with git-apply, didn't test
it though.  And if you don't want the people having to rely on git, you
still can merge master and pxa and provide a diff between some fixed
base and the merge result.  (Or provide two patches and let the others
do the merge.)

Best regards
Uwe

-- =

Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisach, =
Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
