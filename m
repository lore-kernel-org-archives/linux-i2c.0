From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Thu, 8 Aug 2013 13:02:38 -0400
Message-ID: <20130808170238.GK8204@titan.lakedaemon.net>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
 <20130807143546.GD2978@katana>
 <20130807155700.GE19280@titan.lakedaemon.net>
 <5203B97A.8060605@free-electrons.com>
 <20130808164323.GD27325@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130808164323.GD27325@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Wolfram Sang <wsa@the-dreams.de>, Nadav Haklai <nadavh@marvell.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <Leif.Lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "jcm@redhat.com" <jcm@redhat.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "vanhoof@canonical.com" <vanhoof@canonical.com>, Piotr Ziecik <kosmo@semihalf.c>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 08, 2013 at 05:43:23PM +0100, Mark Rutland wrote:
> On Thu, Aug 08, 2013 at 04:30:02PM +0100, Gregory CLEMENT wrote:
> > On 07/08/2013 17:57, Jason Cooper wrote:
> > > On Wed, Aug 07, 2013 at 04:35:46PM +0200, Wolfram Sang wrote:
> > >>
> > >>> But we shouldn't use it alone: we should always use:
> > >>> compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> > >>>
> > >>> From my point of view using  "marvell,mv78230-i2c" alone is an error.
> > >>>
> > >>> Wolfram what is your opinion on it?
> > >>
> > >> It is not strictly an error, but risky. If you use an older Kernel
> > >> version (or other OS) which only offers "mv64xxx" you will have no
> > >> match. Although the driver theoretically could have basic support for
> > >> all mv64xxx variants skipping all additional features of later IP
> > >> revisions.
> > > 
> > > I agree here.  The driver is advertising what IP blocks it can handle,
> > > so it makes sense to add both strings since it can handle both.
> > 
> > Wolfram,
> > so beside remarks about the compatibility strings. I didn't any other
> > comment since the v3 which was 7 weeks ago.
> > 
> > Does it mean that once I will have added the handle of this string,
> > you will be able to take the series for the 3.12 kernel?
> 
> Please could you also ensure the new string is documented in
> Documentation/devicetree, with a brief description of what it implies
> about the hardware beyond the exiting "marvell,mv64xxx-i2c" string.

That was in patch 3/3:

  ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c

Which I've applied here:

  http://git.infradead.org/linux-mvebu.git/commitdiff/e7c4a1e9f937453a32a5119868cac49de098640a

And my reasoning for taking it:

  http://marc.info/?l=linux-arm-kernel&m=137555145730141&w=2

I haven't sent a PR to arm-soc yet (I like to let things gel in -next
for a few days), so if there's something wrong with it, please let me
know.

thx,

Jason.
