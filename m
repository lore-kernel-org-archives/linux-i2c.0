From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v2] Driver for NS LP3944 FunLight Chip
Date: Mon, 30 Jun 2008 15:28:40 +0200
Message-ID: <20080630152840.93ec049d.ospite@studenti.unina.it>
References: <20080618094645.1a7c8c26.ospite@studenti.unina.it>
	<20080625201409.5df975d4@hyperion.delvare>
	<20080627175649.6c0e717e.ospite@studenti.unina.it>
	<20080627224256.718e5dc8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627224256.718e5dc8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Jun 2008 22:42:56 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Antonio,
> 
> > > (...)
> > > Apparently this implies that your driver (or at least this interface
> > > thereof) can only support one device? That's unfortunate.
> > 
> > How can I support multiple devices? Passing a i2c_client variable I
> > guess, but then, how can I get the client, say, inside a leds-class
> > driver before I can talk to it?
> 
> Question is, why do you have separate drivers for the i2c interface and
> the leds-class parts in the first place? Just put everything in the
> same driver and you're problem is solved, I think.
> 

Well, I separated the two to share the chip specific code with other
future possible users. AFAIU leds-class drivers are meant to provide a
high level interface to userspace. LP3944_LED0 can be the red led on
Motorola A910 but it could well be the blue led on a different machine
which uses lp3944 chip. That's why.

Regards,
   Antonio Ospite

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
