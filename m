From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] i2c: expand I2C's id.name to 23 characters
Date: Fri, 19 Sep 2008 14:39:03 -0600
Message-ID: <20080919203903.GA10187@secretlab.ca>
References: <20080919180339.GA13899@oksana.dev.rtsoft.ru>
	<20080919220308.3173320e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20080919220308.3173320e@hyperion.delvare>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 19, 2008 at 10:03:08PM +0200, Jean Delvare wrote:
> On Fri, 19 Sep 2008 22:03:39 +0400, Anton Vorontsov wrote:
> > It was discussed[1] that we should match on the first (most specific)
> > entry in the device tree.
> > 
> > The most lengthy I2C compatible entry for the MPC8349E-mITX MCU
> > devices is "mc9s08qg8-mpc8349emitx" (w/o vendor name). This means
> > that we have to allow longer IDs to be used in the I2C subsystem.
> > 
> > [1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html
> 
> Nack. Just come up with shorter names. "mc9s08qg8-mpc8349emitx" is
> simply too long to start with. Looking at the mcu_mpc8349emitx driver
> you just submitted, you are clearly abusing the i2c client name to pass
> platform-specific information, and that's bad. I'm not even sure why
> you do that, given that all the names are then handled the same as far
> as I can see.

The whole "matching on the first entry" thing is just a Linux-internal
heuristic.  If the heuristic breaks down (like it does here), then there
is a mechanism to override it in of_base.c which has a
compatible-->modalias translation table.

g.
