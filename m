From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 17 Oct 2008 13:43:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0810171341370.23885@shell4.speakeasy.net>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809251902.00201.david-b@pacbell.net>
	<Pine.LNX.4.64.0809261652040.7680@t2.domain.actdsltmp>
	<200810171204.54448.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4081461398886312990=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200810171204.54448.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============4081461398886312990==
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Oct 2008, David Brownell wrote:
> ... just to recap this before I scrub old mail from my mbox:
>
> On Friday 26 September 2008, Trent Piepho wrote:
> > > It's not a question of the I2C adapter supporting it. =A0It's a
> > > question of whether there's an SMBALERT# signal on your board,
> > > which can generate an interrupt. =A0If it can, this patch has an
> > > IRQ handler which implements the SMBus alert protocol. =A0Think
> > > of it as sideband signaling ... unknown to that adapter.
> >
> > If nothing is alerting, then the read from the ARA address won't get an=
 ack.
>
> Absolutely nothing you've said makes a real argument against
> providing support for SMBALERT#.

Which isn't surprising, since I wasn't trying to make an argument against
providing support for SMBALERT#.  I was making an argument for why it might
be necessary to do something else.


--===============4081461398886312990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4081461398886312990==--
