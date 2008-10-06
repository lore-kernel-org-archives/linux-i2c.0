From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
Date: Mon, 6 Oct 2008 22:44:02 +0400
Message-ID: <20081006184402.GA13392@oksana.dev.rtsoft.ru>
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
	<20080930124424.GA6878@oksana.dev.rtsoft.ru>
	<20081001132248.191e92b3@hyperion.delvare>
	<20081001113948.GA20115@oksana.dev.rtsoft.ru>
	<20081006172831.GA27233@oksana.dev.rtsoft.ru>
	<20081006173158.GA11208@secretlab.ca>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20081006173158.GA11208@secretlab.ca>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 06, 2008 at 11:31:58AM -0600, Grant Likely wrote:
> On Mon, Oct 06, 2008 at 09:28:31PM +0400, Anton Vorontsov wrote:
> > On Wed, Oct 01, 2008 at 03:39:48PM +0400, Anton Vorontsov wrote:
> > [...]
> > > > > Any issues with this or the second patch? Can we merge them?
> > > > 
> > > > I do not have the time to review these patches (and, honestly, have no
> > > > interest in them.) So I will not merge them but I have no objection to
> > > > them being merged by somebody else.
> > > 
> > > Ok, thanks for the sincerity.. ;-)
> > > 
> > > Kumar, could you pick up the two patches via the patchworks?
> > > 
> > > [1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
> > > http://patchwork.ozlabs.org/patch/1105/
> > > 
> 
> Since I've been involved with the i2c of bindings, I can pick this one up.

Much appreciated, thanks!

> > > [2/2] i2c: MPC8349E-mITX Power Management and GPIO expander driver
> > > http://patchwork.ozlabs.org/patch/1106/
> 
> But I'm not involved enough with this one, so it should go through
> kumar.

That's fine, the first and second patches could go separate trees
since it won't break the build.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
