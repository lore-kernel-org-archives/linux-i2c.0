From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Wed, 23 Apr 2008 13:09:19 +0200
Message-ID: <20080423130919.5d55feff@hyperion.delvare>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<480A2117.7020502@scram.de>
	<200804211356.10192.laurentp@cse-semaphore.com>
	<200804211412.49201.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200804211412.49201.sr@denx.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Stefan Roese <sr@denx.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 21 Apr 2008 14:12:48 +0200, Stefan Roese wrote:
> On Monday 21 April 2008, Laurent Pinchart wrote:
> > > > > Is there any chance they will got to 2.6.26?
> > > >
> > > > I'm not sure. I didn't have the time to look at it myself, but I am
> > > > under the impression that the powerpc folks are tired of having to wait
> > > > for me and may push it to Linus through their tree? That would be fine
> > > > with me, as I don't want to be the one delaying something many
> > > > developers want (but I also can't sign patches I've not even read.)
> >
> > The patches are required for long awaited I2C support on various PowerPC
> > boards. As the ppc architecture support is going away in 2.6.27, it would
> > be nice to have them applied in 2.6.26.
> 
> Yes, please.

I know that many people would like to see these patches upstream
quickly, no question about that. The problem is that I am very busy
with my day job and my family life these days so I just don't know when
I will find the time an energy to go through this huge patch set.

-- 
Jean Delvare
