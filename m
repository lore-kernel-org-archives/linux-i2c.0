From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and
	GPIO	expander driver
Date: Tue, 23 Sep 2008 13:07:15 +0100
Message-ID: <20080923120713.GC32245@sirena.org.uk>
References: <20080919180354.GB13899@oksana.dev.rtsoft.ru>
	<20080922224540.GM2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080922224540.GM2716-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2008 at 11:45:40PM +0100, Ben Dooks wrote:

> I've also a driver for a similar PMU fitted to a number
> of our boards that provides basic gpio (wakeup sources) and some
> minimalist power management (so isn't really fit for regulator
> framwork) and isn't really a gpio chip (so drivers/gpio isn't
> really the place for it either.)

FWIW the regulator framework does have support for representing things
as limited as completely non-controllable regulators so it may still be
worth considering that.  It at least provides a degree of abstraction
for the clients in case they are used with more complex regulators and
would allow integration of your PMU with more complex secondary
regulators.  May not be worth the bother, though.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
